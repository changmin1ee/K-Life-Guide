package com.klifeguide.backend.domain.report;

import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.global.jpa.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(name = "reports")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Report extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "reporter_id", nullable = false)
    private User reporter;

    @Enumerated(EnumType.STRING)
    @Column(name = "target_type", nullable = false, length = 20)
    private ReportTargetType targetType;

    @Column(name = "target_id", nullable = false)
    private Long targetId;

    @Enumerated(EnumType.STRING)
    @Column(name = "reason_type", nullable = false, length = 30)
    private ReportReasonType reasonType;

    @Lob
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ReportStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "handled_by")
    private User handledBy;

    @Column(name = "handled_at")
    private LocalDateTime handledAt;

    @Builder
    private Report(User reporter, ReportTargetType targetType, Long targetId,
                    ReportReasonType reasonType, String description) {
        this.reporter = reporter;
        this.targetType = targetType;
        this.targetId = targetId;
        this.reasonType = reasonType;
        this.description = description;
        this.status = ReportStatus.PENDING;
    }

    public void resolve(User admin, boolean accepted) {
        this.handledBy = admin;
        this.status = accepted ? ReportStatus.RESOLVED : ReportStatus.REJECTED;
        this.handledAt = LocalDateTime.now();
    }

    public void startReviewing() {
        this.status = ReportStatus.REVIEWING;
    }
}
