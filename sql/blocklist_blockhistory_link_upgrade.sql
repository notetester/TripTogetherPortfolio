-- ============================================================
-- Blocklist / Block History linkage upgrade
-- 목적:
-- 1) USER_BLOCK_HISTORY 는 차단 이력(감사 로그)
-- 2) IP_BLOCKLIST      는 현재 유효한 IP 차단 목록
-- 을 명확히 분리하되, block_request_id 로 서로 매칭한다.
--
-- 주의:
-- - 컬럼 추가만 수행한다.
-- - 기존 테이블명/컬럼명/PK 는 유지한다.
-- - MySQL 8.x 기준.
-- ============================================================

ALTER TABLE USER_BLOCK_HISTORY
    ADD COLUMN IF NOT EXISTS block_request_id VARCHAR(36) NULL
        COMMENT '차단 요청 식별자(UUID). IP_BLOCKLIST 와 매칭용' AFTER block_idx,
    ADD COLUMN IF NOT EXISTS ip_block_registered_at DATETIME NULL
        COMMENT 'IP_BLOCKLIST 에 현재 차단 목록으로 반영된 시각' AFTER blocked_at,
    ADD COLUMN IF NOT EXISTS ip_block_released_at DATETIME NULL
        COMMENT 'IP_BLOCKLIST 에서 현재 차단 목록 해제 처리된 시각' AFTER released_at;

ALTER TABLE USER_BLOCK_HISTORY
    ADD UNIQUE KEY uq_ubh_request_id (block_request_id),
    ADD INDEX idx_ubh_request_id (block_request_id);

ALTER TABLE IP_BLOCKLIST
    ADD COLUMN IF NOT EXISTS block_request_id VARCHAR(36) NULL
        COMMENT '연결된 USER_BLOCK_HISTORY.block_request_id' AFTER ip_address,
    ADD COLUMN IF NOT EXISTS user_idx BIGINT NULL
        COMMENT '연관 회원 PK (회원+IP 차단일 때 사용)' AFTER block_request_id,
    ADD COLUMN IF NOT EXISTS block_type VARCHAR(20) NULL
        COMMENT '연관 차단 유형 (USER_ONLY / IP_ONLY / USER_IP)' AFTER user_idx,
    ADD COLUMN IF NOT EXISTS blocked_by_user_idx BIGINT NULL
        COMMENT '차단 처리 관리자 PK' AFTER block_type,
    ADD COLUMN IF NOT EXISTS is_active TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '현재 유효한 IP 차단 여부' AFTER reason,
    ADD COLUMN IF NOT EXISTS expires_at DATETIME NULL
        COMMENT 'IP 차단 만료 시각' AFTER is_active,
    ADD COLUMN IF NOT EXISTS released_at DATETIME NULL
        COMMENT 'IP 차단 해제 시각' AFTER expires_at,
    ADD COLUMN IF NOT EXISTS released_by_user_idx BIGINT NULL
        COMMENT 'IP 차단 해제 관리자 PK' AFTER released_at,
    ADD COLUMN IF NOT EXISTS updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '마지막 수정 시각' AFTER released_by_user_idx;

ALTER TABLE IP_BLOCKLIST
    ADD INDEX idx_ipb_request_id (block_request_id),
    ADD INDEX idx_ipb_user_active (user_idx, is_active),
    ADD INDEX idx_ipb_active_expires (is_active, expires_at),
    ADD CONSTRAINT fk_ipb_user
        FOREIGN KEY (user_idx) REFERENCES USERS(user_idx)
        ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_blocked_by
        FOREIGN KEY (blocked_by_user_idx) REFERENCES USERS(user_idx)
        ON DELETE SET NULL,
    ADD CONSTRAINT fk_ipb_released_by
        FOREIGN KEY (released_by_user_idx) REFERENCES USERS(user_idx)
        ON DELETE SET NULL;

-- 기존 USER_BLOCK_HISTORY 레코드에 요청 식별자 부여
UPDATE USER_BLOCK_HISTORY
SET block_request_id = UUID()
WHERE block_request_id IS NULL;

-- 현재 IP_BLOCKLIST 를 가장 최근의 활성 USER_BLOCK_HISTORY 와 연결
UPDATE IP_BLOCKLIST ip
JOIN (
    SELECT h.blocked_ip,
           h.block_request_id,
           h.user_idx,
           h.block_type,
           h.blocked_by_user_idx,
           h.expires_at,
           h.blocked_at,
           h.ip_block_registered_at,
           h.block_idx
    FROM USER_BLOCK_HISTORY h
    JOIN (
        SELECT blocked_ip, MAX(block_idx) AS max_block_idx
        FROM USER_BLOCK_HISTORY
        WHERE blocked_ip IS NOT NULL
          AND is_active = TRUE
        GROUP BY blocked_ip
    ) x
      ON h.block_idx = x.max_block_idx
) last_hist
  ON ip.ip_address = last_hist.blocked_ip
SET ip.block_request_id = COALESCE(ip.block_request_id, last_hist.block_request_id),
    ip.user_idx = COALESCE(ip.user_idx, last_hist.user_idx),
    ip.block_type = COALESCE(ip.block_type, last_hist.block_type),
    ip.blocked_by_user_idx = COALESCE(ip.blocked_by_user_idx, last_hist.blocked_by_user_idx),
    ip.is_active = COALESCE(ip.is_active, TRUE),
    ip.expires_at = COALESCE(ip.expires_at, last_hist.expires_at),
    ip.updated_at = NOW();

-- IP_BLOCKLIST 반영 시각 초기 보정
UPDATE USER_BLOCK_HISTORY
SET ip_block_registered_at = COALESCE(ip_block_registered_at, blocked_at)
WHERE blocked_ip IS NOT NULL
  AND is_active = TRUE
  AND ip_block_registered_at IS NULL;
