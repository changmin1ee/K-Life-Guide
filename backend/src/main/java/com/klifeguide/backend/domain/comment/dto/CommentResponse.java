package com.klifeguide.backend.domain.comment.dto;

import com.klifeguide.backend.domain.comment.Comment;
import com.klifeguide.backend.domain.common.ContentStatus;

import java.time.LocalDateTime;

public record CommentResponse(
        String id,
        String postId,
        Long authorId,
        String parentCommentId,
        int depth,
        String content,
        int likeCount,
        boolean accepted,
        ContentStatus status,
        LocalDateTime createdAt
) {
    public static CommentResponse from(Comment comment) {
        return new CommentResponse(
                comment.getId(),
                comment.getPostId(),
                comment.getAuthorId(),
                comment.getParentCommentId(),
                comment.getDepth(),
                comment.getContent(),
                comment.getLikeCount(),
                comment.isAccepted(),
                comment.getStatus(),
                comment.getCreatedAt()
        );
    }
}
