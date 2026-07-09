package com.klife.klifeguide.domain.roadmap.controller;

import com.klife.klifeguide.domain.roadmap.dto.RoadmapResDTO;
import com.klife.klifeguide.domain.roadmap.exception.code.RoadmapSuccessCode;
import com.klife.klifeguide.domain.roadmap.service.RoadmapService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/roadmap")
@RequiredArgsConstructor
@Tag(name = "Roadmap", description = "7일 정착 로드맵 API")
public class RoadmapController {

    private final RoadmapService roadmapService;

    @GetMapping
    @Operation(summary = "로드맵 조회", description = "7일 정착 로드맵 전체 진행 상황을 조회합니다.")
    public ApiResponse<RoadmapResDTO.RoadmapProgress> getRoadmap(
            @AuthenticationPrincipal AuthMember authMember) {

        RoadmapResDTO.RoadmapProgress result = roadmapService.getRoadmap(authMember.getMemberId());
        return ApiResponse.onSuccess(RoadmapSuccessCode.GET_ROADMAP, result);
    }

    @PostMapping("/{itemId}/toggle")
    @Operation(summary = "로드맵 항목 토글", description = "로드맵 항목의 완료 상태를 토글합니다.")
    public ApiResponse<RoadmapResDTO.RoadmapItemInfo> toggleRoadmapItem(
            @PathVariable Long itemId,
            @AuthenticationPrincipal AuthMember authMember) {

        RoadmapResDTO.RoadmapItemInfo result = roadmapService.toggleRoadmapItem(authMember.getMemberId(), itemId);
        return ApiResponse.onSuccess(RoadmapSuccessCode.UPDATE_ROADMAP_ITEM, result);
    }
}
