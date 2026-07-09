package com.klife.klifeguide.domain.auth.controller;

import com.klife.klifeguide.domain.auth.dto.AuthReqDTO;
import com.klife.klifeguide.domain.auth.dto.AuthResDTO;
import com.klife.klifeguide.domain.auth.exception.code.AuthSuccessCode;
import com.klife.klifeguide.domain.auth.service.AuthService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Auth", description = "인증 API")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/google")
    @Operation(
            summary = "Google 로그인",
            description = "Google ID 토큰으로 로그인 또는 회원가입합니다. " +
                    "개발 단계에서는 유효한 JWT 형식의 토큰이 아니어도 fallback으로 처리됩니다."
    )
    public ApiResponse<AuthResDTO.TokenResponse> googleLogin(
            @RequestBody AuthReqDTO.GoogleLogin request
    ) {
        AuthResDTO.TokenResponse response = authService.googleLogin(request.getIdToken());
        return ApiResponse.onSuccess(AuthSuccessCode.LOGIN_SUCCESS, response);
    }

    @PostMapping("/logout")
    @Operation(summary = "로그아웃", description = "Refresh Token 삭제")
    public ApiResponse<Void> logout(@AuthenticationPrincipal AuthMember authMember) {
        authService.logout(authMember.getMemberId());
        return ApiResponse.onSuccess(AuthSuccessCode.LOGOUT_SUCCESS, null);
    }

    @PostMapping("/refresh")
    @Operation(
            summary = "토큰 갱신",
            description = "Refresh 토큰으로 새로운 Access 토큰을 발급합니다."
    )
    public ApiResponse<AuthResDTO.TokenResponse> refresh(
            @RequestBody AuthReqDTO.GoogleLogin request  // TODO: RefreshReqDTO로 교체
    ) {
        // TODO: RefreshToken 검증 및 재발급 로직 구현
        throw new UnsupportedOperationException("refresh token 기능은 아직 구현되지 않았습니다.");
    }
}
