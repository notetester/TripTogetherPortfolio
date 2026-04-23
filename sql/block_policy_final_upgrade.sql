/* ============================================================
   TripTogether block policy final upgrade
   - USER_BLOCK_HISTORY: 통합 차단 이력 원본
   - USER_BLOCKLIST   : 회원/회원기준 현재 차단 상태
   - IP_BLOCKLIST     : 전역/런타임 IP 차단 규칙 + 현재 상태
   ============================================================ */

CREATE TABLE IF NOT EXISTS IP_BLOCK_BATCH (
    ip_block_batch_idx BIGINT AUTO_INCREMENT PRIMARY KEY
        COMMENT 'IP 차단 배치 PK',
    batch_code VARCHAR(50) NOT NULL UNIQUE
        COMMENT '배치 코드 (예: VPN_FEED_202604 / SPAM_FEED_20260401)',
    batch_name VARCHAR(100) NOT NULL
        COMMENT '배치명',
    source_type VARCHAR(30) NOT NULL
        COMMENT '배치 출처 유형 (MANUAL / VPN_FEED / SPAM_FEED / GEO_POLICY / AUTO_DETECTION)',
    source_name VARCHAR(100) NULL
        COMMENT '출처명',
    is_active TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '배치 활성 여부',
    description VARCHAR(255) NULL
        COMMENT '설명',
    created_by_user_idx BIGINT NULL
        COMMENT '생성한 관리자 PK',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '생성 시각',
    updated_by_user_idx BIGINT NULL
        COMMENT '수정한 관리자 PK',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정 시각',
    CONSTRAINT fk_ibb_created_by FOREIGN KEY (created_by_user_idx) REFERENCES USERS(user_idx) ON DELETE SET NULL,
    CONSTRAINT fk_ibb_updated_by FOREIGN KEY (updated_by_user_idx) REFERENCES USERS(user_idx) ON DELETE SET NULL,
    INDEX idx_ibb_active_source (is_active, source_type)
) COMMENT='전역 IP 차단 규칙을 배치 단위로 묶어 관리하는 테이블';

ALTER TABLE USER_BLOCK_HISTORY
    ADD COLUMN block_request_id VARCHAR(36) NULL COMMENT '차단 요청 식별자(UUID). USER_BLOCKLIST/IP_BLOCKLIST 와 매칭용' AFTER block_idx,
    ADD COLUMN block_target_key VARCHAR(120) NULL COMMENT '차단 대상 식별 키' AFTER block_request_id,
    ADD COLUMN history_kind VARCHAR(20) NOT NULL DEFAULT 'BLOCK' COMMENT '이력 종류 (BLOCK / RELEASE / EXPIRE_SYNC / REBLOCK_SYNC)' AFTER block_target_key,
    ADD COLUMN block_scope VARCHAR(20) NOT NULL DEFAULT 'USER_ACTION' COMMENT '차단 출처 범위 (USER_ACTION / GLOBAL / AUTO_DETECTION)' AFTER history_kind,
    ADD COLUMN ip_match_type VARCHAR(20) NULL COMMENT 'IP 매칭 방식 (SINGLE_IP / CIDR / RANGE / COUNTRY / ASN)' AFTER blocked_ip,
    ADD COLUMN cidr_notation VARCHAR(64) NULL COMMENT 'CIDR 표기' AFTER ip_match_type,
    ADD COLUMN range_start_ip VARCHAR(45) NULL COMMENT 'IP 범위 시작값' AFTER cidr_notation,
    ADD COLUMN range_end_ip VARCHAR(45) NULL COMMENT 'IP 범위 끝값' AFTER range_start_ip,
    ADD COLUMN ip_block_batch_idx BIGINT NULL COMMENT '연결된 IP_BLOCK_BATCH PK' AFTER range_end_ip,
    ADD COLUMN list_synced_at DATETIME NULL COMMENT 'USER_BLOCKLIST/IP_BLOCKLIST 반영 시각' AFTER updated_at,
    ADD COLUMN ip_block_registered_at DATETIME NULL COMMENT 'IP_BLOCKLIST 에 현재 차단 목록으로 반영된 시각' AFTER blocked_at,
    ADD COLUMN ip_block_released_at DATETIME NULL COMMENT 'IP_BLOCKLIST 에서 현재 차단 목록 해제 처리된 시각' AFTER released_at;

