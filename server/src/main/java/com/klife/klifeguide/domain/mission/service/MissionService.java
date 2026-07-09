package com.klife.klifeguide.domain.mission.service;

import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.exception.MemberException;
import com.klife.klifeguide.domain.member.exception.code.MemberErrorCode;
import com.klife.klifeguide.domain.member.repository.MemberRepository;
import com.klife.klifeguide.domain.mission.converter.MissionConverter;
import com.klife.klifeguide.domain.mission.dto.MissionResDTO;
import com.klife.klifeguide.domain.mission.entity.MemberMission;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import com.klife.klifeguide.domain.mission.exception.MissionException;
import com.klife.klifeguide.domain.mission.exception.code.MissionErrorCode;
import com.klife.klifeguide.domain.mission.repository.MemberMissionRepository;
import com.klife.klifeguide.domain.mission.repository.MissionRepository;
import com.klife.klifeguide.domain.reward.enums.PointSource;
import com.klife.klifeguide.domain.reward.service.RewardService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class MissionService {

    private final MissionRepository missionRepository;
    private final MemberMissionRepository memberMissionRepository;
    private final MemberRepository memberRepository;
    private final MissionConverter missionConverter;
    private final RewardService rewardService;

    @Autowired
    public MissionService(
            MissionRepository missionRepository,
            MemberMissionRepository memberMissionRepository,
            MemberRepository memberRepository,
            MissionConverter missionConverter,
            @Lazy RewardService rewardService
    ) {
        this.missionRepository = missionRepository;
        this.memberMissionRepository = memberMissionRepository;
        this.memberRepository = memberRepository;
        this.missionConverter = missionConverter;
        this.rewardService = rewardService;
    }

    /**
     * 미션 목록 조회
     * type이 null이면 전체, memberId가 있으면 myProgress/myStatus 포함
     * 비로그인(memberId=null) + 타입 필터 없음(type=null)인 경우 캐시 사용
     */
    public List<MissionResDTO.MissionSummary> getMissions(MissionType type, Long memberId) {
        // 비로그인 전체 목록은 캐시된 메서드로 위임
        if (memberId == null && type == null) {
            return getAllMissionsForGuest();
        }

        List<Mission> missions = (type == null)
                ? missionRepository.findAllByOrderBySortOrderAsc()
                : missionRepository.findByTypeOrderBySortOrderAsc(type);

        Map<Long, MemberMission> memberMissionMap = buildMemberMissionMap(memberId);

        return missions.stream()
                .map(m -> missionConverter.toMissionSummary(m, memberMissionMap.get(m.getId())))
                .collect(Collectors.toList());
    }

    /**
     * 비로그인 게스트용 전체 미션 목록 (캐시 적용, TTL 30분)
     */
    @Cacheable(value = "missions", key = "'all'")
    public List<MissionResDTO.MissionSummary> getAllMissionsForGuest() {
        return missionRepository.findAllByOrderBySortOrderAsc().stream()
                .map(m -> missionConverter.toMissionSummary(m, null))
                .toList();
    }

    /**
     * 미션 상세 조회 (steps 포함)
     */
    public MissionResDTO.MissionInfo getMissionDetail(Long missionId, Long memberId) {
        Mission mission = findMissionById(missionId);
        MemberMission memberMission = findMemberMission(memberId, missionId);
        return missionConverter.toMissionInfo(mission, memberMission);
    }

    /**
     * 미션 시작
     */
    @Transactional
    public MissionResDTO.MissionInfo startMission(Long memberId, Long missionId) {
        Mission mission = findMissionById(missionId);

        Optional<MemberMission> existing = memberMissionRepository.findByMemberIdAndMissionId(memberId, missionId);
        if (existing.isPresent()) {
            MemberMission mm = existing.get();
            if (mm.getStatus() == MissionStatus.COMPLETED) {
                throw new MissionException(MissionErrorCode.MISSION_ALREADY_COMPLETED);
            }
            // 이미 IN_PROGRESS인 경우 현재 상태 반환
            return missionConverter.toMissionInfo(mission, mm);
        }

        MemberMission memberMission = MemberMission.builder()
                .memberId(memberId)
                .mission(mission)
                .status(MissionStatus.IN_PROGRESS)
                .progress(0.0)
                .build();

        memberMissionRepository.save(memberMission);
        return missionConverter.toMissionInfo(mission, memberMission);
    }

    /**
     * 미션 완료 — 완료 시 missions 캐시 전체 무효화
     */
    @Transactional
    @CacheEvict(value = "missions", allEntries = true)
    public MissionResDTO.CompletionResult completeMission(Long memberId, Long missionId, String proofImageUrl) {
        Mission mission = findMissionById(missionId);

        // VERIFY 타입 proofImageUrl 검증 (S3 미구현 동안 optional 처리)
        // if (mission.getType() == MissionType.VERIFY
        //         && (proofImageUrl == null || proofImageUrl.isBlank())) {
        //     throw new MissionException(MissionErrorCode.PROOF_IMAGE_REQUIRED);
        // }

        // 미션이 시작되지 않은 경우 자동으로 시작 처리
        MemberMission memberMission = memberMissionRepository
                .findByMemberIdAndMissionId(memberId, missionId)
                .orElseGet(() -> {
                    MemberMission newMm = MemberMission.builder()
                            .memberId(memberId)
                            .mission(mission)
                            .status(MissionStatus.IN_PROGRESS)
                            .progress(0.0)
                            .build();
                    return memberMissionRepository.save(newMm);
                });

        if (memberMission.getStatus() == MissionStatus.COMPLETED) {
            throw new MissionException(MissionErrorCode.MISSION_ALREADY_COMPLETED);
        }

        memberMission.complete(proofImageUrl);

        // Member xp/point 업데이트
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberException(MemberErrorCode.MEMBER_NOT_FOUND));

        member.addXp(mission.getXp());
        member.addPoints(mission.getPoint());

        // 완료 미션 수 집계 후 배지 지급 체크
        int completedCount = (int) memberMissionRepository.countByMemberIdAndStatus(memberId, MissionStatus.COMPLETED);
        rewardService.checkAndAwardBadges(memberId, completedCount);

        // 포인트 이력 기록
        rewardService.recordPointHistory(
                memberId,
                mission.getPoint(),
                mission.getXp(),
                mission.getKoTitle() + " 미션 완료",
                PointSource.MISSION_COMPLETE
        );

        return MissionResDTO.CompletionResult.builder()
                .memberId(memberId)
                .missionId(missionId)
                .earnedXp(mission.getXp())
                .earnedPoints(mission.getPoint())
                .newTotalXp(member.getXp())
                .newTotalPoints(member.getPoints())
                .newLevel(member.getLevel())
                .build();
    }

    /**
     * 내 미션 목록 (시작 + 완료 모두)
     */
    public List<MissionResDTO.MissionSummary> getMyMissions(Long memberId) {
        List<MemberMission> memberMissions = memberMissionRepository.findByMemberId(memberId);
        return memberMissions.stream()
                .map(mm -> missionConverter.toMissionSummary(mm.getMission(), mm))
                .collect(Collectors.toList());
    }

    /**
     * 완료한 미션 목록
     */
    public List<MissionResDTO.MissionSummary> getMyCompletedMissions(Long memberId) {
        List<MemberMission> memberMissions = memberMissionRepository
                .findByMemberIdAndStatus(memberId, MissionStatus.COMPLETED);
        return memberMissions.stream()
                .map(mm -> missionConverter.toMissionSummary(mm.getMission(), mm))
                .collect(Collectors.toList());
    }

    /**
     * 완료한 미션 수
     */
    public long getCompletedMissionCount(Long memberId) {
        return memberMissionRepository.countByMemberIdAndStatus(memberId, MissionStatus.COMPLETED);
    }

    // ────────── private helpers ──────────

    private Mission findMissionById(Long missionId) {
        return missionRepository.findById(missionId)
                .orElseThrow(() -> new MissionException(MissionErrorCode.MISSION_NOT_FOUND));
    }

    private MemberMission findMemberMission(Long memberId, Long missionId) {
        if (memberId == null) return null;
        return memberMissionRepository.findByMemberIdAndMissionId(memberId, missionId)
                .orElse(null);
    }

    private Map<Long, MemberMission> buildMemberMissionMap(Long memberId) {
        if (memberId == null) return Map.of();
        return memberMissionRepository.findByMemberId(memberId).stream()
                .collect(Collectors.toMap(mm -> mm.getMission().getId(), mm -> mm));
    }
}
