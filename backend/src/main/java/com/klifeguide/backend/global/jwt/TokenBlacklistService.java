package com.klifeguide.backend.global.jwt;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class TokenBlacklistService {

    private static final String BLACKLIST_KEY_PREFIX = "auth:blacklist:at:";

    private final StringRedisTemplate stringRedisTemplate;

    public TokenBlacklistService(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    public void blacklist(String jti, long remainingMillis, String reason) {
        if (remainingMillis <= 0) {
            return;
        }
        stringRedisTemplate.opsForValue().set(
                BLACKLIST_KEY_PREFIX + jti, reason, Duration.ofMillis(remainingMillis));
    }

    public boolean isBlacklisted(String jti) {
        return Boolean.TRUE.equals(stringRedisTemplate.hasKey(BLACKLIST_KEY_PREFIX + jti));
    }
}
