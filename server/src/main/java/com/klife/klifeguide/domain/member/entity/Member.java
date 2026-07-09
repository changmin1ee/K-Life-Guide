package com.klife.klifeguide.domain.member.entity;

import com.klife.klifeguide.domain.member.enums.Language;
import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "member")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "profile_image_url")
    private String profileImageUrl;

    @Column(name = "provider_id")
    private String providerId;

    @Builder.Default
    @Column(nullable = false)
    private Integer points = 0;

    @Builder.Default
    @Column(nullable = false)
    private Integer xp = 0;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Language language = Language.KO;

    @Column(name = "last_login_at")
    private LocalDateTime lastLoginAt;

    public void addPoints(int amount) {
        this.points += amount;
    }

    public void addXp(int amount) {
        this.xp += amount;
    }

    public void updateLanguage(Language language) {
        this.language = language;
    }

    public void updateLastLoginAt(LocalDateTime time) {
        this.lastLoginAt = time;
    }

    public int getLevel() {
        return 3 + (xp / 500);
    }
}
