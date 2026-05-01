-- TripTogether 보안 위험 판단 일반화 + 유저 차단 메타데이터 확장
-- 적용 대상: MySQL 8.x
--
-- 목적:
-- 1. 로그인 전용 LOGIN_RISK_EXTERNAL_ASSESSMENT를 넘어, 계정/IP/콘텐츠/정책 판단을 모두 담는 SECURITY_RISK_ASSESSMENT를 추가한다.
-- 2. USER_BLOCKLIST / USER_BLOCK_HISTORY에도 IP_BLOCKLIST 수준의 운영 메타데이터를 부여한다.
-- 3. SYSTEM 역할 계정을 시드하여 AI/룰엔진/정책동기화 주체로 감사 추적 가능하게 한다.
-- 4. AI/알고리즘/상위 정책기관 판단 기반 유저 자동 차단 샘플 데이터를 넣는다.

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

CREATE TABLE IF NOT EXISTS `SECURITY_RISK_ASSESSMENT` (
  `assessment_idx` bigint NOT NULL AUTO_INCREMENT,
  `assessment_scope` varchar(40) NOT NULL COMMENT 'LOGIN_RISK / USER_SECURITY / CONTENT_MODERATION / IP_REPUTATION / POLICY_SYNC',
  `source_kind` varchar(40) NOT NULL COMMENT 'AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / ASSESSMENT_PIPELINE',
  `source_code` varchar(80) NOT NULL COMMENT '판단 모듈/기관/알고리즘 코드',
  `source_name` varchar(160) NOT NULL COMMENT '판단 출처 표시명',
  `source_version` varchar(60) DEFAULT NULL,
  `source_type` varchar(40) DEFAULT NULL COMMENT 'LOGIN_RISK_EVENT / LOGIN_RISK_REVIEW / REPORT / COMMUNITY_POST 등',
  `source_id` bigint DEFAULT NULL,
  `policy_code` varchar(60) DEFAULT NULL,
  `subject_type` varchar(30) NOT NULL COMMENT 'USER / IP / IP_RANGE / ASN / COUNTRY / CONTENT',
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `country_code` varchar(10) DEFAULT NULL,
  `asn` varchar(20) DEFAULT NULL,
  `content_type` varchar(40) DEFAULT NULL,
  `content_id` bigint DEFAULT NULL,
  `risk_score` int DEFAULT NULL COMMENT '0~100 위험 점수',
  `risk_level` varchar(20) DEFAULT NULL COMMENT 'LOW / MEDIUM / HIGH / CRITICAL / PENDING',
  `confidence_score` int DEFAULT NULL COMMENT '0~100 신뢰도',
  `recommendation_action` varchar(40) DEFAULT NULL COMMENT 'MONITOR / REVIEW / LOCK_ACCOUNT / BLOCK_USER / BLOCK_IP / BLOCK_CIDR / HIDE_CONTENT / ALLOW',
  `recommendation_reason` varchar(500) DEFAULT NULL,
  `evidence_summary` varchar(1000) DEFAULT NULL,
  `decision_status` varchar(30) NOT NULL DEFAULT 'PROPOSED' COMMENT 'PROPOSED / APPLIED / IGNORED / PENDING',
  `raw_payload` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessment_idx`),
  KEY `idx_sra_scope_created` (`assessment_scope`,`created_at`),
  KEY `idx_sra_source_kind_created` (`source_kind`,`created_at`),
  KEY `idx_sra_risk_level_created` (`risk_level`,`created_at`),
  KEY `idx_sra_decision_status` (`decision_status`,`created_at`),
  KEY `idx_sra_subject` (`subject_type`,`subject_key`,`created_at`),
  KEY `idx_sra_source_ref` (`source_type`,`source_id`),
  KEY `idx_sra_user_created` (`user_idx`,`created_at`),
  KEY `idx_sra_ip_created` (`ip_address`,`created_at`),
  CONSTRAINT `fk_sra_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI/알고리즘/상위 정책기관 기반 일반 보안 위험 판단 결과';

-- USER_BLOCKLIST: IP_BLOCKLIST와 같은 수준의 운영 메타데이터 보강
CALL add_column_if_missing('USER_BLOCKLIST', 'rule_action', '`rule_action` varchar(10) NOT NULL DEFAULT ''BLOCK'' COMMENT ''규칙 동작 BLOCK / ALLOW''');
CALL add_column_if_missing('USER_BLOCKLIST', 'control_mode', '`control_mode` varchar(30) NOT NULL DEFAULT ''MANUAL'' COMMENT ''MANUAL / AUTO / BATCH / MANUAL_OVERRIDE''');
CALL add_column_if_missing('USER_BLOCKLIST', 'rule_origin_type', '`rule_origin_type` varchar(30) NOT NULL DEFAULT ''MANUAL'' COMMENT ''MANUAL / AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / FEED / SYSTEM''');
CALL add_column_if_missing('USER_BLOCKLIST', 'source_scope', '`source_scope` varchar(30) NOT NULL DEFAULT ''GLOBAL'' COMMENT ''GLOBAL / USER_ACTION / AUTO_DETECTION / CONTENT_MODERATION / LOGIN_RISK''');
CALL add_column_if_missing('USER_BLOCKLIST', 'block_category', '`block_category` varchar(40) NOT NULL DEFAULT ''SECURITY'' COMMENT ''SPAM / ABUSE / BRUTE_FORCE / CONTENT_VIOLATION / FRAUD / SECURITY / MANUAL''');
CALL add_column_if_missing('USER_BLOCKLIST', 'risk_score', '`risk_score` int DEFAULT NULL COMMENT ''위험 점수 0~100''');
CALL add_column_if_missing('USER_BLOCKLIST', 'is_auto_block', '`is_auto_block` tinyint(1) NOT NULL DEFAULT 0 COMMENT ''자동 차단 여부''');
CALL add_column_if_missing('USER_BLOCKLIST', 'auto_block_source', '`auto_block_source` varchar(50) DEFAULT NULL COMMENT ''RULE / AI / POLICY_SYNC / FEED / SYSTEM''');
CALL add_column_if_missing('USER_BLOCKLIST', 'detail_message', '`detail_message` varchar(1000) DEFAULT NULL COMMENT ''상세 판단 메모''');
CALL add_column_if_missing('USER_BLOCKLIST', 'priority', '`priority` int NOT NULL DEFAULT 1 COMMENT ''우선순위. 높을수록 먼저 평가''');
CALL add_column_if_missing('USER_BLOCKLIST', 'is_effective_active', '`is_effective_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT ''현재 실제 평가 대상 여부''');
CALL add_column_if_missing('USER_BLOCKLIST', 'effective_status', '`effective_status` varchar(50) NOT NULL DEFAULT ''EFFECTIVE'' COMMENT ''EFFECTIVE / RULE_INACTIVE / EXPIRED / MANUAL_RELEASED''');
CALL add_column_if_missing('USER_BLOCKLIST', 'effective_status_reason', '`effective_status_reason` varchar(500) DEFAULT NULL COMMENT ''최종 상태 설명''');
CALL add_column_if_missing('USER_BLOCKLIST', 'effective_synced_at', '`effective_synced_at` datetime DEFAULT NULL COMMENT ''최종 상태 동기화 시각''');
CALL add_column_if_missing('USER_BLOCKLIST', 'last_control_action', '`last_control_action` varchar(50) NOT NULL DEFAULT ''CREATE'' COMMENT ''CREATE / AUTO_BLOCK / MANUAL_ENABLE / MANUAL_DISABLE / RELEASE / OVERRIDE''');
CALL add_column_if_missing('USER_BLOCKLIST', 'last_control_by_user_idx', '`last_control_by_user_idx` bigint DEFAULT NULL COMMENT ''마지막 제어 작업자''');
CALL add_column_if_missing('USER_BLOCKLIST', 'last_control_at', '`last_control_at` datetime DEFAULT NULL COMMENT ''마지막 제어 시각''');
CALL add_column_if_missing('USER_BLOCKLIST', 'last_control_reason', '`last_control_reason` varchar(255) DEFAULT NULL COMMENT ''마지막 제어 사유''');
CALL add_column_if_missing('USER_BLOCKLIST', 'source_assessment_idx', '`source_assessment_idx` bigint DEFAULT NULL COMMENT ''SECURITY_RISK_ASSESSMENT.assessment_idx''');

-- USER_BLOCK_HISTORY: 현재 상태와 동일한 판단 근거/자동화 메타데이터 보강
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'rule_origin_type', '`rule_origin_type` varchar(30) NOT NULL DEFAULT ''MANUAL'' COMMENT ''MANUAL / AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / FEED / SYSTEM''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_scope', '`source_scope` varchar(30) NOT NULL DEFAULT ''GLOBAL'' COMMENT ''GLOBAL / USER_ACTION / AUTO_DETECTION / CONTENT_MODERATION / LOGIN_RISK''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'block_category', '`block_category` varchar(40) NOT NULL DEFAULT ''SECURITY'' COMMENT ''SPAM / ABUSE / BRUTE_FORCE / CONTENT_VIOLATION / FRAUD / SECURITY / MANUAL''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'risk_score', '`risk_score` int DEFAULT NULL COMMENT ''위험 점수 0~100''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'is_auto_block', '`is_auto_block` tinyint(1) NOT NULL DEFAULT 0 COMMENT ''자동 차단 여부''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'auto_block_source', '`auto_block_source` varchar(50) DEFAULT NULL COMMENT ''RULE / AI / POLICY_SYNC / FEED / SYSTEM''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'detail_message', '`detail_message` varchar(1000) DEFAULT NULL COMMENT ''상세 판단 메모''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'priority', '`priority` int NOT NULL DEFAULT 1 COMMENT ''우선순위''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'is_effective_active', '`is_effective_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT ''현재 실제 평가 대상 여부''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'effective_status', '`effective_status` varchar(50) NOT NULL DEFAULT ''EFFECTIVE'' COMMENT ''EFFECTIVE / RULE_INACTIVE / EXPIRED / MANUAL_RELEASED''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'effective_status_reason', '`effective_status_reason` varchar(500) DEFAULT NULL COMMENT ''최종 상태 설명''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'effective_synced_at', '`effective_synced_at` datetime DEFAULT NULL COMMENT ''최종 상태 동기화 시각''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'last_control_action', '`last_control_action` varchar(50) NOT NULL DEFAULT ''CREATE'' COMMENT ''CREATE / AUTO_BLOCK / MANUAL_ENABLE / MANUAL_DISABLE / RELEASE / OVERRIDE''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'last_control_by_user_idx', '`last_control_by_user_idx` bigint DEFAULT NULL COMMENT ''마지막 제어 작업자''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'last_control_at', '`last_control_at` datetime DEFAULT NULL COMMENT ''마지막 제어 시각''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'last_control_reason', '`last_control_reason` varchar(255) DEFAULT NULL COMMENT ''마지막 제어 사유''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_assessment_idx', '`source_assessment_idx` bigint DEFAULT NULL COMMENT ''SECURITY_RISK_ASSESSMENT.assessment_idx''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_action_type', '`source_action_type` varchar(40) DEFAULT NULL COMMENT ''차단 조치 유형''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_action_group_id', '`source_action_group_id` varchar(36) DEFAULT NULL COMMENT ''같은 보안 조치 묶음 ID''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_user_idx', '`source_user_idx` bigint DEFAULT NULL COMMENT ''조치 기준 사용자 PK''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_ip_address', '`source_ip_address` varchar(45) DEFAULT NULL COMMENT ''조치 기준 IP''');

CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_origin_category', '(`rule_origin_type`,`block_category`,`is_active`)');
CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_auto_source', '(`is_auto_block`,`auto_block_source`,`blocked_at`)');
CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_risk_score', '(`risk_score`,`blocked_at`)');
CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_effective_status2', '(`is_effective_active`,`effective_status`)');
CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_source_assessment', '(`source_assessment_idx`)');

CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_origin_category', '(`rule_origin_type`,`block_category`,`created_at`)');
CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_auto_source', '(`is_auto_block`,`auto_block_source`,`created_at`)');
CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_risk_score', '(`risk_score`,`created_at`)');
CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_source_assessment', '(`source_assessment_idx`)');

DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_column_if_missing;

START TRANSACTION;

-- SYSTEM 역할 계정 시드. 실제 자동 집행 주체를 감사 추적하기 위한 계정이다.
INSERT INTO USERS
(user_id, user_email, user_password, password_enabled, email_verified, email_login_enabled,
 account_status, nickname, nationality, preferred_lang, user_role, created_at, status_changed_at)
VALUES
('system_ai_security', NULL, NULL, 0, 0, 0, 'ACTIVE', 'AI 보안 자동화 시스템', 'SYSTEM', 'ko', 'SYSTEM', NOW(), NOW()),
('system_rule_engine', NULL, NULL, 0, 0, 0, 'ACTIVE', '룰 기반 보안 엔진', 'SYSTEM', 'ko', 'SYSTEM', NOW(), NOW()),
('system_policy_engine', NULL, NULL, 0, 0, 0, 'ACTIVE', '상위 정책 동기화 시스템', 'SYSTEM', 'ko', 'SYSTEM', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 user_role = 'SYSTEM',
 account_status = 'ACTIVE',
 status_changed_at = NOW();

-- 시연용 계정
INSERT INTO USERS
(user_id, user_email, user_password, password_enabled, email_verified, email_login_enabled,
 account_status, nickname, nationality, preferred_lang, user_role, created_at, status_changed_at)
VALUES
('demo_spam_user', 'demo_spam_user@example.com', '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 1, 1,
 'ACTIVE', '시연스팸계정', 'KR', 'ko', 'USER', NOW(), NOW()),
('demo_content_abuse_user', 'demo_content_abuse_user@example.com', '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 1, 1,
 'ACTIVE', '시연부적절게시글계정', 'KR', 'ko', 'USER', NOW(), NOW()),
('demo_policy_watch_user', 'demo_policy_watch_user@example.com', '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 1, 1,
 'ACTIVE', '시연정책감시계정', 'KR', 'ko', 'USER', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 account_status = VALUES(account_status),
 nickname = VALUES(nickname),
 status_changed_at = NOW();

SELECT @system_ai_idx := user_idx FROM USERS WHERE user_id = 'system_ai_security' LIMIT 1;
SELECT @system_rule_idx := user_idx FROM USERS WHERE user_id = 'system_rule_engine' LIMIT 1;
SELECT @system_policy_idx := user_idx FROM USERS WHERE user_id = 'system_policy_engine' LIMIT 1;
SELECT @demo_spam_idx := user_idx FROM USERS WHERE user_id = 'demo_spam_user' LIMIT 1;
SELECT @demo_content_idx := user_idx FROM USERS WHERE user_id = 'demo_content_abuse_user' LIMIT 1;
SELECT @demo_policy_idx := user_idx FROM USERS WHERE user_id = 'demo_policy_watch_user' LIMIT 1;

SET @DEMO_SECURITY_TAG := 'DEMO-SECURITY-ASSESS-20260501';

-- 로그인 외부 판단 테이블이 이미 있으면 일반 보안 판단 테이블로 복사한다.
INSERT INTO SECURITY_RISK_ASSESSMENT
(assessment_scope, source_kind, source_code, source_name, source_version,
 source_type, source_id, policy_code, subject_type, subject_key,
 user_idx, ip_address, country_code, asn, content_type, content_id,
 risk_score, risk_level, confidence_score, recommendation_action, recommendation_reason,
 evidence_summary, decision_status, raw_payload, created_at)
SELECT
 'LOGIN_RISK',
 source_kind, source_code, source_name, source_version,
 source_type, source_id, policy_code, subject_type, subject_key,
 user_idx, ip_address, country_code, asn, NULL, NULL,
 risk_score, risk_level, confidence_score, recommendation_action, recommendation_reason,
 evidence_summary, decision_status, raw_payload, created_at
FROM LOGIN_RISK_EXTERNAL_ASSESSMENT lrea
WHERE NOT EXISTS (
    SELECT 1
    FROM SECURITY_RISK_ASSESSMENT sra
    WHERE sra.assessment_scope = 'LOGIN_RISK'
      AND sra.source_kind = lrea.source_kind
      AND sra.source_code = lrea.source_code
      AND sra.subject_type = lrea.subject_type
      AND sra.subject_key = lrea.subject_key
      AND COALESCE(sra.source_id, -1) = COALESCE(lrea.source_id, -1)
);

DELETE FROM SECURITY_RISK_ASSESSMENT
WHERE raw_payload IS NOT NULL
  AND JSON_UNQUOTE(JSON_EXTRACT(raw_payload, '$.demoTag')) = @DEMO_SECURITY_TAG;

INSERT INTO SECURITY_RISK_ASSESSMENT
(assessment_scope, source_kind, source_code, source_name, source_version,
 source_type, source_id, policy_code, subject_type, subject_key,
 user_idx, ip_address, country_code, asn, content_type, content_id,
 risk_score, risk_level, confidence_score, recommendation_action, recommendation_reason,
 evidence_summary, decision_status, raw_payload, created_at)
VALUES
('USER_SECURITY', 'AI_MODEL', 'SPAM_ACCOUNT_AI_V2', 'Spam Account Classifier', 'v2.0-demo',
 'COMMUNITY_ACTIVITY', NULL, 'AUTO_SPAM_ACCOUNT_BLOCK', 'USER', 'demo_spam_user',
 @demo_spam_idx, '198.51.100.44', 'KR', '4766', NULL, NULL,
 94, 'CRITICAL', 88, 'BLOCK_USER',
 '짧은 시간 내 유사 게시글 대량 작성과 신고 누적이 스팸 계정 패턴과 일치합니다.',
 '10분 내 유사 게시글 38건, 신고 12건, 동일 IP 대역 반복 사용. 자동 계정 차단 권고.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_SECURITY_TAG, 'source', 'ai', 'features', JSON_OBJECT('postCount10m', 38, 'reportCount', 12, 'ipReputation', 'LOW')),
 '2026-05-01 10:00:00'),

('CONTENT_MODERATION', 'AI_MODEL', 'CONTENT_SAFETY_AI_V3', 'Content Safety Classifier', 'v3.1-demo',
 'COMMUNITY_POST', 91001, 'CONTENT_ABUSE_ACCOUNT_REVIEW', 'USER', 'demo_content_abuse_user',
 @demo_content_idx, '203.0.113.77', 'KR', '4766', 'COMMUNITY_POST', 91001,
 89, 'HIGH', 84, 'LOCK_ACCOUNT',
 '부적절 게시글 반복 작성과 신고 누적으로 계정 보호 조치가 필요합니다.',
 '삭제/숨김 대상 게시글 7건, 신고 9건, 유사 문구 반복. 관리자 검토 또는 계정 일시 제한 권고.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_SECURITY_TAG, 'source', 'ai', 'contentType', 'COMMUNITY_POST', 'contentId', 91001),
 '2026-05-01 10:02:00'),

('USER_SECURITY', 'RULE_ALGORITHM', 'MULTI_ACCOUNT_SPAM_RULE_V1', 'Multi Account Spam Rule Engine', '1.0',
 'USER_BEHAVIOR', NULL, 'RULE_BASED_SPAM_ACCOUNT_BLOCK', 'USER', 'demo_spam_user',
 @demo_spam_idx, '198.51.100.44', 'KR', '4766', NULL, NULL,
 82, 'HIGH', 96, 'BLOCK_USER',
 '동일 기기/대역에서 생성된 다수 계정의 유사 행동이 내부 룰 임계값을 초과했습니다.',
 '동일 UA/대역 기반 계정 8개, 유사 게시글 61건. 룰 기반 계정 차단 권고.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_SECURITY_TAG, 'source', 'algorithm', 'rule', 'MULTI_ACCOUNT_SPAM_RULE_V1'),
 '2026-05-01 10:04:00'),

('USER_SECURITY', 'POLICY_AUTHORITY', 'PLATFORM-SAFETY-POLICY-DEMO-04', '상위 플랫폼 안전 정책', '2026.05-demo',
 'POLICY_SYNC', NULL, 'POLICY_AUTHORITY_USER_WATCH', 'USER', 'demo_policy_watch_user',
 @demo_policy_idx, '192.0.2.88', 'KR', '4766', NULL, NULL,
 76, 'HIGH', 90, 'REVIEW',
 '상위 정책기관의 반복 악성 행위 지표와 일부 일치합니다.',
 '즉시 자동 차단보다는 운영자 검토 후 계정 보호 또는 모니터링 권고.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_SECURITY_TAG, 'source', 'policy_authority', 'advisory', 'PLATFORM-SAFETY-POLICY-DEMO-04'),
 '2026-05-01 10:06:00'),

('IP_REPUTATION', 'POLICY_AUTHORITY', 'CERT-IP-REPUTATION-DEMO-19', '상위 보안 관제 IP 평판', '2026.05-demo',
 'POLICY_SYNC', NULL, 'POLICY_AUTHORITY_IP_REPUTATION', 'IP', '203.0.113.200',
 NULL, '203.0.113.200', 'RU', '12389', NULL, NULL,
 91, 'CRITICAL', 92, 'BLOCK_IP',
 '상위 관제에서 계정 탈취 시도와 연관된 IP로 분류했습니다.',
 '최근 24시간 내 다수 플랫폼 계정 탈취 지표와 일치. IP 차단 또는 WAF 동기화 권고.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_SECURITY_TAG, 'source', 'policy_authority', 'advisory', 'CERT-IP-REPUTATION-DEMO-19'),
 '2026-05-01 10:08:00');

-- 시연: AI 판단 기반 자동 계정 차단을 실제 USER_BLOCKLIST/HISTORY에 반영
SELECT @spam_assessment_idx := assessment_idx
FROM SECURITY_RISK_ASSESSMENT
WHERE raw_payload IS NOT NULL
  AND JSON_UNQUOTE(JSON_EXTRACT(raw_payload, '$.demoTag')) = @DEMO_SECURITY_TAG
  AND source_code = 'SPAM_ACCOUNT_AI_V2'
LIMIT 1;

SET @spam_block_request_id := 'sra-demo-block-20260501-0001';
SET @spam_action_group_id := 'sra-demo-group-20260501-0001';

DELETE FROM USER_BLOCKLIST WHERE block_request_id = @spam_block_request_id;
DELETE FROM USER_BLOCK_HISTORY WHERE block_request_id = @spam_block_request_id;

INSERT INTO USER_BLOCK_HISTORY (
    block_request_id, block_target_key,
    user_idx, block_type, blocked_ip, is_active, reason,
    blocked_by_user_idx, blocked_at, expires_at,
    rule_action, control_mode, operation_source, history_kind, block_scope,
    rule_origin_type, source_scope, block_category, risk_score,
    is_auto_block, auto_block_source, detail_message, priority,
    before_effective_active, after_effective_active, before_effective_status, after_effective_status,
    source_assessment_idx, source_action_type, source_action_group_id, source_user_idx, source_ip_address,
    effective_result, control_reason,
    created_by_user_idx, created_at, updated_by_user_idx, updated_at
)
SELECT
    @spam_block_request_id, CONCAT('USER:', @demo_spam_idx),
    @demo_spam_idx, 'USER_ONLY', NULL, TRUE,
    'AI 스팸 계정 판단에 따른 자동 계정 차단',
    @system_ai_idx, NOW(), NULL,
    'BLOCK', 'AUTO', 'AUTO', 'BLOCK', 'AUTO_DETECTION',
    'AI_MODEL', 'USER_SECURITY', 'SPAM', risk_score,
    TRUE, 'AI', evidence_summary, 100,
    NULL, TRUE, NULL, 'EFFECTIVE',
    assessment_idx, 'AI_AUTO_USER_BLOCK', @spam_action_group_id, @demo_spam_idx, ip_address,
    'APPLIED', recommendation_reason,
    @system_ai_idx, NOW(), @system_ai_idx, NOW()
FROM SECURITY_RISK_ASSESSMENT
WHERE assessment_idx = @spam_assessment_idx;

SELECT @spam_history_idx := block_idx FROM USER_BLOCK_HISTORY WHERE block_request_id = @spam_block_request_id LIMIT 1;

INSERT INTO USER_BLOCKLIST (
    source_history_block_idx, block_request_id, block_target_key,
    user_idx, block_type, blocked_ip, is_active, snapshot_status, reason,
    rule_action, control_mode, rule_origin_type, source_scope, block_category,
    risk_score, is_auto_block, auto_block_source, detail_message, priority,
    is_effective_active, effective_status, effective_status_reason, effective_synced_at,
    last_control_action, last_control_by_user_idx, last_control_at, last_control_reason,
    source_assessment_idx, source_action_type, source_action_group_id, source_user_idx, source_ip_address,
    blocked_by_user_idx, blocked_at, expires_at, last_history_at, synced_at,
    created_by_user_idx, created_at, updated_by_user_idx, updated_at
)
SELECT
    @spam_history_idx, @spam_block_request_id, CONCAT('USER:', @demo_spam_idx),
    @demo_spam_idx, 'USER_ONLY', NULL, TRUE, 'ACTIVE',
    'AI 스팸 계정 판단에 따른 자동 계정 차단',
    'BLOCK', 'AUTO', 'AI_MODEL', 'USER_SECURITY', 'SPAM',
    risk_score, TRUE, 'AI', evidence_summary, 100,
    TRUE, 'EFFECTIVE', 'AI 보안 판단에 따른 현재 평가 대상 계정 차단', NOW(),
    'AUTO_BLOCK', @system_ai_idx, NOW(), recommendation_reason,
    assessment_idx, 'AI_AUTO_USER_BLOCK', @spam_action_group_id, @demo_spam_idx, ip_address,
    @system_ai_idx, NOW(), NULL, NOW(), NOW(),
    @system_ai_idx, NOW(), @system_ai_idx, NOW()
FROM SECURITY_RISK_ASSESSMENT
WHERE assessment_idx = @spam_assessment_idx
ON DUPLICATE KEY UPDATE
    source_history_block_idx = VALUES(source_history_block_idx),
    is_active = TRUE,
    snapshot_status = 'ACTIVE',
    risk_score = VALUES(risk_score),
    is_auto_block = TRUE,
    auto_block_source = 'AI',
    detail_message = VALUES(detail_message),
    source_assessment_idx = VALUES(source_assessment_idx),
    source_action_group_id = VALUES(source_action_group_id),
    last_control_action = 'AUTO_BLOCK',
    last_control_by_user_idx = @system_ai_idx,
    last_control_at = NOW(),
    updated_by_user_idx = @system_ai_idx,
    updated_at = NOW();

UPDATE USERS
SET account_status = 'BLOCKED',
    blocked_until = NULL,
    blocked_reason = 'AI 스팸 계정 판단에 따른 자동 보호/차단 조치',
    status_changed_at = NOW()
WHERE user_idx = @demo_spam_idx;

UPDATE SECURITY_RISK_ASSESSMENT
SET decision_status = 'APPLIED'
WHERE assessment_idx = @spam_assessment_idx;

COMMIT;

-- 확인
-- SELECT assessment_scope, source_kind, source_code, subject_type, subject_key, risk_score, risk_level, recommendation_action, decision_status
-- FROM SECURITY_RISK_ASSESSMENT
-- WHERE raw_payload IS NOT NULL
--   AND JSON_UNQUOTE(JSON_EXTRACT(raw_payload, '$.demoTag')) = 'DEMO-SECURITY-ASSESS-20260501'
-- ORDER BY created_at;
--
-- SELECT user_idx, block_category, rule_origin_type, risk_score, is_auto_block, auto_block_source, source_assessment_idx, detail_message
-- FROM USER_BLOCKLIST
-- WHERE source_assessment_idx IS NOT NULL
-- ORDER BY blocked_at DESC;
