package com.klife.klifeguide.domain.auth.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum AuthSuccessCode implements BaseSuccessCode {

    LOGIN_SUCCESS(HttpStatus.OK, "AUTH200", "로그인 성공"),
    LOGOUT_SUCCESS(HttpStatus.OK, "AUTH200_1", "로그아웃 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
