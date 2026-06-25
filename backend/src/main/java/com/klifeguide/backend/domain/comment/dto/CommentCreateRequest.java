package com.klifeguide.backend.domain.comment.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CommentCreateRequest(
        String parentCommentId,
        @NotBlank @Size(max = 1000) String content
) {
}
