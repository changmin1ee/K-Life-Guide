package com.klife.klifeguide.domain.roadmap.exception;

import com.klife.klifeguide.domain.roadmap.exception.code.RoadmapErrorCode;
import com.klife.klifeguide.global.apiPayload.exception.ProjectException;

public class RoadmapException extends ProjectException {

    public RoadmapException(RoadmapErrorCode errorCode) {
        super(errorCode);
    }
}
