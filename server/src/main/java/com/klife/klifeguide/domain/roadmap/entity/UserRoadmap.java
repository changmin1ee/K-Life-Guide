package com.klife.klifeguide.domain.roadmap.entity;

import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(
        name = "user_roadmap",
        uniqueConstraints = @UniqueConstraint(columnNames = {"member_id", "roadmap_item_id"})
)
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class UserRoadmap extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "member_id", nullable = false)
    private Long memberId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "roadmap_item_id", nullable = false)
    private RoadmapItem roadmapItem;

    @Column(nullable = false)
    @Builder.Default
    private Boolean done = false;

    @Column
    private LocalDateTime completedAt;

    public void markDone() {
        this.done = true;
        this.completedAt = LocalDateTime.now();
    }

    public void markUndone() {
        this.done = false;
        this.completedAt = null;
    }
}
