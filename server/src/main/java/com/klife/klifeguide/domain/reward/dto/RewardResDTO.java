package com.klife.klifeguide.domain.reward.dto;

import com.klife.klifeguide.domain.reward.enums.PointSource;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

public class RewardResDTO {

    @Getter
    @Builder
    public static class BadgeInfo {
        private Long id;
        private String koName;
        private String enName;
        private String koDesc;
        private String enDesc;
        private String iconKey;
        private Integer requiredMissionCount;
        private boolean earned;
        private LocalDateTime earnedAt;
    }

    @Getter
    @Builder
    public static class PointHistoryInfo {
        private Long id;
        private Integer points;
        private Integer xp;
        private String description;
        private PointSource source;
        private LocalDateTime createdAt;
    }

    @Getter
    @Builder
    public static class PassportInfo {
        private List<CategoryAdaptation> categoryAdaptations;
    }

    @Getter
    @Builder
    public static class CategoryAdaptation {
        private String koCategory;
        private String enCategory;
        private int completedCount;
        private int totalCount;
        private double adaptationRate;
    }
}
