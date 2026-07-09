package com.klife.klifeguide.domain.member.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MemberSuccessCode implements BaseSuccessCode {

    GET_MY_PROFILE(HttpStatus.OK, "MEMBER200", "내 프로필 조회 성공"),
    UPDATE_LANGUAGE(HttpStatus.OK, "MEMBER200_1", "언어 설정 변경 성공"),
    LOGIN_SUCCESS(HttpStatus.OK, "MEMBER200_2", "로그인 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
