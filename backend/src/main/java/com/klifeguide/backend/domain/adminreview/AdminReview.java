package com.klifeguide.backend.domain.adminreview;

import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.domain.usermission.UserMission;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "admin_reviews")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AdminReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_mission_id", nullable = false, unique = true)
    private UserMission userMission;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "admin_id", nullable = false)
    private User admin;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ReviewDecision decision;

    @Lob
    private String reason;

    @Column(name = "reviewed_at", nullable = false)
    private LocalDateTime reviewedAt;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Builder
    private AdminReview(UserMission userMission, User admin, ReviewDecision decision, String reason) {
        this.userMission = userMission;
        this.admin = admin;
        this.decision = decision;
        this.reason = reason;
        this.reviewedAt = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
    }
}
