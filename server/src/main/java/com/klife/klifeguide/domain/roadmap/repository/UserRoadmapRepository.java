package com.klife.klifeguide.domain.roadmap.repository;

import com.klife.klifeguide.domain.roadmap.entity.UserRoadmap;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRoadmapRepository extends JpaRepository<UserRoadmap, Long> {

    Optional<UserRoadmap> findByMemberIdAndRoadmapItemId(Long memberId, Long itemId);

    List<UserRoadmap> findByMemberIdOrderByRoadmapItemSortOrderAsc(Long memberId);

    long countByMemberIdAndDoneTrue(Long memberId);
}
