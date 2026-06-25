package com.klifeguide.backend.domain.friendship;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface FriendshipRepository extends JpaRepository<Friendship, Long> {

    Optional<Friendship> findByRequesterIdAndReceiverId(Long requesterId, Long receiverId);

    List<Friendship> findByReceiverIdAndStatus(Long receiverId, FriendshipStatus status);

    @Query("""
            SELECT f FROM Friendship f
            WHERE f.status = :status
            AND (f.requester.id = :userId OR f.receiver.id = :userId)
            """)
    List<Friendship> findAllByUserIdAndStatus(@Param("userId") Long userId, @Param("status") FriendshipStatus status);
}
