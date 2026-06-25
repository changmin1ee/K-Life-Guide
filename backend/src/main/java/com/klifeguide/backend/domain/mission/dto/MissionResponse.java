package com.klifeguide.backend.domain.mission.dto;

import com.klifeguide.backend.domain.mission.Mission;
import com.klifeguide.backend.domain.mission.MissionDifficulty;
import com.klifeguide.backend.domain.mission.MissionStatus;

import java.math.BigDecimal;

public record MissionResponse(
        Long id,
        Long categoryId,
        String categoryName,
        String title,
        String description,
        BigDecimal latitude,
        BigDecimal longitude,
        int radiusMeters,
        String locationName,
        String address,
        int points,
        MissionDifficulty difficulty,
        MissionStatus status
) {
    public static MissionResponse from(Mission mission) {
        return new MissionResponse(
                mission.getId(),
                mission.getCategory().getId(),
                mission.getCategory().getName(),
                mission.getTitle(),
                mission.getDescription(),
                mission.getLatitude(),
                mission.getLongitude(),
                mission.getRadiusMeters(),
                mission.getLocationName(),
                mission.getAddress(),
                mission.getPoints(),
                mission.getDifficulty(),
                mission.getStatus()
        );
    }
}
