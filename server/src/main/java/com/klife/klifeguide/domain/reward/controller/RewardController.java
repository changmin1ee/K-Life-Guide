package com.klife.klifeguide.domain.reward.controller;

import com.klife.klifeguide.domain.reward.dto.RewardResDTO;
import com.klife.klifeguide.domain.reward.exception.code.RewardSuccessCode;
import com.klife.klifeguide.domain.reward.service.RewardService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name = "Reward", description = "보상/뱃지/포인트 API")
public class RewardController {

    private final RewardService rewardService;

    @GetMapping("/api/members/me/badges")
    @Operation(summary = "내 뱃지 목록 조회", description = "획득한 뱃지와 미획득 뱃지 목록을 조회합니다.")
    public ApiResponse<List<RewardResDTO.BadgeInfo>> getMyBadges(
            @AuthenticationPrincipal AuthMember authMember) {

        List<RewardResDTO.BadgeInfo> result = rewardService.getMyBadges(authMember.getMemberId());
        return ApiResponse.onSuccess(RewardSuccessCode.GET_BADGES, result);
    }

    @GetMapping("/api/members/me/points/history")
    @Operation(summary = "포인트 내역 조회", description = "포인트 적립 내역을 최신순으로 조회합니다.")
    public ApiResponse<List<RewardResDTO.PointHistoryInfo>> getPointHistory(
            @AuthenticationPrincipal AuthMember authMember) {

        List<RewardResDTO.PointHistoryInfo> result = rewardService.getPointHistory(authMember.getMemberId());
        return ApiResponse.onSuccess(RewardSuccessCode.GET_POINT_HISTORY, result);
    }

    @GetMapping("/api/members/me/passport")
    @Operation(summary = "K-라이프 패스포트 조회", description = "카테고리별 적응률을 조회합니다.")
    public ApiResponse<RewardResDTO.PassportInfo> getPassport(
            @AuthenticationPrincipal AuthMember authMember) {

        RewardResDTO.PassportInfo result = rewardService.getPassport(authMember.getMemberId());
        return ApiResponse.onSuccess(RewardSuccessCode.GET_PASSPORT, result);
    }
}
