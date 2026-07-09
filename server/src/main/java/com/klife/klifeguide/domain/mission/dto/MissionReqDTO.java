package com.klife.klifeguide.domain.mission.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

public class MissionReqDTO {

    /**
     * 미션 시작 요청 (body 없음, missionId는 path variable)
     */
    @Getter
    @NoArgsConstructor
    public static class StartMission {
    }

    /**
     * 미션 완료 요청
     * - VERIFY 타입: proofImageUrl 필수
     * - GUIDE  타입: proofImageUrl null
     */
    @Getter
    @NoArgsConstructor
    public static class CompleteMission {
        private String proofImageUrl;
    }

    /**
     * 진행률 업데이트 요청
     */
    @Getter
    @NoArgsConstructor
    public static class UpdateProgress {
        private Double progress;
    }
}
