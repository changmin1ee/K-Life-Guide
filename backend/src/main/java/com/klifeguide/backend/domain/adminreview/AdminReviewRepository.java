package com.klifeguide.backend.domain.adminreview;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminReviewRepository extends JpaRepository<AdminReview, Long> {

    Optional<AdminReview> findByUserMissionId(Long userMissionId);

    Page<AdminReview> findByAdminId(Long adminId, Pageable pageable);
}
