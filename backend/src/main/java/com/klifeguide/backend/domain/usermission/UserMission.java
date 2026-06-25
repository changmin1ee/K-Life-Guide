package com.klifeguide.backend.domain.usermission;

import com.klifeguide.backend.domain.mission.Mission;
import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.global.jpa.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Entity
@Table(
        name = "user_missions",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_user_missions_attempt",
                columnNames = {"user_id", "mission_id", "attempt_no"}
        )
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserMission extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "mission_id", nullable = false)
    private Mission mission;

    @Column(name = "attempt_no", nullable = false)
    private int attemptNo;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private UserMissionStatus status;

    @Column(name = "photo_url", nullable = false, length = 500)
    private String photoUrl;

    @Column(name = "submitted_latitude", nullable = false, precision = 10, scale = 7)
    private BigDecimal submittedLatitude;

    @Column(name = "submitted_longitude", nullable = false, precision = 10, scale = 7)
    private BigDecimal submittedLongitude;

    @Column(name = "distance_meters", precision = 10, scale = 2)
    private BigDecimal distanceMeters;

    @Column(name = "gps_verified", nullable = false)
    private boolean gpsVerified;

    @Column(name = "gemini_confidence_score", precision = 5, scale = 2)
    private BigDecimal geminiConfidenceScore;

    @Lob
    @Column(name = "gemini_analysis_result", columnDefinition = "json")
    private String geminiAnalysisResult;

    @Column(name = "ai_verified_at")
    private LocalDateTime aiVerifiedAt;

    @Column(name = "auto_approved", nullable = false)
    private boolean autoApproved;

    @Column(name = "points_earned", nullable = false)
    private int pointsEarned;

    @Column(name = "submitted_at", nullable = false)
    private LocalDateTime submittedAt;

    @Column(name = "reviewed_at")
    private LocalDateTime reviewedAt;

    @Builder
    private UserMission(User user, Mission mission, int attemptNo, String photoUrl,
                         BigDecimal submittedLatitude, BigDecimal submittedLongitude) {
        this.user = user;
        this.mission = mission;
        this.attemptNo = attemptNo > 0 ? attemptNo : 1;
        this.photoUrl = photoUrl;
        this.submittedLatitude = submittedLatitude;
        this.submittedLongitude = submittedLongitude;
        this.status = UserMissionStatus.PENDING_REVIEW;
        this.gpsVerified = false;
        this.autoApproved = false;
        this.pointsEarned = 0;
        this.submittedAt = LocalDateTime.now();
    }

    public void applyGpsResult(BigDecimal distanceMeters, boolean gpsVerified) {
        this.distanceMeters = distanceMeters;
        this.gpsVerified = gpsVerified;
    }

    public void applyGeminiResult(BigDecimal confidenceScore, String analysisResultJson) {
        this.geminiConfidenceScore = confidenceScore;
        this.geminiAnalysisResult = analysisResultJson;
        this.aiVerifiedAt = LocalDateTime.now();
    }

    public void autoApprove(int points) {
        this.status = UserMissionStatus.AI_APPROVED;
        this.autoApproved = true;
        this.pointsEarned = points;
        this.reviewedAt = LocalDateTime.now();
    }

    public void escalateToAdminReview() {
        this.status = UserMissionStatus.NEEDS_ADMIN_REVIEW;
    }

    public void rejectByAi() {
        this.status = UserMissionStatus.AI_REJECTED;
        this.reviewedAt = LocalDateTime.now();
    }

    public void confirmByAdmin(boolean approved, int points) {
        this.status = approved ? UserMissionStatus.APPROVED : UserMissionStatus.REJECTED;
        this.pointsEarned = approved ? points : 0;
        this.reviewedAt = LocalDateTime.now();
    }
}
