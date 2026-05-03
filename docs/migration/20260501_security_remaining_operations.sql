-- TripTogether 보안 거버넌스 잔여 작업 반영
-- 적용 대상: MySQL 8.x
--
-- 특징:
-- - SCHEMA_MIGRATION_HISTORY는 운영 기능과 연결하지 않는다. 삭제해도 서비스 기능에 영향이 없도록 유지한다.
-- - 실제 외부 AI/WAF API 키는 저장하지 않고 ENV/PROP 참조만 저장한다.

DELIMITER $$

DROP PROCEDURE IF EXISTS add_column_if_missing $$
CREATE PROCEDURE add_column_if_missing(
    IN p_table_name VARCHAR(64),
    IN p_column_name VARCHAR(64),
    IN p_column_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = p_table_name
          AND COLUMN_NAME = p_column_name
    ) THEN
        SET @ddl = CONCAT('ALTER TABLE `', p_table_name, '` ADD COLUMN ', p_column_definition);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

DROP PROCEDURE IF EXISTS add_index_if_missing $$
CREATE PROCEDURE add_index_if_missing(
    IN p_table_name VARCHAR(64),
    IN p_index_name VARCHAR(64),
    IN p_index_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = p_table_name
          AND INDEX_NAME = p_index_name
    ) THEN
        SET @ddl = CONCAT('ALTER TABLE `', p_table_name, '` ADD INDEX `', p_index_name, '` ', p_index_definition);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

DELIMITER ;

CREATE TABLE IF NOT EXISTS `SCHEMA_MIGRATION_HISTORY` (
  `migration_id` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `checksum_hint` varchar(128) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'APPLIED',
  `applied_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `applied_by` varchar(100) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`migration_id`),
  KEY `idx_smh_status_applied` (`status`,`applied_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='수동 SQL 마이그레이션 적용 이력. 운영 기능과 직접 연결하지 않는다.';

CALL add_column_if_missing('SECURITY_ACTION_AUDIT', 'reason_code',
    '`reason_code` varchar(100) DEFAULT NULL COMMENT ''감사 사유 코드. 예: SECURITY.APPEAL.ACCEPTED''');
CALL add_column_if_missing('SECURITY_ACTION_AUDIT', 'reason_args',
    '`reason_args` json DEFAULT NULL COMMENT ''감사 사유 파라미터 JSON''');

CALL add_index_if_missing('SECURITY_ACTION_AUDIT', 'idx_saa_reason_code', '(`reason_code`,`created_at`)');
CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_duplicate_guard', '(`target_type`,`target_key`,`block_access_request_id`,`appeal_status`)');

-- 기존 해제된 유저 차단 데이터의 실효 상태 보정
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

-- 외부 Provider 연결 준비용 설정. 실제 키값은 저장하지 않고 ENV 참조만 저장한다.
INSERT INTO SECURITY_ASSESSMENT_PROVIDER_CONFIG
(provider_code, provider_kind, provider_name, is_enabled, endpoint_url, api_key_ref, model_name,
 timeout_millis, fail_open, status, description, created_at, updated_at)
VALUES
('GENERIC_AI_RISK_HTTP', 'AI_MODEL', 'Generic HTTP AI Risk Provider', 0, NULL, 'ENV:TRIPTOGETHER_AI_RISK_KEY', 'external-risk-model', 5000, 1, 'DISABLED', 'HTTP 기반 AI 위험 판단 Provider. Endpoint와 API 키 참조를 입력하고 활성화하면 동작합니다.', NOW(), NOW()),
('GENERIC_POLICY_AUTHORITY_HTTP', 'POLICY_AUTHORITY', 'Generic Policy Authority Provider', 0, NULL, 'ENV:TRIPTOGETHER_POLICY_AUTHORITY_KEY', 'policy-feed', 5000, 1, 'DISABLED', '상위 정책기관/관제센터 HTTP Provider. Endpoint와 API 키 참조를 입력하고 활성화하면 동작합니다.', NOW(), NOW()),
('GENERIC_WAF_HTTP', 'WAF_CDN', 'Generic WAF/CDN Sync Provider', 0, NULL, 'ENV:TRIPTOGETHER_WAF_SYNC_KEY', 'waf-sync-gateway', 5000, 0, 'DISABLED', 'Cloudflare/AWS WAF/Nginx Gateway로 연결할 수 있는 HTTP WAF 동기화 Provider입니다.', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 provider_kind = VALUES(provider_kind),
 provider_name = VALUES(provider_name),
 api_key_ref = VALUES(api_key_ref),
 model_name = VALUES(model_name),
 timeout_millis = VALUES(timeout_millis),
 description = VALUES(description),
 updated_at = NOW();

-- WAF 큐 상태 정리
UPDATE LOGIN_RISK_WAF_SYNC_QUEUE
SET status = 'EXTERNAL_PROVIDER_PENDING',
    detail_message = COALESCE(detail_message, '외부 WAF/CDN Provider 연결 대기 상태입니다.'),
    updated_at = NOW()
WHERE status = 'PENDING'
  AND source_type IN ('SECURITY_RISK_ASSESSMENT', 'LOGIN_RISK_REVIEW');

INSERT INTO SCHEMA_MIGRATION_HISTORY
(migration_id, description, checksum_hint, status, applied_by, notes)
VALUES
('20260501_security_remaining_operations', '외부 Provider HTTP 골격, WAF 재시도, 감사 reason_code/reason_args, 이의제기 중복 제한', NULL, 'APPLIED', 'manual/sql', '운영 테이블과 직접 연결되지 않는 이력 기록')
ON DUPLICATE KEY UPDATE
 status = VALUES(status),
 applied_at = NOW(),
 notes = VALUES(notes);

DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_column_if_missing;

-- 확인
-- SELECT provider_code, provider_kind, is_enabled, status, endpoint_url, api_key_ref FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG ORDER BY provider_code;
-- SELECT status, COUNT(*) FROM LOGIN_RISK_WAF_SYNC_QUEUE GROUP BY status;
-- SELECT migration_id, status, applied_at FROM SCHEMA_MIGRATION_HISTORY ORDER BY applied_at DESC;