ALTER TABLE USER_BLOCK_HISTORY
    ADD CONSTRAINT fk_ubh_batch FOREIGN KEY (ip_block_batch_idx) REFERENCES IP_BLOCK_BATCH(ip_block_batch_idx) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_ubh_request_id (block_request_id),
    ADD INDEX idx_ubh_target_key (block_target_key),
    ADD INDEX idx_ubh_history_kind (history_kind),
    ADD INDEX idx_ubh_block_scope (block_scope),
    ADD INDEX idx_ubh_ip_match_type (ip_match_type),
    ADD INDEX idx_ubh_batch (ip_block_batch_idx);

ALTER TABLE USER_BLOCKLIST
    ADD COLUMN source_history_block_idx BIGINT NULL COMMENT '현재 차단 상태의 원본 USER_BLOCK_HISTORY.block_idx' AFTER block_idx,
    ADD COLUMN block_request_id VARCHAR(36) NULL COMMENT '현재 차단 상태를 만든 요청 식별자(UUID)' AFTER source_history_block_idx,
    ADD COLUMN block_target_key VARCHAR(120) NULL COMMENT '현재 차단 대상 식별 키' AFTER block_request_id,
    ADD COLUMN snapshot_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '스냅샷 상태 (ACTIVE / RELEASED / EXPIRED)' AFTER is_active,
    ADD COLUMN last_history_at DATETIME NULL COMMENT '원본 USER_BLOCK_HISTORY 최종 반영 시각' AFTER updated_at,
    ADD COLUMN synced_at DATETIME NULL COMMENT '스냅샷 동기화 시각' AFTER last_history_at;

ALTER TABLE USER_BLOCKLIST
    ADD CONSTRAINT fk_ubl_source_history FOREIGN KEY (source_history_block_idx) REFERENCES USER_BLOCK_HISTORY(block_idx) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_ubl_target_key (block_target_key),
    ADD INDEX idx_ubl_request_id (block_request_id),
    ADD INDEX idx_ubl_snapshot_status (snapshot_status),
    ADD INDEX idx_ubl_source_history (source_history_block_idx);

ALTER TABLE IP_BLOCKLIST
    ADD COLUMN ip_blocklist_idx BIGINT NOT NULL AUTO_INCREMENT COMMENT 'IP_BLOCKLIST PK' FIRST,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (ip_blocklist_idx);

ALTER TABLE IP_BLOCKLIST
    ADD COLUMN block_request_id VARCHAR(36) NULL COMMENT '연결된 USER_BLOCK_HISTORY.block_request_id' AFTER ip_address,
    ADD COLUMN block_target_key VARCHAR(120) NULL COMMENT '차단 규칙 식별 키' AFTER block_request_id,
    ADD COLUMN source_history_block_idx BIGINT NULL COMMENT '원본 USER_BLOCK_HISTORY.block_idx' AFTER block_target_key,
    ADD COLUMN source_blocklist_idx BIGINT NULL COMMENT '원본 USER_BLOCKLIST.block_idx' AFTER source_history_block_idx,
    ADD COLUMN ip_block_batch_idx BIGINT NULL COMMENT '연결된 IP_BLOCK_BATCH PK' AFTER source_blocklist_idx,
    ADD COLUMN match_type VARCHAR(20) NOT NULL DEFAULT 'SINGLE_IP' COMMENT '매칭 방식 (SINGLE_IP / CIDR / RANGE / COUNTRY / ASN)' AFTER ip_block_batch_idx,
    ADD COLUMN cidr_notation VARCHAR(64) NULL COMMENT 'CIDR 표기' AFTER match_type,
    ADD COLUMN range_start_ip VARCHAR(45) NULL COMMENT 'IP 범위 시작값' AFTER cidr_notation,
    ADD COLUMN range_end_ip VARCHAR(45) NULL COMMENT 'IP 범위 끝값' AFTER range_start_ip,
    ADD COLUMN country_code VARCHAR(10) NULL COMMENT '국가 코드' AFTER range_end_ip,
    ADD COLUMN asn VARCHAR(20) NULL COMMENT 'ASN 코드' AFTER country_code,
    ADD COLUMN source_scope VARCHAR(20) NOT NULL DEFAULT 'GLOBAL' COMMENT '차단 출처 범위 (GLOBAL / USER_ACTION / AUTO_DETECTION)' AFTER asn,
    ADD COLUMN block_category VARCHAR(20) NOT NULL DEFAULT 'SPAM' COMMENT '차단 분류 (SPAM / ABUSE / BRUTE_FORCE / GEO / VPN / MANUAL / SECURITY)' AFTER source_scope,
    ADD COLUMN user_idx BIGINT NULL COMMENT '연관 회원 PK (회원+IP 차단일 때 사용)' AFTER block_category,
    ADD COLUMN block_type VARCHAR(20) NULL COMMENT '연관 차단 유형 (IP_ONLY / USER_IP)' AFTER user_idx,
    ADD COLUMN blocked_by_user_idx BIGINT NULL COMMENT '차단 처리 관리자 PK' AFTER block_type,
    ADD COLUMN is_active TINYINT(1) NOT NULL DEFAULT 1 COMMENT '현재 유효한 IP 차단 여부' AFTER reason,
    ADD COLUMN expires_at DATETIME NULL COMMENT 'IP 차단 만료 시각' AFTER is_active,
    ADD COLUMN released_at DATETIME NULL COMMENT 'IP 차단 해제 시각' AFTER expires_at,
    ADD COLUMN released_by_user_idx BIGINT NULL COMMENT 'IP 차단 해제 관리자 PK' AFTER released_at,
    ADD COLUMN risk_score INT NULL COMMENT '위험 점수(0~100)' AFTER released_by_user_idx,
    ADD COLUMN is_auto_block TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'AUTO_DETECTION으로 인한 자동 차단인지 여부' AFTER risk_score,
    ADD COLUMN auto_block_source VARCHAR(50) NULL COMMENT '자동 차단 주체/출처 (RULE / AI / POLICY_SYNC / FEED 등)' AFTER is_auto_block,
    ADD COLUMN detail_message VARCHAR(255) NULL COMMENT '상세 메모' AFTER auto_block_source,
    ADD COLUMN priority INT NOT NULL DEFAULT 1 COMMENT '우선순위. 높을수록 먼저 평가' AFTER detail_message,
    ADD COLUMN last_synced_at DATETIME NULL COMMENT '마지막 동기화 시각' AFTER priority,
    ADD COLUMN updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정 시각' AFTER last_synced_at;

