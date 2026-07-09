package com.klife.klifeguide.domain.community.controller;

import com.klife.klifeguide.domain.community.dto.PostReqDTO;
import com.klife.klifeguide.domain.community.dto.PostResDTO;
import com.klife.klifeguide.domain.community.enums.BoardType;
import com.klife.klifeguide.domain.community.exception.code.CommunitySuccessCode;
import com.klife.klifeguide.domain.community.service.CommunityService;
import com.klife.klifeguide.global.apiPayload.ApiResponse;
import com.klife.klifeguide.global.entity.AuthMember;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Tag(name = "Community", description = "커뮤니티 API")
public class CommunityController {

    private final CommunityService communityService;

    @Operation(summary = "게시글 목록 조회", description = "전체 또는 게시판 유형별 게시글 목록을 조회합니다.")
    @GetMapping("/posts")
    public ApiResponse<List<PostResDTO.PostSummary>> getPosts(
            @RequestParam(required = false) BoardType boardType,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        Long memberId = authMember != null ? authMember.getMemberId() : null;
        return ApiResponse.onSuccess(CommunitySuccessCode.GET_POSTS, communityService.getPosts(boardType, memberId));
    }

    @Operation(summary = "게시글 작성", description = "새 게시글을 작성합니다.")
    @PostMapping("/posts")
    public ApiResponse<PostResDTO.PostSummary> createPost(
            @AuthenticationPrincipal AuthMember authMember,
            @RequestBody @Valid PostReqDTO.CreatePost req
    ) {
        return ApiResponse.onSuccess(CommunitySuccessCode.CREATE_POST, communityService.createPost(authMember.getMemberId(), req));
    }

    @Operation(summary = "게시글 상세 조회", description = "게시글 상세 정보와 댓글 목록을 조회합니다.")
    @GetMapping("/posts/{postId}")
    public ApiResponse<PostResDTO.PostDetail> getPostDetail(
            @PathVariable String postId,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        Long memberId = authMember != null ? authMember.getMemberId() : null;
        return ApiResponse.onSuccess(CommunitySuccessCode.GET_POST, communityService.getPostDetail(postId, memberId));
    }

    @Operation(summary = "댓글 작성", description = "게시글에 댓글을 작성합니다.")
    @PostMapping("/posts/{postId}/replies")
    public ApiResponse<PostResDTO.ReplyInfo> createReply(
            @PathVariable String postId,
            @AuthenticationPrincipal AuthMember authMember,
            @RequestBody @Valid PostReqDTO.CreateReply req
    ) {
        return ApiResponse.onSuccess(CommunitySuccessCode.CREATE_REPLY, communityService.createReply(authMember.getMemberId(), postId, req));
    }

    @Operation(summary = "게시글 추천 토글", description = "게시글 추천을 추가하거나 취소합니다.")
    @PostMapping("/posts/{postId}/like")
    public ApiResponse<PostResDTO.LikeResult> toggleLike(
            @PathVariable String postId,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        PostResDTO.LikeResult result = communityService.toggleLike(authMember.getMemberId(), postId);
        CommunitySuccessCode code = result.isLiked() ? CommunitySuccessCode.LIKE_POST : CommunitySuccessCode.UNLIKE_POST;
        return ApiResponse.onSuccess(code, result);
    }

    @Operation(summary = "Q&A 해결됨 처리", description = "Q&A 게시글을 해결됨으로 처리합니다. 작성자만 가능합니다.")
    @PostMapping("/posts/{postId}/solve")
    public ApiResponse<PostResDTO.SolveResult> solvePost(
            @PathVariable String postId,
            @AuthenticationPrincipal AuthMember authMember
    ) {
        return ApiResponse.onSuccess(CommunitySuccessCode.SOLVE_POST, communityService.solvePost(authMember.getMemberId(), postId));
    }

    @Operation(summary = "내가 쓴 글 목록", description = "로그인한 사용자가 작성한 게시글 목록을 조회합니다.")
    @GetMapping("/members/me/posts")
    public ApiResponse<List<PostResDTO.PostSummary>> getMyPosts(
            @AuthenticationPrincipal AuthMember authMember
    ) {
        return ApiResponse.onSuccess(CommunitySuccessCode.GET_MY_POSTS, communityService.getMyPosts(authMember.getMemberId()));
    }
}
