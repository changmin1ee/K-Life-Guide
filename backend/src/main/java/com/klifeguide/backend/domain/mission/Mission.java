package com.klifeguide.backend.domain.mission;

import com.klifeguide.backend.domain.missioncategory.MissionCategory;
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
@Table(name = "missions")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Mission extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false)
    private MissionCategory category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Column(nullable = false, length = 100)
    private String title;

    @Lob
    private String description;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal latitude;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal longitude;

    @Column(name = "radius_meters", nullable = false)
    private int radiusMeters;

    @Column(name = "location_name", length = 255)
    private String locationName;

    @Column(length = 255)
    private String address;

    @Column(nullable = false)
    private int points;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MissionDifficulty difficulty;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MissionStatus status;

    @Column(name = "start_date")
    private LocalDateTime startDate;

    @Column(name = "end_date")
    private LocalDateTime endDate;

    @Builder
    private Mission(MissionCategory category, User createdBy, String title, String description,
                     BigDecimal latitude, BigDecimal longitude, int radiusMeters, String locationName,
                     String address, int points, MissionDifficulty difficulty,
                     LocalDateTime startDate, LocalDateTime endDate) {
        this.category = category;
        this.createdBy = createdBy;
        this.title = title;
        this.description = description;
        this.latitude = latitude;
        this.longitude = longitude;
        this.radiusMeters = radiusMeters > 0 ? radiusMeters : 100;
        this.locationName = locationName;
        this.address = address;
        this.points = points;
        this.difficulty = difficulty != null ? difficulty : MissionDifficulty.NORMAL;
        this.status = MissionStatus.ACTIVE;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public void archive() {
        this.status = MissionStatus.ARCHIVED;
    }
}
