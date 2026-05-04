-- TripTogether 보안 거버넌스 후속 보강
-- 범위:
-- 1. 정책 피드 API 수신 시연용 샘플 Provider/정책 row 보강
-- 2. SECURITY_APPEAL_COOLDOWN 정책 row 추가/갱신
--
-- 주의:
-- - 새 테이블 생성 없음
-- - 테이블 구조 변경 없음

START TRANSACTION;

INSERT INTO SECURITY_ASSESSMENT_PROVIDER_CONFIG
(provider_code, provider_kind, provider_name, is_enabled, endpoint_url, api_key_ref, model_name,
 timeout_millis, fail_open, status, description, created_at, updated_at)
VALUES
('POLICY_FEED_API_SAMPLE', 'POLICY_AUTHORITY', 'Policy Feed API Sample Contract', 1, '/admin/blocks/policy-feed/api', NULL, 'manual-feed-api-v1', 3000, 1, 'READY', '외부 정책기관/관제 API 협의 전 TripTogether가 제안할 수 있는 표준 정책 피드 수신 계약 샘플입니다.', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 provider_kind = VALUES(provider_kind),
 provider_name = VALUES(provider_name),
 is_enabled = VALUES(is_enabled),
 endpoint_url = VALUES(endpoint_url),
 api_key_ref = VALUES(api_key_ref),
 model_name = VALUES(model_name),
 timeout_millis = VALUES(timeout_millis),
 fail_open = VALUES(fail_open),
 status = VALUES(status),
 description = VALUES(description),
 updated_at = NOW();

INSERT INTO LOGIN_RISK_POLICY
(policy_code, policy_name, policy_type, is_active,
 observation_minutes, threshold_count, distinct_account_threshold,
 lock_duration_minutes, warning_before_count, reset_on_success, action_type,
 require_admin_review, review_severity, notification_category,
 ai_assist_enabled, ai_risk_score_threshold, waf_sync_enabled,
 description, created_at, updated_at)
VALUES
('SECURITY_APPEAL_COOLDOWN', 'Security Appeal Cooldown Policy', 'SECURITY_APPEAL', 1,
 10080, 2, 3,
 0, 0, 0, 'APPEAL_LIMIT',
 0, 'LOW', 'BLOCK_REVIEW',
 0, 0, 0,
 '공개 보안 이의제기 재접수 제한 정책입니다. observation_minutes=REJECTED 후 재접수 제한 시간(분), threshold_count=동일 조치 최대 거절 횟수, distinct_account_threshold=동일 IP 대상 일일 접수 제한입니다.',
 NOW(), NOW())
ON DUPLICATE KEY UPDATE
 policy_name = VALUES(policy_name),
 policy_type = VALUES(policy_type),
 observation_minutes = VALUES(observation_minutes),
 threshold_count = VALUES(threshold_count),
 distinct_account_threshold = VALUES(distinct_account_threshold),
 action_type = VALUES(action_type),
 notification_category = VALUES(notification_category),
 description = VALUES(description),
 updated_at = NOW();

COMMIT;

-- 확인용
-- SELECT policy_code, is_active, observation_minutes, threshold_count, distinct_account_threshold
-- FROM LOGIN_RISK_POLICY
-- WHERE policy_code = 'SECURITY_APPEAL_COOLDOWN';
--
-- SELECT provider_code, provider_kind, endpoint_url, model_name, is_enabled
-- FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
-- WHERE provider_code = 'POLICY_FEED_API_SAMPLE';
