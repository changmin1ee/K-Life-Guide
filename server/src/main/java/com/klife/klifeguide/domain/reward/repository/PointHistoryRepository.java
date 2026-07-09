package com.klife.klifeguide.domain.reward.repository;

import com.klife.klifeguide.domain.reward.entity.PointHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PointHistoryRepository extends JpaRepository<PointHistory, Long> {

    List<PointHistory> findByMemberIdOrderByCreatedAtDesc(Long memberId);
}
