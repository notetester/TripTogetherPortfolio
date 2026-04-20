-- ============================================================
-- 차단 관리 권한 / 그룹 / 권한코드 / 관리자 계정 시드
-- 비밀번호 해시 고정:
-- $2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i
-- ============================================================

-- 1) 차단 관련 개별 권한 코드
INSERT IGNORE INTO ADMIN_PERMISSION_POLICY
(permission_code, display_name, description, is_active, created_at, updated_at, priority)
VALUES
('USER_BLOCK_ADMIN',   '유저 차단 관리자',   '회원 차단/해제 및 회원 기준 차단 상태 관리', 1, NOW(), NOW(), 120),
('IP_BLOCK_ADMIN',     'IP 차단 관리자',     '전역 IP / CIDR / RANGE 차단 규칙 관리', 1, NOW(), NOW(), 121),
('BLOCK_POLICY_ADMIN', '차단 정책 관리자',   'IP 차단 배치 및 차단 정책 운영 관리', 1, NOW(), NOW(), 122),
('BLOCK_AUDIT_ADMIN',  '차단 감사 관리자',   '차단 이력 및 현재 차단 현황 감사 조회', 1, NOW(), NOW(), 123);

-- 2) 차단 관련 권한 그룹
INSERT IGNORE INTO ADMIN_PERMISSION_GROUP_POLICY
(group_code, display_name, description, is_active, created_at, updated_at, priority)
VALUES
('BLOCK_USER_OPERATIONS',   '유저 차단 운영',   '회원 차단/해제와 현재 회원 차단 상태 운영', 1, NOW(), NOW(), 120),
('BLOCK_IP_OPERATIONS',     'IP 차단 운영',     '전역 IP 차단 규칙 운영', 1, NOW(), NOW(), 121),
('BLOCK_POLICY_OPERATIONS', '차단 정책 운영',   '차단 배치 및 정책 운영', 1, NOW(), NOW(), 122),
('BLOCK_AUDIT_OPERATIONS',  '차단 감사 운영',   '차단 이력/현황 감사 조회', 1, NOW(), NOW(), 123),
('BLOCK_FULL_OPERATIONS',   '차단 통합 운영',   '차단 관련 전 기능 운영', 1, NOW(), NOW(), 124);

-- 3) 그룹별 권한 구성
INSERT IGNORE INTO ADMIN_PERMISSION_GROUP_ITEM
(group_code, permission_code, is_active, created_at, updated_at, priority)
VALUES
('BLOCK_USER_OPERATIONS',   'USER_BLOCK_ADMIN',   1, NOW(), NOW(), 120),
('BLOCK_IP_OPERATIONS',     'IP_BLOCK_ADMIN',     1, NOW(), NOW(), 121),
('BLOCK_POLICY_OPERATIONS', 'BLOCK_POLICY_ADMIN', 1, NOW(), NOW(), 122),
('BLOCK_AUDIT_OPERATIONS',  'BLOCK_AUDIT_ADMIN',  1, NOW(), NOW(), 123),
('BLOCK_FULL_OPERATIONS',   'USER_BLOCK_ADMIN',   1, NOW(), NOW(), 124),
('BLOCK_FULL_OPERATIONS',   'IP_BLOCK_ADMIN',     1, NOW(), NOW(), 125),
('BLOCK_FULL_OPERATIONS',   'BLOCK_POLICY_ADMIN', 1, NOW(), NOW(), 126),
('BLOCK_FULL_OPERATIONS',   'BLOCK_AUDIT_ADMIN',  1, NOW(), NOW(), 127);

-- 4) 실효 권한 코드(권한 묶음)
INSERT IGNORE INTO ADMIN_PERMISSION_CODE_POLICY
(admin_permission_code, display_name, description, is_active, created_at, updated_at, priority)
VALUES
('BLOCK_OPERATION_STANDARD', '차단 운영 표준', '유저 차단, IP 차단, 차단 감사 권한 조합', 1, NOW(), NOW(), 120),
('BLOCK_OPERATION_MASTER',   '차단 운영 마스터', '유저 차단, IP 차단, 정책 운영, 차단 감사 전체 조합', 1, NOW(), NOW(), 121);

INSERT IGNORE INTO ADMIN_PERMISSION_CODE_GROUP_ITEM
(admin_permission_code, group_code, is_active, created_at, updated_at, priority)
VALUES
('BLOCK_OPERATION_STANDARD', 'BLOCK_USER_OPERATIONS',  1, NOW(), NOW(), 120),
('BLOCK_OPERATION_STANDARD', 'BLOCK_IP_OPERATIONS',    1, NOW(), NOW(), 121),
('BLOCK_OPERATION_STANDARD', 'BLOCK_AUDIT_OPERATIONS', 1, NOW(), NOW(), 122),
('BLOCK_OPERATION_MASTER',   'BLOCK_FULL_OPERATIONS',  1, NOW(), NOW(), 123);

