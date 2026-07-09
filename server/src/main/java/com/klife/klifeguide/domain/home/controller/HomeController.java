package com.klife.klifeguide.domain.home.controller;

import com.klife.klifeguide.domain.home.dto.HomeResDTO;
import com.klife.klifeguide.domain.home.exception.code.HomeSuccessCode;
import com.klife.klifeguide.domain.home.service.HomeService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Tag(name = "Home", description = "홈 통합 API")
public class HomeController {

    private final HomeService homeService;

    /**
     * GET /api/home — 홈 통합 데이터 조회
     */
    @GetMapping("/api/home")
    @Operation(summary = "홈 데이터 조회", description = "로그인 유저의 홈 화면에 필요한 모든 데이터를 한 번에 반환합니다.")
    public ResponseEntity<ApiResponse<HomeResDTO.HomeData>> getHome(
            @AuthenticationPrincipal AuthMember authMember
    ) {
        HomeResDTO.HomeData result = homeService.getHomeData(authMember.getMemberId());
        return ResponseEntity.ok(ApiResponse.onSuccess(HomeSuccessCode.GET_HOME, result));
    }

    /**
     * GET /health — 헬스 체크 (permitAll)
     */
    @GetMapping("/health")
    @Operation(summary = "헬스 체크", description = "서버 상태 확인용 엔드포인트 (인증 불필요)")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("OK");
    }
}
