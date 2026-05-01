-- TripTogether 로그인 위험 정책 시연용 샘플 데이터
-- 전제:
--   1) docs/migration/20260501_login_risk_policy.sql 적용 완료
--   2) 시연용 demo_* 계정이 있으면 해당 계정과 연결됨
--      없더라도 IP/비회원 중심 데이터는 삽입 가능
--
-- 시연 검색 키워드:
--   DEMO-RISK-20260501
--   demo_abuse_target
--   198.51.100.77
--   203.0.113.45
--   ACCOUNT_PASSWORD_FAILURE_LOCK
--   IP_SUSPICIOUS_LOGIN_REVIEW
--   PENDING / HOLD / APPROVED / REJECTED

START TRANSACTION;

SET @DEMO_RISK_TAG := 'DEMO-RISK-20260501';

SELECT @demo_user_idx := user_idx FROM USERS WHERE user_id = 'demo_user' LIMIT 1;
SELECT @demo_business_idx := user_idx FROM USERS WHERE user_id = 'demo_business' LIMIT 1;
SELECT @demo_partner_idx := user_idx FROM USERS WHERE user_id = 'demo_partner' LIMIT 1;
SELECT @demo_abuse_target_idx := user_idx FROM USERS WHERE user_id = 'demo_abuse_target' LIMIT 1;
SELECT @demo_block_target_idx := user_idx FROM USERS WHERE user_id = 'demo_block_target' LIMIT 1;
SELECT @demo_ops_admin_idx := user_idx FROM USERS WHERE user_id = 'demo_ops_admin' LIMIT 1;
SELECT @demo_super_admin_idx := user_idx FROM USERS WHERE user_id = 'demo_super_admin' LIMIT 1;

-- 기존 시연 데이터 정리
DELETE FROM MYPAGE_FEED_NOTIFICATION
 WHERE source_type = 'LOGIN_RISK_REVIEW'
   AND message LIKE CONCAT('%', @DEMO_RISK_TAG, '%');

DELETE FROM LOGIN_RISK_REVIEW_QUEUE
 WHERE detail_message LIKE CONCAT('%', @DEMO_RISK_TAG, '%')
    OR summary LIKE CONCAT('%', @DEMO_RISK_TAG, '%')
    OR request_id LIKE 'lrq-%';

DELETE FROM LOGIN_RISK_EVENT
 WHERE detail_message LIKE CONCAT('%', @DEMO_RISK_TAG, '%')
    OR request_id LIKE 'lre-%'
    OR flow_trace_id LIKE 'lrf-%';

DELETE FROM LOGIN_RISK_COUNTER
 WHERE detail_message LIKE CONCAT('%', @DEMO_RISK_TAG, '%')
    OR subject_key IN (
        CAST(@demo_abuse_target_idx AS CHAR),
        CAST(@demo_block_target_idx AS CHAR),
        '198.51.100.77',
        '203.0.113.45',
        '203.0.113.0/24',
        '198.51.100.0/28',
        '192.0.2.44'
    );

-- 정책값을 시연에 적합하게 보정
UPDATE LOGIN_RISK_POLICY
SET is_active = 1,
    observation_minutes = 10,
    threshold_count = 5,
    lock_duration_minutes = 15,
    warning_before_count = 2,
    reset_on_success = 1,
    require_admin_review = 0,
    review_severity = 'MEDIUM',
    notification_category = 'LOGIN_RISK',
    updated_at = NOW()
WHERE policy_code = 'ACCOUNT_PASSWORD_FAILURE_LOCK';

UPDATE LOGIN_RISK_POLICY
SET is_active = 1,
    observation_minutes = 60,
    threshold_count = 3,
    lock_duration_minutes = NULL,
    warning_before_count = NULL,
    reset_on_success = 1,
    require_admin_review = 1,
    review_severity = 'HIGH',
    notification_category = 'LOGIN_RISK',
    updated_at = NOW()
WHERE policy_code = 'ACCOUNT_REPEATED_LOCK_PROTECTION';

UPDATE LOGIN_RISK_POLICY
SET is_active = 1,
    observation_minutes = 10,
    threshold_count = 10,
    distinct_account_threshold = 5,
    lock_duration_minutes = 30,
    warning_before_count = NULL,
    reset_on_success = 1,
    require_admin_review = 0,
    review_severity = 'HIGH',
    notification_category = 'LOGIN_RISK',
    updated_at = NOW()
WHERE policy_code = 'IP_FAILED_LOGIN_LOCK';

