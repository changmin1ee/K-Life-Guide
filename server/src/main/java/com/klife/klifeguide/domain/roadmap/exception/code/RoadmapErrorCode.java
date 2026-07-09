package com.klife.klifeguide.domain.roadmap.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum RoadmapErrorCode implements BaseErrorCode {

    ROADMAP_ITEM_NOT_FOUND(HttpStatus.NOT_FOUND, "ROAD404", "로드맵 항목을 찾을 수 없습니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
