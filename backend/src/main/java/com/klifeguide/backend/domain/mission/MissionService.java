package com.klifeguide.backend.domain.mission;

import com.klifeguide.backend.domain.mission.dto.CachedMissionPage;
import com.klifeguide.backend.domain.mission.dto.CreateMissionRequest;
import com.klifeguide.backend.domain.mission.dto.MissionResponse;
import com.klifeguide.backend.domain.missioncategory.MissionCategory;
import com.klifeguide.backend.domain.missioncategory.MissionCategoryRepository;
import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.domain.user.UserRepository;
import com.klifeguide.backend.global.exception.BusinessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class MissionService {

    private final MissionRepository missionRepository;
    private final MissionCategoryRepository missionCategoryRepository;
    private final UserRepository userRepository;
    private final MissionCacheService missionCacheService;

    public MissionService(MissionRepository missionRepository,
                           MissionCategoryRepository missionCategoryRepository,
                           UserRepository userRepository,
                           MissionCacheService missionCacheService) {
        this.missionRepository = missionRepository;
        this.missionCategoryRepository = missionCategoryRepository;
        this.userRepository = userRepository;
        this.missionCacheService = missionCacheService;
    }

    public Page<MissionResponse> getMissions(Long categoryId, Pageable pageable) {
        return missionCacheService.getList(categoryId, pageable)
                .map(cached -> (Page<MissionResponse>) new PageImpl<>(cached.content(), pageable, cached.totalElements()))
                .orElseGet(() -> loadAndCacheMissions(categoryId, pageable));
    }

    private Page<MissionResponse> loadAndCacheMissions(Long categoryId, Pageable pageable) {
        Page<Mission> missions = categoryId != null
                ? missionRepository.findByCategoryIdAndStatus(categoryId, MissionStatus.ACTIVE, pageable)
                : missionRepository.findByStatus(MissionStatus.ACTIVE, pageable);

        List<MissionResponse> content = missions.getContent().stream().map(MissionResponse::from).toList();
        missionCacheService.putList(categoryId, pageable, new CachedMissionPage(content, missions.getTotalElements()));

        return new PageImpl<>(content, pageable, missions.getTotalElements());
    }

    public MissionResponse getMission(Long missionId) {
        return missionCacheService.getDetail(missionId)
                .orElseGet(() -> loadAndCacheMissionDetail(missionId));
    }

    private MissionResponse loadAndCacheMissionDetail(Long missionId) {
        Mission mission = missionRepository.findWithCategoryById(missionId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "MISSION_NOT_FOUND", "미션을 찾을 수 없습니다."));
        MissionResponse response = MissionResponse.from(mission);
        missionCacheService.putDetail(missionId, response);
        return response;
    }

    @Transactional
    public MissionResponse createMission(Long adminId, CreateMissionRequest request) {
        MissionCategory category = missionCategoryRepository.findById(request.categoryId())
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "MISSION_CATEGORY_NOT_FOUND", "미션 카테고리를 찾을 수 없습니다."));
        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "USER_NOT_FOUND", "사용자를 찾을 수 없습니다."));

        Mission mission = Mission.builder()
                .category(category)
                .createdBy(admin)
                .title(request.title())
                .description(request.description())
                .latitude(request.latitude())
                .longitude(request.longitude())
                .radiusMeters(request.radiusMeters() != null ? request.radiusMeters() : 100)
                .locationName(request.locationName())
                .address(request.address())
                .points(request.points())
                .difficulty(request.difficulty())
                .startDate(request.startDate())
                .endDate(request.endDate())
                .build();

        missionRepository.save(mission);
        missionCacheService.evictAllLists();

        return MissionResponse.from(mission);
    }
}
