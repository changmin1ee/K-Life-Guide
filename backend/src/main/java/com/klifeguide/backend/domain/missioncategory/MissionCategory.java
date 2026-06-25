package com.klifeguide.backend.domain.missioncategory;

import com.klifeguide.backend.global.jpa.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "mission_categories")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MissionCategory extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String name;

    @Column(length = 255)
    private String description;

    @Column(name = "icon_url", length = 500)
    private String iconUrl;

    @Column(name = "display_order", nullable = false)
    private int displayOrder;

    @Builder
    private MissionCategory(String name, String description, String iconUrl, int displayOrder) {
        this.name = name;
        this.description = description;
        this.iconUrl = iconUrl;
        this.displayOrder = displayOrder;
    }
}
