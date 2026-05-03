-- TripTogether 보안 거버넌스 후속 안정화
-- 적용 대상: MySQL 8.x
--
-- 포함 범위:
-- 1. 마이그레이션 적용 이력 테이블 추가
-- 2. 기존 보안 마이그레이션 적용 이력 기록
-- 3. 기존 해제 차단 데이터의 실효 상태 보정
-- 4. 일반 보안 검토 큐 시연 데이터 상태 다양화
-- 5. Provider/WAF 큐 골격에서 사용하는 상태값 설명용 샘플/이력 기록

CREATE TABLE IF NOT EXISTS `SCHEMA_MIGRATION_HISTORY` (
  `migration_id` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `checksum_hint` varchar(128) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'APPLIED' COMMENT 'APPLIED / FAILED / ROLLED_BACK / MANUAL_CHECK_REQUIRED',
  `applied_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `applied_by` varchar(100) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`migration_id`),
  KEY `idx_smh_status_applied` (`status`,`applied_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='수동 SQL 마이그레이션 적용 이력';

INSERT INTO SCHEMA_MIGRATION_HISTORY
(migration_id, description, checksum_hint, status, applied_by, notes)
VALUES
('20260501_login_risk_policy', '로그인 위험 정책 엔진 테이블/기본 정책', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_login_risk_policy_demo_seed', '로그인 위험 정책 시연 데이터', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_login_risk_followup', '보호 메일, 검토 큐 처리, Provider/WAF 후보 구조', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_login_risk_external_assessment_ready', '로그인 외부 판단/Provider 연결 준비', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_security_risk_assessment_user_block_enhancement', '일반 보안 판단 및 유저 차단 메타데이터 확장', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_security_appeal_public_flow', '사용자 보안 이의제기 접수 및 토큰 흐름', NULL, 'APPLIED', 'manual/sql', '기존 적용분 이력 등록'),
('20260501_security_governance_cleanup', '컴파일/XSS/i18n/이력/워커 골격 후속 안정화', NULL, 'APPLIED', 'manual/sql', '현재 SQL')
ON DUPLICATE KEY UPDATE
 status = VALUES(status),
 applied_at = NOW(),
 notes = VALUES(notes);

-- 과거 해제된 유저 차단 데이터의 실효 상태 보정
UPDATE USER_BLOCKLIST
SET is_effective_active = 0,
    effective_status = 'MANUAL_RELEASED',
    effective_status_reason = COALESCE(effective_status_reason, '기존 해제 데이터 마이그레이션 보정'),
    last_control_action = CASE
        WHEN last_control_action IS NULL OR last_control_action = 'CREATE'
        THEN 'RELEASE'
        ELSE last_control_action
    END,
    last_control_at = COALESCE(last_control_at, released_at, updated_at, NOW()),
    last_control_reason = COALESCE(last_control_reason, '기존 해제 데이터 마이그레이션 보정')
WHERE is_active = 0
   OR snapshot_status = 'RELEASED';

-- 일반 보안 검토 큐 시연 데이터 상태를 다양화
UPDATE SECURITY_REVIEW_QUEUE
SET review_status = 'HOLD',
    reviewed_at = COALESCE(reviewed_at, NOW()),
    review_comment = COALESCE(review_comment, 'DEMO-SECURITY-REVIEW-20260501: 추가 확인 필요')
WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
  AND review_idx = (
      SELECT review_idx FROM (
          SELECT review_idx
          FROM SECURITY_REVIEW_QUEUE
          WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
          ORDER BY review_idx ASC
          LIMIT 1 OFFSET 1
      ) q
  );

UPDATE SECURITY_REVIEW_QUEUE
SET review_status = 'REJECTED',
    reviewed_at = COALESCE(reviewed_at, NOW()),
    review_comment = COALESCE(review_comment, 'DEMO-SECURITY-REVIEW-20260501: 조치하지 않음')
WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
  AND review_idx = (
      SELECT review_idx FROM (
          SELECT review_idx
          FROM SECURITY_REVIEW_QUEUE
          WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
          ORDER BY review_idx ASC
          LIMIT 1 OFFSET 2
      ) q
  );

UPDATE SECURITY_REVIEW_QUEUE
SET review_status = 'APPROVED',
    reviewed_at = COALESCE(reviewed_at, NOW()),
    review_comment = COALESCE(review_comment, 'DEMO-SECURITY-REVIEW-20260501: 승인 완료')
WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
  AND review_idx = (
      SELECT review_idx FROM (
          SELECT review_idx
          FROM SECURITY_REVIEW_QUEUE
          WHERE detail_message LIKE '%DEMO-SECURITY-REVIEW-20260501%'
          ORDER BY review_idx ASC
          LIMIT 1 OFFSET 3
      ) q
  );

-- WAF 큐는 실제 외부 Provider 연결 전까지 대기 상태로 정리 가능
UPDATE LOGIN_RISK_WAF_SYNC_QUEUE
SET status = 'EXTERNAL_PROVIDER_PENDING',
    detail_message = COALESCE(detail_message, '외부 WAF/CDN Provider 연결 대기 상태입니다.'),
    updated_at = NOW()
WHERE status = 'PENDING'
  AND source_type IN ('SECURITY_RISK_ASSESSMENT', 'LOGIN_RISK_REVIEW');

-- 확인
-- SELECT * FROM SCHEMA_MIGRATION_HISTORY ORDER BY applied_at DESC;
-- SELECT review_status, COUNT(*) FROM SECURITY_REVIEW_QUEUE GROUP BY review_status;
-- SELECT status, COUNT(*) FROM LOGIN_RISK_WAF_SYNC_QUEUE GROUP BY status;
