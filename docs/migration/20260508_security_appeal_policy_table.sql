-- TripTogether 보안 이의제기 전용 정책 테이블/UI 보강
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 범위:
-- 1. SECURITY_APPEAL_POLICY 전용 정책 테이블 생성
-- 2. DEFAULT 정책 row seed
-- 3. 기존 LOGIN_RISK_POLICY의 SECURITY_APPEAL_COOLDOWN / SECURITY_APPEAL_RATE_LIMIT 값이 있으면 초기값으로 승계
--
-- 주의:
-- - 실제 CAPTCHA/Cloudflare Turnstile API 연동은 하지 않고 시연용 설정값만 보관

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

INSERT INTO SECURITY_APPEAL_POLICY
(policy_code, is_active,
 allow_multiple_open_appeals, max_open_appeals_per_case, closed_blocks_new_appeals,
 rejected_cooldown_minutes, max_rejected_count, ip_daily_appeal_limit,
 verification_window_minutes, max_verification_emails, verification_token_ttl_minutes,
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

-- 확인용
-- SELECT * FROM SECURITY_APPEAL_POLICY WHERE policy_code = 'DEFAULT';
