-- TripTogether 런타임 설정 DB 정책화
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 범위:
-- 1. APPLICATION_RUNTIME_SETTING: properties/env 성격의 런타임 설정을 DB에서 우선 조회
-- 2. APPLICATION_RUNTIME_SETTING_HISTORY: 설정 변경 이력/버전
-- 3. OAuth / Mail / Base URL / Block Cache / Auth Email Token TTL / Dormant 기준 seed
--
-- 동작 원칙:
-- - 코드에서는 DB 값 우선 사용
-- - setting_value가 비어 있으면 fallback_value 사용
-- - 테이블/row가 없거나 조회 실패 시 기존 properties/@Value/default로 fallback

CREATE TABLE IF NOT EXISTS `APPLICATION_RUNTIME_SETTING` (
  `setting_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '런타임 설정 PK',
  `setting_key` varchar(160) NOT NULL COMMENT '설정 키. 예: oauth.kakao.client-id',
  `setting_group` varchar(60) NOT NULL DEFAULT 'GENERAL' COMMENT '설정 그룹',
  `display_name` varchar(160) NOT NULL COMMENT '관리자 표시명',
  `setting_value` text DEFAULT NULL COMMENT 'DB 우선 설정값',
  `fallback_value` text DEFAULT NULL COMMENT 'DB 설정값이 비어 있을 때 사용할 fallback',
  `value_type` varchar(30) NOT NULL DEFAULT 'STRING' COMMENT 'STRING / NUMBER / BOOLEAN / URL / SECRET',
  `is_secret` tinyint(1) NOT NULL DEFAULT 0 COMMENT '민감 설정 여부',
  `is_editable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '관리자 UI 수정 허용 여부',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '설정 활성 여부',
  `description` varchar(1000) DEFAULT NULL COMMENT '설정 설명',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '마지막 수정 관리자',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`setting_idx`),
  UNIQUE KEY `uk_ars_setting_key` (`setting_key`),
  KEY `idx_ars_group_key` (`setting_group`,`setting_key`),
  KEY `idx_ars_active` (`is_active`,`setting_group`),
  KEY `idx_ars_updated_by` (`updated_by_user_idx`,`updated_at`),
  CONSTRAINT `fk_ars_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DB 우선 런타임 설정';

CREATE TABLE IF NOT EXISTS `APPLICATION_RUNTIME_SETTING_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '런타임 설정 변경 이력 PK',
  `setting_idx` bigint NOT NULL COMMENT 'APPLICATION_RUNTIME_SETTING.setting_idx',
  `setting_key` varchar(160) NOT NULL COMMENT '설정 키',
  `version_no` int NOT NULL COMMENT '설정별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / IMPORT / RESET',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_value` text DEFAULT NULL COMMENT '변경 전 설정값',
  `after_value` text DEFAULT NULL COMMENT '변경 후 설정값',
  `before_fallback_value` text DEFAULT NULL COMMENT '변경 전 fallback',
  `after_fallback_value` text DEFAULT NULL COMMENT '변경 후 fallback',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 전체 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 전체 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_arsh_setting_version` (`setting_idx`,`version_no`),
  KEY `idx_arsh_key_created` (`setting_key`,`created_at`),
  KEY `idx_arsh_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_arsh_setting` FOREIGN KEY (`setting_idx`) REFERENCES `APPLICATION_RUNTIME_SETTING` (`setting_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_arsh_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DB 우선 런타임 설정 변경 이력';

INSERT INTO APPLICATION_RUNTIME_SETTING
(setting_key, setting_group, display_name, setting_value, fallback_value, value_type, is_secret, is_editable, is_active, description, created_at, updated_at)
VALUES
('spring.mail.username', 'MAIL', 'Mail From Username', NULL, NULL, 'SECRET', 1, 1, 1, '메일 발신자 주소. DB 값이 없으면 spring.mail.username properties 값을 사용합니다.', NOW(), NOW()),
('app.base-url', 'APP', 'Application Base URL', NULL, 'http://localhost:8080/TripTogether', 'URL', 0, 1, 1, '사용자 인증/복구 링크 생성용 기본 URL입니다.', NOW(), NOW()),
('app.public-base-url', 'APP', 'Public Application Base URL', NULL, 'http://localhost:8080/TripTogether', 'URL', 0, 1, 1, '차단/이의제기 등 외부 공개 링크 생성용 URL입니다.', NOW(), NOW()),
('security.block.cache.file', 'SECURITY', 'Block Rule Cache File', NULL, './data/block-rule-cache.json', 'STRING', 0, 1, 1, '차단 규칙 파일 캐시 경로입니다.', NOW(), NOW()),
('auth.email.default-token-ttl-minutes', 'AUTH_EMAIL', 'Default Email Token TTL Minutes', '30', '30', 'NUMBER', 0, 1, 1, '기본 이메일 토큰 유효 시간입니다.', NOW(), NOW()),
('auth.email.find-id-token-ttl-minutes', 'AUTH_EMAIL', 'Find ID Token TTL Minutes', '30', '30', 'NUMBER', 0, 1, 1, '아이디 찾기 인증 링크 유효 시간입니다.', NOW(), NOW()),
('auth.email.reset-password-token-ttl-minutes', 'AUTH_EMAIL', 'Reset Password Token TTL Minutes', '30', '30', 'NUMBER', 0, 1, 1, '비밀번호 재설정 링크 유효 시간입니다.', NOW(), NOW()),
('auth.email.profile-email-token-ttl-minutes', 'AUTH_EMAIL', 'Profile Email Verification Token TTL Minutes', '30', '30', 'NUMBER', 0, 1, 1, '마이페이지 이메일 인증 링크 유효 시간입니다.', NOW(), NOW()),
('auth.dormant.inactive-days', 'AUTH_ACCOUNT', 'Dormant Account Inactive Days', '365', '365', 'NUMBER', 0, 1, 1, '휴면 전환 기본 미접속 기준일입니다.', NOW(), NOW()),
('oauth.kakao.client-id', 'OAUTH_KAKAO', 'Kakao Client ID', NULL, NULL, 'SECRET', 1, 1, 1, 'Kakao OAuth client_id. DB 값 우선, 없으면 properties 값을 사용합니다.', NOW(), NOW()),
('oauth.kakao.client-secret', 'OAUTH_KAKAO', 'Kakao Client Secret', NULL, NULL, 'SECRET', 1, 1, 1, 'Kakao OAuth client_secret.', NOW(), NOW()),
('oauth.kakao.redirect-uri', 'OAUTH_KAKAO', 'Kakao Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Kakao 로그인 redirect URI.', NOW(), NOW()),
('oauth.kakao.link-redirect-uri', 'OAUTH_KAKAO', 'Kakao Link Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Kakao 계정 연동 redirect URI.', NOW(), NOW()),
('oauth.kakao.logout-redirect-uri', 'OAUTH_KAKAO', 'Kakao Logout Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Kakao logout redirect URI.', NOW(), NOW()),
('oauth.naver.client-id', 'OAUTH_NAVER', 'Naver Client ID', NULL, NULL, 'SECRET', 1, 1, 1, 'Naver OAuth client_id.', NOW(), NOW()),
('oauth.naver.client-secret', 'OAUTH_NAVER', 'Naver Client Secret', NULL, NULL, 'SECRET', 1, 1, 1, 'Naver OAuth client_secret.', NOW(), NOW()),
('oauth.naver.redirect-uri', 'OAUTH_NAVER', 'Naver Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Naver 로그인 redirect URI.', NOW(), NOW()),
('oauth.naver.link-redirect-uri', 'OAUTH_NAVER', 'Naver Link Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Naver 계정 연동 redirect URI.', NOW(), NOW()),
('oauth.naver.logout-redirect-uri', 'OAUTH_NAVER', 'Naver Logout Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Naver logout redirect URI.', NOW(), NOW()),
('oauth.google.client-id', 'OAUTH_GOOGLE', 'Google Client ID', NULL, NULL, 'SECRET', 1, 1, 1, 'Google OAuth client_id.', NOW(), NOW()),
('oauth.google.client-secret', 'OAUTH_GOOGLE', 'Google Client Secret', NULL, NULL, 'SECRET', 1, 1, 1, 'Google OAuth client_secret.', NOW(), NOW()),
('oauth.google.redirect-uri', 'OAUTH_GOOGLE', 'Google Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Google 로그인 redirect URI.', NOW(), NOW()),
('oauth.google.link-redirect-uri', 'OAUTH_GOOGLE', 'Google Link Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Google 계정 연동 redirect URI.', NOW(), NOW()),
('oauth.google.logout-redirect-uri', 'OAUTH_GOOGLE', 'Google Logout Redirect URI', NULL, NULL, 'URL', 0, 1, 1, 'Google logout redirect URI.', NOW(), NOW())
ON DUPLICATE KEY UPDATE
  setting_group = VALUES(setting_group),
  display_name = VALUES(display_name),
  fallback_value = COALESCE(APPLICATION_RUNTIME_SETTING.fallback_value, VALUES(fallback_value)),
  value_type = VALUES(value_type),
  is_secret = VALUES(is_secret),
  is_editable = VALUES(is_editable),
  description = VALUES(description),
  updated_at = NOW();

INSERT INTO APPLICATION_RUNTIME_SETTING_HISTORY
(setting_idx, setting_key, version_no, change_type, actor_user_idx, before_value, after_value, before_fallback_value, after_fallback_value, before_config_json, after_config_json, created_at)
SELECT
 s.setting_idx,
 s.setting_key,
 1,
 'CREATE',
 NULL,
 NULL,
 s.setting_value,
 NULL,
 s.fallback_value,
 NULL,
 JSON_OBJECT(
   'settingKey', s.setting_key,
   'settingGroup', s.setting_group,
   'displayName', s.display_name,
   'valueType', s.value_type,
   'secret', s.is_secret,
   'active', s.is_active
 ),
 NOW()
FROM APPLICATION_RUNTIME_SETTING s
WHERE NOT EXISTS (
  SELECT 1 FROM APPLICATION_RUNTIME_SETTING_HISTORY h WHERE h.setting_idx = s.setting_idx
);

-- 확인용
-- SELECT setting_key, setting_group, setting_value, fallback_value, is_active FROM APPLICATION_RUNTIME_SETTING ORDER BY setting_group, setting_key;
