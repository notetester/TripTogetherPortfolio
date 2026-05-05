-- TripTogether 보안 이의제기 이메일 인증 기반 접수 보강
-- 범위:
-- 1. SECURITY_ACTION_APPEAL_TOKEN에 submitter_email 컬럼 추가
-- 2. publicRequestId + verified email 기반 비로그인 결과 조회 지원
--
-- 주의:
-- - 새 테이블 생성 없음

SET @col_exists := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'SECURITY_ACTION_APPEAL_TOKEN'
      AND COLUMN_NAME = 'submitter_email'
);
SET @sql := IF(@col_exists = 0,
    'ALTER TABLE SECURITY_ACTION_APPEAL_TOKEN ADD COLUMN submitter_email varchar(320) DEFAULT NULL COMMENT ''이의제기 제출 전 인증한 이메일'' AFTER block_access_request_id',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @idx_exists := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'SECURITY_ACTION_APPEAL_TOKEN'
      AND INDEX_NAME = 'idx_saat_submitter_email_created'
);
SET @sql := IF(@idx_exists = 0,
    'CREATE INDEX idx_saat_submitter_email_created ON SECURITY_ACTION_APPEAL_TOKEN (submitter_email, created_at)',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @idx_exists := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'SECURITY_ACTION_APPEAL'
      AND INDEX_NAME = 'idx_saa_public_request'
);
SET @sql := IF(@idx_exists = 0,
    'CREATE INDEX idx_saa_public_request ON SECURITY_ACTION_APPEAL (public_request_id)',
    'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 확인용
-- SHOW COLUMNS FROM SECURITY_ACTION_APPEAL_TOKEN LIKE 'submitter_email';
-- SHOW INDEX FROM SECURITY_ACTION_APPEAL_TOKEN WHERE Key_name = 'idx_saat_submitter_email_created';
-- SHOW INDEX FROM SECURITY_ACTION_APPEAL WHERE Key_name = 'idx_saa_public_request';
