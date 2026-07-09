package com.klife.klifeguide.domain.reward.repository;

import com.klife.klifeguide.domain.reward.entity.Badge;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BadgeRepository extends JpaRepository<Badge, Long> {

    List<Badge> findByRequiredMissionCountLessThanEqualOrderByRequiredMissionCountAsc(int count);
}
