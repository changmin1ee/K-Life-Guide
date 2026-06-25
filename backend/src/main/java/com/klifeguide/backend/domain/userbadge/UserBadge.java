package com.klifeguide.backend.domain.userbadge;

import com.klifeguide.backend.domain.badge.Badge;
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
        name = "user_badges",
        uniqueConstraints = @UniqueConstraint(name = "uk_user_badges", columnNames = {"user_id", "badge_id"})
)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserBadge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "badge_id", nullable = false)
    private Badge badge;

    @Column(name = "acquired_at", nullable = false)
    private LocalDateTime acquiredAt;

    @Builder
    private UserBadge(User user, Badge badge) {
        this.user = user;
        this.badge = badge;
        this.acquiredAt = LocalDateTime.now();
    }
}
