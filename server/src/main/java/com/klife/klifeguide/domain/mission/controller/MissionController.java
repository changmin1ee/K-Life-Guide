package com.klife.klifeguide.domain.mission.controller;

import com.klife.klifeguide.domain.mission.dto.MissionReqDTO;
import com.klife.klifeguide.domain.mission.dto.MissionResDTO;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import com.klife.klifeguide.domain.mission.exception.code.MissionSuccessCode;
import com.klife.klifeguide.domain.mission.service.MissionService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name = "Mission", description = "미션 API")
public class MissionController {

    private final MissionService missionService;

    /**
     * GET /api/missions — 미션 목록 조회 (필터: type)
     */
    @GetMapping("/api/missions")
    @Operation(summary = "미션 목록 조회", description = "type 필터 없으면 전체 반환. 로그인 시 나의 진행 상태 포함.")
    public ResponseEntity<ApiResponse<List<MissionResDTO.MissionSummary>>> getMissions(
            @RequestParam(required = false) MissionType type,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        Long memberId = (authMember != null) ? authMember.getMemberId() : null;
        List<MissionResDTO.MissionSummary> result = missionService.getMissions(type, memberId);
        return ResponseEntity.ok(ApiResponse.onSuccess(MissionSuccessCode.GET_MISSIONS, result));
    }

    /**
     * GET /api/missions/{missionId} — 미션 상세 조회
     */
    @GetMapping("/api/missions/{missionId}")
    @Operation(summary = "미션 상세 조회", description = "steps 포함. 로그인 시 나의 진행 상태 포함.")
    public ResponseEntity<ApiResponse<MissionResDTO.MissionInfo>> getMission(
            @PathVariable Long missionId,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        Long memberId = (authMember != null) ? authMember.getMemberId() : null;
        MissionResDTO.MissionInfo result = missionService.getMissionDetail(missionId, memberId);
        return ResponseEntity.ok(ApiResponse.onSuccess(MissionSuccessCode.GET_MISSION, result));
    }

    /**
     * POST /api/missions/{missionId}/start — 미션 시작
     */
    @PostMapping("/api/missions/{missionId}/start")
    @Operation(summary = "미션 시작", description = "로그인 필수. MemberMission 생성 (IN_PROGRESS, progress=0.0)")
    public ResponseEntity<ApiResponse<MissionResDTO.MissionInfo>> startMission(
            @PathVariable Long missionId,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        MissionResDTO.MissionInfo result = missionService.startMission(authMember.getMemberId(), missionId);
        return ResponseEntity.status(201)
                .body(ApiResponse.onSuccess(MissionSuccessCode.START_MISSION, result));
    }

    /**
     * POST /api/missions/{missionId}/complete — 미션 완료
     */
    @PostMapping("/api/missions/{missionId}/complete")
    @Operation(summary = "미션 완료", description = "VERIFY 타입은 proofImageUrl 필수.")
    public ResponseEntity<ApiResponse<MissionResDTO.CompletionResult>> completeMission(
            @PathVariable Long missionId,
            @RequestBody(required = false) MissionReqDTO.CompleteMission request,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        String proofImageUrl = (request != null) ? request.getProofImageUrl() : null;
        MissionResDTO.CompletionResult result =
                missionService.completeMission(authMember.getMemberId(), missionId, proofImageUrl);
        return ResponseEntity.ok(ApiResponse.onSuccess(MissionSuccessCode.COMPLETE_MISSION, result));
    }

    /**
     * GET /api/members/me/missions — 내 미션 목록 (진행 중 + 완료)
     */
    @GetMapping("/api/members/me/missions")
    @Operation(summary = "내 미션 목록 조회", description = "로그인 필수. 진행 중 + 완료 미션 모두 반환.")
    public ResponseEntity<ApiResponse<List<MissionResDTO.MissionSummary>>> getMyMissions(
            @AuthenticationPrincipal AuthMember authMember
    ) {
        List<MissionResDTO.MissionSummary> result = missionService.getMyMissions(authMember.getMemberId());
        return ResponseEntity.ok(ApiResponse.onSuccess(MissionSuccessCode.GET_MY_MISSIONS, result));
    }

    /**
     * GET /api/members/me/missions/completed — 완료한 미션 목록
     */
    @GetMapping("/api/members/me/missions/completed")
    @Operation(summary = "완료한 미션 목록 조회", description = "로그인 필수. 완료된 미션만 반환.")
    public ResponseEntity<ApiResponse<List<MissionResDTO.MissionSummary>>> getMyCompletedMissions(
            @AuthenticationPrincipal AuthMember authMember
    ) {
        List<MissionResDTO.MissionSummary> result =
                missionService.getMyCompletedMissions(authMember.getMemberId());
        return ResponseEntity.ok(ApiResponse.onSuccess(MissionSuccessCode.GET_MY_MISSIONS, result));
    }
}
