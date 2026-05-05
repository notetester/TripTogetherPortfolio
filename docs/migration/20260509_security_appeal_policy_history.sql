-- TripTogether 보안 이의제기 정책 이력/버전 관리 및 추가 TTL 정책
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 범위:
-- 1. SECURITY_APPEAL_POLICY가 없으면 생성
-- 2. protected_appeal_token_ttl_days 컬럼 보강
-- 3. SECURITY_APPEAL_POLICY_HISTORY 변경 이력 테이블 생성
-- 4. DEFAULT 정책 row seed

CREATE TABLE IF NOT EXISTS `SECURITY_APPEAL_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '보안 이의제기 정책 PK',
  `policy_code` varchar(60) NOT NULL DEFAULT 'DEFAULT' COMMENT '정책 코드. 현재 DEFAULT 단일 정책 사용',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '정책 활성 여부',
  `allow_multiple_open_appeals` tinyint(1) NOT NULL DEFAULT 1 COMMENT '동일 차단 건의 복수 PENDING/HOLD 접수 허용 여부',
  `max_open_appeals_per_case` int NOT NULL DEFAULT 3 COMMENT '동일 차단 건 동시 PENDING/HOLD 접수 허용 수',
  `closed_blocks_new_appeals` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'CLOSED 처리된 동일 차단 건의 추가 접수 차단 여부',
  `rejected_cooldown_minutes` int NOT NULL DEFAULT 10080 COMMENT 'REJECTED 후 재접수 제한 시간(분)',
  `max_rejected_count` int NOT NULL DEFAULT 2 COMMENT '동일 차단 건 최대 반려 횟수',
  `ip_daily_appeal_limit` int NOT NULL DEFAULT 3 COMMENT '동일 IP 대상 일일 이의제기 접수 제한',
  `verification_window_minutes` int NOT NULL DEFAULT 60 COMMENT '인증 메일 발송 제한 관찰 시간(분)',
  `max_verification_emails` int NOT NULL DEFAULT 3 COMMENT '동일 requestId/email 인증 메일 발송 한도',
  `verification_token_ttl_minutes` int NOT NULL DEFAULT 30 COMMENT '이메일 인증 링크 유효 시간(분)',
  `protected_appeal_token_ttl_days` int NOT NULL DEFAULT 7 COMMENT '계정 보호 조치 안내 메일의 이의제기 링크 유효 기간(일)',
  `result_lookup_window_minutes` int NOT NULL DEFAULT 60 COMMENT '결과 조회 실패 제한 관찰 시간(분)',
  `max_result_lookup_failures` int NOT NULL DEFAULT 5 COMMENT 'publicRequestId 결과 조회 실패 허용 횟수',
  `result_lookup_retention_days` int NOT NULL DEFAULT 365 COMMENT '비로그인 결과 조회 가능 기간(일). 0이면 제한 없음',
  `allowed_email_domains` varchar(1000) DEFAULT NULL COMMENT '허용 이메일 도메인 CSV. 비어 있으면 전체 허용',
  `blocked_email_domains` varchar(1000) DEFAULT NULL COMMENT '차단 이메일 도메인 CSV',
  `captcha_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'CAPTCHA/Turnstile 사용 준비 토글. 실제 연동은 별도 Provider',
  `captcha_provider_code` varchar(80) DEFAULT 'MOCK_TURNSTILE' COMMENT 'CAPTCHA Provider 코드',
  `description` varchar(1000) DEFAULT NULL COMMENT '관리자 설명',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uk_sap_policy_code` (`policy_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 이의제기 채널/쿨타임/rate-limit 전용 정책';

