package com.klifeguide.backend.domain.friendship;

import com.klifeguide.backend.domain.user.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Entity
@Table(
        name = "friendships",
        uniqueConstraints = @UniqueConstraint(name = "uk_friendships_pair", columnNames = {"requester_id", "receiver_id"})
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Friendship {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "requester_id", nullable = false)
    private User requester;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "receiver_id", nullable = false)
    private User receiver;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private FriendshipStatus status;

    @Column(name = "requested_at", nullable = false)
    private LocalDateTime requestedAt;

    @Column(name = "responded_at")
    private LocalDateTime respondedAt;

    @Builder
    private Friendship(User requester, User receiver) {
        if (requester.getId() != null && requester.getId().equals(receiver.getId())) {
            throw new IllegalArgumentException("자기 자신에게 친구 요청을 보낼 수 없습니다.");
        }
        this.requester = requester;
        this.receiver = receiver;
        this.status = FriendshipStatus.PENDING;
        this.requestedAt = LocalDateTime.now();
    }

    public void accept() {
        this.status = FriendshipStatus.ACCEPTED;
        this.respondedAt = LocalDateTime.now();
    }

    public void reject() {
        this.status = FriendshipStatus.REJECTED;
        this.respondedAt = LocalDateTime.now();
    }

    public void block() {
        this.status = FriendshipStatus.BLOCKED;
        this.respondedAt = LocalDateTime.now();
    }
}
