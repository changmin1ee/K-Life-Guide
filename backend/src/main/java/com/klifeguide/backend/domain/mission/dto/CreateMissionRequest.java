package com.klifeguide.backend.domain.mission.dto;

import com.klifeguide.backend.domain.mission.MissionDifficulty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record CreateMissionRequest(
        @NotNull Long categoryId,
        @NotBlank String title,
        String description,
        @NotNull BigDecimal latitude,
        @NotNull BigDecimal longitude,
        @PositiveOrZero Integer radiusMeters,
        String locationName,
        String address,
        @PositiveOrZero int points,
        MissionDifficulty difficulty,
        LocalDateTime startDate,
        LocalDateTime endDate
) {
}
