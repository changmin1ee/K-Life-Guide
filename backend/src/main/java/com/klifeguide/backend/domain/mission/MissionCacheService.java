package com.klifeguide.backend.domain.mission;

import com.klifeguide.backend.domain.mission.dto.CachedMissionPage;
import com.klifeguide.backend.domain.mission.dto.MissionResponse;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.Optional;

/**
 * mission:list:version 을 버전 키로 사용해, 목록 캐시는 패턴 삭제(SCAN/KEYS) 없이
 * INCR 한 번으로 통째로 무효화한다. 이전 버전 캐시는 TTL이 지나면 자연 소멸한다.
 */
@Component
public class MissionCacheService {

    private static final String LIST_VERSION_KEY = "mission:list:version";
    private static final Duration LIST_TTL = Duration.ofMinutes(10);
    private static final Duration DETAIL_TTL = Duration.ofMinutes(30);

    private final RedisTemplate<String, Object> redisTemplate;
    private final StringRedisTemplate stringRedisTemplate;

    public MissionCacheService(RedisTemplate<String, Object> redisTemplate, StringRedisTemplate stringRedisTemplate) {
        this.redisTemplate = redisTemplate;
        this.stringRedisTemplate = stringRedisTemplate;
    }

    public Optional<CachedMissionPage> getList(Long categoryId, Pageable pageable) {
        Object cached = redisTemplate.opsForValue().get(buildListKey(categoryId, pageable));
        return Optional.ofNullable((CachedMissionPage) cached);
    }

    public void putList(Long categoryId, Pageable pageable, CachedMissionPage page) {
        redisTemplate.opsForValue().set(buildListKey(categoryId, pageable), page, LIST_TTL);
    }

    public void evictAllLists() {
        stringRedisTemplate.opsForValue().increment(LIST_VERSION_KEY);
    }

    public Optional<MissionResponse> getDetail(Long missionId) {
        Object cached = redisTemplate.opsForValue().get(detailKey(missionId));
        return Optional.ofNullable((MissionResponse) cached);
    }

    public void putDetail(Long missionId, MissionResponse response) {
        redisTemplate.opsForValue().set(detailKey(missionId), response, DETAIL_TTL);
    }

    public void evictDetail(Long missionId) {
        redisTemplate.delete(detailKey(missionId));
    }

    private String buildListKey(Long categoryId, Pageable pageable) {
        String category = categoryId != null ? categoryId.toString() : "ALL";
        return "mission:list:v%d:cat:%s:page:%d:size:%d".formatted(
                currentListVersion(), category, pageable.getPageNumber(), pageable.getPageSize());
    }

    private String detailKey(Long missionId) {
        return "mission:detail:" + missionId;
    }

    private long currentListVersion() {
        String value = stringRedisTemplate.opsForValue().get(LIST_VERSION_KEY);
        return value != null ? Long.parseLong(value) : 0L;
    }
}
