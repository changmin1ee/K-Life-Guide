package com.klife.klifeguide.domain.phrase.controller;

import com.klife.klifeguide.domain.phrase.dto.PhraseResDTO;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import com.klife.klifeguide.domain.phrase.exception.code.PhraseSuccessCode;
import com.klife.klifeguide.domain.phrase.service.PhraseService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name = "Phrase", description = "생활 필수 표현 API")
public class PhraseController {

    private final PhraseService phraseService;

    @GetMapping("/api/phrases")
    @Operation(summary = "표현 목록 조회", description = "카테고리별 또는 전체 표현 목록을 조회합니다.")
    public ApiResponse<List<PhraseResDTO.CategoryPhrasesInfo>> getPhrases(
            @RequestParam(required = false) PhraseCategory category,
            @AuthenticationPrincipal AuthMember authMember) {

        Long memberId = authMember != null ? authMember.getMemberId() : null;

        if (category != null) {
            List<PhraseResDTO.PhraseInfo> phrases = phraseService.getPhrasesByCategory(category, memberId);
            List<PhraseResDTO.CategoryPhrasesInfo> result = List.of(
                    PhraseResDTO.CategoryPhrasesInfo.builder()
                            .category(category)
                            .koName(category.getKo())
                            .enName(category.getEn())
                            .phrases(phrases)
                            .build()
            );
            return ApiResponse.onSuccess(PhraseSuccessCode.GET_PHRASES, result);
        }

        List<PhraseResDTO.CategoryPhrasesInfo> result = phraseService.getAllPhrases(memberId);
        return ApiResponse.onSuccess(PhraseSuccessCode.GET_PHRASES, result);
    }

    @PostMapping("/api/phrases/{phraseId}/save")
    @Operation(summary = "표현 즐겨찾기 저장", description = "표현을 즐겨찾기에 저장합니다.")
    public ApiResponse<PhraseResDTO.PhraseInfo> savePhrase(
            @PathVariable Long phraseId,
            @AuthenticationPrincipal AuthMember authMember) {

        PhraseResDTO.PhraseInfo result = phraseService.savePhrase(authMember.getMemberId(), phraseId);
        return ApiResponse.onSuccess(PhraseSuccessCode.SAVE_PHRASE, result);
    }

    @DeleteMapping("/api/phrases/{phraseId}/save")
    @Operation(summary = "표현 즐겨찾기 해제", description = "저장된 표현을 즐겨찾기에서 해제합니다.")
    public ApiResponse<Void> unsavePhrase(
            @PathVariable Long phraseId,
            @AuthenticationPrincipal AuthMember authMember) {

        phraseService.unsavePhrase(authMember.getMemberId(), phraseId);
        return ApiResponse.onSuccess(PhraseSuccessCode.UNSAVE_PHRASE, null);
    }

    @GetMapping("/api/members/me/phrases/saved")
    @Operation(summary = "저장한 표현 목록 조회", description = "내가 저장한 표현 목록을 조회합니다.")
    public ApiResponse<List<PhraseResDTO.PhraseInfo>> getSavedPhrases(
            @AuthenticationPrincipal AuthMember authMember) {

        List<PhraseResDTO.PhraseInfo> result = phraseService.getSavedPhrases(authMember.getMemberId());
        return ApiResponse.onSuccess(PhraseSuccessCode.GET_SAVED_PHRASES, result);
    }
}
