-- TripTogether 보안 보강: 계정+IP 동시 차단 조치 그룹 및 교집합 분석 컬럼
-- 적용 대상: MySQL 8.x
--
-- 목적
-- 1. USER_BLOCKLIST와 IP_BLOCKLIST는 런타임 규칙을 분리 저장한다.
--    - 계정 차단: USER_BLOCKLIST / USER_ONLY
--    - IP 차단: IP_BLOCKLIST / SINGLE_IP, CIDR, RANGE, COUNTRY, ASN
-- 2. 다만 관리자 분석을 위해 같은 조치에서 파생된 규칙은 source_action_group_id로 묶는다.
-- 3. BLOCK_ACCESS_LOG에는 실제 차단 요청이 원래 차단 대상 계정·IP와 교차하는지 기록한다.

DELIMITER $$

DROP PROCEDURE IF EXISTS add_column_if_missing $$
CREATE PROCEDURE add_column_if_missing(
    IN p_table_name VARCHAR(64),
    IN p_column_name VARCHAR(64),
    IN p_column_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
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
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
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

CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_action_type', '`source_action_type` varchar(40) DEFAULT NULL COMMENT ''차단 조치 유형. 예: USER_AND_IP_BLOCK''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_action_group_id', '`source_action_group_id` varchar(36) DEFAULT NULL COMMENT ''같은 보안 조치 묶음 ID''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_user_idx', '`source_user_idx` bigint DEFAULT NULL COMMENT ''조치 기준 사용자 PK''');
CALL add_column_if_missing('USER_BLOCK_HISTORY', 'source_ip_address', '`source_ip_address` varchar(45) DEFAULT NULL COMMENT ''조치 기준 IP''');

CALL add_column_if_missing('USER_BLOCKLIST', 'source_action_type', '`source_action_type` varchar(40) DEFAULT NULL COMMENT ''차단 조치 유형. 예: USER_AND_IP_BLOCK''');
CALL add_column_if_missing('USER_BLOCKLIST', 'source_action_group_id', '`source_action_group_id` varchar(36) DEFAULT NULL COMMENT ''같은 보안 조치 묶음 ID''');
CALL add_column_if_missing('USER_BLOCKLIST', 'source_user_idx', '`source_user_idx` bigint DEFAULT NULL COMMENT ''조치 기준 사용자 PK''');
CALL add_column_if_missing('USER_BLOCKLIST', 'source_ip_address', '`source_ip_address` varchar(45) DEFAULT NULL COMMENT ''조치 기준 IP''');

CALL add_column_if_missing('IP_BLOCKLIST', 'source_action_type', '`source_action_type` varchar(40) DEFAULT NULL COMMENT ''차단 조치 유형. 예: USER_AND_IP_BLOCK''');
CALL add_column_if_missing('IP_BLOCKLIST', 'source_action_group_id', '`source_action_group_id` varchar(36) DEFAULT NULL COMMENT ''같은 보안 조치 묶음 ID''');
CALL add_column_if_missing('IP_BLOCKLIST', 'source_user_idx', '`source_user_idx` bigint DEFAULT NULL COMMENT ''조치 기준 사용자 PK''');
CALL add_column_if_missing('IP_BLOCKLIST', 'source_ip_address', '`source_ip_address` varchar(45) DEFAULT NULL COMMENT ''조치 기준 IP''');

CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'source_action_type', '`source_action_type` varchar(40) DEFAULT NULL COMMENT ''차단 규칙 생성 조치 유형''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'source_action_group_id', '`source_action_group_id` varchar(36) DEFAULT NULL COMMENT ''같은 보안 조치 묶음 ID''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'source_user_idx', '`source_user_idx` bigint DEFAULT NULL COMMENT ''규칙 생성 당시 기준 사용자 PK''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'source_ip_address', '`source_ip_address` varchar(45) DEFAULT NULL COMMENT ''규칙 생성 당시 기준 IP''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'is_source_user_match', '`is_source_user_match` tinyint(1) DEFAULT NULL COMMENT ''요청 사용자와 기준 사용자가 일치하는지''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'is_source_ip_match', '`is_source_ip_match` tinyint(1) DEFAULT NULL COMMENT ''요청 IP와 기준 IP가 일치하는지''');
CALL add_column_if_missing('BLOCK_ACCESS_LOG', 'is_source_user_ip_intersection', '`is_source_user_ip_intersection` tinyint(1) DEFAULT NULL COMMENT ''기준 사용자와 기준 IP가 모두 일치하는지''');

CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_source_action_group', '(`source_action_group_id`, `created_at`)');
CALL add_index_if_missing('USER_BLOCK_HISTORY', 'idx_ubh_source_user_ip', '(`source_user_idx`, `source_ip_address`, `created_at`)');

CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_source_action_group', '(`source_action_group_id`, `blocked_at`)');
CALL add_index_if_missing('USER_BLOCKLIST', 'idx_ubl_source_user_ip', '(`source_user_idx`, `source_ip_address`, `blocked_at`)');

CALL add_index_if_missing('IP_BLOCKLIST', 'idx_ipb_source_action_group', '(`source_action_group_id`, `blocked_at`)');
CALL add_index_if_missing('IP_BLOCKLIST', 'idx_ipb_source_user_ip', '(`source_user_idx`, `source_ip_address`, `blocked_at`)');

CALL add_index_if_missing('BLOCK_ACCESS_LOG', 'idx_bal_source_action_group', '(`source_action_group_id`, `created_at`)');
CALL add_index_if_missing('BLOCK_ACCESS_LOG', 'idx_bal_source_user_ip', '(`source_user_idx`, `source_ip_address`, `created_at`)');
CALL add_index_if_missing('BLOCK_ACCESS_LOG', 'idx_bal_source_intersection', '(`is_source_user_ip_intersection`, `created_at`)');

DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_column_if_missing;

START TRANSACTION;

UPDATE USER_BLOCK_HISTORY
SET source_action_type = CASE
        WHEN block_type = 'USER_IP' THEN 'USER_AND_IP_BLOCK'
        WHEN block_type = 'USER_ONLY' THEN 'USER_BLOCK'
        WHEN block_type = 'IP_ONLY' THEN 'IP_BLOCK_FROM_MEMBER'
        ELSE COALESCE(source_action_type, 'BLOCK_ACTION')
    END,
    source_action_group_id = COALESCE(source_action_group_id, block_request_id, UUID()),
    source_user_idx = COALESCE(source_user_idx, user_idx),
    source_ip_address = COALESCE(source_ip_address, blocked_ip)
WHERE source_action_group_id IS NULL
   OR source_action_type IS NULL
   OR source_user_idx IS NULL
   OR source_ip_address IS NULL;

UPDATE USER_BLOCKLIST ub
JOIN USER_BLOCK_HISTORY h ON h.block_idx = ub.source_history_block_idx
SET ub.source_action_type = COALESCE(ub.source_action_type, h.source_action_type),
    ub.source_action_group_id = COALESCE(ub.source_action_group_id, h.source_action_group_id),
    ub.source_user_idx = COALESCE(ub.source_user_idx, h.source_user_idx, ub.user_idx),
    ub.source_ip_address = COALESCE(ub.source_ip_address, h.source_ip_address, ub.blocked_ip)
WHERE ub.source_history_block_idx IS NOT NULL;

UPDATE USER_BLOCKLIST
SET source_action_type = CASE
        WHEN block_type = 'USER_IP' THEN 'USER_AND_IP_BLOCK'
        WHEN block_type = 'USER_ONLY' THEN 'USER_BLOCK'
        WHEN block_type = 'IP_ONLY' THEN 'IP_BLOCK_FROM_MEMBER'
        ELSE COALESCE(source_action_type, 'BLOCK_ACTION')
    END,
    source_action_group_id = COALESCE(source_action_group_id, block_request_id, UUID()),
    source_user_idx = COALESCE(source_user_idx, user_idx),
    source_ip_address = COALESCE(source_ip_address, blocked_ip)
WHERE source_action_group_id IS NULL
   OR source_action_type IS NULL
   OR source_user_idx IS NULL
   OR source_ip_address IS NULL;

UPDATE IP_BLOCKLIST ipb
JOIN USER_BLOCK_HISTORY h ON h.block_idx = ipb.source_history_block_idx
SET ipb.source_action_type = COALESCE(ipb.source_action_type, h.source_action_type),
    ipb.source_action_group_id = COALESCE(ipb.source_action_group_id, h.source_action_group_id),
    ipb.source_user_idx = COALESCE(ipb.source_user_idx, h.source_user_idx, ipb.user_idx),
    ipb.source_ip_address = COALESCE(ipb.source_ip_address, h.source_ip_address, ipb.ip_address)
