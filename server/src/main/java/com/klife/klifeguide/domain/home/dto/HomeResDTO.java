package com.klife.klifeguide.domain.home.dto;

import com.klife.klifeguide.domain.member.enums.Language;
import com.klife.klifeguide.domain.mission.dto.MissionResDTO;
import com.klife.klifeguide.domain.roadmap.dto.RoadmapResDTO;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

public class HomeResDTO {

    @Getter
    @Builder
    public static class HomeData {
        private MemberSummary member;
        private List<MissionResDTO.MissionSummary> inProgressMissions;
        private List<MissionResDTO.MissionSummary> recentCompletedMissions;
        private MissionResDTO.MissionSummary recommendedMission;
        private RoadmapResDTO.RoadmapProgress roadmapProgress;
        private int todayCompletedCount;
    }

    @Getter
    @Builder
    public static class MemberSummary {
        private Long id;
        private String name;
        private String profileImageUrl;
        private int level;
        private int xp;
        private int points;
        private int completedMissionCount;
        private Language language;
    }
}
