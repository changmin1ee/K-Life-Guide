package com.klifeguide.backend.domain.post.dto;

import com.klifeguide.backend.domain.common.ContentStatus;
import com.klifeguide.backend.domain.post.Post;
import com.klifeguide.backend.domain.post.PostType;

import java.time.LocalDateTime;
import java.util.List;

public record PostResponse(
        String id,
        PostType postType,
        Long authorId,
        String title,
        String content,
        String category,
        List<String> tags,
        int viewCount,
        int likeCount,
        int commentCount,
        ContentStatus status,
        Boolean qnaResolved,
        String qnaAcceptedCommentId,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static PostResponse from(Post post) {
        return new PostResponse(
                post.getId(),
                post.getPostType(),
                post.getAuthorId(),
                post.getTitle(),
                post.getContent(),
                post.getCategory(),
                post.getTags(),
                post.getViewCount(),
                post.getLikeCount(),
                post.getCommentCount(),
                post.getStatus(),
                post.getQna() != null ? post.getQna().isResolved() : null,
                post.getQna() != null ? post.getQna().getAcceptedCommentId() : null,
                post.getCreatedAt(),
                post.getUpdatedAt()
        );
    }
}
