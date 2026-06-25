package com.klifeguide.backend.domain.usermission.dto;

import jakarta.validation.constraints.NotNull;

public record AdminReviewRequest(
        @NotNull Boolean approved,
        String reason
) {
}
