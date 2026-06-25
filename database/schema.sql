-- K-Life-Guide MySQL DDL
-- 도메인: users, mission_categories, missions, user_missions, badges, user_badges,
--         admin_reviews, friendships, notifications, reports

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- users
-- ============================================================
CREATE TABLE users (
    id                  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email               VARCHAR(255)    NOT NULL,
    password            VARCHAR(255)    NULL COMMENT '소셜 로그인만 사용하는 경우 NULL',
    nickname            VARCHAR(50)     NOT NULL,
    profile_image_url   VARCHAR(500)    NULL,
    provider            VARCHAR(20)     NOT NULL DEFAULT 'LOCAL' COMMENT 'LOCAL, GOOGLE, KAKAO ...',
    provider_id         VARCHAR(100)    NULL,
    role                VARCHAR(20)     NOT NULL DEFAULT 'USER' COMMENT 'USER, ADMIN',
    status              VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, SUSPENDED, WITHDRAWN',
    total_points        INT             NOT NULL DEFAULT 0,
    level               INT             NOT NULL DEFAULT 1,
    last_login_at       DATETIME        NULL,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at          DATETIME        NULL,
    UNIQUE KEY uk_users_email (email),
    UNIQUE KEY uk_users_nickname (nickname),
    UNIQUE KEY uk_users_provider (provider, provider_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원';

-- ============================================================
-- mission_categories
-- ============================================================
CREATE TABLE mission_categories (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50)     NOT NULL,
    description     VARCHAR(255)    NULL,
    icon_url        VARCHAR(500)    NULL,
    display_order   INT             NOT NULL DEFAULT 0,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_mission_categories_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='미션 카테고리';

-- ============================================================
-- missions
-- ============================================================
CREATE TABLE missions (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id     BIGINT UNSIGNED NOT NULL,
    created_by      BIGINT UNSIGNED NULL COMMENT '미션을 등록한 관리자',
    title           VARCHAR(100)    NOT NULL,
    description     TEXT            NULL,
    latitude        DECIMAL(10,7)   NOT NULL COMMENT '미션 인증 기준 위치',
    longitude       DECIMAL(10,7)   NOT NULL,
    radius_meters   INT             NOT NULL DEFAULT 100 COMMENT '허용 반경(m)',
    location_name   VARCHAR(255)    NULL,
    address         VARCHAR(255)    NULL,
    points          INT             NOT NULL DEFAULT 0 COMMENT '완료 시 지급 포인트',
    difficulty      VARCHAR(20)     NOT NULL DEFAULT 'NORMAL' COMMENT 'EASY, NORMAL, HARD',
    status          VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE, INACTIVE, ARCHIVED',
    start_date      DATETIME        NULL,
    end_date        DATETIME        NULL,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_missions_category FOREIGN KEY (category_id) REFERENCES mission_categories (id),
    CONSTRAINT fk_missions_created_by FOREIGN KEY (created_by) REFERENCES users (id),
    INDEX idx_missions_category (category_id),
    INDEX idx_missions_status (status),
    INDEX idx_missions_location (latitude, longitude)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='미션';

-- ============================================================
-- user_missions  (GPS + 사진 + Gemini confidence 인증 구조)
-- ============================================================
CREATE TABLE user_missions (
    id                          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id                     BIGINT UNSIGNED NOT NULL,
    mission_id                  BIGINT UNSIGNED NOT NULL,
    attempt_no                  INT             NOT NULL DEFAULT 1 COMMENT '반려 후 재제출 시 증가',
    status                      VARCHAR(20)     NOT NULL DEFAULT 'PENDING_REVIEW'
                                    COMMENT 'PENDING_REVIEW, AI_APPROVED, NEEDS_ADMIN_REVIEW, AI_REJECTED, APPROVED, REJECTED',
    photo_url                   VARCHAR(500)    NOT NULL COMMENT '인증 사진 원본 URL',
    submitted_latitude          DECIMAL(10,7)   NOT NULL COMMENT '사진 촬영 시점 GPS',
    submitted_longitude         DECIMAL(10,7)   NOT NULL,
    distance_meters             DECIMAL(10,2)   NULL COMMENT 'missions.latitude/longitude 기준 거리(Haversine)',
    gps_verified                BOOLEAN         NOT NULL DEFAULT FALSE COMMENT 'distance_meters <= missions.radius_meters',
    gemini_confidence_score     DECIMAL(5,2)    NULL COMMENT '0.00 ~ 100.00',
    gemini_analysis_result      JSON            NULL COMMENT 'Gemini 응답 원문(라벨/근거/세부 점수)',
    ai_verified_at              DATETIME        NULL,
    auto_approved               BOOLEAN         NOT NULL DEFAULT FALSE COMMENT '관리자 검수 없이 자동 승인 여부',
    points_earned               INT             NOT NULL DEFAULT 0,
    submitted_at                DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at                 DATETIME        NULL COMMENT '최종 확정(AI 또는 관리자) 시각',
    created_at                  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_missions_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_user_missions_mission FOREIGN KEY (mission_id) REFERENCES missions (id),
    UNIQUE KEY uk_user_missions_attempt (user_id, mission_id, attempt_no),
    INDEX idx_user_missions_status (status),
    INDEX idx_user_missions_user (user_id),
    INDEX idx_user_missions_mission (mission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저 미션 인증(GPS+사진+Gemini 신뢰도)';

-- ============================================================
-- badges
-- ============================================================
CREATE TABLE badges (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50)     NOT NULL,
    description     VARCHAR(255)    NULL,
    icon_url        VARCHAR(500)    NULL,
    badge_type      VARCHAR(30)     NOT NULL COMMENT 'MISSION_COUNT, CATEGORY_MASTER, STREAK, SPECIAL',
    condition_value INT             NULL COMMENT '달성 조건 수치(예: 미션 10회)',
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_badges_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='배지';

-- ============================================================
-- user_badges
-- ============================================================
CREATE TABLE user_badges (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED NOT NULL,
    badge_id        BIGINT UNSIGNED NOT NULL,
    acquired_at     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_badges_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_user_badges_badge FOREIGN KEY (badge_id) REFERENCES badges (id),
    UNIQUE KEY uk_user_badges (user_id, badge_id),
    INDEX idx_user_badges_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저 보유 배지';

-- ============================================================
-- admin_reviews
-- ============================================================
CREATE TABLE admin_reviews (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_mission_id BIGINT UNSIGNED NOT NULL,
    admin_id        BIGINT UNSIGNED NOT NULL,
    decision        VARCHAR(20)     NOT NULL COMMENT 'APPROVED, REJECTED',
    reason          TEXT            NULL,
    reviewed_at     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_admin_reviews_user_mission FOREIGN KEY (user_mission_id) REFERENCES user_missions (id),
    CONSTRAINT fk_admin_reviews_admin FOREIGN KEY (admin_id) REFERENCES users (id),
    UNIQUE KEY uk_admin_reviews_user_mission (user_mission_id),
    INDEX idx_admin_reviews_admin (admin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리자 미션 인증 검수';

-- ============================================================
-- friendships
-- ============================================================
CREATE TABLE friendships (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    requester_id    BIGINT UNSIGNED NOT NULL,
    receiver_id     BIGINT UNSIGNED NOT NULL,
    status          VARCHAR(20)     NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, ACCEPTED, REJECTED, BLOCKED',
    requested_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    responded_at    DATETIME        NULL,
    CONSTRAINT fk_friendships_requester FOREIGN KEY (requester_id) REFERENCES users (id),
    CONSTRAINT fk_friendships_receiver FOREIGN KEY (receiver_id) REFERENCES users (id),
    CONSTRAINT uk_friendships_pair UNIQUE (requester_id, receiver_id),
    CONSTRAINT chk_friendships_not_self CHECK (requester_id <> receiver_id),
    INDEX idx_friendships_receiver (receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='친구 관계';

-- ============================================================
-- notifications
-- ============================================================
CREATE TABLE notifications (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT UNSIGNED NOT NULL COMMENT '수신자',
    type            VARCHAR(30)     NOT NULL
                        COMMENT 'MISSION_APPROVED, MISSION_REJECTED, BADGE_EARNED, FRIEND_REQUEST, FRIEND_ACCEPTED, REPORT_RESULT, SYSTEM',
    title           VARCHAR(100)    NOT NULL,
    content         VARCHAR(500)    NULL,
    related_id      BIGINT UNSIGNED NULL COMMENT 'type에 따른 다형성 참조 ID (mission, friendship 등)',
    is_read         BOOLEAN         NOT NULL DEFAULT FALSE,
    read_at         DATETIME        NULL,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users (id),
    INDEX idx_notifications_user_read (user_id, is_read),
    INDEX idx_notifications_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='알림';

-- ============================================================
-- reports
-- ============================================================
CREATE TABLE reports (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reporter_id     BIGINT UNSIGNED NOT NULL,
    target_type     VARCHAR(20)     NOT NULL COMMENT 'USER, USER_MISSION 등 다형성 대상 타입',
    target_id       BIGINT UNSIGNED NOT NULL,
    reason_type     VARCHAR(30)     NOT NULL COMMENT 'SPAM, INAPPROPRIATE_CONTENT, FAKE_GPS, ABUSE, OTHER',
    description     TEXT            NULL,
    status          VARCHAR(20)     NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, REVIEWING, RESOLVED, REJECTED',
    handled_by      BIGINT UNSIGNED NULL COMMENT '처리한 관리자',
    handled_at      DATETIME        NULL,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_reports_reporter FOREIGN KEY (reporter_id) REFERENCES users (id),
    CONSTRAINT fk_reports_handler FOREIGN KEY (handled_by) REFERENCES users (id),
    INDEX idx_reports_target (target_type, target_id),
    INDEX idx_reports_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='신고';

SET FOREIGN_KEY_CHECKS = 1;
