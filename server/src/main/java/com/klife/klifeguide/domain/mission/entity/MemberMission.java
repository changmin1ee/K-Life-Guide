package com.klife.klifeguide.domain.mission.entity;

import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "member_mission")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class MemberMission extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long memberId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mission_id", nullable = false)
    private Mission mission;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MissionStatus status;

    @Column(nullable = false)
    @Builder.Default
    private Double progress = 0.0;

    @Column
    private String proofImageUrl;

    @Column
    private LocalDateTime completedAt;

    public void complete(String proofImageUrl) {
        this.status = MissionStatus.COMPLETED;
        this.progress = 1.0;
        this.proofImageUrl = proofImageUrl;
        this.completedAt = LocalDateTime.now();
    }

    public void updateProgress(double progress) {
        this.progress = progress;
    }
}
