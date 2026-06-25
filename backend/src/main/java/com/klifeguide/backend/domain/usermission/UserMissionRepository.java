package com.klifeguide.backend.domain.usermission;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface UserMissionRepository extends JpaRepository<UserMission, Long> {

    List<UserMission> findByUserIdAndMissionIdOrderByAttemptNoDesc(Long userId, Long missionId);

    Optional<UserMission> findTopByUserIdAndMissionIdOrderByAttemptNoDesc(Long userId, Long missionId);

    boolean existsByUserIdAndMissionIdAndStatusIn(Long userId, Long missionId, Collection<UserMissionStatus> statuses);

    @Query(
            value = "SELECT um FROM UserMission um JOIN FETCH um.mission WHERE um.user.id = :userId",
            countQuery = "SELECT COUNT(um) FROM UserMission um WHERE um.user.id = :userId"
    )
    Page<UserMission> findByUserId(@Param("userId") Long userId, Pageable pageable);

    Page<UserMission> findByStatus(UserMissionStatus status, Pageable pageable);
}
