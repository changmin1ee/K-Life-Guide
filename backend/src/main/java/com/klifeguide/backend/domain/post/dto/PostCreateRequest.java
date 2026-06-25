package com.klifeguide.backend.domain.post.dto;

import com.klifeguide.backend.domain.post.PostType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;

public record PostCreateRequest(
        @NotNull PostType postType,
        @NotBlank String title,
        @NotBlank String content,
        String category,
        List<String> tags
) {
}
