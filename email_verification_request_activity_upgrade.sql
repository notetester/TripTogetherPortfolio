-- ============================================================
-- TripTogether - EMAIL_VERIFICATION / EMAIL_VERIFICATION_REQUEST
-- 연결 강화 + USER_ACTIVITY_LOG 추가
--
-- 원칙:
-- 1) 기존 테이블명 / 컬럼명은 유지한다.
-- 2) 기존 컬럼은 삭제/변경하지 않고, 필요한 컬럼만 추가한다.
-- 3) EMAIL_VERIFICATION_REQUEST 는 '요청 헤더/워크플로우',
--    EMAIL_VERIFICATION 은 '실제 발급된 토큰 인스턴스'로 해석한다.
-- ============================================================

-- ------------------------------------------------------------
-- 1. EMAIL_VERIFICATION_REQUEST 확장
--    - 범용 이메일 액션 요청 헤더로 확장할 수 있도록 user_idx 를 NULL 허용
-- ------------------------------------------------------------
ALTER TABLE EMAIL_VERIFICATION_REQUEST
    MODIFY COLUMN user_idx BIGINT NULL
    COMMENT '이메일 액션 요청 대상 사용자 PK (식별 가능 시)';

ALTER TABLE EMAIL_VERIFICATION_REQUEST
    ADD INDEX idx_evreq_token (token),
    ADD INDEX idx_evreq_user_created (user_idx, created_at),
    ADD INDEX idx_evreq_purpose_requested (purpose, requested_at);

-- ------------------------------------------------------------
-- 2. EMAIL_VERIFICATION 확장
--    - 요청 헤더와 연결
--    - 토큰 사용/취소/수정 시각 보강
-- ------------------------------------------------------------
ALTER TABLE EMAIL_VERIFICATION
    ADD COLUMN email_verification_request_idx BIGINT NULL
        COMMENT '연결된 이메일 액션 요청 PK (EMAIL_VERIFICATION_REQUEST.email_verification_request_idx)'
        AFTER verify_idx,
    ADD COLUMN request_id VARCHAR(36) NULL
        COMMENT '연결된 이메일 액션 요청 식별자(UUID)'
        AFTER email_verification_request_idx,
    ADD COLUMN used_at DATETIME NULL
        COMMENT '토큰 사용 완료 시각'
        AFTER used,
    ADD COLUMN cancelled_at DATETIME NULL
        COMMENT '신규 요청 등으로 인해 무효 처리된 시각'
        AFTER expired_at,
    ADD COLUMN updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '토큰 레코드의 마지막 상태 변경 시각'
        AFTER cancelled_at;

ALTER TABLE EMAIL_VERIFICATION
    ADD INDEX idx_verify_request_fk (email_verification_request_idx),
    ADD INDEX idx_verify_request_id (request_id),
    ADD INDEX idx_verify_purpose_created (purpose, created_at),
    ADD INDEX idx_verify_expired_at (expired_at);

ALTER TABLE EMAIL_VERIFICATION
    ADD CONSTRAINT fk_verify_request
        FOREIGN KEY (email_verification_request_idx)
        REFERENCES EMAIL_VERIFICATION_REQUEST(email_verification_request_idx)
        ON DELETE CASCADE;

-- ------------------------------------------------------------
-- 3. 기존 데이터 백필
--    - 현재 두 테이블은 token 값을 공유하므로 그것으로 요청-토큰 연결 복원
-- ------------------------------------------------------------
UPDATE EMAIL_VERIFICATION v
JOIN EMAIL_VERIFICATION_REQUEST r
  ON v.token = r.token
SET v.email_verification_request_idx = r.email_verification_request_idx,
    v.request_id = r.request_id
WHERE v.email_verification_request_idx IS NULL;

UPDATE EMAIL_VERIFICATION
SET used_at = created_at
WHERE used = 1
  AND used_at IS NULL;

-- ------------------------------------------------------------
-- 4. 일반 활동 로그 테이블 추가
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS USER_ACTIVITY_LOG (
    activity_idx BIGINT AUTO_INCREMENT PRIMARY KEY
        COMMENT '일반 활동 로그 PK',

    request_id VARCHAR(36) NOT NULL
        COMMENT '단일 HTTP 요청 식별자(UUID). 보안 이력 및 이메일 요청/토큰 이력과 상관관계 추적용',

    user_idx BIGINT NULL
        COMMENT '로그인 사용자 PK (비회원은 NULL)',

    session_id VARCHAR(100) NULL
        COMMENT '세션 식별자',

    request_uri VARCHAR(255) NOT NULL
        COMMENT '요청 URI',

    http_method VARCHAR(10) NOT NULL
        COMMENT 'HTTP 메서드',

    activity_type VARCHAR(30) NOT NULL
        COMMENT '활동 분류 (PAGE_VIEW / ACTION / AJAX / API)',

    activity_code VARCHAR(50) NULL
        COMMENT '구체적 활동 코드 (예: VIEW_LOGIN_PAGE / CREATE_POST / CLICK_FIND_ID / SEND_PROFILE_EMAIL_VERIFY)',

    target_type VARCHAR(30) NULL
        COMMENT '대상 유형 (예: POST / COMMENT / INQUIRY / SOCIAL / EMAIL_VERIFICATION_REQUEST)',

    target_id VARCHAR(100) NULL
        COMMENT '대상 식별자',

    handler_name VARCHAR(200) NULL
        COMMENT '처리 핸들러 (예: AuthController#loginPage)',

    query_string VARCHAR(1000) NULL
        COMMENT '민감정보를 제거한 쿼리 문자열',

    referer VARCHAR(500) NULL
        COMMENT '민감정보를 제거한 이전 페이지 Referer',

    ip_address VARCHAR(45) NULL
        COMMENT '접속 IP',

    user_agent VARCHAR(500) NULL
        COMMENT '브라우저 / 디바이스 정보',

    response_status INT NULL
        COMMENT '응답 상태 코드',

    response_time_ms INT NULL
        COMMENT '요청 처리 시간(ms)',

    is_success BOOLEAN NULL
        COMMENT '성공 여부 (2xx/3xx=TRUE, 예외/4xx/5xx=FALSE)',

    detail_summary VARCHAR(500) NULL
        COMMENT '민감정보를 제외한 활동 요약',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '로그 시각',

    CONSTRAINT fk_activity_user
        FOREIGN KEY (user_idx) REFERENCES USERS(user_idx)
        ON DELETE SET NULL,

    INDEX idx_ual_request_id (request_id),
    INDEX idx_ual_user_created (user_idx, created_at),
    INDEX idx_ual_activity_type_created (activity_type, created_at),
    INDEX idx_ual_activity_code_created (activity_code, created_at),
    INDEX idx_ual_target (target_type, target_id),
    INDEX idx_ual_request_uri (request_uri),
    INDEX idx_ual_created_at (created_at)
) COMMENT='회원/비회원의 일반 활동(페이지 방문, 요청 호출 등)을 기록하는 범용 활동 로그';