-- 5) 차단 관리자 계정 생성
INSERT IGNORE INTO USERS
(user_id, user_password, password_enabled, email_verified, email_login_enabled,
 account_status, member_grade, is_verified_member, cash_balance, mileage_balance, point_balance,
 level_no, exp_points, total_post_count, total_comment_count,
 nickname, nationality, preferred_lang, created_at, user_role,
 admin_position, admin_position_code, admin_responsibility, admin_permission, admin_permission_code)
VALUES
('blocksuper01',  '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '차단최고관리자', 'KR', 'ko', NOW(), 'ADMIN', 'Director', 'DIRECTOR', '차단 총괄', 'SUPER_ADMIN', NULL),
('blockuser01',   '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '유저차단관리자', 'KR', 'ko', NOW(), 'ADMIN', 'Manager',  'MANAGER',  '회원 차단 운영', 'USER_BLOCK_ADMIN', NULL),
('blockip01',     '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '아이피차단관리자', 'KR', 'ko', NOW(), 'ADMIN', 'Engineer', 'ENGINEER', '전역 IP 차단 운영', 'IP_BLOCK_ADMIN', NULL),
('blockpolicy01', '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '차단정책관리자', 'KR', 'ko', NOW(), 'ADMIN', 'Manager',  'MANAGER',  '차단 정책/배치 운영', 'BLOCK_POLICY_ADMIN', 'BLOCK_OPERATION_MASTER'),
('blockaudit01',  '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '차단감사관리자', 'KR', 'ko', NOW(), 'ADMIN', 'Inspector','INSPECTOR', '차단 이력 감사', 'BLOCK_AUDIT_ADMIN', NULL),
('blockops01',    '$2a$10$8zBdVKhYipTkhpLDYmFHFe97BurecIkjcC9658FRgfhDiANpYtT5i', 1, 0, 0, 'ACTIVE', 'BRONZE', 0, 0, 0, 0, 1, 0, 0, 0, '차단통합운영자', 'KR', 'ko', NOW(), 'ADMIN', 'Manager',  'MANAGER',  '차단 운영 표준', 'BLOCK_OPERATION_STANDARD', 'BLOCK_OPERATION_STANDARD');

-- 6) 최고관리자 직접 권한 부여
INSERT IGNORE INTO ADMIN_PERMISSION
(user_idx, permission_code, is_active, granted_by_user_idx, description, granted_at, created_at, updated_at, priority)
SELECT u.user_idx, 'SUPER_ADMIN', 1, NULL, '차단 최고관리자 시드 계정', NOW(), NOW(), NOW(), 200
FROM USERS u
WHERE u.user_id = 'blocksuper01';

-- 7) 그룹 기반 권한 부여
INSERT IGNORE INTO ADMIN_PERMISSION_GROUP
(user_idx, group_code, is_active, description, granted_at, created_at, updated_at, priority)
SELECT u.user_idx, 'BLOCK_USER_OPERATIONS', 1, '유저 차단 운영 시드', NOW(), NOW(), NOW(), 120
FROM USERS u WHERE u.user_id = 'blockuser01';

INSERT IGNORE INTO ADMIN_PERMISSION_GROUP
(user_idx, group_code, is_active, description, granted_at, created_at, updated_at, priority)
SELECT u.user_idx, 'BLOCK_IP_OPERATIONS', 1, 'IP 차단 운영 시드', NOW(), NOW(), NOW(), 121
FROM USERS u WHERE u.user_id = 'blockip01';

INSERT IGNORE INTO ADMIN_PERMISSION_GROUP
(user_idx, group_code, is_active, description, granted_at, created_at, updated_at, priority)
SELECT u.user_idx, 'BLOCK_AUDIT_OPERATIONS', 1, '차단 감사 운영 시드', NOW(), NOW(), NOW(), 123
FROM USERS u WHERE u.user_id = 'blockaudit01';

-- 8) blockpolicy01 은 권한 코드(BLOCK_OPERATION_MASTER)로 전체 조합을 적용받고,
--    blockops01 은 권한 코드(BLOCK_OPERATION_STANDARD)로 표준 운영 조합을 적용받음.
--    필요 시 직접 권한/그룹을 추가로 더 부여할 수 있음.
