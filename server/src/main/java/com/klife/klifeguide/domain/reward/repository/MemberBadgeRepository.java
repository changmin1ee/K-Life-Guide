package com.klife.klifeguide.domain.reward.repository;

import com.klife.klifeguide.domain.reward.entity.MemberBadge;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemberBadgeRepository extends JpaRepository<MemberBadge, Long> {

    List<MemberBadge> findByMemberIdOrderByEarnedAtDesc(Long memberId);

    boolean existsByMemberIdAndBadgeId(Long memberId, Long badgeId);
}
