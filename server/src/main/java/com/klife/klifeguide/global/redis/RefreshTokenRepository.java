package com.klife.klifeguide.global.redis;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class RefreshTokenRepository {

    private static final String KEY_PREFIX = "refresh:";
    private final StringRedisTemplate stringRedisTemplate;

    // Refresh Token 저장 (7일 TTL)
    public void save(Long memberId, String refreshToken) {
        stringRedisTemplate.opsForValue()
                .set(KEY_PREFIX + memberId, refreshToken, Duration.ofDays(7));
    }

    // Refresh Token 조회
    public Optional<String> findByMemberId(Long memberId) {
        String token = stringRedisTemplate.opsForValue().get(KEY_PREFIX + memberId);
        return Optional.ofNullable(token);
    }

    // Refresh Token 삭제 (로그아웃)
    public void delete(Long memberId) {
        stringRedisTemplate.delete(KEY_PREFIX + memberId);
    }

    // 유효성 검사 (저장된 토큰과 일치하는지)
    public boolean isValid(Long memberId, String refreshToken) {
        return findByMemberId(memberId)
                .map(stored -> stored.equals(refreshToken))
                .orElse(false);
    }
}
