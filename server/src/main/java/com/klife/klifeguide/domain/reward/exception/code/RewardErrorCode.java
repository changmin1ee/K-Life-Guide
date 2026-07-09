package com.klife.klifeguide.domain.reward.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum RewardErrorCode implements BaseErrorCode {

    BADGE_NOT_FOUND(HttpStatus.NOT_FOUND, "REWARD404", "뱃지를 찾을 수 없습니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
