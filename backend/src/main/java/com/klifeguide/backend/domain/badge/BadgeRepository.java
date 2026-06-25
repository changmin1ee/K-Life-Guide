package com.klifeguide.backend.domain.badge;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BadgeRepository extends JpaRepository<Badge, Long> {

    Optional<Badge> findByName(String name);

    List<Badge> findByBadgeType(BadgeType badgeType);
}
