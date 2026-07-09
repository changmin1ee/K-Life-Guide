package com.klife.klifeguide.domain.auth.controller;

import com.klife.klifeguide.domain.auth.dto.AuthResDTO;
import com.klife.klifeguide.domain.auth.exception.code.AuthSuccessCode;
import com.klife.klifeguide.domain.member.converter.MemberConverter;
import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.service.MemberService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.jwt.JwtProvider;
import com.klife.klifeguide.global.redis.RefreshTokenRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.*;

/**
 * 개발/테스트 전용 인증 컨트롤러.
 * Google OAuth Client ID 없이 이메일만으로 JWT 발급.
 *
 * ⚠️ @Profile("dev") — 운영 환경에서는 절대 활성화되지 않음.
 */
@Profile("dev")
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Auth Dev", description = "개발 전용 인증 API (운영 비활성)")
public class AuthDevController {

    private final MemberService memberService;
    private final MemberConverter memberConverter;
    private final JwtProvider jwtProvider;
    private final RefreshTokenRepository refreshTokenRepository;

    @PostMapping("/dev-login")
    @Operation(
            summary = "[DEV] 이메일 로그인",
            description = "Google OAuth 없이 이메일만으로 JWT 발급. dev 프로파일에서만 동작."
    )
    public ApiResponse<AuthResDTO.TokenResponse> devLogin(@RequestParam String email) {
        Member member = memberService.findOrCreate(
                email,
                "Dev User",
                "dev_" + email,   // providerId
                null
        );

        String accessToken  = jwtProvider.generateAccessToken(member.getId());
        String refreshToken = jwtProvider.generateRefreshToken(member.getId());
        refreshTokenRepository.save(member.getId(), refreshToken);

        MemberResDTO.MyProfile profile = memberConverter.toMyProfile(member, 0);

        return ApiResponse.onSuccess(
                AuthSuccessCode.LOGIN_SUCCESS,
                AuthResDTO.TokenResponse.builder()
                        .accessToken(accessToken)
                        .refreshToken(refreshToken)
                        .member(profile)
                        .build()
        );
    }
}
