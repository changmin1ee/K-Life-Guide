package com.klife.klifeguide.domain.roadmap.dto;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

public class RoadmapResDTO {

    @Getter
    @Builder
    public static class RoadmapItemInfo {
        private Long id;
        private Integer dayNumber;
        private String koTitle;
        private String enTitle;
        private String koDesc;
        private String enDesc;
        private Integer sortOrder;
        private String iconKey;
        private boolean done;
        private LocalDateTime completedAt;
    }

    @Getter
    @Builder
    public static class RoadmapProgress {
        private int totalCount;
        private int completedCount;
        private double progressPercent;
        private List<RoadmapItemInfo> items;
    }
}
