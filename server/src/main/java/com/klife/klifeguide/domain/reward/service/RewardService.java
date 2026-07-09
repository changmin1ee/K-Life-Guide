package com.klife.klifeguide.domain.reward.service;

import com.klife.klifeguide.domain.mission.entity.MemberMission;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.enums.MissionCategory;
import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import com.klife.klifeguide.domain.mission.repository.MemberMissionRepository;
import com.klife.klifeguide.domain.mission.repository.MissionRepository;
import com.klife.klifeguide.domain.reward.converter.RewardConverter;
import com.klife.klifeguide.domain.reward.dto.RewardResDTO;
import com.klife.klifeguide.domain.reward.entity.Badge;
import com.klife.klifeguide.domain.reward.entity.MemberBadge;
import com.klife.klifeguide.domain.reward.entity.PointHistory;
import com.klife.klifeguide.domain.reward.enums.PointSource;
import com.klife.klifeguide.domain.reward.repository.BadgeRepository;
import com.klife.klifeguide.domain.reward.repository.MemberBadgeRepository;
import com.klife.klifeguide.domain.reward.repository.PointHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RewardService {

    private final BadgeRepository badgeRepository;
    private final MemberBadgeRepository memberBadgeRepository;
    private final PointHistoryRepository pointHistoryRepository;
    private final MissionRepository missionRepository;
    private final MemberMissionRepository memberMissionRepository;
    private final RewardConverter rewardConverter;

    public List<RewardResDTO.BadgeInfo> getMyBadges(Long memberId) {
        List<Badge> allBadges = badgeRepository.findAll();

        Map<Long, MemberBadge> earnedMap = memberBadgeRepository.findByMemberIdOrderByEarnedAtDesc(memberId)
                .stream()
                .collect(Collectors.toMap(mb -> mb.getBadge().getId(), mb -> mb));

        List<RewardResDTO.BadgeInfo> earnedBadges = new ArrayList<>();
        List<RewardResDTO.BadgeInfo> unearnedBadges = new ArrayList<>();

        for (Badge badge : allBadges) {
            if (earnedMap.containsKey(badge.getId())) {
                earnedBadges.add(rewardConverter.toBadgeInfo(earnedMap.get(badge.getId())));
            } else {
                unearnedBadges.add(rewardConverter.toBadgeInfo(badge));
            }
        }

        earnedBadges.addAll(unearnedBadges);
        return earnedBadges;
    }

    public List<RewardResDTO.PointHistoryInfo> getPointHistory(Long memberId) {
        return pointHistoryRepository.findByMemberIdOrderByCreatedAtDesc(memberId)
                .stream()
                .map(rewardConverter::toPointHistoryInfo)
                .collect(Collectors.toList());
    }

    public RewardResDTO.PassportInfo getPassport(Long memberId) {
        List<Mission> allMissions = missionRepository.findAll();
        List<MemberMission> completedMissions = memberMissionRepository.findByMemberIdAndStatus(memberId, MissionStatus.COMPLETED);

        Set<Long> completedMissionIds = completedMissions.stream()
                .map(mm -> mm.getMission().getId())
                .collect(Collectors.toSet());

        List<RewardResDTO.CategoryAdaptation> adaptations = Arrays.stream(MissionCategory.values())
                .map(category -> {
                    long totalCount = allMissions.stream()
                            .filter(m -> m.getKoCategory().equals(category.getKo()))
                            .count();
                    long completedCount = allMissions.stream()
                            .filter(m -> m.getKoCategory().equals(category.getKo())
                                    && completedMissionIds.contains(m.getId()))
                            .count();
                    return rewardConverter.toCategoryAdaptation(
                            category.getKo(),
                            category.getEn(),
                            (int) completedCount,
                            (int) totalCount
                    );
                })
                .collect(Collectors.toList());

        return rewardConverter.toPassportInfo(adaptations);
    }

    @Transactional
    public void checkAndAwardBadges(Long memberId, int completedMissionCount) {
        List<Badge> eligibleBadges = badgeRepository
                .findByRequiredMissionCountLessThanEqualOrderByRequiredMissionCountAsc(completedMissionCount);

        for (Badge badge : eligibleBadges) {
            if (!memberBadgeRepository.existsByMemberIdAndBadgeId(memberId, badge.getId())) {
                MemberBadge memberBadge = MemberBadge.builder()
                        .memberId(memberId)
                        .badge(badge)
                        .earnedAt(LocalDateTime.now())
                        .build();
                memberBadgeRepository.save(memberBadge);
            }
        }
    }

    @Transactional
    public void recordPointHistory(Long memberId, int points, int xp, String description, PointSource source) {
        PointHistory pointHistory = PointHistory.builder()
                .memberId(memberId)
                .points(points)
                .xp(xp)
                .description(description)
                .source(source)
                .build();
        pointHistoryRepository.save(pointHistory);
    }
}
