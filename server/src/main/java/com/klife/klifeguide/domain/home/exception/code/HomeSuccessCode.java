package com.klife.klifeguide.domain.home.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum HomeSuccessCode implements BaseSuccessCode {

    GET_HOME(HttpStatus.OK, "HOME200", "홈 데이터 조회 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
