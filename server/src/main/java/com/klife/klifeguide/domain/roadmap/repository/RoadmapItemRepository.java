package com.klife.klifeguide.domain.roadmap.repository;

import com.klife.klifeguide.domain.roadmap.entity.RoadmapItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoadmapItemRepository extends JpaRepository<RoadmapItem, Long> {

    List<RoadmapItem> findAllByOrderBySortOrderAsc();
}
