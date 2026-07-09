package com.klife.klifeguide.domain.auth.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

public class AuthReqDTO {

    @Getter
    @NoArgsConstructor
    public static class GoogleLogin {
        private String idToken;
    }
}
