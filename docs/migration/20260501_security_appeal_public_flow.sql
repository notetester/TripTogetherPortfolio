-- TripTogether 보안 조치 사용자 이의제기 접수 흐름 보강
-- 적용 대상: MySQL 8.x
--
-- 목적
-- 1. 차단 안내 페이지와 보호 조치 이메일에서 사용자 이의제기 접수 가능
-- 2. 이메일 토큰 기반 제한 접수 링크 제공
-- 3. 접수 건을 SECURITY_ACTION_APPEAL에 구조화 저장
-- 4. 로그인 사용자 기반이면 비공개 문의(INQUIRY_POST)도 함께 생성 가능
-- 5. 관리자 수용 시 USER/IP 차단 해제 메타데이터와 SECURITY_RISK_ASSESSMENT 상태 보정

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

CREATE TABLE IF NOT EXISTS `SECURITY_ACTION_APPEAL_TOKEN` (
  `token_idx` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `target_type` varchar(40) NOT NULL COMMENT 'USER_BLOCK / IP_BLOCK / CONTENT_MODERATION',
  `target_key` varchar(160) NOT NULL,
  `source_assessment_idx` bigint DEFAULT NULL,
  `block_request_id` varchar(36) DEFAULT NULL,
  `block_access_request_id` varchar(36) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE / USED / EXPIRED / REVOKED',
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_idx`),
  UNIQUE KEY `uk_saat_token` (`token`),
  KEY `idx_saat_user_created` (`user_idx`,`created_at`),
  KEY `idx_saat_target` (`target_type`,`target_key`),
  KEY `idx_saat_status_expires` (`status`,`expires_at`),
  KEY `idx_saat_assessment` (`source_assessment_idx`),
  CONSTRAINT `fk_security_action_appeal_token_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_action_appeal_token_assessment` FOREIGN KEY (`source_assessment_idx`) REFERENCES `SECURITY_RISK_ASSESSMENT` (`assessment_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 조치 이의제기 이메일/차단 안내 접수 토큰';

CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'appeal_token_idx',
    '`appeal_token_idx` bigint DEFAULT NULL COMMENT ''SECURITY_ACTION_APPEAL_TOKEN.token_idx''');
CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'block_request_id',
    '`block_request_id` varchar(36) DEFAULT NULL COMMENT ''차단 규칙 생성 요청 ID''');
CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'block_access_request_id',
    '`block_access_request_id` varchar(36) DEFAULT NULL COMMENT ''차단 접근 로그 request_id''');
CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'inquiry_id',
    '`inquiry_id` bigint DEFAULT NULL COMMENT ''연동된 비공개 문의 ID''');
CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'submitter_email',
    '`submitter_email` varchar(200) DEFAULT NULL COMMENT ''비로그인/토큰 접수 연락 이메일''');
CALL add_column_if_missing('SECURITY_ACTION_APPEAL', 'public_request_id',
    '`public_request_id` varchar(40) DEFAULT NULL COMMENT ''사용자에게 표시하는 접수번호''');

CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'source_assessment_idx',
    '`source_assessment_idx` bigint DEFAULT NULL COMMENT ''차단 원천 보안 판단 ID''');

CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_token', '(`appeal_token_idx`)');
CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_block_request', '(`block_request_id`)');
CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_block_access_request', '(`block_access_request_id`)');
CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_public_request', '(`public_request_id`)');
CALL add_index_if_missing('SECURITY_ACTION_APPEAL', 'idx_saa2_inquiry', '(`inquiry_id`)');
CALL add_index_if_missing('BLOCK_ACCESS_LOG', 'idx_bal_source_assessment', '(`source_assessment_idx`)');

DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_column_if_missing;

-- 기존 해제 데이터의 실효 상태 보정
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

-- 기존 BLOCK_ACCESS_LOG 중 source_action_group_id로 연결 가능한 SECURITY_RISK_ASSESSMENT가 있으면 최대한 보정한다.
UPDATE BLOCK_ACCESS_LOG bal
JOIN SECURITY_RISK_ASSESSMENT sra
  ON bal.source_action_group_id IS NOT NULL
 AND sra.raw_payload IS NOT NULL
 AND JSON_UNQUOTE(JSON_EXTRACT(sra.raw_payload, '$.demoTag')) IN ('DEMO-SECURITY-ASSESS-20260501', 'DEMO-EXT-ASSESS-20260501')
SET bal.source_assessment_idx = COALESCE(bal.source_assessment_idx, sra.assessment_idx)
WHERE bal.source_assessment_idx IS NULL
  AND (
      bal.source_user_idx = sra.user_idx
      OR bal.source_ip_address = sra.ip_address
      OR bal.ip_address = sra.ip_address
  );

