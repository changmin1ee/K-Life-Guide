package com.klifeguide.backend.domain.badge;

import com.klifeguide.backend.global.jpa.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "badges")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Badge extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String name;

    @Column(length = 255)
    private String description;

    @Column(name = "icon_url", length = 500)
    private String iconUrl;

    @Enumerated(EnumType.STRING)
    @Column(name = "badge_type", nullable = false, length = 30)
    private BadgeType badgeType;

    @Column(name = "condition_value")
    private Integer conditionValue;

    @Builder
    private Badge(String name, String description, String iconUrl, BadgeType badgeType, Integer conditionValue) {
        this.name = name;
        this.description = description;
        this.iconUrl = iconUrl;
        this.badgeType = badgeType;
        this.conditionValue = conditionValue;
    }
}
