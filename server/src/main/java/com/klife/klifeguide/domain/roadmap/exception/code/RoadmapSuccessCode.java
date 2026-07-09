package com.klife.klifeguide.domain.roadmap.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum RoadmapSuccessCode implements BaseSuccessCode {

    GET_ROADMAP(HttpStatus.OK, "ROAD200", "로드맵 조회 성공"),
    UPDATE_ROADMAP_ITEM(HttpStatus.OK, "ROAD200_1", "로드맵 항목 업데이트 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
