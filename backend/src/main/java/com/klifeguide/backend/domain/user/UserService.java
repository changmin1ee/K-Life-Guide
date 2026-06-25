package com.klifeguide.backend.domain.user;

import com.klifeguide.backend.domain.user.dto.LoginRequest;
import com.klifeguide.backend.domain.user.dto.SignUpRequest;
import com.klifeguide.backend.domain.user.dto.TokenResponse;
import com.klifeguide.backend.global.exception.BusinessException;
import com.klifeguide.backend.global.jwt.JwtTokenProvider;
import com.klifeguide.backend.global.jwt.TokenBlacklistService;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final TokenBlacklistService tokenBlacklistService;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder,
                        JwtTokenProvider jwtTokenProvider, TokenBlacklistService tokenBlacklistService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
        this.tokenBlacklistService = tokenBlacklistService;
    }

    @Transactional
    public User signUp(SignUpRequest request) {
        if (userRepository.existsByEmail(request.email())) {
            throw new BusinessException(HttpStatus.CONFLICT, "EMAIL_ALREADY_EXISTS", "이미 가입된 이메일입니다.");
        }
        if (userRepository.existsByNickname(request.nickname())) {
            throw new BusinessException(HttpStatus.CONFLICT, "NICKNAME_ALREADY_EXISTS", "이미 사용 중인 닉네임입니다.");
        }

        User user = User.builder()
                .email(request.email())
                .password(passwordEncoder.encode(request.password()))
                .nickname(request.nickname())
                .provider(AuthProvider.LOCAL)
                .role(UserRole.USER)
                .build();

        return userRepository.save(user);
    }

    @Transactional
    public TokenResponse login(LoginRequest request) {
        User user = userRepository.findByEmail(request.email())
                .orElseThrow(() -> new BusinessException(HttpStatus.UNAUTHORIZED, "INVALID_CREDENTIALS", "이메일 또는 비밀번호가 올바르지 않습니다."));

        if (user.getPassword() == null || !passwordEncoder.matches(request.password(), user.getPassword())) {
            throw new BusinessException(HttpStatus.UNAUTHORIZED, "INVALID_CREDENTIALS", "이메일 또는 비밀번호가 올바르지 않습니다.");
        }
        if (user.getStatus() != UserStatus.ACTIVE) {
            throw new BusinessException(HttpStatus.FORBIDDEN, "ACCOUNT_NOT_ACTIVE", "이용할 수 없는 계정입니다.");
        }

        user.recordLogin();

        String accessToken = jwtTokenProvider.createAccessToken(user.getId().toString(), user.getRole().name());
        String refreshToken = jwtTokenProvider.createRefreshToken(user.getId().toString());
        return TokenResponse.of(accessToken, refreshToken);
    }

    public void logout(String accessToken) {
        String jti = jwtTokenProvider.getJti(accessToken);
        long remainingMillis = jwtTokenProvider.getRemainingMillis(accessToken);
        tokenBlacklistService.blacklist(jti, remainingMillis, "LOGOUT");
    }

    public User getById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "USER_NOT_FOUND", "사용자를 찾을 수 없습니다."));
    }
}
