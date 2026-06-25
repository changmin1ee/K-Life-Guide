package com.klifeguide.backend.domain.user.dto;

import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.domain.user.UserRole;

public record UserResponse(
        Long id,
        String email,
        String nickname,
        String profileImageUrl,
        UserRole role,
        int totalPoints,
        int level
) {
    public static UserResponse from(User user) {
        return new UserResponse(
                user.getId(),
                user.getEmail(),
                user.getNickname(),
                user.getProfileImageUrl(),
                user.getRole(),
                user.getTotalPoints(),
                user.getLevel()
        );
    }
}
