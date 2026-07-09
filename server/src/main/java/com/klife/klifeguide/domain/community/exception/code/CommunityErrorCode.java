package com.klife.klifeguide.domain.community.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum CommunityErrorCode implements BaseErrorCode {

    POST_NOT_FOUND(HttpStatus.NOT_FOUND, "COMM404", "게시글을 찾을 수 없습니다"),
    REPLY_NOT_FOUND(HttpStatus.NOT_FOUND, "COMM404_1", "댓글을 찾을 수 없습니다"),
    ALREADY_LIKED(HttpStatus.CONFLICT, "COMM409", "이미 추천한 게시글입니다"),
    NOT_POST_AUTHOR(HttpStatus.FORBIDDEN, "COMM403", "게시글 작성자만 가능합니다"),
    ONLY_QNA_CAN_SOLVE(HttpStatus.BAD_REQUEST, "COMM400", "Q&A 게시글만 해결됨 처리가 가능합니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
