-- =============================================
-- FINANCE_ADMIN 권한 카탈로그 그룹/템플릿 연동 시드
-- =============================================
-- 어드민 내지갑 관리 페이지(/admin/finance) MVP 구현 완료에 따라
-- 1) 신규 권한 그룹 'FINANCE_OPERATIONS' (내지갑 운영팀) 추가
-- 2) FINANCE_ADMIN 권한 코드 ↔ FINANCE_OPERATIONS 그룹 매핑
-- 3) FINANCE_ADMIN 권한 코드 ↔ FINANCE_ADMIN 개별권한 매핑 (코드 = 단일 권한)
--
-- 주의:
-- - DDL 없음 (CREATE/ALTER 없음). 순수 INSERT 만.
-- - 기존 권한 코드들은 PERMISSION_ITEM/GROUP_ITEM 매핑이 0건이라
--   FINANCE_ADMIN 만 정리하면 일관성은 약함. 후속 작업으로 다른 코드 정리 권장.
-- - SUPERADMIN 사용자는 자동 통과이므로 사용자 단위 grant 는 별도 불필요.
--   다른 어드민에게 내지갑 권한 부여하려면 superAdmin UI 통해 진행.
-- =============================================

-- 1) 권한 그룹 신설: FINANCE_OPERATIONS
INSERT INTO `ADMIN_PERMISSION_GROUP_POLICY`
    (`group_code`, `display_name`, `description`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_OPERATIONS', '내지갑 운영팀',
     '내지갑 캐시/마일리지/포인트 자산 조회 및 변동 이력 운영',
     1, NULL, NOW(), NULL, NOW(), 25);

-- 2) 권한 코드 ↔ 권한 그룹 매핑: FINANCE_ADMIN ↔ FINANCE_OPERATIONS
INSERT INTO `ADMIN_PERMISSION_CODE_GROUP_ITEM`
    (`admin_permission_code`, `group_code`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_ADMIN', 'FINANCE_OPERATIONS', 1,
     NULL, NOW(), NULL, NOW(), 1);

-- 3) 권한 코드 ↔ 개별권한 매핑: FINANCE_ADMIN ↔ FINANCE_ADMIN (단일 권한 형태)
INSERT INTO `ADMIN_PERMISSION_CODE_PERMISSION_ITEM`
    (`admin_permission_code`, `permission_code`, `is_active`,
     `created_by_user_idx`, `created_at`, `updated_by_user_idx`, `updated_at`, `priority`)
VALUES
    ('FINANCE_ADMIN', 'FINANCE_ADMIN', 1,
     NULL, NOW(), NULL, NOW(), 1);
