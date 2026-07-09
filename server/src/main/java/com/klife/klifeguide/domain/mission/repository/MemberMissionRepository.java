package com.klife.klifeguide.domain.mission.repository;

import com.klife.klifeguide.domain.mission.entity.MemberMission;
import com.klife.klifeguide.domain.mission.enums.MissionStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface MemberMissionRepository extends JpaRepository<MemberMission, Long> {

    Optional<MemberMission> findByMemberIdAndMissionId(Long memberId, Long missionId);

    List<MemberMission> findByMemberId(Long memberId);

    List<MemberMission> findByMemberIdAndStatus(Long memberId, MissionStatus status);

    long countByMemberIdAndStatus(Long memberId, MissionStatus status);

    boolean existsByMemberIdAndMissionId(Long memberId, Long missionId);

    @Query("SELECT mm FROM MemberMission mm WHERE mm.memberId = :memberId AND mm.status = 'COMPLETED' ORDER BY mm.completedAt DESC")
    List<MemberMission> findCompletedByMemberIdOrderByCompletedAtDesc(@Param("memberId") Long memberId);

    @Query("SELECT COUNT(mm) FROM MemberMission mm WHERE mm.memberId = :memberId AND mm.status = 'COMPLETED' AND mm.completedAt >= :startOfDay AND mm.completedAt < :endOfDay")
    int countCompletedToday(@Param("memberId") Long memberId,
                            @Param("startOfDay") LocalDateTime startOfDay,
                            @Param("endOfDay") LocalDateTime endOfDay);
}
