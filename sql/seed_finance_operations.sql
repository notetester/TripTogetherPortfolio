-- =============================================
-- FINANCE_ADMIN 권한 그룹 / 템플릿 연동 시드 (수정본)
-- =============================================
-- 어드민 내지갑 관리 페이지(/admin/finance) MVP 구현 완료에 따라
-- 신규 권한 그룹 + 권한 템플릿 + 매핑 시드 추가.
--
-- 테이블 구조:
-- - ADMIN_PERMISSION_POLICY                : 개별 권한 (FINANCE_ADMIN 이미 존재)
-- - ADMIN_PERMISSION_GROUP_POLICY          : 권한 그룹 (FINANCE_OPERATIONS 신규)
-- - ADMIN_PERMISSION_GROUP_ITEM            : 그룹 ↔ 개별권한 매핑
-- - ADMIN_PERMISSION_CODE_POLICY           : 권한 템플릿 (FINANCE_OP_STD 신규)
-- - ADMIN_PERMISSION_CODE_GROUP_ITEM       : 템플릿 ↔ 그룹 매핑
-- - ADMIN_PERMISSION_CODE_PERMISSION_ITEM  : 템플릿 ↔ 개별권한 매핑
--
-- 안전:
-- - DDL 없음 (CREATE/ALTER 없음). 순수 INSERT 만.
-- - 1번 INSERT 는 IGNORE 처리 — 이전에 한 번 실행됐을 경우 중복 키 무시.
-- - SUPERADMIN 사용자는 자동 통과이므로 사용자 단위 grant 는 별도 불필요.
-- =============================================

-- 1) 권한 그룹 신설: FINANCE_OPERATIONS (이전에 성공했으면 IGNORE)
INSERT IGNORE INTO `ADMIN_PERMISSION_GROUP_POLICY`
    (`group_code`, `display_name`, `description`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OPERATIONS', '내지갑 운영팀',
     '내지갑 캐시/마일리지/포인트 자산 조회 및 변동 이력 운영',
     1, NULL, NOW(), NULL, NOW(), 25);

-- 2) 권한 그룹 ↔ 개별 권한 매핑: FINANCE_OPERATIONS 가 FINANCE_ADMIN 권한을 포함
INSERT IGNORE INTO `ADMIN_PERMISSION_GROUP_ITEM`
    (`group_code`, `permission_code`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OPERATIONS', 'FINANCE_ADMIN', 1,
     NULL, NOW(), NULL, NOW(), 1);

-- 3) 권한 템플릿 신설: FINANCE_OP_STD ('내지갑 운영 표준')
INSERT IGNORE INTO `ADMIN_PERMISSION_CODE_POLICY`
    (`admin_permission_code`, `display_name`, `description`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OP_STD', '내지갑 운영 표준',
     '내지갑 자산 조회 및 변동 이력 운영 권한 묶음',
     1, NULL, NOW(), NULL, NOW(), 136);

-- 4) 권한 템플릿 ↔ 그룹 매핑: FINANCE_OP_STD 가 FINANCE_OPERATIONS 그룹을 포함
INSERT IGNORE INTO `ADMIN_PERMISSION_CODE_GROUP_ITEM`
    (`admin_permission_code`, `group_code`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OP_STD', 'FINANCE_OPERATIONS', 1,
     NULL, NOW(), NULL, NOW(), 1);

-- 5) 권한 템플릿 ↔ 개별권한 매핑: FINANCE_OP_STD 가 FINANCE_ADMIN 개별권한도 직접 포함
INSERT IGNORE INTO `ADMIN_PERMISSION_CODE_PERMISSION_ITEM`
    (`admin_permission_code`, `permission_code`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OP_STD', 'FINANCE_ADMIN', 1,
     NULL, NOW(), NULL, NOW(), 1);
