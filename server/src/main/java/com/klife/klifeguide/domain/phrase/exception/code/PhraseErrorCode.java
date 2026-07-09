package com.klife.klifeguide.domain.phrase.exception.code;

import com.klife.klifeguide.global.apiPayload.code.BaseErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PhraseErrorCode implements BaseErrorCode {

    PHRASE_NOT_FOUND(HttpStatus.NOT_FOUND, "PHRASE404", "표현을 찾을 수 없습니다"),
    ALREADY_SAVED(HttpStatus.CONFLICT, "PHRASE409", "이미 저장된 표현입니다"),
    NOT_SAVED(HttpStatus.BAD_REQUEST, "PHRASE400", "저장되지 않은 표현입니다"),
    ;

    private final HttpStatus status;
    private final String code;
    private final String message;
}
