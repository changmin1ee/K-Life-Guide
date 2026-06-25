package com.klifeguide.backend.domain.comment;

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
import org.springframework.data.mongodb.core.mapping.FieldType;

import java.time.LocalDateTime;

@Getter
@Document(collection = "comments")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Comment {

    @Id
    private String id;

    @Indexed
    @Field(targetType = FieldType.OBJECT_ID)
    private String postId;

    private Long authorId;

    @Field(targetType = FieldType.OBJECT_ID)
    private String parentCommentId;

    private int depth;

    private String content;

    private int likeCount;

    private boolean accepted;

    private ContentStatus status;

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @Field("deletedAt")
    private LocalDateTime deletedAt;

    @Builder
    private Comment(String postId, Long authorId, String parentCommentId, String content) {
        this.postId = postId;
        this.authorId = authorId;
        this.parentCommentId = parentCommentId;
        this.depth = parentCommentId == null ? 0 : 1;
        this.content = content;
        this.likeCount = 0;
        this.accepted = false;
        this.status = ContentStatus.ACTIVE;
    }

    public void accept() {
        if (this.depth != 0) {
            throw new IllegalStateException("최상위 댓글만 채택할 수 있습니다.");
        }
        this.accepted = true;
    }

    public void delete() {
        this.status = ContentStatus.DELETED;
        this.deletedAt = LocalDateTime.now();
    }
}