UPDATE LOGIN_RISK_POLICY
SET is_active = 1,
    observation_minutes = 60,
    threshold_count = 20,
    distinct_account_threshold = 8,
    lock_duration_minutes = NULL,
    warning_before_count = NULL,
    reset_on_success = 1,
    require_admin_review = 1,
    review_severity = 'MEDIUM',
    notification_category = 'LOGIN_RISK',
    updated_at = NOW()
WHERE policy_code = 'IP_SUSPICIOUS_LOGIN_REVIEW';

UPDATE LOGIN_RISK_POLICY
SET is_active = 1,
    observation_minutes = 5,
    threshold_count = 50,
    distinct_account_threshold = 20,
    lock_duration_minutes = NULL,
    warning_before_count = NULL,
    reset_on_success = 1,
    require_admin_review = 1,
    review_severity = 'CRITICAL',
    notification_category = 'LOGIN_RISK',
    updated_at = NOW()
WHERE policy_code = 'IP_BURST_AUTO_BLOCK_RECOMMENDATION';

-- 현재 제한/카운터 상태
INSERT INTO LOGIN_RISK_COUNTER
(policy_code, subject_type, subject_key, attempt_count, action_type, blocked_until, detail_message, observed_started_at, last_event_at, updated_at)
VALUES
('ACCOUNT_PASSWORD_FAILURE_LOCK', 'USER', CAST(@demo_abuse_target_idx AS CHAR), 4, 'WARN', NULL,
 CONCAT(@DEMO_RISK_TAG, ' demo_abuse_target 계정 비밀번호 실패 4회. 1회 추가 실패 시 로그인 일시 제한 예정'),
 '2026-05-01 08:40:00', '2026-05-01 08:49:00', '2026-05-01 08:49:00'),

('ACCOUNT_PASSWORD_FAILURE_LOCK', 'USER', CAST(@demo_block_target_idx AS CHAR), 5, 'ACCOUNT_TEMP_LOCK', '2026-05-01 09:30:00',
 CONCAT(@DEMO_RISK_TAG, ' demo_block_target 계정 비밀번호 실패 임계값 도달. 로그인 일시 제한 중'),
 '2026-05-01 08:50:00', '2026-05-01 08:56:00', '2026-05-01 08:56:00'),

('IP_FAILED_LOGIN_LOCK', 'IP', '198.51.100.77', 12, 'IP_LOGIN_LOCK', '2026-05-01 09:45:00',
 CONCAT(@DEMO_RISK_TAG, ' 동일 IP에서 다수 계정 로그인 실패. IP 로그인 일시 제한 중'),
 '2026-05-01 08:35:00', '2026-05-01 09:00:00', '2026-05-01 09:00:00'),

('IP_SUSPICIOUS_LOGIN_REVIEW', 'IP', '203.0.113.45', 23, 'ADMIN_REVIEW', NULL,
 CONCAT(@DEMO_RISK_TAG, ' 자동 차단 전 관리자 검토 대상 IP. 실패만 누적되나 계정 분포가 애매함'),
 '2026-05-01 07:20:00', '2026-05-01 08:55:00', '2026-05-01 08:55:00'),

('IP_BURST_AUTO_BLOCK_RECOMMENDATION', 'IP', '203.0.113.0/24', 58, 'ADMIN_REVIEW', NULL,
 CONCAT(@DEMO_RISK_TAG, ' 짧은 시간 다량 실패. 대역 단위 긴급 검토 필요'),
 '2026-05-01 08:52:00', '2026-05-01 08:57:00', '2026-05-01 08:57:00')
ON DUPLICATE KEY UPDATE
 attempt_count = VALUES(attempt_count),
 action_type = VALUES(action_type),
 blocked_until = VALUES(blocked_until),
 detail_message = VALUES(detail_message),
 observed_started_at = VALUES(observed_started_at),
 last_event_at = VALUES(last_event_at),
 updated_at = VALUES(updated_at);

-- 계정 단위: 경고 단계 4회 실패
INSERT INTO LOGIN_RISK_EVENT
(policy_code, event_type, subject_type, subject_key, user_idx, ip_address, login_identifier,
 threshold_count, observed_count, action_type, decision_status, review_required,
 blocked_until, request_id, flow_trace_id, detail_message, created_at)
