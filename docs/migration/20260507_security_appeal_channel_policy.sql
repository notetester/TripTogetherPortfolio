-- TripTogether 보안 이의제기 채널 정책/rate-limit 보강
-- 범위:
-- 1. SECURITY_APPEAL_RATE_LIMIT 정책 row 추가/갱신
-- 2. SECURITY_ACTION_APPEAL.appeal_status의 CLOSED 상태 설명 보강
--
-- 주의:
-- - 새 테이블 생성 없음
-- - CAPTCHA/Turnstile Provider 연동은 제외

START TRANSACTION;

INSERT INTO LOGIN_RISK_POLICY
(policy_code, policy_name, policy_type, is_active,
 observation_minutes, threshold_count, distinct_account_threshold,
 lock_duration_minutes, warning_before_count, reset_on_success, action_type,
 require_admin_review, review_severity, notification_category,
 ai_assist_enabled, ai_risk_score_threshold, waf_sync_enabled,
 description, created_at, updated_at)
VALUES
('SECURITY_APPEAL_RATE_LIMIT', 'Security Appeal Channel Rate Limit Policy', 'SECURITY_APPEAL', 1,
 60, 3, 5,
 30, 3, 0, 'APPEAL_RATE_LIMIT',
 0, 'LOW', 'BLOCK_REVIEW',
 0, 0, 0,
 '이의제기 채널 제한 정책입니다. observation_minutes=rate-limit 관찰 시간(분), threshold_count=동일 requestId/email 인증 링크 발송 한도, distinct_account_threshold=publicRequestId 결과 조회 실패 한도, lock_duration_minutes=인증 링크 TTL(분), warning_before_count=동일 건 동시 PENDING/HOLD 접수 허용 수입니다.',
 NOW(), NOW())
ON DUPLICATE KEY UPDATE
 policy_name = VALUES(policy_name),
 policy_type = VALUES(policy_type),
 observation_minutes = VALUES(observation_minutes),
 threshold_count = VALUES(threshold_count),
 distinct_account_threshold = VALUES(distinct_account_threshold),
 lock_duration_minutes = VALUES(lock_duration_minutes),
 warning_before_count = VALUES(warning_before_count),
 action_type = VALUES(action_type),
 notification_category = VALUES(notification_category),
 description = VALUES(description),
 updated_at = NOW();

COMMIT;

-- 확인용
-- SELECT policy_code, is_active, observation_minutes, threshold_count, distinct_account_threshold, lock_duration_minutes, warning_before_count
-- FROM LOGIN_RISK_POLICY
-- WHERE policy_code IN ('SECURITY_APPEAL_COOLDOWN', 'SECURITY_APPEAL_RATE_LIMIT');
