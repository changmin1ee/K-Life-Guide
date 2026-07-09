package com.klife.klifeguide.domain.reward.exception;

import com.klife.klifeguide.domain.reward.exception.code.RewardErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class RewardException extends ProjectException {

    public RewardException(RewardErrorCode errorCode) {
        super(errorCode);
    }
}
