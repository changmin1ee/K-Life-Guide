package com.klife.klifeguide.domain.community.exception;

import com.klife.klifeguide.domain.community.exception.code.CommunityErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class CommunityException extends ProjectException {

    public CommunityException(CommunityErrorCode errorCode) {
        super(errorCode);
    }
}
