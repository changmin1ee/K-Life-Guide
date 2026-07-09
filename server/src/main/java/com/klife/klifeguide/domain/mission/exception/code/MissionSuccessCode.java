package com.klife.klifeguide.domain.mission.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MissionSuccessCode implements BaseSuccessCode {

    GET_MISSIONS(HttpStatus.OK, "MISSION200", "미션 목록 조회 성공"),
    GET_MISSION(HttpStatus.OK, "MISSION200_1", "미션 상세 조회 성공"),
    START_MISSION(HttpStatus.CREATED, "MISSION201", "미션 시작 성공"),
    COMPLETE_MISSION(HttpStatus.OK, "MISSION200_2", "미션 완료 성공"),
    GET_MY_MISSIONS(HttpStatus.OK, "MISSION200_3", "내 미션 목록 조회 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
