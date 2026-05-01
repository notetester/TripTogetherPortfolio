-- TripTogether 로그인 위험 정책 후속 보강
-- 1) 정책별 AI 판단 보조/WAF 동기화 후보 설정
-- 2) 관리자 검토 승인 시 외부 WAF/CDN 동기화 후보 기록
-- 3) AI 판단 결과 저장 스텁
-- 4) 기존 정책/샘플 데이터 보정

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

CALL add_column_if_missing('LOGIN_RISK_POLICY', 'ai_assist_enabled',
    '`ai_assist_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT ''AI 판단 보조 사용 여부''');
CALL add_column_if_missing('LOGIN_RISK_POLICY', 'ai_risk_score_threshold',
    '`ai_risk_score_threshold` int DEFAULT NULL COMMENT ''AI 위험 점수 기준값''');
CALL add_column_if_missing('LOGIN_RISK_POLICY', 'waf_sync_enabled',
    '`waf_sync_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT ''승인 후 WAF/CDN 동기화 후보 생성 여부''');

CREATE TABLE IF NOT EXISTS `LOGIN_RISK_WAF_SYNC_QUEUE` (
  `sync_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_type` varchar(40) NOT NULL COMMENT 'LOGIN_RISK_REVIEW 등',
  `source_id` bigint DEFAULT NULL COMMENT '원천 검토/이벤트 ID',
  `sync_action` varchar(20) NOT NULL COMMENT 'BLOCK / ALLOW / REMOVE',
  `target_type` varchar(20) NOT NULL COMMENT 'IP / CIDR / COUNTRY / ASN',
  `target_value` varchar(120) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING / SYNCED / FAILED / SKIPPED',
  `detail_message` varchar(1000) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sync_idx`),
  KEY `idx_lrws_status_created` (`status`,`created_at`),
  KEY `idx_lrws_target` (`target_type`,`target_value`),
  KEY `idx_lrws_source` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='외부 WAF/CDN 동기화 후보 큐';

CREATE TABLE IF NOT EXISTS `LOGIN_RISK_AI_ASSESSMENT` (
  `assessment_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_type` varchar(40) NOT NULL COMMENT 'LOGIN_RISK_EVENT / LOGIN_RISK_REVIEW',
  `source_id` bigint DEFAULT NULL,
  `risk_score` int DEFAULT NULL,
  `risk_label` varchar(30) DEFAULT NULL COMMENT 'LOW / MEDIUM / HIGH / CRITICAL / PENDING',
  `model_name` varchar(100) DEFAULT NULL,
  `summary` varchar(1000) DEFAULT NULL,
  `raw_payload` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessment_idx`),
  KEY `idx_lrai_source` (`source_type`,`source_id`),
  KEY `idx_lrai_score` (`risk_score`,`created_at`),
  KEY `idx_lrai_label` (`risk_label`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 AI 판단 결과/스텁';

CALL add_index_if_missing('LOGIN_RISK_POLICY', 'idx_lrp_ai_waf', '(`ai_assist_enabled`, `waf_sync_enabled`)');

DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_column_if_missing;

UPDATE LOGIN_RISK_POLICY
SET ai_assist_enabled = CASE
        WHEN policy_code IN ('IP_SUSPICIOUS_LOGIN_REVIEW', 'IP_BURST_AUTO_BLOCK_RECOMMENDATION') THEN 1
        ELSE COALESCE(ai_assist_enabled, 0)
    END,
    ai_risk_score_threshold = CASE
        WHEN policy_code = 'IP_BURST_AUTO_BLOCK_RECOMMENDATION' THEN 85
        WHEN policy_code = 'IP_SUSPICIOUS_LOGIN_REVIEW' THEN 70
        ELSE ai_risk_score_threshold
    END,
    waf_sync_enabled = CASE
        WHEN policy_code IN ('IP_SUSPICIOUS_LOGIN_REVIEW', 'IP_BURST_AUTO_BLOCK_RECOMMENDATION') THEN 1
        ELSE COALESCE(waf_sync_enabled, 0)
    END,
    updated_at = NOW();

INSERT INTO LOGIN_RISK_AI_ASSESSMENT
(source_type, source_id, risk_score, risk_label, model_name, summary, raw_payload, created_at)
SELECT 'LOGIN_RISK_REVIEW',
       rq.review_idx,
       CASE rq.severity WHEN 'CRITICAL' THEN 93 WHEN 'HIGH' THEN 82 WHEN 'MEDIUM' THEN 67 ELSE 40 END,
       rq.severity,
       'demo-risk-rules-ai-stub',
       CONCAT('시연용 AI 판단 스텁: ', rq.summary),
       JSON_OBJECT('demo', true, 'source', 'DEMO-RISK-20260501', 'subjectKey', rq.subject_key),
       rq.created_at
FROM LOGIN_RISK_REVIEW_QUEUE rq
WHERE rq.detail_message LIKE '%DEMO-RISK-20260501%'
  AND NOT EXISTS (
      SELECT 1 FROM LOGIN_RISK_AI_ASSESSMENT a
      WHERE a.source_type = 'LOGIN_RISK_REVIEW'
        AND a.source_id = rq.review_idx
  );

INSERT INTO LOGIN_RISK_WAF_SYNC_QUEUE
(source_type, source_id, sync_action, target_type, target_value, status, detail_message, created_at, updated_at)
SELECT 'LOGIN_RISK_REVIEW',
       rq.review_idx,
       'BLOCK',
       CASE WHEN rq.subject_type = 'IP_RANGE' THEN 'CIDR' ELSE 'IP' END,
       rq.subject_key,
       CASE WHEN rq.review_status = 'APPROVED' THEN 'PENDING' ELSE 'SKIPPED' END,
       CONCAT('시연용 WAF 동기화 후보: ', rq.summary),
       rq.updated_at,
       rq.updated_at
FROM LOGIN_RISK_REVIEW_QUEUE rq
WHERE rq.detail_message LIKE '%DEMO-RISK-20260501%'
  AND rq.subject_type IN ('IP', 'IP_RANGE')
  AND NOT EXISTS (
      SELECT 1 FROM LOGIN_RISK_WAF_SYNC_QUEUE w
      WHERE w.source_type = 'LOGIN_RISK_REVIEW'
        AND w.source_id = rq.review_idx
  );

-- 확인
-- SELECT policy_code, ai_assist_enabled, ai_risk_score_threshold, waf_sync_enabled FROM LOGIN_RISK_POLICY ORDER BY policy_idx;
-- SELECT * FROM LOGIN_RISK_AI_ASSESSMENT ORDER BY created_at DESC;
-- SELECT * FROM LOGIN_RISK_WAF_SYNC_QUEUE ORDER BY created_at DESC;