VALUES
('ACCOUNT_PASSWORD_FAILURE_LOCK', 'WARNING', 'USER', CAST(@demo_abuse_target_idx AS CHAR), @demo_abuse_target_idx, '192.0.2.31', 'demo_abuse_target',
 5, 3, 'WARN', 'RECORDED', 0, NULL, 'lre-20260501-0001', 'lrf-20260501-account-warn-01',
 CONCAT(@DEMO_RISK_TAG, ' 비밀번호 실패 3회. 제한 전 잔여 2회 안내'), '2026-05-01 08:45:00'),
('ACCOUNT_PASSWORD_FAILURE_LOCK', 'WARNING', 'USER', CAST(@demo_abuse_target_idx AS CHAR), @demo_abuse_target_idx, '192.0.2.31', 'demo_abuse_target',
 5, 4, 'WARN', 'RECORDED', 0, NULL, 'lre-20260501-0002', 'lrf-20260501-account-warn-01',
 CONCAT(@DEMO_RISK_TAG, ' 비밀번호 실패 4회. 제한 전 잔여 1회 안내'), '2026-05-01 08:49:00'),

-- 계정 일시 제한 도달
('ACCOUNT_PASSWORD_FAILURE_LOCK', 'THRESHOLD_REACHED', 'USER', CAST(@demo_block_target_idx AS CHAR), @demo_block_target_idx, '192.0.2.32', 'demo_block_target',
 5, 5, 'ACCOUNT_TEMP_LOCK', 'AUTO_APPLIED', 0, '2026-05-01 09:30:00', 'lre-20260501-0003', 'lrf-20260501-account-lock-01',
 CONCAT(@DEMO_RISK_TAG, ' 비밀번호 실패 5회로 계정 로그인 일시 제한 적용'), '2026-05-01 08:56:00'),

-- 반복 제한으로 보호 조치 전환
('ACCOUNT_REPEATED_LOCK_PROTECTION', 'PROTECTION_REQUIRED', 'USER', CAST(@demo_block_target_idx AS CHAR), @demo_block_target_idx, '192.0.2.33', 'demo_block_target',
 3, 3, 'ACCOUNT_PROTECTION_REQUIRED', 'AUTO_APPLIED', 1, NULL, 'lre-20260501-0004', 'lrf-20260501-protection-01',
 CONCAT(@DEMO_RISK_TAG, ' 최근 60분 내 계정 일시 제한 3회. 운영자 확인 전 보호 조치 필요'), '2026-05-01 09:02:00'),

-- IP 로그인 일시 제한
('IP_FAILED_LOGIN_LOCK', 'THRESHOLD_REACHED', 'IP', '198.51.100.77', @demo_abuse_target_idx, '198.51.100.77', 'demo_abuse_target',
 10, 12, 'IP_LOGIN_LOCK', 'AUTO_APPLIED', 0, '2026-05-01 09:45:00', 'lre-20260501-0005', 'lrf-20260501-ip-lock-01',
 CONCAT(@DEMO_RISK_TAG, ' 동일 IP에서 10분 내 실패 12회, 서로 다른 식별자 6개. 로그인 일시 제한 적용'), '2026-05-01 09:00:00'),

-- 관리자 검토 큐로 넘긴 애매한 IP
('IP_SUSPICIOUS_LOGIN_REVIEW', 'REVIEW_CREATED', 'IP', '203.0.113.45', NULL, '203.0.113.45', NULL,
 20, 23, 'ADMIN_REVIEW', 'REVIEW_PENDING', 1, NULL, 'lre-20260501-0006', 'lrf-20260501-ip-review-01',
 CONCAT(@DEMO_RISK_TAG, ' 실패 23회. 성공 로그인 없음. 자동 차단 대신 관리자 검토 큐 생성'), '2026-05-01 08:55:00'),

-- 긴급 대역 검토
('IP_BURST_AUTO_BLOCK_RECOMMENDATION', 'REVIEW_CREATED', 'IP_RANGE', '203.0.113.0/24', NULL, '203.0.113.0/24', NULL,
 50, 58, 'ADMIN_REVIEW', 'REVIEW_PENDING', 1, NULL, 'lre-20260501-0007', 'lrf-20260501-burst-01',
 CONCAT(@DEMO_RISK_TAG, ' 5분 내 실패 58회, 서로 다른 식별자 24개. 대역 단위 긴급 검토 필요'), '2026-05-01 08:57:00'),

-- 정상 로그인 성공으로 계정 카운터 초기화 시연용 기록
('ACCOUNT_PASSWORD_FAILURE_LOCK', 'COUNTER_RESET', 'USER', CAST(@demo_user_idx AS CHAR), @demo_user_idx, '192.0.2.34', 'demo_user',
 5, 0, 'RESET_ON_SUCCESS', 'RECORDED', 0, NULL, 'lre-20260501-0008', 'lrf-20260501-reset-01',
 CONCAT(@DEMO_RISK_TAG, ' 로그인 성공으로 실패 카운터 초기화됨'), '2026-05-01 09:05:00'),

