package com.klife.klifeguide.domain.mission.repository;

import com.klife.klifeguide.domain.mission.entity.MissionStep;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MissionStepRepository extends JpaRepository<MissionStep, Long> {
}
