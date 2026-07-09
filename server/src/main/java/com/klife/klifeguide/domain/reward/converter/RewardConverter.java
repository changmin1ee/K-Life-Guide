package com.klife.klifeguide.domain.reward.converter;

import com.klife.klifeguide.domain.reward.dto.RewardResDTO;
import com.klife.klifeguide.domain.reward.entity.Badge;
import com.klife.klifeguide.domain.reward.entity.MemberBadge;
import com.klife.klifeguide.domain.reward.entity.PointHistory;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
public class RewardConverter {

    public RewardResDTO.BadgeInfo toBadgeInfo(Badge badge, boolean earned, LocalDateTime earnedAt) {
        return RewardResDTO.BadgeInfo.builder()
                .id(badge.getId())
                .koName(badge.getKoName())
                .enName(badge.getEnName())
                .koDesc(badge.getKoDesc())
                .enDesc(badge.getEnDesc())
                .iconKey(badge.getIconKey())
                .requiredMissionCount(badge.getRequiredMissionCount())
                .earned(earned)
                .earnedAt(earnedAt)
                .build();
    }

    public RewardResDTO.BadgeInfo toBadgeInfo(Badge badge) {
        return toBadgeInfo(badge, false, null);
    }

    public RewardResDTO.BadgeInfo toBadgeInfo(MemberBadge memberBadge) {
        return toBadgeInfo(memberBadge.getBadge(), true, memberBadge.getEarnedAt());
    }

    public RewardResDTO.PointHistoryInfo toPointHistoryInfo(PointHistory pointHistory) {
        return RewardResDTO.PointHistoryInfo.builder()
                .id(pointHistory.getId())
                .points(pointHistory.getPoints())
                .xp(pointHistory.getXp())
                .description(pointHistory.getDescription())
                .source(pointHistory.getSource())
                .createdAt(pointHistory.getCreatedAt())
                .build();
    }

    public RewardResDTO.CategoryAdaptation toCategoryAdaptation(
            String koCategory, String enCategory, int completedCount, int totalCount) {
        double adaptationRate = totalCount > 0 ? (double) completedCount / totalCount : 0.0;
        return RewardResDTO.CategoryAdaptation.builder()
                .koCategory(koCategory)
                .enCategory(enCategory)
                .completedCount(completedCount)
                .totalCount(totalCount)
                .adaptationRate(adaptationRate)
                .build();
    }

    public RewardResDTO.PassportInfo toPassportInfo(List<RewardResDTO.CategoryAdaptation> adaptations) {
        return RewardResDTO.PassportInfo.builder()
                .categoryAdaptations(adaptations)
                .build();
    }
}
