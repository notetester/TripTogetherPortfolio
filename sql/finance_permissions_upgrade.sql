-- =========================================================================
-- finance_permissions_upgrade.sql
--
-- 어드민 내지갑 관리 권한 세분화 (D안 진행 / Phase 17)
--
-- 추가 권한:
--   - FINANCE_OPERATOR       : 환불·자산 조정 등 운영성 쓰기 작업
--   - FINANCE_POLICY_ADMIN   : 충전 한도·적립률 등 정책 설정 (읽기+쓰기)
--
-- 기존 FINANCE_ADMIN 은 read-only 유지.
-- =========================================================================

INSERT INTO `ADMIN_PERMISSION_POLICY`
    (`permission_code`, `display_name`, `description`, `is_active`, `priority`)
VALUES
    ('FINANCE_OPERATOR',     '내지갑 운영자',       '환불·자산 조정 등 운영성 쓰기 작업',         1, 14),
    ('FINANCE_POLICY_ADMIN', '내지갑 정책 관리자',   '충전 한도·적립률 등 내지갑 정책 설정',        1, 15) AS new_row
ON DUPLICATE KEY UPDATE
    `display_name` = new_row.`display_name`,
    `description`  = new_row.`description`,
    `is_active`    = new_row.`is_active`,
    `priority`     = new_row.`priority`;

-- (선택) 기존 FINANCE_ADMIN 보유자가 곧바로 운영/정책 권한도 사용할 수 있게
--       자동 부여하지는 않는다. SUPER_ADMIN 만 모든 권한을 통과하므로,
--       각 운영자에게 권한을 부여하는 것은 superAdmin 화면에서 진행한다.
