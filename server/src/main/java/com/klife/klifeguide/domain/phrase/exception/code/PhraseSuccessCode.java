package com.klife.klifeguide.domain.phrase.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseSuccessCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PhraseSuccessCode implements BaseSuccessCode {

    GET_PHRASES(HttpStatus.OK, "PHRASE200", "표현 목록 조회 성공"),
    SAVE_PHRASE(HttpStatus.CREATED, "PHRASE201", "표현 즐겨찾기 저장 성공"),
    UNSAVE_PHRASE(HttpStatus.OK, "PHRASE200_1", "표현 즐겨찾기 해제 성공"),
    GET_SAVED_PHRASES(HttpStatus.OK, "PHRASE200_2", "저장한 표현 목록 조회 성공"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
