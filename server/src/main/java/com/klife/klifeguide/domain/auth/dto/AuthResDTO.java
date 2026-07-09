package com.klife.klifeguide.domain.auth.dto;

import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import lombok.Builder;
import lombok.Getter;

public class AuthResDTO {

    @Getter
    @Builder
    public static class TokenResponse {
        private String accessToken;
        private String refreshToken;
        private MemberResDTO.MyProfile member;
    }
}
