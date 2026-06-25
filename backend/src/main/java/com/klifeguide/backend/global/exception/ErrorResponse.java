package com.klifeguide.backend.global.exception;

import java.time.LocalDateTime;

public record ErrorResponse(
        LocalDateTime timestamp,
        int status,
        String code,
        String message
) {
    public static ErrorResponse of(int status, String code, String message) {
        return new ErrorResponse(LocalDateTime.now(), status, code, message);
    }
}
