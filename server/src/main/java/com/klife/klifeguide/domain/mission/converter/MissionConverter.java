package com.klife.klifeguide.domain.mission.converter;

import com.klife.klifeguide.domain.mission.dto.MissionResDTO;
import com.klife.klifeguide.domain.mission.entity.MemberMission;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.entity.MissionStep;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class MissionConverter {

    public MissionResDTO.MissionInfo toMissionInfo(Mission mission, MemberMission memberMission) {
        List<MissionResDTO.StepInfo> stepInfos = mission.getSteps().stream()
                .map(this::toStepInfo)
                .collect(Collectors.toList());

        return MissionResDTO.MissionInfo.builder()
                .id(mission.getId())
                .type(mission.getType())
                .koCategory(mission.getKoCategory())
                .enCategory(mission.getEnCategory())
                .koTitle(mission.getKoTitle())
                .enTitle(mission.getEnTitle())
                .koDesc(mission.getKoDesc())
                .enDesc(mission.getEnDesc())
                .xp(mission.getXp())
                .point(mission.getPoint())
                .steps(stepInfos)
                .myProgress(memberMission != null ? memberMission.getProgress() : null)
                .myStatus(memberMission != null ? memberMission.getStatus() : null)
                .myMemberMissionId(memberMission != null ? memberMission.getId() : null)
                .build();
    }

    public MissionResDTO.MissionSummary toMissionSummary(Mission mission, MemberMission memberMission) {
        return MissionResDTO.MissionSummary.builder()
                .id(mission.getId())
                .type(mission.getType())
                .koCategory(mission.getKoCategory())
                .enCategory(mission.getEnCategory())
                .koTitle(mission.getKoTitle())
                .enTitle(mission.getEnTitle())
                .koDesc(mission.getKoDesc())
                .enDesc(mission.getEnDesc())
                .xp(mission.getXp())
                .point(mission.getPoint())
                .myProgress(memberMission != null ? memberMission.getProgress() : null)
                .myStatus(memberMission != null ? memberMission.getStatus() : null)
                .build();
    }

    public MissionResDTO.StepInfo toStepInfo(MissionStep step) {
        return MissionResDTO.StepInfo.builder()
                .stepOrder(step.getStepOrder())
                .koStep(step.getKoStep())
                .enStep(step.getEnStep())
                .build();
    }
}
