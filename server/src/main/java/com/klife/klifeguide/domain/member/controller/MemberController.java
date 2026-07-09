package com.klife.klifeguide.domain.member.controller;

import com.klife.klifeguide.domain.member.dto.MemberReqDTO;
import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import com.klife.klifeguide.domain.member.exception.code.MemberSuccessCode;
import com.klife.klifeguide.domain.member.service.MemberService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
@Tag(name = "Member", description = "회원 API")
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/me")
    @Operation(summary = "내 프로필 조회", description = "로그인한 회원의 프로필 정보를 조회합니다.")
    public ApiResponse<MemberResDTO.MyProfile> getMyProfile(
            @AuthenticationPrincipal AuthMember authMember
    ) {
        MemberResDTO.MyProfile profile = memberService.getMyProfile(authMember.getMemberId());
        return ApiResponse.onSuccess(MemberSuccessCode.GET_MY_PROFILE, profile);
    }

    @PatchMapping("/me/language")
    @Operation(summary = "언어 설정 변경", description = "사용 언어(KO/EN)를 변경합니다.")
    public ApiResponse<MemberResDTO.MyProfile> updateLanguage(
            @AuthenticationPrincipal AuthMember authMember,
            @RequestBody MemberReqDTO.UpdateLanguage request
    ) {
        MemberResDTO.MyProfile profile = memberService.updateLanguage(
                authMember.getMemberId(), request.getLanguage()
        );
        return ApiResponse.onSuccess(MemberSuccessCode.UPDATE_LANGUAGE, profile);
    }
}
