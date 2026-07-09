package com.klife.klifeguide.domain.reward.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum RewardSuccessCode implements BaseSuccessCode {

    GET_BADGES(HttpStatus.OK, "REWARD200", "뱃지 목록 조회 성공"),
    GET_POINT_HISTORY(HttpStatus.OK, "REWARD200_1", "포인트 내역 조회 성공"),
    GET_PASSPORT(HttpStatus.OK, "REWARD200_2", "K-라이프 패스포트 조회 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
