package com.klife.klifeguide.domain.mission.exception;

import com.klife.klifeguide.domain.mission.exception.code.MissionErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class MissionException extends ProjectException {

    public MissionException(MissionErrorCode errorCode) {
        super(errorCode);
    }
}
