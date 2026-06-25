package com.klifeguide.backend.domain.mission;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MissionRepository extends JpaRepository<Mission, Long> {

    @EntityGraph(attributePaths = "category")
    Page<Mission> findByStatus(MissionStatus status, Pageable pageable);

    @EntityGraph(attributePaths = "category")
    Page<Mission> findByCategoryIdAndStatus(Long categoryId, MissionStatus status, Pageable pageable);

    @EntityGraph(attributePaths = "category")
    Optional<Mission> findWithCategoryById(Long id);
}
