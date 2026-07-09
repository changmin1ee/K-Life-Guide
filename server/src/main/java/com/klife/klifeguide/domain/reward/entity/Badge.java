package com.klife.klifeguide.domain.reward.entity;

import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "badge")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Badge extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String koName;

    @Column(nullable = false)
    private String enName;

    @Column(nullable = false)
    private String koDesc;

    @Column(nullable = false)
    private String enDesc;

    @Column(nullable = false)
    private Integer requiredMissionCount;

    @Column(nullable = false)
    private String iconKey;
}