SET @col_exists := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'SECURITY_APPEAL_POLICY'
      AND COLUMN_NAME = 'protected_appeal_token_ttl_days'
);
SET @sql := IF(@col_exists = 0,
    'ALTER TABLE SECURITY_APPEAL_POLICY ADD COLUMN protected_appeal_token_ttl_days int NOT NULL DEFAULT 7 COMMENT ''계정 보호 조치 안내 메일의 이의제기 링크 유효 기간(일)'' AFTER verification_token_ttl_minutes',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS `SECURITY_APPEAL_POLICY_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '정책 변경 이력 PK',
  `policy_idx` bigint NOT NULL COMMENT 'SECURITY_APPEAL_POLICY.policy_idx',
  `policy_code` varchar(60) NOT NULL COMMENT '정책 코드',
  `version_no` int NOT NULL COMMENT '정책별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / RESET / IMPORT',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 정책 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 정책 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_saph_policy_version` (`policy_idx`,`version_no`),
  KEY `idx_saph_policy_created` (`policy_code`,`created_at`),
  KEY `idx_saph_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_saph_policy` FOREIGN KEY (`policy_idx`) REFERENCES `SECURITY_APPEAL_POLICY` (`policy_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_saph_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 이의제기 정책 변경 이력/버전';

INSERT INTO SECURITY_APPEAL_POLICY
(policy_code, is_active,
 allow_multiple_open_appeals, max_open_appeals_per_case, closed_blocks_new_appeals,
 rejected_cooldown_minutes, max_rejected_count, ip_daily_appeal_limit,
 verification_window_minutes, max_verification_emails, verification_token_ttl_minutes, protected_appeal_token_ttl_days,
 result_lookup_window_minutes, max_result_lookup_failures, result_lookup_retention_days,
 allowed_email_domains, blocked_email_domains, captcha_enabled, captcha_provider_code,
 description, created_at, updated_at)
SELECT
 'DEFAULT',
 1,
 1,
 COALESCE((SELECT warning_before_count FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 3),
 1,
 COALESCE((SELECT observation_minutes FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_COOLDOWN' LIMIT 1), 10080),
 COALESCE((SELECT threshold_count FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_COOLDOWN' LIMIT 1), 2),
 COALESCE((SELECT distinct_account_threshold FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_COOLDOWN' LIMIT 1), 3),
 COALESCE((SELECT observation_minutes FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 60),
 COALESCE((SELECT threshold_count FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 3),
 COALESCE((SELECT lock_duration_minutes FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 30),
 7,
 COALESCE((SELECT observation_minutes FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 60),
 COALESCE((SELECT distinct_account_threshold FROM LOGIN_RISK_POLICY WHERE policy_code = 'SECURITY_APPEAL_RATE_LIMIT' LIMIT 1), 5),
 365,
 NULL,
 NULL,
 0,
 'MOCK_TURNSTILE',
 '보안 이의제기 전용 정책입니다. 인증 메일, 결과 조회, 동일 건 다중 접수, CLOSED 종결 정책을 관리자 UI에서 직접 조정합니다.',
 NOW(),
 NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM SECURITY_APPEAL_POLICY WHERE policy_code = 'DEFAULT'
);

INSERT INTO SECURITY_APPEAL_POLICY_HISTORY
(policy_idx, policy_code, version_no, change_type, actor_user_idx, before_config_json, after_config_json, created_at)
SELECT
 p.policy_idx,
 p.policy_code,
 1,
 'CREATE',
 NULL,
 NULL,
 JSON_OBJECT(
   'policyCode', p.policy_code,
   'active', p.is_active,
   'maxOpenAppealsPerCase', p.max_open_appeals_per_case,
   'verificationTokenTtlMinutes', p.verification_token_ttl_minutes,
   'protectedAppealTokenTtlDays', p.protected_appeal_token_ttl_days,
   'resultLookupRetentionDays', p.result_lookup_retention_days
 ),
 NOW()
FROM SECURITY_APPEAL_POLICY p
WHERE p.policy_code = 'DEFAULT'
  AND NOT EXISTS (
    SELECT 1 FROM SECURITY_APPEAL_POLICY_HISTORY h WHERE h.policy_idx = p.policy_idx
  );

-- 확인용
-- SELECT * FROM SECURITY_APPEAL_POLICY WHERE policy_code = 'DEFAULT';
-- SELECT * FROM SECURITY_APPEAL_POLICY_HISTORY WHERE policy_code = 'DEFAULT' ORDER BY version_no DESC;
