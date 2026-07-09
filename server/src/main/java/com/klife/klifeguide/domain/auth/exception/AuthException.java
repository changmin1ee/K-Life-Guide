package com.klife.klifeguide.domain.auth.exception;

import com.klife.klifeguide.domain.auth.exception.code.AuthErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class AuthException extends ProjectException {

    public AuthException(AuthErrorCode errorCode) {
        super(errorCode);
    }
}