WHERE ipb.source_history_block_idx IS NOT NULL;

UPDATE IP_BLOCKLIST ipb
LEFT JOIN USER_BLOCKLIST ub ON ub.block_idx = ipb.source_blocklist_idx
SET ipb.source_action_type = COALESCE(ipb.source_action_type, ub.source_action_type,
        CASE WHEN ipb.user_idx IS NOT NULL THEN 'IP_BLOCK_FROM_MEMBER' ELSE 'IP_BLOCK' END),
    ipb.source_action_group_id = COALESCE(ipb.source_action_group_id, ub.source_action_group_id, ipb.block_request_id, UUID()),
    ipb.source_user_idx = COALESCE(ipb.source_user_idx, ub.source_user_idx, ipb.user_idx),
    ipb.source_ip_address = COALESCE(ipb.source_ip_address, ub.source_ip_address, ipb.ip_address)
WHERE ipb.source_action_group_id IS NULL
   OR ipb.source_action_type IS NULL
   OR ipb.source_user_idx IS NULL
   OR ipb.source_ip_address IS NULL;

UPDATE BLOCK_ACCESS_LOG bal
LEFT JOIN IP_BLOCKLIST ipb
       ON bal.block_kind = 'IP'
      AND bal.block_rule_idx = ipb.ip_blocklist_idx
LEFT JOIN USER_BLOCKLIST ub
       ON bal.block_kind = 'USER'
      AND bal.block_rule_idx = ub.block_idx
SET bal.source_action_type = COALESCE(bal.source_action_type, ipb.source_action_type, ub.source_action_type),
    bal.source_action_group_id = COALESCE(bal.source_action_group_id, ipb.source_action_group_id, ub.source_action_group_id),
    bal.source_user_idx = COALESCE(bal.source_user_idx, ipb.source_user_idx, ub.source_user_idx),
    bal.source_ip_address = COALESCE(bal.source_ip_address, ipb.source_ip_address, ub.source_ip_address),
    bal.is_source_user_match = CASE
        WHEN COALESCE(bal.source_user_idx, ipb.source_user_idx, ub.source_user_idx) IS NULL OR bal.user_idx IS NULL THEN 0
        WHEN COALESCE(bal.source_user_idx, ipb.source_user_idx, ub.source_user_idx) = bal.user_idx THEN 1
        ELSE 0
    END,
    bal.is_source_ip_match = CASE
        WHEN COALESCE(bal.source_ip_address, ipb.source_ip_address, ub.source_ip_address) IS NULL OR bal.ip_address IS NULL THEN 0
        WHEN COALESCE(bal.source_ip_address, ipb.source_ip_address, ub.source_ip_address) = bal.ip_address THEN 1
        ELSE 0
    END,
    bal.is_source_user_ip_intersection = CASE
        WHEN COALESCE(bal.source_user_idx, ipb.source_user_idx, ub.source_user_idx) IS NOT NULL
         AND bal.user_idx IS NOT NULL
         AND COALESCE(bal.source_user_idx, ipb.source_user_idx, ub.source_user_idx) = bal.user_idx
         AND COALESCE(bal.source_ip_address, ipb.source_ip_address, ub.source_ip_address) IS NOT NULL
         AND bal.ip_address IS NOT NULL
         AND COALESCE(bal.source_ip_address, ipb.source_ip_address, ub.source_ip_address) = bal.ip_address
        THEN 1 ELSE 0
    END
WHERE bal.source_action_group_id IS NULL
   OR bal.is_source_user_match IS NULL
   OR bal.is_source_ip_match IS NULL
   OR bal.is_source_user_ip_intersection IS NULL;

COMMIT;

-- 확인 예시
-- SELECT source_action_type, source_action_group_id, source_user_idx, source_ip_address
-- FROM IP_BLOCKLIST
-- WHERE source_action_type = 'USER_AND_IP_BLOCK'
-- ORDER BY blocked_at DESC;
--
-- SELECT request_id, block_kind, block_match_type, user_idx, ip_address,
--        source_action_type, source_action_group_id, source_user_idx, source_ip_address,
--        is_source_user_match, is_source_ip_match, is_source_user_ip_intersection
-- FROM BLOCK_ACCESS_LOG
-- WHERE source_action_type = 'USER_AND_IP_BLOCK'
-- ORDER BY created_at DESC;