-- 비즈니스 계정 보호 검토
('ACCOUNT_REPEATED_LOCK_PROTECTION', 'REVIEW_CREATED', 'USER', CAST(@demo_business_idx AS CHAR), @demo_business_idx, '198.51.100.88', 'demo_business',
 3, 2, 'ADMIN_REVIEW', 'REVIEW_PENDING', 1, NULL, 'lre-20260501-0009', 'lrf-20260501-business-review-01',
 CONCAT(@DEMO_RISK_TAG, ' 비즈니스 계정의 반복 실패. 자동 보호 조치 전 운영자 검토 필요'), '2026-05-01 09:08:00');

-- 관리자 검토 큐: PENDING / HOLD / APPROVED / REJECTED를 모두 보여주기
INSERT INTO LOGIN_RISK_REVIEW_QUEUE
(policy_code, review_type, severity, subject_type, subject_key, user_idx, ip_address,
 request_id, flow_trace_id, summary, detail_message, review_status,
 reviewed_by_user_idx, reviewed_at, review_comment, created_at, updated_at)
VALUES
('ACCOUNT_REPEATED_LOCK_PROTECTION', 'ACCOUNT_PROTECTION', 'HIGH', 'USER', CAST(@demo_block_target_idx AS CHAR), @demo_block_target_idx, '192.0.2.33',
 'lrq-20260501-0001', 'lrf-20260501-protection-01',
 CONCAT(@DEMO_RISK_TAG, ' 계정 보호 조치 검토 필요'),
 CONCAT(@DEMO_RISK_TAG, ' 최근 60분 내 로그인 일시 제한 3회. 운영자 확인 전까지 보호 조치 유지 권장'),
 'PENDING', NULL, NULL, NULL, '2026-05-01 09:02:30', '2026-05-01 09:02:30'),

('IP_SUSPICIOUS_LOGIN_REVIEW', 'IP_LOGIN_RISK', 'MEDIUM', 'IP', '203.0.113.45', NULL, '203.0.113.45',
 'lrq-20260501-0002', 'lrf-20260501-ip-review-01',
 CONCAT(@DEMO_RISK_TAG, ' 반복 실패 IP 검토 필요'),
 CONCAT(@DEMO_RISK_TAG, ' 60분 내 실패 23회. 성공 로그인 없음. 공용망 가능성이 있어 자동 차단 대신 검토 요청'),
 'HOLD', @demo_ops_admin_idx, '2026-05-01 09:10:00', '공용망 가능성 확인 필요. 30분 후 재검토', '2026-05-01 08:55:30', '2026-05-01 09:10:00'),

('IP_BURST_AUTO_BLOCK_RECOMMENDATION', 'IP_BURST', 'CRITICAL', 'IP_RANGE', '203.0.113.0/24', NULL, '203.0.113.0/24',
 'lrq-20260501-0003', 'lrf-20260501-burst-01',
 CONCAT(@DEMO_RISK_TAG, ' IP 대역 긴급 검토 필요'),
 CONCAT(@DEMO_RISK_TAG, ' 5분 내 실패 58회, 서로 다른 식별자 24개. WAF/앞단 제한 또는 대역 차단 검토 필요'),
 'PENDING', NULL, NULL, NULL, '2026-05-01 08:57:30', '2026-05-01 08:57:30'),

('IP_SUSPICIOUS_LOGIN_REVIEW', 'IP_LOGIN_RISK', 'MEDIUM', 'IP', '198.51.100.0/28', NULL, '198.51.100.0/28',
 'lrq-20260501-0004', 'lrf-20260501-ip-approved-01',
 CONCAT(@DEMO_RISK_TAG, ' 제휴망 오탐 가능 IP 검토 완료'),
 CONCAT(@DEMO_RISK_TAG, ' 제휴사 테스트망으로 확인. 차단하지 않음'),
 'REJECTED', @demo_super_admin_idx, '2026-05-01 09:12:00', '정상 제휴 테스트 트래픽으로 판단', '2026-05-01 08:40:00', '2026-05-01 09:12:00'),

