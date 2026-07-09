package com.klife.klifeguide.domain.auth.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.klife.klifeguide.domain.auth.dto.AuthResDTO;
import com.klife.klifeguide.domain.auth.exception.AuthException;
import com.klife.klifeguide.domain.auth.exception.code.AuthErrorCode;
import com.klife.klifeguide.domain.member.converter.MemberConverter;
import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.service.MemberService;
import com.klife.klifeguide.global.jwt.JwtProvider;
import com.klife.klifeguide.global.redis.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class AuthService {

    private static final String GOOGLE_TOKENINFO_URL =
            "https://oauth2.googleapis.com/tokeninfo?id_token=";

    private final MemberService memberService;
    private final MemberConverter memberConverter;
    private final JwtProvider jwtProvider;
    private final ObjectMapper objectMapper;
    private final RefreshTokenRepository refreshTokenRepository;
    private final RestTemplate restTemplate;

    @Value("${google.client-id}")
    private String googleClientId;

    public AuthResDTO.TokenResponse googleLogin(String idToken) {
        GoogleTokenPayload payload = verifyGoogleToken(idToken);

        Member member = memberService.findOrCreate(
                payload.email(),
                payload.name(),
                payload.sub(),
                payload.picture()
        );
        member.updateLastLoginAt(LocalDateTime.now());

        String accessToken  = jwtProvider.generateAccessToken(member.getId());
        String refreshToken = jwtProvider.generateRefreshToken(member.getId());
        refreshTokenRepository.save(member.getId(), refreshToken);

        MemberResDTO.MyProfile profile = memberConverter.toMyProfile(member, 0);

        return AuthResDTO.TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .member(profile)
                .build();
    }

    public void logout(Long memberId) {
        refreshTokenRepository.delete(memberId);
    }

    /**
     * Google tokeninfo 엔드포인트를 호출하여 ID 토큰을 검증한다.
     * - 토큰 만료(exp) 검증은 Google이 처리
     * - aud(client_id) 일치 여부는 직접 검증
     * - GOOGLE_CLIENT_ID가 "dummy-client-id"인 경우(개발/테스트) aud 검증 스킵
     */
    private GoogleTokenPayload verifyGoogleToken(String idToken) {
        try {
            String url = GOOGLE_TOKENINFO_URL + idToken;
            ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);

            if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
                throw new AuthException(AuthErrorCode.INVALID_GOOGLE_TOKEN);
            }

            JsonNode node = objectMapper.readTree(response.getBody());

            // 에러 응답 체크
            if (node.has("error")) {
                log.warn("[AuthService] Google tokeninfo error: {}", node.get("error").asText());
                throw new AuthException(AuthErrorCode.INVALID_GOOGLE_TOKEN);
            }

            // aud(client_id) 검증 (dummy가 아닌 경우만)
            if (!"dummy-client-id".equals(googleClientId)) {
                String aud = getText(node, "aud");
                if (!googleClientId.equals(aud)) {
                    log.warn("[AuthService] Google token aud mismatch. expected={}, actual={}", googleClientId, aud);
                    throw new AuthException(AuthErrorCode.INVALID_GOOGLE_TOKEN);
                }
            }

            return new GoogleTokenPayload(
                    getText(node, "sub"),
                    getText(node, "email"),
                    getTextOrDefault(node, "name", "K-Life User"),
                    getTextOrDefault(node, "picture", null)
            );

        } catch (AuthException e) {
            throw e;
        } catch (Exception e) {
            log.error("[AuthService] Google token verification failed: {}", e.getMessage());
            throw new AuthException(AuthErrorCode.INVALID_GOOGLE_TOKEN);
        }
    }

    private String getText(JsonNode node, String field) {
        JsonNode child = node.get(field);
        if (child == null || child.isNull() || child.asText().isBlank()) {
            throw new AuthException(AuthErrorCode.INVALID_GOOGLE_TOKEN);
        }
        return child.asText();
    }

    private String getTextOrDefault(JsonNode node, String field, String defaultValue) {
        JsonNode child = node.get(field);
        return (child != null && !child.isNull()) ? child.asText() : defaultValue;
    }

    private record GoogleTokenPayload(String sub, String email, String name, String picture) {}
}
