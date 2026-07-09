package com.klife.klifeguide.domain.auth.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum AuthErrorCode implements BaseErrorCode {

    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH401", "유효하지 않은 토큰입니다"),
    EXPIRED_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH401_1", "만료된 토큰입니다"),
    INVALID_GOOGLE_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH401_2", "유효하지 않은 Google 토큰입니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