('ACCOUNT_REPEATED_LOCK_PROTECTION', 'ACCOUNT_PROTECTION', 'HIGH', 'USER', CAST(@demo_business_idx AS CHAR), @demo_business_idx, '198.51.100.88',
 'lrq-20260501-0005', 'lrf-20260501-business-review-01',
 CONCAT(@DEMO_RISK_TAG, ' 비즈니스 계정 보호 조치 승인'),
 CONCAT(@DEMO_RISK_TAG, ' 결제/상품 관리 권한이 있는 계정에서 반복 실패. 임시 보호 조치 승인'),
 'APPROVED', @demo_super_admin_idx, '2026-05-01 09:15:00', '계정 보호 조치 유지 및 이메일 안내 필요', '2026-05-01 09:08:30', '2026-05-01 09:15:00');

-- 관리자별 알림 수신 설정 예시
-- 운영 관리자는 로그인 위험 알림 수신
INSERT INTO ADMIN_NOTIFICATION_PREFERENCE
(user_idx, notification_category, is_enabled, created_at, updated_at)
SELECT @demo_ops_admin_idx, 'LOGIN_RISK', 1, NOW(), NOW()
WHERE @demo_ops_admin_idx IS NOT NULL
ON DUPLICATE KEY UPDATE is_enabled = VALUES(is_enabled), updated_at = NOW();

-- 최고 관리자는 로그인 위험 알림 수신
INSERT INTO ADMIN_NOTIFICATION_PREFERENCE
(user_idx, notification_category, is_enabled, created_at, updated_at)
SELECT @demo_super_admin_idx, 'LOGIN_RISK', 1, NOW(), NOW()
WHERE @demo_super_admin_idx IS NOT NULL
ON DUPLICATE KEY UPDATE is_enabled = VALUES(is_enabled), updated_at = NOW();

-- 예시: 기업 승인 알림은 운영 관리자에게 끔
INSERT INTO ADMIN_NOTIFICATION_PREFERENCE
(user_idx, notification_category, is_enabled, created_at, updated_at)
SELECT @demo_ops_admin_idx, 'BUSINESS_APPLICATION', 0, NOW(), NOW()
WHERE @demo_ops_admin_idx IS NOT NULL
ON DUPLICATE KEY UPDATE is_enabled = VALUES(is_enabled), updated_at = NOW();

-- 관리자 알림 샘플
INSERT INTO MYPAGE_FEED_NOTIFICATION
(user_idx, source_type, source_id, message, target_url, created_at, is_read)
SELECT u.user_idx,
       'LOGIN_RISK_REVIEW',
       rq.review_idx,
       CONCAT('[', @DEMO_RISK_TAG, '] ', rq.summary),
       '/admin/login-risk/policies',
       rq.created_at,
       CASE WHEN rq.review_status IN ('APPROVED', 'REJECTED') THEN 1 ELSE 0 END
FROM USERS u
JOIN LOGIN_RISK_REVIEW_QUEUE rq
  ON rq.detail_message LIKE CONCAT('%', @DEMO_RISK_TAG, '%')
WHERE u.account_status = 'ACTIVE'
  AND u.user_role IN ('ADMIN', 'SUPERADMIN')
  AND NOT EXISTS (
      SELECT 1
      FROM ADMIN_NOTIFICATION_PREFERENCE p
      WHERE p.user_idx = u.user_idx
        AND p.notification_category = 'LOGIN_RISK'
        AND p.is_enabled = 0
  );

COMMIT;

-- 빠른 확인 쿼리
-- SELECT * FROM LOGIN_RISK_POLICY ORDER BY policy_idx;
-- SELECT policy_code, subject_type, subject_key, attempt_count, action_type, blocked_until, detail_message FROM LOGIN_RISK_COUNTER WHERE detail_message LIKE '%DEMO-RISK-20260501%' ORDER BY updated_at DESC;
-- SELECT policy_code, event_type, subject_type, subject_key, observed_count, action_type, decision_status, review_required, detail_message, created_at FROM LOGIN_RISK_EVENT WHERE detail_message LIKE '%DEMO-RISK-20260501%' ORDER BY created_at;
-- SELECT review_status, severity, review_type, subject_type, subject_key, summary, reviewed_by_user_idx, reviewed_at FROM LOGIN_RISK_REVIEW_QUEUE WHERE detail_message LIKE '%DEMO-RISK-20260501%' ORDER BY created_at;
-- SELECT user_idx, source_type, source_id, message, target_url, is_read, created_at FROM MYPAGE_FEED_NOTIFICATION WHERE source_type='LOGIN_RISK_REVIEW' AND message LIKE '%DEMO-RISK-20260501%' ORDER BY created_at DESC;
