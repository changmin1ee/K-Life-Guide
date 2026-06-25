package com.klifeguide.backend.domain.usermission.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public record MissionSubmitRequest(
        @NotBlank String photoUrl,
        @NotNull BigDecimal latitude,
        @NotNull BigDecimal longitude
) {
}
