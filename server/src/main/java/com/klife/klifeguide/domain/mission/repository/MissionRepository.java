package com.klife.klifeguide.domain.mission.repository;

import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MissionRepository extends JpaRepository<Mission, Long> {

    List<Mission> findAllByOrderBySortOrderAsc();

    List<Mission> findByTypeOrderBySortOrderAsc(MissionType type);
}