ALTER TABLE IP_BLOCKLIST
    ADD CONSTRAINT fk_ipb_user FOREIGN KEY (user_idx) REFERENCES USERS(user_idx) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_blocked_by FOREIGN KEY (blocked_by_user_idx) REFERENCES USERS(user_idx) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_released_by FOREIGN KEY (released_by_user_idx) REFERENCES USERS(user_idx) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_source_history FOREIGN KEY (source_history_block_idx) REFERENCES USER_BLOCK_HISTORY(block_idx) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_source_blocklist FOREIGN KEY (source_blocklist_idx) REFERENCES USER_BLOCKLIST(block_idx) ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_batch FOREIGN KEY (ip_block_batch_idx) REFERENCES IP_BLOCK_BATCH(ip_block_batch_idx) ON DELETE SET NULL,
    ADD UNIQUE KEY uq_ipb_target_key (block_target_key),
    ADD INDEX idx_ipb_request_id (block_request_id),
    ADD INDEX idx_ipb_ip_active (ip_address, is_active),
    ADD INDEX idx_ipb_user_active (user_idx, is_active),
    ADD INDEX idx_ipb_active_expires (is_active, expires_at),
    ADD INDEX idx_ipb_match_type_active (match_type, is_active),
    ADD INDEX idx_ipb_scope_category (source_scope, block_category, is_active),
    ADD INDEX idx_ipb_batch_active (ip_block_batch_idx, is_active),
    ADD INDEX idx_ipb_country_active (country_code, is_active),
    ADD INDEX idx_ipb_asn_active (asn, is_active);

UPDATE USER_BLOCK_HISTORY
SET block_request_id = UUID()
WHERE block_request_id IS NULL;

UPDATE USER_BLOCK_HISTORY
SET block_target_key = CASE
    WHEN block_type = 'USER_ONLY' AND user_idx IS NOT NULL THEN CONCAT('USER:', user_idx)
    WHEN block_type = 'IP_ONLY' AND blocked_ip IS NOT NULL THEN CONCAT('IP:', blocked_ip)
    WHEN block_type = 'USER_IP' AND user_idx IS NOT NULL AND blocked_ip IS NOT NULL THEN CONCAT('USER_IP:', user_idx, ':', blocked_ip)
    WHEN blocked_ip IS NOT NULL THEN CONCAT('IP:', blocked_ip)
    WHEN user_idx IS NOT NULL THEN CONCAT('USER:', user_idx)
    ELSE CONCAT('HISTORY:', block_idx)
END
WHERE block_target_key IS NULL;

