package com.klife.klifeguide.domain.mission.dto;

import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

public class MissionResDTO {

    /**
     * 미션 상세 정보 (steps 포함, 로그인 유저 기준 myProgress/myStatus 포함)
     */
    @Getter
    @Builder
    public static class MissionInfo {
        private Long id;
        private MissionType type;
        private String koCategory;
        private String enCategory;
        private String koTitle;
        private String enTitle;
        private String koDesc;
        private String enDesc;
        private Integer xp;
        private Integer point;
        private List<StepInfo> steps;

        // 로그인 유저 기준 (미로그인이면 null)
        private Double myProgress;
        private MissionStatus myStatus;
        private Long myMemberMissionId;
    }

    /**
     * 미션 스텝 정보
     */
    @Getter
    @Builder
    public static class StepInfo {
        private Integer stepOrder;
        private String koStep;
        private String enStep;
    }

    /**
     * 미션 목록용 요약 정보
     */
    @Getter
    @Builder
    public static class MissionSummary {
        private Long id;
        private MissionType type;
        private String koCategory;
        private String enCategory;
        private String koTitle;
        private String enTitle;
        private String koDesc;
        private String enDesc;
        private Integer xp;
        private Integer point;

        // 로그인 유저 기준 (미로그인이면 null)
        private Double myProgress;
        private MissionStatus myStatus;
    }

    /**
     * 미션 완료 결과
     */
    @Getter
    @Builder
    public static class CompletionResult {
        private Long memberId;
        private Long missionId;
        private Integer earnedXp;
        private Integer earnedPoints;
        private Integer newTotalXp;
        private Integer newTotalPoints;
        private Integer newLevel;
    }
}
