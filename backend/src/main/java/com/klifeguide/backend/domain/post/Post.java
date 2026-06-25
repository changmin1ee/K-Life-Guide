package com.klifeguide.backend.domain.post;

import com.klifeguide.backend.domain.common.ContentStatus;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Document(collection = "posts")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Post {

    @Id
    private String id;

    private PostType postType;

    @Indexed
    private Long authorId;

    private String title;

    private String content;

    private String category;

    private List<String> tags = new ArrayList<>();

    private List<ImageItem> images = new ArrayList<>();

    private int viewCount;

    private int likeCount;

    private int commentCount;

    private ContentStatus status;

    private QnaInfo qna;

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @Field("deletedAt")
    private LocalDateTime deletedAt;

    @Builder
    private Post(PostType postType, Long authorId, String title, String content,
                  String category, List<String> tags) {
        this.postType = postType;
        this.authorId = authorId;
        this.title = title;
        this.content = content;
        this.category = category;
        this.tags = tags != null ? tags : new ArrayList<>();
        this.images = new ArrayList<>();
        this.viewCount = 0;
        this.likeCount = 0;
        this.commentCount = 0;
        this.status = ContentStatus.ACTIVE;
        this.qna = postType == PostType.QNA ? new QnaInfo(false, null) : null;
    }

    public void update(String title, String content, String category, List<String> tags) {
        this.title = title;
        this.content = content;
        this.category = category;
        this.tags = tags != null ? tags : new ArrayList<>();
    }

    public void increaseViewCount() {
        this.viewCount++;
    }

    public void increaseCommentCount() {
        this.commentCount++;
    }

    public void decreaseCommentCount() {
        if (this.commentCount > 0) {
            this.commentCount--;
        }
    }

    public void resolveQna(String acceptedCommentId) {
        if (this.qna == null) {
            throw new IllegalStateException("Q&A 게시글이 아닙니다.");
        }
        this.qna.resolve(acceptedCommentId);
    }

    public void delete() {
        this.status = ContentStatus.DELETED;
        this.deletedAt = LocalDateTime.now();
    }
}
