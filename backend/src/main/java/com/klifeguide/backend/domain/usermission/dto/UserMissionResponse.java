package com.klifeguide.backend.domain.usermission.dto;

import com.klifeguide.backend.domain.usermission.UserMission;
import com.klifeguide.backend.domain.usermission.UserMissionStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record UserMissionResponse(
        Long id,
        Long missionId,
        String missionTitle,
        int attemptNo,
        UserMissionStatus status,
        String photoUrl,
        BigDecimal submittedLatitude,
        BigDecimal submittedLongitude,
        BigDecimal distanceMeters,
        boolean gpsVerified,
        BigDecimal geminiConfidenceScore,
        boolean autoApproved,
        int pointsEarned,
        LocalDateTime submittedAt,
        LocalDateTime reviewedAt
) {
    public static UserMissionResponse from(UserMission userMission) {
        return new UserMissionResponse(
                userMission.getId(),
                userMission.getMission().getId(),
                userMission.getMission().getTitle(),
                userMission.getAttemptNo(),
                userMission.getStatus(),
                userMission.getPhotoUrl(),
                userMission.getSubmittedLatitude(),
                userMission.getSubmittedLongitude(),
                userMission.getDistanceMeters(),
                userMission.isGpsVerified(),
                userMission.getGeminiConfidenceScore(),
                userMission.isAutoApproved(),
                userMission.getPointsEarned(),
                userMission.getSubmittedAt(),
                userMission.getReviewedAt()
        );
    }
}
