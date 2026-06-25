package com.klifeguide.backend.domain.missioncategory;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MissionCategoryRepository extends JpaRepository<MissionCategory, Long> {

    Optional<MissionCategory> findByName(String name);

    List<MissionCategory> findAllByOrderByDisplayOrderAsc();
}
