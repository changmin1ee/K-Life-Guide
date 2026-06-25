package com.klifeguide.backend.domain.post.dto;

import jakarta.validation.constraints.NotBlank;

import java.util.List;

public record PostUpdateRequest(
        @NotBlank String title,
        @NotBlank String content,
        String category,
        List<String> tags
) {
}
