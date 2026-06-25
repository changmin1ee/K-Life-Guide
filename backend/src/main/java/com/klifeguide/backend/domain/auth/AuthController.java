package com.klifeguide.backend.domain.auth;

import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.domain.user.UserService;
import com.klifeguide.backend.domain.user.dto.LoginRequest;
import com.klifeguide.backend.domain.user.dto.SignUpRequest;
import com.klifeguide.backend.domain.user.dto.TokenResponse;
import com.klifeguide.backend.domain.user.dto.UserResponse;
import com.klifeguide.backend.global.exception.BusinessException;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private static final String BEARER_PREFIX = "Bearer ";

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/signup")
    public ResponseEntity<UserResponse> signUp(@Valid @RequestBody SignUpRequest request) {
        User user = userService.signUp(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(UserResponse.from(user));
    }

    @PostMapping("/login")
    public ResponseEntity<TokenResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(userService.login(request));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestHeader("Authorization") String authorizationHeader) {
        if (!StringUtils.hasText(authorizationHeader) || !authorizationHeader.startsWith(BEARER_PREFIX)) {
            throw new BusinessException(HttpStatus.BAD_REQUEST, "INVALID_AUTHORIZATION_HEADER", "Authorization 헤더가 올바르지 않습니다.");
        }
        userService.logout(authorizationHeader.substring(BEARER_PREFIX.length()));
        return ResponseEntity.noContent().build();
    }
}
