package com.klife.klifeguide.domain.roadmap.converter;

import com.klife.klifeguide.domain.roadmap.dto.RoadmapResDTO;
import com.klife.klifeguide.domain.roadmap.entity.RoadmapItem;
import com.klife.klifeguide.domain.roadmap.entity.UserRoadmap;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RoadmapConverter {

    public RoadmapResDTO.RoadmapItemInfo toRoadmapItemInfo(RoadmapItem item, boolean done, java.time.LocalDateTime completedAt) {
        return RoadmapResDTO.RoadmapItemInfo.builder()
                .id(item.getId())
                .dayNumber(item.getDayNumber())
                .koTitle(item.getKoTitle())
                .enTitle(item.getEnTitle())
                .koDesc(item.getKoDesc())
                .enDesc(item.getEnDesc())
                .sortOrder(item.getSortOrder())
                .iconKey(item.getIconKey())
                .done(done)
                .completedAt(completedAt)
                .build();
    }

    public RoadmapResDTO.RoadmapItemInfo toRoadmapItemInfo(UserRoadmap userRoadmap) {
        return toRoadmapItemInfo(
                userRoadmap.getRoadmapItem(),
                userRoadmap.getDone(),
                userRoadmap.getCompletedAt()
        );
    }

    public RoadmapResDTO.RoadmapProgress toRoadmapProgress(List<RoadmapResDTO.RoadmapItemInfo> items) {
        int total = items.size();
        long completed = items.stream().filter(RoadmapResDTO.RoadmapItemInfo::isDone).count();
        double percent = total > 0 ? (double) completed / total * 100.0 : 0.0;

        return RoadmapResDTO.RoadmapProgress.builder()
                .totalCount(total)
                .completedCount((int) completed)
                .progressPercent(percent)
                .items(items)
                .build();
    }
}
