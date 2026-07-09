package com.klife.klifeguide.domain.mission.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MissionErrorCode implements BaseErrorCode {

    MISSION_NOT_FOUND(HttpStatus.NOT_FOUND, "MISSION404", "미션을 찾을 수 없습니다"),
    MISSION_ALREADY_COMPLETED(HttpStatus.CONFLICT, "MISSION409", "이미 완료된 미션입니다"),
    MISSION_NOT_STARTED(HttpStatus.BAD_REQUEST, "MISSION400", "시작하지 않은 미션입니다"),
    PROOF_IMAGE_REQUIRED(HttpStatus.BAD_REQUEST, "MISSION400_1", "인증 사진이 필요합니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