START TRANSACTION;

SET @DEMO_APPEAL_FLOW_TAG := 'DEMO-SECURITY-APPEAL-FLOW-20260501';

SELECT @demo_spam_idx := user_idx FROM USERS WHERE user_id = 'demo_spam_user' LIMIT 1;
SELECT @demo_block_idx := user_idx FROM USERS WHERE user_id = 'demo_block_target' LIMIT 1;
SELECT @demo_spam_assessment_idx := assessment_idx
FROM SECURITY_RISK_ASSESSMENT
WHERE source_code = 'SPAM_ACCOUNT_AI_V2'
ORDER BY assessment_idx DESC
LIMIT 1;

DELETE FROM SECURITY_ACTION_APPEAL
WHERE public_request_id LIKE 'SAP-DEMO-%'
   OR appeal_content LIKE CONCAT('%', @DEMO_APPEAL_FLOW_TAG, '%');

DELETE FROM SECURITY_ACTION_APPEAL_TOKEN
WHERE token LIKE 'demo-appeal-token-%';

INSERT INTO SECURITY_ACTION_APPEAL_TOKEN
(token, user_idx, target_type, target_key, source_assessment_idx, block_request_id, block_access_request_id, status, expires_at, created_at)
VALUES
('demo-appeal-token-user-block-20260501', @demo_spam_idx, 'USER_BLOCK', CONCAT('USER:', @demo_spam_idx), @demo_spam_assessment_idx,
 'sra-demo-block-20260501-0001', NULL, 'ACTIVE', DATE_ADD(NOW(), INTERVAL 7 DAY), NOW()),
('demo-appeal-token-account-protection-20260501', @demo_block_idx, 'USER_BLOCK', CONCAT('USER:', @demo_block_idx), NULL,
 NULL, NULL, 'ACTIVE', DATE_ADD(NOW(), INTERVAL 7 DAY), NOW());

INSERT INTO SECURITY_ACTION_APPEAL
(user_idx, target_type, target_key, source_assessment_idx, appeal_token_idx,
 block_request_id, block_access_request_id, inquiry_id, submitter_email, public_request_id,
 appeal_status, appeal_title, appeal_content, created_at, updated_at)
SELECT
 @demo_spam_idx,
 'USER_BLOCK',
 CONCAT('USER:', @demo_spam_idx),
 @demo_spam_assessment_idx,
 t.token_idx,
 'sra-demo-block-20260501-0001',
 NULL,
 NULL,
 'demo_spam_user@example.com',
 'SAP-DEMO-0001',
 'PENDING',
 'AI 스팸 계정 차단 이의제기',
 CONCAT(@DEMO_APPEAL_FLOW_TAG, ' 정상 홍보 게시글이 스팸으로 오탐된 것으로 보입니다. 재검토를 요청합니다.'),
 NOW(),
 NOW()
FROM SECURITY_ACTION_APPEAL_TOKEN t
WHERE t.token = 'demo-appeal-token-user-block-20260501';

INSERT INTO SECURITY_ACTION_APPEAL
(user_idx, target_type, target_key, source_assessment_idx, appeal_token_idx,
 block_request_id, block_access_request_id, inquiry_id, submitter_email, public_request_id,
 appeal_status, appeal_title, appeal_content, reviewed_by_user_idx, reviewed_at, review_comment, created_at, updated_at)
SELECT
 @demo_block_idx,
 'USER_BLOCK',
 CONCAT('USER:', @demo_block_idx),
 NULL,
 t.token_idx,
 NULL,
 NULL,
 NULL,
 'demo_block_target@example.com',
 'SAP-DEMO-0002',
 'HOLD',
 '계정 보호 조치 재검토 요청',
 CONCAT(@DEMO_APPEAL_FLOW_TAG, ' 본인이 시도하지 않은 로그인 실패로 보호 조치가 걸린 것 같습니다. 접속 기록 확인을 요청합니다.'),
 NULL,
 NOW(),
 '추가 본인 확인 필요',
 NOW(),
 NOW()
FROM SECURITY_ACTION_APPEAL_TOKEN t
WHERE t.token = 'demo-appeal-token-account-protection-20260501';

COMMIT;

-- 확인
-- SELECT token, target_type, target_key, status, expires_at FROM SECURITY_ACTION_APPEAL_TOKEN ORDER BY created_at DESC;
-- SELECT public_request_id, target_type, target_key, appeal_status, submitter_email, block_request_id, block_access_request_id FROM SECURITY_ACTION_APPEAL ORDER BY created_at DESC;
