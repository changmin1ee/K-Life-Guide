# K-Life-Guide MongoDB 컬렉션 설계

대상 컬렉션: `posts`(자유게시판 + Q&A 통합), `comments`(대댓글 1단계 포함)

## 설계 원칙
- 게시판 종류는 컬렉션을 분리하지 않고 `postType` 필드로 구분(자유게시판/Q&A가 목록 조회·검색 로직을 공유하기 때문).
- `authorId`는 MySQL `users.id`(BIGINT)를 그대로 저장하는 **참조 ID**. Mongo가 FK를 강제하지 않으므로 정합성은 애플리케이션 레벨에서 보장.
- soft delete(`deletedAt`)로 삭제하고 실제 document는 보관(신고/관리자 검수 추적용).
- 댓글은 대댓글까지만 허용(depth 0/1)하는 것을 가정해 `parentCommentId` 하나로 표현. 무한 depth가 필요해지면 `path`(materialized path) 방식으로 전환.

---

## 1. `posts`

```javascript
db.createCollection("posts", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["postType", "authorId", "title", "content", "status", "createdAt"],
      properties: {
        postType: { enum: ["FREE", "QNA"] },
        authorId: { bsonType: "long" },
        title: { bsonType: "string", maxLength: 200 },
        content: { bsonType: "string" },
        category: { bsonType: ["string", "null"] },
        tags: { bsonType: "array", items: { bsonType: "string" } },
        images: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["url", "order"],
            properties: {
              url: { bsonType: "string" },
              order: { bsonType: "int" }
            }
          }
        },
        viewCount: { bsonType: "int", minimum: 0 },
        likeCount: { bsonType: "int", minimum: 0 },
        commentCount: { bsonType: "int", minimum: 0 },
        status: { enum: ["ACTIVE", "BLINDED", "DELETED"] },
        qna: {
          bsonType: ["object", "null"],
          properties: {
            isResolved: { bsonType: "bool" },
            acceptedCommentId: { bsonType: ["objectId", "null"] }
          }
        },
        createdAt: { bsonType: "date" },
        updatedAt: { bsonType: "date" },
        deletedAt: { bsonType: ["date", "null"] }
      }
    }
  },
  validationLevel: "moderate"
});
```

### 예시 document (Q&A)
```json
{
  "_id": "ObjectId(...)",
  "postType": "QNA",
  "authorId": 1024,
  "title": "F-2 비자 연장 서류 관련 질문",
  "content": "...",
  "category": "비자/체류",
  "tags": ["비자", "F-2"],
  "images": [],
  "viewCount": 37,
  "likeCount": 2,
  "commentCount": 3,
  "status": "ACTIVE",
  "qna": { "isResolved": true, "acceptedCommentId": "ObjectId(...)" },
  "createdAt": "2026-06-20T10:00:00Z",
  "updatedAt": "2026-06-21T09:00:00Z",
  "deletedAt": null
}
```
- `postType: "FREE"`인 경우 `qna` 필드는 생략(`null`)하고, 카테고리는 자유게시판용 값(예: "잡담", "정보공유")을 사용.

### 인덱스
```javascript
db.posts.createIndex({ status: 1, postType: 1, createdAt: -1 }, { name: "ix_posts_list" });
db.posts.createIndex({ authorId: 1, createdAt: -1 }, { name: "ix_posts_author" });
db.posts.createIndex({ category: 1, createdAt: -1 }, { name: "ix_posts_category" });
db.posts.createIndex({ postType: 1, "qna.isResolved": 1 }, {
  name: "ix_posts_qna_unresolved",
  partialFilterExpression: { postType: "QNA" }
});
db.posts.createIndex({ title: "text", content: "text" }, { name: "ix_posts_text_search" });
```

---

## 2. `comments`

```javascript
db.createCollection("comments", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["postId", "authorId", "content", "depth", "status", "createdAt"],
      properties: {
        postId: { bsonType: "objectId" },
        authorId: { bsonType: "long" },
        parentCommentId: { bsonType: ["objectId", "null"] },
        depth: { bsonType: "int", enum: [0, 1] },
        content: { bsonType: "string", maxLength: 1000 },
        likeCount: { bsonType: "int", minimum: 0 },
        isAccepted: { bsonType: "bool" },
        status: { enum: ["ACTIVE", "BLINDED", "DELETED"] },
        createdAt: { bsonType: "date" },
        updatedAt: { bsonType: "date" },
        deletedAt: { bsonType: ["date", "null"] }
      }
    }
  },
  validationLevel: "moderate"
});
```

### 예시 document
```json
{
  "_id": "ObjectId(...)",
  "postId": "ObjectId(...)",
  "authorId": 2048,
  "parentCommentId": null,
  "depth": 0,
  "content": "출입국에 문의해보니 서류 하나가 더 필요하다고 하네요.",
  "likeCount": 5,
  "isAccepted": true,
  "status": "ACTIVE",
  "createdAt": "2026-06-20T11:00:00Z",
  "updatedAt": "2026-06-20T11:00:00Z",
  "deletedAt": null
}
```
- `isAccepted`는 `postType: "QNA"`이고 `parentCommentId: null`(최상위 댓글)인 경우에만 의미를 가짐. 채택 시 `posts.qna.acceptedCommentId`와 함께 갱신(트랜잭션 불가 환경이므로 댓글 채택 서비스 로직에서 두 컬렉션을 순차 업데이트 후 실패 시 보상 처리).

### 인덱스
```javascript
db.comments.createIndex({ postId: 1, createdAt: 1 }, { name: "ix_comments_post_order" });
db.comments.createIndex({ postId: 1, parentCommentId: 1 }, { name: "ix_comments_post_parent" });
db.comments.createIndex({ authorId: 1, createdAt: -1 }, { name: "ix_comments_author" });
```

### 카운터 동기화
- `posts.commentCount`는 댓글 생성/삭제 시 `$inc`로 갱신(예: `db.posts.updateOne({_id: postId}, {$inc: {commentCount: 1}})`). 정확한 카운트가 깨질 가능성에 대비해 배치로 재계산하는 운영 스크립트를 별도로 둘 것을 권장.
