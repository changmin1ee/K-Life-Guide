package com.klife.klifeguide.domain.roadmap.entity;

import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "roadmap_item")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class RoadmapItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String koTitle;

    @Column(nullable = false)
    private String enTitle;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String koDesc;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String enDesc;

    @Column(nullable = false)
    private Integer dayNumber;

    @Column(nullable = false)
    private Integer sortOrder;

    @Column
    private String iconKey;
}
