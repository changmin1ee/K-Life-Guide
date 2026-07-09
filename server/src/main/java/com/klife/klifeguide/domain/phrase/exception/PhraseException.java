package com.klife.klifeguide.domain.phrase.exception;

import com.klife.klifeguide.domain.phrase.exception.code.PhraseErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class PhraseException extends ProjectException {

    public PhraseException(PhraseErrorCode errorCode) {
        super(errorCode);
    }
}
