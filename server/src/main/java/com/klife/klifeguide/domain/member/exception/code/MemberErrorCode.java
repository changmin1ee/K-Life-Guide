package com.klife.klifeguide.domain.member.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MemberErrorCode implements BaseErrorCode {

    MEMBER_NOT_FOUND(HttpStatus.NOT_FOUND, "MEMBER404", "회원을 찾을 수 없습니다"),
    DUPLICATE_EMAIL(HttpStatus.CONFLICT, "MEMBER409", "이미 가입된 이메일입니다"),
    UNAUTHORIZED_MEMBER(HttpStatus.UNAUTHORIZED, "MEMBER401", "인증된 회원만 접근 가능합니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
