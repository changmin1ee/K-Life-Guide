package com.klife.klifeguide.domain.mission.entity;

import com.klife.klifeguide.domain.mission.enums.MissionType;
import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "mission")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Mission extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String koCategory;

    @Column(nullable = false)
    private String enCategory;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MissionType type;

    @Column(nullable = false)
    private String koTitle;

    @Column(nullable = false)
    private String enTitle;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String koDesc;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String enDesc;

    @Column(nullable = false)
    private Integer xp;

    @Column(nullable = false)
    private Integer point;

    @Column(nullable = false)
    private Integer sortOrder;

    @OneToMany(mappedBy = "mission", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("stepOrder ASC")
    @Builder.Default
    private List<MissionStep> steps = new ArrayList<>();

    @OneToMany(mappedBy = "mission")
    @Builder.Default
    private List<MemberMission> memberMissions = new ArrayList<>();
}