UPDATE USER_BLOCK_HISTORY
SET block_scope = CASE
        WHEN ip_block_batch_idx IS NOT NULL THEN 'GLOBAL'
        WHEN user_idx IS NULL AND blocked_ip IS NOT NULL THEN 'GLOBAL'
        ELSE 'USER_ACTION'
    END,
    ip_match_type = CASE
        WHEN cidr_notation IS NOT NULL THEN 'CIDR'
        WHEN range_start_ip IS NOT NULL OR range_end_ip IS NOT NULL THEN 'RANGE'
        WHEN blocked_ip IS NOT NULL THEN 'SINGLE_IP'
        ELSE ip_match_type
    END
WHERE block_scope IS NULL OR ip_match_type IS NULL;

UPDATE USER_BLOCKLIST
SET block_target_key = CASE
    WHEN block_type = 'USER_ONLY' AND user_idx IS NOT NULL THEN CONCAT('USER:', user_idx)
    WHEN block_type = 'IP_ONLY' AND blocked_ip IS NOT NULL THEN CONCAT('IP:', blocked_ip)
    WHEN block_type = 'USER_IP' AND user_idx IS NOT NULL AND blocked_ip IS NOT NULL THEN CONCAT('USER_IP:', user_idx, ':', blocked_ip)
    WHEN blocked_ip IS NOT NULL THEN CONCAT('IP:', blocked_ip)
    WHEN user_idx IS NOT NULL THEN CONCAT('USER:', user_idx)
    ELSE CONCAT('LIST:', block_idx)
END
WHERE block_target_key IS NULL;

UPDATE USER_BLOCKLIST u
JOIN (
    SELECT h.block_idx, h.block_request_id, h.block_target_key, h.blocked_at
    FROM USER_BLOCK_HISTORY h
    JOIN (
        SELECT block_target_key, MAX(block_idx) AS max_block_idx
        FROM USER_BLOCK_HISTORY
        WHERE is_active = TRUE AND block_target_key IS NOT NULL
        GROUP BY block_target_key
    ) x ON h.block_idx = x.max_block_idx
) last_hist ON u.block_target_key = last_hist.block_target_key
SET u.source_history_block_idx = COALESCE(u.source_history_block_idx, last_hist.block_idx),
    u.block_request_id = COALESCE(u.block_request_id, last_hist.block_request_id),
    u.snapshot_status = CASE
        WHEN u.is_active = TRUE THEN 'ACTIVE'
        WHEN u.released_at IS NOT NULL THEN 'RELEASED'
        ELSE 'EXPIRED'
    END,
    u.last_history_at = COALESCE(u.last_history_at, last_hist.blocked_at),
    u.synced_at = COALESCE(u.synced_at, NOW());

UPDATE IP_BLOCKLIST
SET block_target_key = CONCAT('IP:', ip_address),
    match_type = 'SINGLE_IP',
    source_scope = COALESCE(source_scope, 'GLOBAL'),
    block_category = COALESCE(block_category, 'SPAM')
WHERE block_target_key IS NULL;

UPDATE IP_BLOCKLIST ip
JOIN (
    SELECT h.blocked_ip, h.block_request_id, h.block_target_key, h.user_idx, h.block_type,
           h.blocked_by_user_idx, h.expires_at, h.block_idx
    FROM USER_BLOCK_HISTORY h
    JOIN (
        SELECT blocked_ip, MAX(block_idx) AS max_block_idx
        FROM USER_BLOCK_HISTORY
        WHERE blocked_ip IS NOT NULL AND is_active = TRUE
        GROUP BY blocked_ip
    ) x ON h.block_idx = x.max_block_idx
) last_hist ON ip.ip_address = last_hist.blocked_ip
SET ip.source_history_block_idx = COALESCE(ip.source_history_block_idx, last_hist.block_idx),
    ip.block_request_id = COALESCE(ip.block_request_id, last_hist.block_request_id),
    ip.block_target_key = COALESCE(ip.block_target_key, last_hist.block_target_key),
    ip.user_idx = COALESCE(ip.user_idx, last_hist.user_idx),
    ip.block_type = COALESCE(ip.block_type, last_hist.block_type),
    ip.blocked_by_user_idx = COALESCE(ip.blocked_by_user_idx, last_hist.blocked_by_user_idx),
    ip.is_active = COALESCE(ip.is_active, TRUE),
    ip.expires_at = COALESCE(ip.expires_at, last_hist.expires_at),
    ip.last_synced_at = NOW(),
    ip.updated_at = NOW();

UPDATE USER_BLOCK_HISTORY
SET ip_block_registered_at = COALESCE(ip_block_registered_at, blocked_at),
    list_synced_at = COALESCE(list_synced_at, NOW())
WHERE blocked_ip IS NOT NULL
  AND is_active = TRUE
  AND (ip_block_registered_at IS NULL OR list_synced_at IS NULL);
