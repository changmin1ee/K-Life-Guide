package com.klife.klifeguide.domain.home.service;

import com.klife.klifeguide.domain.home.dto.HomeResDTO;
import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.repository.MemberRepository;
import com.klife.klifeguide.domain.mission.converter.MissionConverter;
import com.klife.klifeguide.domain.mission.dto.MissionResDTO;
import com.klife.klifeguide.domain.mission.entity.MemberMission;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import com.klife.klifeguide.domain.mission.repository.MemberMissionRepository;
import com.klife.klifeguide.domain.mission.repository.MissionRepository;
import com.klife.klifeguide.domain.roadmap.dto.RoadmapResDTO;
import com.klife.klifeguide.domain.roadmap.service.RoadmapService;
import com.klife.klifeguide.global.apiPayload.code.GeneralErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class HomeService {

    private final MemberRepository memberRepository;
    private final MemberMissionRepository memberMissionRepository;
    private final MissionRepository missionRepository;
    private final MissionConverter missionConverter;
    private final RoadmapService roadmapService;

    public HomeResDTO.HomeData getHomeData(Long memberId) {
        // 1. Member 조회
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new ProjectException(GeneralErrorCode.NOT_FOUND));

        // 2. IN_PROGRESS 미션 조회 (progress > 0, 완료 안된 것)
        List<MemberMission> inProgressMMs = memberMissionRepository
                .findByMemberIdAndStatus(memberId, MissionStatus.IN_PROGRESS)
                .stream()
                .filter(mm -> mm.getProgress() > 0)
                .collect(Collectors.toList());

        List<MissionResDTO.MissionSummary> inProgressMissions = inProgressMMs.stream()
                .map(mm -> missionConverter.toMissionSummary(mm.getMission(), mm))
                .collect(Collectors.toList());

        // 3. 최근 완료 미션 (최근 5개)
        List<MemberMission> completedMMs = memberMissionRepository
                .findCompletedByMemberIdOrderByCompletedAtDesc(memberId);

        List<MissionResDTO.MissionSummary> recentCompletedMissions = completedMMs.stream()
                .limit(5)
                .map(mm -> missionConverter.toMissionSummary(mm.getMission(), mm))
                .collect(Collectors.toList());

        // 4. 추천 미션: IN_PROGRESS가 있으면 첫 번째, 없으면 미시작 미션 중 첫 번째
        MissionResDTO.MissionSummary recommendedMission = null;

        List<MemberMission> allInProgress = memberMissionRepository
                .findByMemberIdAndStatus(memberId, MissionStatus.IN_PROGRESS);

        if (!allInProgress.isEmpty()) {
            MemberMission first = allInProgress.get(0);
            recommendedMission = missionConverter.toMissionSummary(first.getMission(), first);
        } else {
            Set<Long> startedMissionIds = memberMissionRepository.findByMemberId(memberId)
                    .stream()
                    .map(mm -> mm.getMission().getId())
                    .collect(Collectors.toSet());

            Mission firstNotStarted = missionRepository.findAllByOrderBySortOrderAsc()
                    .stream()
                    .filter(m -> !startedMissionIds.contains(m.getId()))
                    .findFirst()
                    .orElse(null);

            if (firstNotStarted != null) {
                recommendedMission = missionConverter.toMissionSummary(firstNotStarted, null);
            }
        }

        // 5. 로드맵 진행률
        RoadmapResDTO.RoadmapProgress roadmapProgress = roadmapService.getRoadmap(memberId);

        // 6. 오늘 완료한 미션 수
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();
        int todayCompletedCount = memberMissionRepository.countCompletedToday(memberId, startOfDay, endOfDay);

        // 7. 완료 미션 총 개수
        int completedMissionCount = (int) memberMissionRepository.countByMemberIdAndStatus(memberId, MissionStatus.COMPLETED);

        // 8. MemberSummary 조립
        HomeResDTO.MemberSummary memberSummary = HomeResDTO.MemberSummary.builder()
                .id(member.getId())
                .name(member.getName())
                .profileImageUrl(member.getProfileImageUrl())
                .level(member.getLevel())
                .xp(member.getXp())
                .points(member.getPoints())
                .completedMissionCount(completedMissionCount)
                .language(member.getLanguage())
                .build();

        return HomeResDTO.HomeData.builder()
                .member(memberSummary)
                .inProgressMissions(inProgressMissions)
                .recentCompletedMissions(recentCompletedMissions)
                .recommendedMission(recommendedMission)
                .roadmapProgress(roadmapProgress)
                .todayCompletedCount(todayCompletedCount)
                .build();
    }
}
