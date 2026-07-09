package com.klife.klifeguide.domain.community.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum CommunitySuccessCode implements BaseSuccessCode {

    GET_POSTS(HttpStatus.OK, "COMM200", "게시글 목록 조회 성공"),
    GET_POST(HttpStatus.OK, "COMM200_1", "게시글 상세 조회 성공"),
    CREATE_POST(HttpStatus.CREATED, "COMM201", "게시글 작성 성공"),
    CREATE_REPLY(HttpStatus.CREATED, "COMM201_1", "댓글 작성 성공"),
    LIKE_POST(HttpStatus.OK, "COMM200_2", "게시글 추천 성공"),
    UNLIKE_POST(HttpStatus.OK, "COMM200_3", "게시글 추천 취소 성공"),
    SOLVE_POST(HttpStatus.OK, "COMM200_4", "게시글 해결됨 처리 성공"),
    GET_MY_POSTS(HttpStatus.OK, "COMM200_5", "내 게시글 목록 조회 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
