package com.klifeguide.backend.domain.report;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportRepository extends JpaRepository<Report, Long> {

    Page<Report> findByTargetTypeAndTargetId(ReportTargetType targetType, Long targetId, Pageable pageable);

    Page<Report> findByStatus(ReportStatus status, Pageable pageable);

    Page<Report> findByReporterId(Long reporterId, Pageable pageable);
}
