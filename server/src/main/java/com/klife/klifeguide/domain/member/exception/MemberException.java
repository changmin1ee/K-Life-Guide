package com.klife.klifeguide.domain.member.exception;

import com.klife.klifeguide.domain.member.exception.code.MemberErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class MemberException extends ProjectException {

    public MemberException(MemberErrorCode errorCode) {
        super(errorCode);
    }
}
