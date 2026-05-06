-- --------------------------------------------------------
-- 호스트:                          localhost
-- 서버 버전:                        8.0.45-0ubuntu0.24.04.1 - (Ubuntu)
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.17.0.7273
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 team1_db.AD_CAMPAIGN 구조 내보내기
CREATE TABLE IF NOT EXISTS `AD_CAMPAIGN` (
  `ad_id` bigint NOT NULL AUTO_INCREMENT,
  `slot_code` varchar(40) NOT NULL,
  `title` varchar(200) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `link_url` varchar(500) DEFAULT NULL,
  `link_type` varchar(20) DEFAULT 'EXTERNAL' COMMENT 'NONE / EXTERNAL / INTERNAL',
  `link_target_type` varchar(30) DEFAULT NULL COMMENT 'package / community / courses / explore / flight / shop / mypage / inquiry',
  `link_target_id` bigint DEFAULT NULL COMMENT '대상 리소스 ID (목록 페이지처럼 ID 불필요한 액션은 NULL)',
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `view_count` bigint NOT NULL DEFAULT '0',
  `click_count` bigint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` bigint DEFAULT NULL,
  PRIMARY KEY (`ad_id`),
  KEY `idx_ad_slot_active` (`slot_code`,`is_active`),
  KEY `idx_ad_period` (`start_at`,`end_at`),
  KEY `fk_ad_created_by` (`created_by`),
  CONSTRAINT `fk_ad_created_by` FOREIGN KEY (`created_by`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_ACTION_AUDIT 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_ACTION_AUDIT` (
  `admin_action_audit_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 조치 감사 PK',
  `action_type` varchar(80) NOT NULL COMMENT '조치 유형',
  `action_domain` varchar(60) NOT NULL COMMENT '업무 도메인',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수행 관리자 user_idx',
  `target_type` varchar(60) DEFAULT NULL COMMENT '대상 유형',
  `target_id` varchar(120) DEFAULT NULL COMMENT '대상 식별자',
  `reason_code` varchar(120) DEFAULT NULL COMMENT '표준 사유 코드',
  `reason_args` json DEFAULT NULL COMMENT '사유 인자 JSON',
  `detail_summary` varchar(1000) DEFAULT NULL COMMENT '감사 요약',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`admin_action_audit_idx`),
  KEY `idx_aaa_domain_created` (`action_domain`,`created_at`),
  KEY `idx_aaa_type_created` (`action_type`,`created_at`),
  KEY `idx_aaa_actor_created` (`actor_user_idx`,`created_at`),
  KEY `idx_aaa_target` (`target_type`,`target_id`),
  KEY `idx_aaa_reason_created` (`reason_code`,`created_at`),
  CONSTRAINT `fk_aaa_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 외 일반 관리자 조치 reason_code 감사 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_ASSISTANT_BLOCK 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_ASSISTANT_BLOCK` (
  `block_id` bigint NOT NULL AUTO_INCREMENT,
  `block_type` enum('USER','IP') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `block_value` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'user_idx(문자) 또는 IP',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blocked_by` bigint DEFAULT NULL COMMENT '처리 관리자 user_idx',
  `blocked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL COMMENT 'NULL=영구',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`block_id`),
  UNIQUE KEY `uk_aa_active_type_value` (`is_active`,`block_type`,`block_value`),
  KEY `idx_aa_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 도우미 전용 차단 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_ASSISTANT_DAILY_USAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_ASSISTANT_DAILY_USAGE` (
  `usage_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비로그인 식별자 (assistant 는 기본 로그인 필수,\r\n  통계용)',
  `period_start` datetime NOT NULL COMMENT '현재 주기 시작 시각(KST)',
  `session_count` int NOT NULL DEFAULT '0' COMMENT '해당 주기 내 신규 세션 수 (참고용)',
  `message_count` int NOT NULL DEFAULT '0' COMMENT '해당 주기 내 유저 메시지 수 (enforce 대상)',
  PRIMARY KEY (`usage_id`),
  UNIQUE KEY `uk_aa_user_period` (`user_idx`,`period_start`),
  UNIQUE KEY `uk_aa_ip_period` (`ip_address`,`period_start`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 도우미 주기별 사용량 집계';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_ASSISTANT_GRADE_QUOTA 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_ASSISTANT_GRADE_QUOTA` (
  `quota_id` int NOT NULL AUTO_INCREMENT,
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'GUEST/BRONZE/SILVER/GOLD/DIAMOND/PLATINUM',
  `max_sessions` int NOT NULL DEFAULT '10' COMMENT '동시 보유 세션(CHAT_POST) 수 한도',
  `max_messages_per_period` int NOT NULL DEFAULT '100' COMMENT '주기당 유저 메시지 한도',
  `period_days` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '한도 주기 (일: 1/2/3/4/5/7/14/30)',
  `reset_hour` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '리셋 시각 시 (0-23)',
  `reset_minute` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '리셋 시각 분 (0-59)',
  `quota_refund_enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '세션 삭제 시 사용량 환급 허용',
  `updated_by` bigint DEFAULT NULL COMMENT '마지막 수정 관리자',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`quota_id`),
  UNIQUE KEY `grade` (`grade`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 도우미 등급별 한도';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_ASSISTANT_MODERATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_ASSISTANT_MODERATION` (
  `moderation_id` bigint NOT NULL AUTO_INCREMENT,
  `chat_comment_idx` bigint NOT NULL COMMENT 'CHAT_COMMENT FK (user 메시지 전용)',
  `is_inappropriate` tinyint(1) NOT NULL DEFAULT '0',
  `toxicity_score` decimal(4,3) DEFAULT NULL COMMENT 'Perspective API TOXICITY 점수 0.000~1.000',
  `checked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`moderation_id`),
  UNIQUE KEY `uk_aa_comment` (`chat_comment_idx`),
  KEY `idx_aa_inappropriate` (`is_inappropriate`,`checked_at` DESC),
  CONSTRAINT `fk_aa_mod_comment` FOREIGN KEY (`chat_comment_idx`) REFERENCES `CHAT_COMMENT` (`chat_comment_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 도우미 user 메시지 독성 감지 결과';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 뷰 team1_db.ADMIN_EFFECTIVE_PERMISSION_VW 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `ADMIN_EFFECTIVE_PERMISSION_VW` (
	`user_idx` BIGINT NOT NULL,
	`permission_code` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`permission_source` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`source_group_code` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci'
);

-- 테이블 team1_db.ADMIN_NOTIFICATION_PREFERENCE 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_NOTIFICATION_PREFERENCE` (
  `preference_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `notification_category` varchar(60) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`preference_idx`),
  UNIQUE KEY `uk_anp_user_category` (`user_idx`,`notification_category`),
  CONSTRAINT `fk_anp_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 업무별 알림 수신 설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION` (
  `admin_permission_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 권한 PK',
  `user_idx` bigint NOT NULL COMMENT '권한이 적용되는 관리자 회원 PK',
  `permission_code` varchar(50) NOT NULL COMMENT '권한 코드 (SUPER_ADMIN / COMMUNITY_ADMIN / MEMBER_ADMIN / REPORT_ADMIN / INQUIRY_ADMIN)',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `granted_request_by_user_idx` bigint DEFAULT NULL COMMENT '권한 부여 요청 관리자 PK',
  `granted_approval_by_user_idx` bigint DEFAULT NULL COMMENT '권한 부여 승인 관리자 PK',
  `granted_by_user_idx` bigint DEFAULT NULL COMMENT '실제 권한 부여 적용 관리자 PK',
  `description` varchar(500) DEFAULT NULL COMMENT '권한 부여 사유',
  `granted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '부여 시각',
  `revoked_at` datetime DEFAULT NULL COMMENT '회수 시각',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_idx`),
  UNIQUE KEY `uq_ap_user_permission` (`user_idx`,`permission_code`),
  KEY `fk_ap_request_by` (`granted_request_by_user_idx`),
  KEY `fk_ap_approval_by` (`granted_approval_by_user_idx`),
  KEY `fk_ap_granted_by` (`granted_by_user_idx`),
  KEY `fk_ap_created_by` (`created_by_user_idx`),
  KEY `fk_ap_updated_by` (`updated_by_user_idx`),
  KEY `idx_ap_permission_active` (`permission_code`,`is_active`),
  KEY `idx_ap_user_active` (`user_idx`,`is_active`),
  CONSTRAINT `fk_ap_approval_by` FOREIGN KEY (`granted_approval_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ap_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ap_granted_by` FOREIGN KEY (`granted_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ap_request_by` FOREIGN KEY (`granted_request_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ap_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ap_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 세부 권한';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_CODE_GROUP_ITEM 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_CODE_GROUP_ITEM` (
  `admin_permission_code_group_item_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '실효 권한 코드-권한그룹 구성 항목 PK',
  `admin_permission_code` varchar(30) NOT NULL COMMENT '실효 권한 코드',
  `group_code` varchar(50) NOT NULL COMMENT '실효 권한 코드에 포함되는 권한 그룹 코드',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_code_group_item_idx`),
  UNIQUE KEY `uq_apcgi_code_group` (`admin_permission_code`,`group_code`),
  KEY `fk_apcgi_created_by` (`created_by_user_idx`),
  KEY `fk_apcgi_updated_by` (`updated_by_user_idx`),
  KEY `idx_apcgi_code_active` (`admin_permission_code`,`is_active`),
  KEY `idx_apcgi_group_active` (`group_code`,`is_active`),
  CONSTRAINT `fk_apcgi_code` FOREIGN KEY (`admin_permission_code`) REFERENCES `ADMIN_PERMISSION_CODE_POLICY` (`admin_permission_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apcgi_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apcgi_group` FOREIGN KEY (`group_code`) REFERENCES `ADMIN_PERMISSION_GROUP_POLICY` (`group_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apcgi_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='실효 권한 코드에 포함되는 권한 그룹 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_CODE_PERMISSION_ITEM 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_CODE_PERMISSION_ITEM` (
  `admin_permission_code_permission_item_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '실효 권한 코드-개별권한 구성 항목 PK',
  `admin_permission_code` varchar(30) NOT NULL COMMENT '실효 권한 코드',
  `permission_code` varchar(50) NOT NULL COMMENT '실효 권한 코드에 포함되는 개별 권한 코드',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_code_permission_item_idx`),
  UNIQUE KEY `uq_apcpi_code_permission` (`admin_permission_code`,`permission_code`),
  KEY `fk_apcpi_created_by` (`created_by_user_idx`),
  KEY `fk_apcpi_updated_by` (`updated_by_user_idx`),
  KEY `idx_apcpi_code_active` (`admin_permission_code`,`is_active`),
  KEY `idx_apcpi_permission_active` (`permission_code`,`is_active`),
  CONSTRAINT `fk_apcpi_code` FOREIGN KEY (`admin_permission_code`) REFERENCES `ADMIN_PERMISSION_CODE_POLICY` (`admin_permission_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apcpi_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apcpi_permission` FOREIGN KEY (`permission_code`) REFERENCES `ADMIN_PERMISSION_POLICY` (`permission_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apcpi_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='실효 권한 코드에 포함되는 개별 권한 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_CODE_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_CODE_POLICY` (
  `admin_permission_code_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '실효 권한 코드 정책 PK',
  `admin_permission_code` varchar(30) NOT NULL COMMENT '실효 권한 코드 (예: CS_MANAGER_L1 / MEMBER_SUPPORT_PLUS)',
  `display_name` varchar(100) NOT NULL COMMENT '실효 권한 코드 표시명',
  `description` varchar(255) DEFAULT NULL COMMENT '실효 권한 코드 설명',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_code_policy_idx`),
  UNIQUE KEY `admin_permission_code` (`admin_permission_code`),
  KEY `fk_apcp_created_by` (`created_by_user_idx`),
  KEY `fk_apcp_updated_by` (`updated_by_user_idx`),
  KEY `idx_apcp_active` (`is_active`),
  CONSTRAINT `fk_apcp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apcp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자에게 최종적으로 적용되는 실효 권한 코드 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_GROUP 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_GROUP` (
  `admin_permission_group_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 권한 그룹 부여 PK',
  `user_idx` bigint NOT NULL COMMENT '권한 그룹이 적용되는 관리자 회원 PK',
  `group_code` varchar(50) NOT NULL COMMENT '부여되는 권한 그룹 코드',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `granted_request_by_user_idx` bigint DEFAULT NULL COMMENT '권한 그룹 부여 요청 관리자 PK',
  `granted_approval_by_user_idx` bigint DEFAULT NULL COMMENT '권한 그룹 부여 승인 관리자 PK',
  `granted_by_user_idx` bigint DEFAULT NULL COMMENT '실제 권한 그룹 부여 적용 관리자 PK',
  `description` varchar(500) DEFAULT NULL COMMENT '권한 그룹 부여 사유',
  `granted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '부여 시각',
  `revoked_at` datetime DEFAULT NULL COMMENT '회수 시각',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_group_idx`),
  UNIQUE KEY `uq_apg_user_group` (`user_idx`,`group_code`),
  KEY `fk_apg_request_by` (`granted_request_by_user_idx`),
  KEY `fk_apg_approval_by` (`granted_approval_by_user_idx`),
  KEY `fk_apg_granted_by` (`granted_by_user_idx`),
  KEY `fk_apg_created_by` (`created_by_user_idx`),
  KEY `fk_apg_updated_by` (`updated_by_user_idx`),
  KEY `idx_apg_group_active` (`group_code`,`is_active`),
  KEY `idx_apg_user_active` (`user_idx`,`is_active`),
  CONSTRAINT `fk_apg_approval_by` FOREIGN KEY (`granted_approval_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apg_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apg_granted_by` FOREIGN KEY (`granted_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apg_group_code` FOREIGN KEY (`group_code`) REFERENCES `ADMIN_PERMISSION_GROUP_POLICY` (`group_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apg_request_by` FOREIGN KEY (`granted_request_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apg_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apg_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자에게 권한 그룹을 부여하는 이력/설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_GROUP_ITEM 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_GROUP_ITEM` (
  `admin_permission_group_item_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '권한 그룹 구성 항목 PK',
  `group_code` varchar(50) NOT NULL COMMENT '권한 그룹 코드',
  `permission_code` varchar(50) NOT NULL COMMENT '그룹에 포함되는 권한 코드',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_group_item_idx`),
  UNIQUE KEY `uq_apgi_group_permission` (`group_code`,`permission_code`),
  KEY `fk_apgi_created_by` (`created_by_user_idx`),
  KEY `fk_apgi_updated_by` (`updated_by_user_idx`),
  KEY `idx_apgi_group_active` (`group_code`,`is_active`),
  KEY `idx_apgi_permission_active` (`permission_code`,`is_active`),
  CONSTRAINT `fk_apgi_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apgi_group_code` FOREIGN KEY (`group_code`) REFERENCES `ADMIN_PERMISSION_GROUP_POLICY` (`group_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apgi_permission_code` FOREIGN KEY (`permission_code`) REFERENCES `ADMIN_PERMISSION_POLICY` (`permission_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_apgi_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='권한 그룹에 포함되는 세부 권한 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_GROUP_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_GROUP_POLICY` (
  `admin_permission_group_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 권한 그룹 정책 PK',
  `group_code` varchar(50) NOT NULL COMMENT '권한 그룹 코드 (CUSTOMER_SUPPORT / MEMBER_OPERATIONS / COMMUNITY_OPERATIONS 등)',
  `display_name` varchar(100) NOT NULL COMMENT '권한 그룹 표시명',
  `description` varchar(255) DEFAULT NULL COMMENT '권한 그룹 설명',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_group_policy_idx`),
  UNIQUE KEY `group_code` (`group_code`),
  KEY `fk_apgpolicy_created_by` (`created_by_user_idx`),
  KEY `fk_apgpolicy_updated_by` (`updated_by_user_idx`),
  KEY `idx_apgpolicy_active` (`is_active`),
  CONSTRAINT `fk_apgpolicy_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_apgpolicy_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 권한 그룹 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_PERMISSION_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_PERMISSION_POLICY` (
  `admin_permission_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 권한 정책 PK',
  `permission_code` varchar(50) NOT NULL COMMENT '권한 코드 (SUPER_ADMIN / COMMUNITY_ADMIN / MEMBER_ADMIN / REPORT_ADMIN / INQUIRY_ADMIN)',
  `display_name` varchar(100) NOT NULL COMMENT '권한 표시명',
  `description` varchar(255) DEFAULT NULL COMMENT '권한 설명',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '사용 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_permission_policy_idx`),
  UNIQUE KEY `permission_code` (`permission_code`),
  KEY `fk_appolicy_created_by` (`created_by_user_idx`),
  KEY `fk_appolicy_updated_by` (`updated_by_user_idx`),
  KEY `idx_appolicy_active` (`is_active`),
  CONSTRAINT `fk_appolicy_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_appolicy_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 개별 권한 코드 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_POSITION_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_POSITION_POLICY` (
  `admin_position_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '관리자 직책 정책 PK',
  `admin_position_code` varchar(30) NOT NULL COMMENT '관리자 직책 코드 (MANAGER / INSPECTOR / ENGINEER / DIRECTOR 등)',
  `display_name` varchar(100) NOT NULL COMMENT '직책 표시명',
  `description` varchar(255) DEFAULT NULL COMMENT '직책 설명',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '정렬 순서',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '사용 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`admin_position_policy_idx`),
  UNIQUE KEY `admin_position_code` (`admin_position_code`),
  KEY `fk_app_created_by` (`created_by_user_idx`),
  KEY `fk_app_updated_by` (`updated_by_user_idx`),
  KEY `idx_app_active_sort` (`is_active`,`sort_order`),
  CONSTRAINT `fk_app_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_app_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 직책 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_TRANSLATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_TRANSLATION` (
  `translation_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_idx` bigint NOT NULL,
  `field_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `visibility_scope` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ADMIN_ONLY',
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  `forked_from_translation_idx` bigint DEFAULT NULL,
  `current_revision_idx` bigint DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`translation_idx`),
  KEY `idx_admin_translation_lookup` (`source_type`,`source_idx`,`field_name`,`source_lang`,`target_lang`,`is_deleted`),
  KEY `idx_admin_translation_current_revision` (`current_revision_idx`),
  KEY `idx_admin_translation_primary` (`source_type`,`source_idx`,`field_name`,`source_lang`,`target_lang`,`is_primary`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_TRANSLATION_REVISION 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_TRANSLATION_REVISION` (
  `translation_revision_idx` bigint NOT NULL AUTO_INCREMENT,
  `translation_idx` bigint NOT NULL,
  `version_no` int NOT NULL,
  `parent_revision_idx` bigint DEFAULT NULL,
  `source_snapshot_idx` bigint NOT NULL,
  `translated_text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `translation_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AUTO',
  `translation_engine` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `translation_engine_version` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `style_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT',
  `review_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `reviewed_by` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_comment` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`translation_revision_idx`),
  UNIQUE KEY `uk_admin_translation_revision_version` (`translation_idx`,`version_no`),
  KEY `idx_admin_translation_revision_translation` (`translation_idx`,`translation_revision_idx` DESC),
  KEY `idx_admin_translation_revision_snapshot` (`source_snapshot_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.ADMIN_TRANSLATION_SOURCE_SNAPSHOT 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADMIN_TRANSLATION_SOURCE_SNAPSHOT` (
  `source_snapshot_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_idx` bigint NOT NULL,
  `field_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_text_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_updated_at` datetime DEFAULT NULL,
  `snapshot_seq` int NOT NULL,
  `captured_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `captured_by_user_idx` bigint DEFAULT NULL,
  PRIMARY KEY (`source_snapshot_idx`),
  UNIQUE KEY `uk_admin_translation_snapshot_seq` (`source_type`,`source_idx`,`field_name`,`snapshot_seq`),
  KEY `idx_admin_translation_snapshot_latest` (`source_type`,`source_idx`,`field_name`,`source_snapshot_idx` DESC),
  KEY `idx_admin_translation_snapshot_hash` (`source_type`,`source_idx`,`field_name`,`source_text_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.APPLICATION_RUNTIME_SETTING 구조 내보내기
CREATE TABLE IF NOT EXISTS `APPLICATION_RUNTIME_SETTING` (
  `setting_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '런타임 설정 PK',
  `setting_key` varchar(160) NOT NULL COMMENT '설정 키. 예: oauth.kakao.client-id',
  `setting_group` varchar(60) NOT NULL DEFAULT 'GENERAL' COMMENT '설정 그룹',
  `display_name` varchar(160) NOT NULL COMMENT '관리자 표시명',
  `setting_value` text COMMENT 'DB 우선 설정값',
  `fallback_value` text COMMENT 'DB 설정값이 비어 있을 때 사용할 fallback',
  `value_type` varchar(30) NOT NULL DEFAULT 'STRING' COMMENT 'STRING / NUMBER / BOOLEAN / URL / SECRET',
  `is_secret` tinyint(1) NOT NULL DEFAULT '0' COMMENT '민감 설정 여부',
  `is_editable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '관리자 UI 수정 허용 여부',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '설정 활성 여부',
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DB 우선 런타임 설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.APPLICATION_RUNTIME_SETTING_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `APPLICATION_RUNTIME_SETTING_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '런타임 설정 변경 이력 PK',
  `setting_idx` bigint NOT NULL COMMENT 'APPLICATION_RUNTIME_SETTING.setting_idx',
  `setting_key` varchar(160) NOT NULL COMMENT '설정 키',
  `version_no` int NOT NULL COMMENT '설정별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / IMPORT / RESET',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_value` text COMMENT '변경 전 설정값',
  `after_value` text COMMENT '변경 후 설정값',
  `before_fallback_value` text COMMENT '변경 전 fallback',
  `after_fallback_value` text COMMENT '변경 후 fallback',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 전체 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 전체 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_arsh_setting_version` (`setting_idx`,`version_no`),
  KEY `idx_arsh_key_created` (`setting_key`,`created_at`),
  KEY `idx_arsh_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_arsh_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_arsh_setting` FOREIGN KEY (`setting_idx`) REFERENCES `APPLICATION_RUNTIME_SETTING` (`setting_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DB 우선 런타임 설정 변경 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.BLOCK_ACCESS_LOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `BLOCK_ACCESS_LOG` (
  `block_access_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '차단 접근 로그 PK',
  `request_id` varchar(36) NOT NULL COMMENT '차단된 단일 HTTP 요청 식별자(UUID)',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '동일 흐름 추적용 식별자',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 사용자 PK. 비회원/IP 차단은 NULL 가능',
  `session_id` varchar(100) DEFAULT NULL COMMENT '세션 식별자',
  `request_uri` varchar(255) NOT NULL COMMENT '차단된 요청 URI',
  `http_method` varchar(10) NOT NULL COMMENT 'HTTP 메서드',
  `activity_domain` varchar(30) NOT NULL DEFAULT 'GENERAL' COMMENT '도메인 분류',
  `activity_type` varchar(30) NOT NULL COMMENT 'PAGE_VIEW / ACTION / AJAX / API',
  `activity_code` varchar(50) DEFAULT 'BLOCKED_ACCESS' COMMENT '차단 활동 코드',
  `activity_provider` varchar(20) DEFAULT NULL COMMENT '인증/연동 제공자',
  `auth_event_type` varchar(20) DEFAULT NULL COMMENT 'AUTH 세부 이벤트',
  `target_type` varchar(30) DEFAULT NULL COMMENT '대상 유형',
  `target_id` varchar(100) DEFAULT NULL COMMENT '대상 식별자',
  `handler_name` varchar(200) DEFAULT NULL COMMENT '차단 시점 핸들러',
  `query_string` varchar(1000) DEFAULT NULL COMMENT '민감값 마스킹된 쿼리 문자열',
  `referer` varchar(500) DEFAULT NULL COMMENT '민감값 마스킹된 Referer',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '클라이언트 IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT 'User-Agent',
  `response_status` int DEFAULT '403' COMMENT '차단 응답 상태',
  `response_time_ms` int DEFAULT NULL COMMENT '차단 판단 시간(ms)',
  `is_success` tinyint(1) DEFAULT '0' COMMENT '항상 실패성 요청으로 취급',
  `detail_summary` varchar(500) DEFAULT NULL COMMENT '차단 요약',
  `block_kind` varchar(20) NOT NULL COMMENT 'IP / USER',
  `block_match_type` varchar(30) DEFAULT NULL COMMENT 'SINGLE_IP / CIDR / RANGE / COUNTRY / ASN / USER_ONLY / USER_IP / ACCOUNT_STATUS',
  `block_target_key` varchar(120) DEFAULT NULL COMMENT '차단 대상 키',
  `block_request_id` varchar(36) DEFAULT NULL COMMENT '차단 규칙을 만든 요청 ID',
  `block_rule_idx` bigint DEFAULT NULL COMMENT 'IP_BLOCKLIST.ip_blocklist_idx 또는 USER_BLOCKLIST.block_idx',
  `block_reason` varchar(500) DEFAULT NULL COMMENT '차단 사유',
  `country_code` varchar(2) DEFAULT NULL COMMENT '앞단 CDN/WAF에서 전달한 국가코드',
  `asn` varchar(20) DEFAULT NULL COMMENT '앞단 CDN/WAF에서 전달한 ASN',
  `cache_source` varchar(20) DEFAULT NULL COMMENT 'DB / FILE / EMPTY 등 차단 규칙 캐시 출처',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그 시각',
  `source_action_type` varchar(40) DEFAULT NULL COMMENT '차단 규칙 생성 조치 유형',
  `source_action_group_id` varchar(36) DEFAULT NULL COMMENT '같은 보안 조치 묶음 ID',
  `source_user_idx` bigint DEFAULT NULL COMMENT '규칙 생성 당시 기준 사용자 PK',
  `source_ip_address` varchar(45) DEFAULT NULL COMMENT '규칙 생성 당시 기준 IP',
  `is_source_user_match` tinyint(1) DEFAULT NULL COMMENT '요청 사용자와 기준 사용자가 일치하는지',
  `is_source_ip_match` tinyint(1) DEFAULT NULL COMMENT '요청 IP와 기준 IP가 일치하는지',
  `is_source_user_ip_intersection` tinyint(1) DEFAULT NULL COMMENT '기준 사용자와 기준 IP가 모두 일치하는지',
  `source_assessment_idx` bigint DEFAULT NULL COMMENT '차단 원천 보안 판단 ID',
  PRIMARY KEY (`block_access_idx`),
  KEY `idx_bal_request_id` (`request_id`),
  KEY `idx_bal_user_created` (`user_idx`,`created_at`),
  KEY `idx_bal_ip_created` (`ip_address`,`created_at`),
  KEY `idx_bal_kind_created` (`block_kind`,`created_at`),
  KEY `idx_bal_match_created` (`block_match_type`,`created_at`),
  KEY `idx_bal_target_key` (`block_target_key`),
  KEY `idx_bal_rule_idx` (`block_rule_idx`),
  KEY `idx_bal_country_created` (`country_code`,`created_at`),
  KEY `idx_bal_asn_created` (`asn`,`created_at`),
  KEY `idx_bal_created_at` (`created_at`),
  KEY `idx_bal_source_action_group` (`source_action_group_id`,`created_at`),
  KEY `idx_bal_source_user_ip` (`source_user_idx`,`source_ip_address`,`created_at`),
  KEY `idx_bal_source_intersection` (`is_source_user_ip_intersection`,`created_at`),
  KEY `idx_bal_source_assessment` (`source_assessment_idx`),
  CONSTRAINT `fk_bal_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='IP/회원 차단으로 거부된 요청 전용 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.BUSINESS_ACCOUNT_APPLICATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `BUSINESS_ACCOUNT_APPLICATION` (
  `application_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `requested_role` varchar(30) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `business_number` varchar(50) DEFAULT NULL,
  `manager_name` varchar(50) DEFAULT NULL,
  `manager_phone` varchar(30) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `application_status` varchar(30) NOT NULL DEFAULT 'PENDING',
  `reject_reason` varchar(500) DEFAULT NULL,
  `reviewed_by_user_idx` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_idx`),
  KEY `fk_business_application_user` (`user_idx`),
  KEY `fk_business_application_reviewer` (`reviewed_by_user_idx`),
  CONSTRAINT `fk_business_application_reviewer` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`),
  CONSTRAINT `fk_business_application_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHAT_COMMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHAT_COMMENT` (
  `chat_comment_idx` bigint NOT NULL AUTO_INCREMENT,
  `chat_post_idx` bigint NOT NULL,
  `user_idx` bigint NOT NULL,
  `comment_role` varchar(10) NOT NULL DEFAULT 'USER',
  `content` longtext NOT NULL,
  `comment_order` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_comment_idx`),
  UNIQUE KEY `uq_chat_comment_order` (`chat_post_idx`,`comment_order`),
  KEY `fk_chat_comment_user` (`user_idx`),
  CONSTRAINT `fk_chat_comment_post` FOREIGN KEY (`chat_post_idx`) REFERENCES `CHAT_POST` (`chat_post_idx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_comment_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHAT_POST 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHAT_POST` (
  `chat_post_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_post_idx`),
  KEY `fk_chat_post_user` (`user_idx`),
  CONSTRAINT `fk_chat_post_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_BLOCK 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_BLOCK` (
  `block_id` bigint NOT NULL AUTO_INCREMENT,
  `block_type` enum('USER','IP') COLLATE utf8mb4_unicode_ci NOT NULL,
  `block_value` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'user_idx(문자) 또는 IP',
  `reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blocked_by` bigint DEFAULT NULL COMMENT '처리 관리자 user_idx',
  `blocked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL COMMENT 'NULL=영구',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`block_id`),
  UNIQUE KEY `uk_active_type_value` (`is_active`,`block_type`,`block_value`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='챗봇 전용 차단 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_CONVERSATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_CONVERSATION` (
  `conversation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '대화 PK',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 유저 (anon_session_id와 XOR)',
  `anon_session_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비로그인 HTTP 세션 ID',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '새 대화' COMMENT '대화 제목 (첫 메시지 prefix)',
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '최초 생성 IP',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_active` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '유저 소프트 삭제 여부',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`conversation_id`),
  KEY `idx_user` (`user_idx`,`is_deleted`,`last_active` DESC),
  KEY `idx_anon` (`anon_session_id`,`is_deleted`,`last_active` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='챗봇 대화 그룹';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_DAILY_USAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_DAILY_USAGE` (
  `usage_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비로그인 식별자 (IP 주소, IPv6 포함)',
  `period_start` datetime NOT NULL COMMENT '현재 주기의 시작 시각(KST)',
  `message_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`usage_id`),
  UNIQUE KEY `uk_user_period` (`user_idx`,`period_start`),
  UNIQUE KEY `uk_ip_period` (`ip_address`,`period_start`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='일일 사용량 집계';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_GRADE_QUOTA 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_GRADE_QUOTA` (
  `quota_id` int NOT NULL AUTO_INCREMENT,
  `grade` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'GUEST/BRONZE/SILVER/GOLD/DIAMOND/PLATINUM',
  `max_conversations` int NOT NULL DEFAULT '5' COMMENT '동시 보유 대화 수 한도',
  `max_messages_per_period` int NOT NULL COMMENT '주기당 메시지 한도',
  `max_context_messages` int NOT NULL DEFAULT '10' COMMENT 'AI에 전달할 최근 메시지 수',
  `period_days` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '한도 주기 (일: 1/2/3/4/5/7/14/30)',
  `reset_hour` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '리셋 시각 시 (0-23)',
  `reset_minute` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '리셋 시각 분 (0-59)',
  `quota_refund_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `updated_by` bigint DEFAULT NULL COMMENT '마지막 수정 관리자',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`quota_id`),
  UNIQUE KEY `grade` (`grade`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='등급별 챗봇 한도';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_LINK_CLICK 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_LINK_CLICK` (
  `click_id` bigint NOT NULL AUTO_INCREMENT COMMENT '클릭 로그 PK',
  `message_id` bigint NOT NULL COMMENT '링크가 포함된 assistant 메시지',
  `conversation_id` bigint NOT NULL COMMENT '대화 PK (조회 최적화용 denormalize)',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 유저 (anon_session_id와 XOR)',
  `anon_session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비로그인 HTTP 세션 ID',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '클릭된 내부 URL',
  `label` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '버튼 라벨',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '클릭 시점 IP (IPv6 포함)',
  `clicked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`click_id`),
  KEY `idx_clicked_at` (`clicked_at` DESC),
  KEY `idx_url` (`url`),
  KEY `idx_user` (`user_idx`,`clicked_at` DESC),
  KEY `idx_anon` (`anon_session_id`,`clicked_at` DESC),
  KEY `idx_conv` (`conversation_id`,`clicked_at` DESC),
  KEY `idx_msg` (`message_id`),
  CONSTRAINT `fk_chatbot_click_conv` FOREIGN KEY (`conversation_id`) REFERENCES `CHATBOT_CONVERSATION` (`conversation_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chatbot_click_msg` FOREIGN KEY (`message_id`) REFERENCES `CHATBOT_MESSAGE` (`message_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='챗봇 링크 클릭 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CHATBOT_MESSAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `CHATBOT_MESSAGE` (
  `message_id` bigint NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint NOT NULL,
  `role` enum('user','assistant') COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_inappropriate` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'AI가 부적절 판단한 유저 메시지',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `idx_conv` (`conversation_id`,`created_at`),
  KEY `idx_inappropriate` (`is_inappropriate`,`created_at` DESC),
  CONSTRAINT `fk_chatbot_msg_conv` FOREIGN KEY (`conversation_id`) REFERENCES `CHATBOT_CONVERSATION` (`conversation_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='챗봇 메시지';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_COMMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_COMMENT` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '댓글 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `user_idx` bigint NOT NULL COMMENT '작성자 ID (USERS.user_idx 참조)',
  `content` varchar(500) NOT NULL COMMENT '댓글 내용',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '댓글 작성 IP',
  `comment_status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE/DELETED)',
  `like_count` int NOT NULL DEFAULT '0' COMMENT '댓글 좋아요 수',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  `parent_comment_id` bigint DEFAULT NULL COMMENT '부모 댓글 ID (NULL이면 일반 댓글)',
  `report_count` int DEFAULT '0',
  `ai_flagged` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `idx_cc_post` (`post_id`),
  KEY `idx_cc_user` (`user_idx`),
  KEY `idx_cc_status` (`comment_status`),
  KEY `idx_cc_created` (`created_at`),
  KEY `fk_comment_parent` (`parent_comment_id`),
  CONSTRAINT `fk_cc_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cc_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `COMMUNITY_COMMENT` (`comment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='댓글';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_COMMENT_LIKE 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_COMMENT_LIKE` (
  `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '좋아요 PK',
  `comment_id` bigint NOT NULL COMMENT 'COMMUNITY_COMMENT.comment_id 참조',
  `user_idx` bigint NOT NULL COMMENT 'USERS.user_idx 참조',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 일시',
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `uq_comment_like` (`comment_id`,`user_idx`),
  CONSTRAINT `fk_comment_like_comment` FOREIGN KEY (`comment_id`) REFERENCES `COMMUNITY_COMMENT` (`comment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='댓글 좋아요';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '게시글 ID',
  `user_idx` bigint NOT NULL COMMENT '작성자 ID (USERS.user_idx 참조)',
  `title` varchar(100) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '본문',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '게시글 작성 IP',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일시',
  `region` enum('asia','europe','africa','north_america','south_america','oceania','etc') NOT NULL DEFAULT 'etc' COMMENT '지역',
  `post_type` varchar(20) NOT NULL DEFAULT 'review' COMMENT '유형 (review/photo/tip/question)',
  `post_status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE/BLOCKED/DELETED)',
  `view_count` int NOT NULL DEFAULT '0' COMMENT '조회수',
  `like_count` int NOT NULL DEFAULT '0' COMMENT '좋아요 수 캐시',
  `comment_count` int NOT NULL DEFAULT '0' COMMENT '댓글 수 캐시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  `report_count` int DEFAULT '0' COMMENT '신고 수',
  `is_solved` tinyint DEFAULT NULL COMMENT '해결 여부 (question 타입만, NULL=비해당)',
  `solved_at` datetime DEFAULT NULL COMMENT '해결 처리 일시',
  `accepted_comment_id` bigint DEFAULT NULL COMMENT '채택된 댓글 ID',
  `tip_category` varchar(20) DEFAULT NULL COMMENT '팁 카테고리 (tip 타입만, NULL=비해당)',
  `ai_flagged` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `idx_cp_user` (`user_idx`),
  KEY `idx_cp_created` (`created_at` DESC),
  KEY `idx_cpd_region` (`region`),
  KEY `idx_cpd_type` (`post_type`),
  KEY `idx_cpd_status` (`post_status`),
  KEY `idx_cpd_like` (`like_count` DESC),
  CONSTRAINT `fk_cp_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='커뮤니티 게시글';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST_IMAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST_IMAGE` (
  `image_id` bigint NOT NULL AUTO_INCREMENT COMMENT '이미지 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `image_url` varchar(500) NOT NULL COMMENT '이미지 경로',
  `sort_order` int NOT NULL DEFAULT '1' COMMENT '이미지 순서 (1번이 대표 이미지)',
  `is_auto` tinyint NOT NULL DEFAULT '0' COMMENT '자동추천 이미지 여부 (0=유저업로드, 1=Pixabay자동)',
  PRIMARY KEY (`image_id`),
  KEY `idx_cpi_post` (`post_id`),
  KEY `idx_cpi_order` (`post_id`,`sort_order`),
  CONSTRAINT `fk_cpi_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시글 이미지 (여러 장 지원)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST_LIKE 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST_LIKE` (
  `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '좋아요 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `user_idx` bigint NOT NULL COMMENT '사용자 ID (USERS.user_idx 참조)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 일시',
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `uq_comm_like` (`post_id`,`user_idx`),
  KEY `idx_cpl_post` (`post_id`),
  KEY `idx_cpl_user` (`user_idx`),
  CONSTRAINT `fk_cpl_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cpl_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='커뮤니티 게시글 좋아요 (독자 관리)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST_TAG 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST_TAG` (
  `post_tag_id` bigint NOT NULL AUTO_INCREMENT COMMENT '연결 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `tag_id` int NOT NULL COMMENT '태그 ID (COMMUNITY_TAG.tag_id 참조)',
  PRIMARY KEY (`post_tag_id`),
  UNIQUE KEY `uq_post_tag` (`post_id`,`tag_id`),
  KEY `idx_cpt_post` (`post_id`),
  KEY `idx_cpt_tag` (`tag_id`),
  CONSTRAINT `fk_cpt_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cpt_tag` FOREIGN KEY (`tag_id`) REFERENCES `COMMUNITY_TAG` (`tag_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시글-태그 연결';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_TAG 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_TAG` (
  `tag_id` int NOT NULL AUTO_INCREMENT COMMENT '태그 ID',
  `tag_name` varchar(50) NOT NULL COMMENT '태그명 (예: 도쿄) - UNIQUE',
  `use_count` int NOT NULL DEFAULT '0' COMMENT '사용 횟수 (인기 태그 조회용)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 등록일시',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `uq_tag_name` (`tag_name`),
  KEY `idx_tag_use_count` (`use_count` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=9111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_TAG_RELATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_TAG_RELATION` (
  `relation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '관계 ID',
  `tag_id_a` int NOT NULL COMMENT '태그 A (작은 ID)',
  `tag_id_b` int NOT NULL COMMENT '태그 B (큰 ID)',
  `co_count` int NOT NULL DEFAULT '1' COMMENT '공출현 횟수',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '마지막 업데이트',
  PRIMARY KEY (`relation_id`),
  UNIQUE KEY `uq_tag_relation` (`tag_id_a`,`tag_id_b`),
  KEY `idx_ctr_a` (`tag_id_a`),
  KEY `idx_ctr_b` (`tag_id_b`),
  CONSTRAINT `fk_ctr_a` FOREIGN KEY (`tag_id_a`) REFERENCES `COMMUNITY_TAG` (`tag_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ctr_b` FOREIGN KEY (`tag_id_b`) REFERENCES `COMMUNITY_TAG` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 공출현 관계';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.CONTENT_MODERATION_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `CONTENT_MODERATION_POLICY` (
  `id` tinyint NOT NULL DEFAULT '1' COMMENT '단일 행 고정 (항상 1)',
  `toxicity_level` enum('STRICT','NORMAL','LOOSE') NOT NULL DEFAULT 'NORMAL' COMMENT 'Perspective API 민감도 단계',
  `post_window_minutes` int NOT NULL DEFAULT '5' COMMENT '게시글 도배 차단 시간창(분)',
  `post_max_count` int NOT NULL DEFAULT '3' COMMENT '게시글 도배 차단 허용 개수',
  `comment_window_minutes` int NOT NULL DEFAULT '1' COMMENT '댓글 도배 차단 시간창(분)',
  `comment_max_count` int NOT NULL DEFAULT '5' COMMENT '댓글 도배 차단 허용 개수',
  `inquiry_window_minutes` int NOT NULL DEFAULT '10' COMMENT '문의 도배 차단 시간창(분)',
  `inquiry_max_count` int NOT NULL DEFAULT '3' COMMENT '문의 도배 차단 허용 개수',
  `report_threshold` int NOT NULL DEFAULT '3' COMMENT '신고 누적 BLUR 임계값 (이 값 이상이면 일반 사용자에게 BLUR 처리)',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '최종 수정 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '최종 수정한 관리자 PK',
  PRIMARY KEY (`id`),
  CONSTRAINT `cmp_id_check` CHECK ((`id` = 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='콘텐츠 검열 정책 (단일 행)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EMAIL_VERIFICATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `EMAIL_VERIFICATION` (
  `verify_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '인증 PK',
  `email_verification_request_idx` bigint DEFAULT NULL COMMENT '연결된 이메일 인증 요청 PK (EMAIL_VERIFICATION_REQUEST.email_verification_request_idx)',
  `request_id` varchar(36) DEFAULT NULL COMMENT '연결된 이메일 인증 요청 식별자(UUID). 요청 단위 추적용',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 동일 이메일 액션 흐름 식별자(UUID)',
  `user_idx` bigint DEFAULT NULL COMMENT '회원 PK (비회원 아이디찾기는 NULL 가능)',
  `email` varchar(255) NOT NULL COMMENT '인증 대상 이메일',
  `token` varchar(255) NOT NULL COMMENT 'UUID 토큰',
  `purpose` varchar(20) NOT NULL COMMENT '발급 목적',
  `expired_at` datetime NOT NULL COMMENT '만료 시각 (발급 + 30분)',
  `cancelled_at` datetime DEFAULT NULL COMMENT '신규 요청 발급 등으로 인해 무효 처리된 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '토큰 레코드의 마지막 상태 변경 시각',
  `used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '사용 여부',
  `used_at` datetime DEFAULT NULL COMMENT '토큰 사용 완료 시각',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verify_idx`),
  UNIQUE KEY `token` (`token`),
  KEY `fk_verify_user` (`user_idx`),
  KEY `idx_verify_request_fk` (`email_verification_request_idx`),
  KEY `idx_verify_request_id` (`request_id`),
  KEY `idx_verify_purpose_created` (`purpose`,`created_at`),
  KEY `idx_verify_expired_at` (`expired_at`),
  KEY `idx_verify_flow_trace_id` (`flow_trace_id`),
  CONSTRAINT `fk_verify_request` FOREIGN KEY (`email_verification_request_idx`) REFERENCES `EMAIL_VERIFICATION_REQUEST` (`email_verification_request_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_verify_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='이메일 인증 토큰 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EMAIL_VERIFICATION_REQUEST 구조 내보내기
CREATE TABLE IF NOT EXISTS `EMAIL_VERIFICATION_REQUEST` (
  `email_verification_request_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '이메일 인증 요청 PK',
  `request_id` varchar(36) NOT NULL COMMENT '회원정보 수정 단위의 요청 식별자(UUID)',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 동일 이메일 액션 흐름 식별자(UUID)',
  `user_idx` bigint DEFAULT NULL COMMENT '이메일 액션 요청 대상 사용자 PK (식별 가능 시)',
  `purpose` varchar(30) NOT NULL COMMENT '인증 목적 (예: PROFILE_EMAIL)',
  `pending_email` varchar(255) NOT NULL COMMENT '저장 전 인증 대상 이메일',
  `token` varchar(255) NOT NULL COMMENT '이메일 인증 링크용 토큰',
  `status` varchar(20) NOT NULL DEFAULT 'REQUESTED' COMMENT '요청 상태 (REQUESTED / VERIFIED / APPLIED / EXPIRED / CANCELLED)',
  `requested_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '인증 요청 시각',
  `verified_at` datetime DEFAULT NULL COMMENT '사용자가 이메일 링크를 눌러 인증 완료한 시각',
  `applied_at` datetime DEFAULT NULL COMMENT '인증된 이메일이 실제 USERS 테이블에 반영된 시각',
  `expired_at` datetime NOT NULL COMMENT '인증 요청 만료 시각',
  `cancelled_at` datetime DEFAULT NULL COMMENT '신규 요청 등으로 인해 무효 처리된 시각',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '인증 요청 당시 클라이언트 IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '인증 요청 당시 User-Agent',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 상태 변경 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '레코드 생성 시각',
  PRIMARY KEY (`email_verification_request_idx`),
  UNIQUE KEY `uk_email_verification_request_token` (`token`),
  KEY `idx_evreq_request_id` (`request_id`),
  KEY `idx_evreq_user_purpose_status` (`user_idx`,`purpose`,`status`),
  KEY `idx_evreq_user_email` (`user_idx`,`pending_email`),
  KEY `idx_evreq_expired_at` (`expired_at`),
  KEY `idx_evreq_requested_at` (`requested_at`),
  KEY `idx_evreq_token` (`token`),
  KEY `idx_evreq_user_created` (`user_idx`,`created_at`),
  KEY `idx_evreq_purpose_requested` (`purpose`,`requested_at`),
  KEY `idx_evreq_flow_trace_id` (`flow_trace_id`),
  CONSTRAINT `fk_email_verification_request_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원정보 수정 과정에서 저장 전 이메일 인증 상태를 추적하는 요청 이력 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EXP_LEVEL_OVERRIDE 구조 내보내기
CREATE TABLE IF NOT EXISTS `EXP_LEVEL_OVERRIDE` (
  `exp_level_override_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '레벨 경험치 오버라이드 PK',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `level_no` int NOT NULL COMMENT '대상 레벨',
  `required_total_exp` bigint NOT NULL COMMENT '해당 레벨 달성에 필요한 누적 경험치',
  `reason` varchar(255) DEFAULT NULL COMMENT '오버라이드 사유',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`exp_level_override_idx`),
  UNIQUE KEY `uq_elo_level` (`level_no`),
  KEY `fk_elo_created_by` (`created_by_user_idx`),
  KEY `fk_elo_updated_by` (`updated_by_user_idx`),
  KEY `idx_elo_active` (`is_active`),
  CONSTRAINT `fk_elo_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_elo_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='특정 레벨의 필요 누적 경험치를 수동 지정하는 오버라이드 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EXP_LEVEL_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `EXP_LEVEL_POLICY` (
  `exp_level_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '레벨 성장 정책 PK',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `policy_mode` varchar(20) NOT NULL COMMENT '정책 방식 (QUADRATIC / EXPONENTIAL / HYBRID)',
  `quadratic_a` decimal(12,4) DEFAULT NULL COMMENT '2차 성장식 계수 a (누적 경험치 = a*(L-1)^2 + b*(L-1) + c)',
  `quadratic_b` decimal(12,4) DEFAULT NULL COMMENT '2차 성장식 계수 b',
  `quadratic_c` decimal(12,4) DEFAULT '0.0000' COMMENT '2차 성장식 계수 c',
  `exp_base` decimal(12,4) DEFAULT NULL COMMENT '지수식 기본 경험치',
  `exp_rate` decimal(12,6) DEFAULT NULL COMMENT '지수식 증가율',
  `hybrid_switch_level` int DEFAULT NULL COMMENT 'HYBRID 방식일 때 지수식/혼합 전환 레벨',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `description` varchar(500) DEFAULT NULL COMMENT '정책 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`exp_level_policy_idx`),
  KEY `fk_elp_created_by` (`created_by_user_idx`),
  KEY `fk_elp_updated_by` (`updated_by_user_idx`),
  KEY `idx_elp_active` (`is_active`),
  CONSTRAINT `fk_elp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_elp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='레벨 자동 성장 공식 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EXP_REWARD_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `EXP_REWARD_POLICY` (
  `exp_reward_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '보상 정책 PK',
  `reward_code` varchar(30) NOT NULL COMMENT '보상 코드 (COMMUNITY_POST / COMMUNITY_COMMENT / SPOT_REVIEW / SPOT_REVIEW_COMMENT / PAYMENT)',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `reward_type` varchar(20) NOT NULL COMMENT '지급 방식 (FIXED / PER_AMOUNT)',
  `reward_value` int NOT NULL COMMENT '지급 값 (FIXED면 경험치, PER_AMOUNT면 기준당 경험치)',
  `unit_amount` bigint DEFAULT NULL COMMENT 'PER_AMOUNT일 때 기준 금액 (예: 1000원)',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `description` varchar(500) DEFAULT NULL COMMENT '정책 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`exp_reward_policy_idx`),
  UNIQUE KEY `reward_code` (`reward_code`),
  KEY `fk_erp_created_by` (`created_by_user_idx`),
  KEY `fk_erp_updated_by` (`updated_by_user_idx`),
  KEY `idx_erp_active` (`is_active`),
  KEY `idx_erp_reward_code` (`reward_code`),
  CONSTRAINT `fk_erp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_erp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='행동/결제별 경험치 지급 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.FLIGHT_PURCHASE_SIMULATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `FLIGHT_PURCHASE_SIMULATION` (
  `flight_purchase_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '항공권 구매 시뮬레이션 PK',
  `purchase_no` varchar(40) NOT NULL COMMENT '화면 표시용 예매번호',
  `user_idx` bigint NOT NULL COMMENT '구매 회원 PK',
  `spot_idx` bigint NOT NULL COMMENT '여행지 PK',
  `offer_id` varchar(80) NOT NULL COMMENT 'Mock/API 항공권 견적 ID',
  `provider_type` varchar(30) NOT NULL DEFAULT 'MOCK' COMMENT '항공권 제공자 유형',
  `payment_idx` bigint DEFAULT NULL COMMENT '연결된 결제 내역 PK(USER_PAYMENT_HISTORY.payment_idx)',
  `airline_name` varchar(100) NOT NULL COMMENT '항공사명',
  `flight_no` varchar(30) NOT NULL COMMENT '편명',
  `origin_airport_code` varchar(10) NOT NULL COMMENT '출발 공항 코드',
  `destination_airport_code` varchar(10) NOT NULL COMMENT '도착 공항 코드',
  `departure_time` datetime NOT NULL COMMENT '출발 시각',
  `arrival_time` datetime NOT NULL COMMENT '도착 시각',
  `trip_type` varchar(20) NOT NULL DEFAULT 'ROUND_TRIP' COMMENT '항공권 유형: ONE_WAY / ROUND_TRIP',
  `return_airline_name` varchar(100) DEFAULT NULL COMMENT '귀국편 항공사명',
  `return_flight_no` varchar(30) DEFAULT NULL COMMENT '귀국편 편명',
  `return_origin_airport_code` varchar(10) DEFAULT NULL COMMENT '귀국편 출발 공항 코드',
  `return_destination_airport_code` varchar(10) DEFAULT NULL COMMENT '귀국편 도착 공항 코드',
  `return_departure_time` datetime DEFAULT NULL COMMENT '귀국편 출발 시각',
  `return_arrival_time` datetime DEFAULT NULL COMMENT '귀국편 도착 시각',
  `outbound_price` bigint NOT NULL DEFAULT '0' COMMENT '가는 편 금액',
  `return_price` bigint NOT NULL DEFAULT '0' COMMENT '오는 편 금액',
  `total_price` bigint NOT NULL COMMENT '총 결제 금액',
  `used_cash` bigint NOT NULL DEFAULT '0' COMMENT '사용 캐시',
  `used_mileage` bigint NOT NULL DEFAULT '0' COMMENT '사용 마일리지',
  `status` varchar(20) NOT NULL DEFAULT 'COMPLETED' COMMENT '상태',
  `cancel_reason` varchar(500) DEFAULT NULL COMMENT '항공권 예매 취소 사유',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`flight_purchase_idx`),
  UNIQUE KEY `uq_flight_purchase_no` (`purchase_no`),
  KEY `idx_flight_purchase_user_created` (`user_idx`,`created_at`),
  KEY `idx_flight_purchase_spot_created` (`spot_idx`,`created_at`),
  KEY `idx_flight_purchase_payment_idx` (`payment_idx`),
  CONSTRAINT `fk_flight_purchase_payment` FOREIGN KEY (`payment_idx`) REFERENCES `USER_PAYMENT_HISTORY` (`payment_idx`),
  CONSTRAINT `fk_flight_purchase_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_flight_purchase_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='항공권 구매 시뮬레이션 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.INQUIRY 구조 내보내기
CREATE TABLE IF NOT EXISTS `INQUIRY` (
  `inquiry_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `inquiry_status` varchar(20) NOT NULL DEFAULT 'WAITING',
  `answer_content` text,
  `answered_by_user_idx` bigint DEFAULT NULL,
  `answered_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inquiry_id`),
  KEY `fk_inquiry_user` (`user_idx`),
  KEY `fk_inquiry_answer_user` (`answered_by_user_idx`),
  CONSTRAINT `fk_inquiry_answer_user` FOREIGN KEY (`answered_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_inquiry_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.INQUIRY_ANSWER 구조 내보내기
CREATE TABLE IF NOT EXISTS `INQUIRY_ANSWER` (
  `answer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '답변 PK',
  `inquiry_id` bigint NOT NULL COMMENT 'INQUIRY_POST.inquiry_id 참조',
  `admin_user_idx` bigint NOT NULL COMMENT '답변한 운영진 USERS.user_idx',
  `content` text NOT NULL COMMENT '답변 내용',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '답변일',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`answer_id`),
  UNIQUE KEY `uq_inquiry_answer` (`inquiry_id`),
  KEY `fk_inquiry_answer_admin` (`admin_user_idx`),
  CONSTRAINT `fk_inquiry_answer_admin` FOREIGN KEY (`admin_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_inquiry_answer_post` FOREIGN KEY (`inquiry_id`) REFERENCES `INQUIRY_POST` (`inquiry_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 답변';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.INQUIRY_ANSWER_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `INQUIRY_ANSWER_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '이력 PK',
  `answer_id` bigint DEFAULT NULL COMMENT '대상 답변 FK (답변 삭제 시 NULL)',
  `inquiry_id` bigint NOT NULL COMMENT '문의 FK (조회 편의용)',
  `prev_content` text NOT NULL COMMENT '변경 전 본문',
  `prev_admin_user_idx` bigint NOT NULL COMMENT '변경 전 답변자',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '변경 시각',
  `changed_by` bigint NOT NULL COMMENT '변경/삭제 수행 어드민',
  `change_type` varchar(10) NOT NULL COMMENT 'UPDATE / DELETE',
  PRIMARY KEY (`history_idx`),
  KEY `idx_iah_answer` (`answer_id`,`changed_at` DESC),
  KEY `idx_iah_inquiry` (`inquiry_id`,`changed_at` DESC),
  KEY `fk_iah_changed_by` (`changed_by`),
  CONSTRAINT `fk_iah_answer` FOREIGN KEY (`answer_id`) REFERENCES `INQUIRY_ANSWER` (`answer_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_iah_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_iah_inquiry` FOREIGN KEY (`inquiry_id`) REFERENCES `INQUIRY_POST` (`inquiry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 답변 변경 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.INQUIRY_ATTACHMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `INQUIRY_ATTACHMENT` (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '첨부파일 ID',
  `inquiry_id` bigint NOT NULL COMMENT '문의 ID',
  `file_url` varchar(500) NOT NULL COMMENT '파일 경로',
  `file_name` varchar(200) NOT NULL COMMENT '원본 파일명',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '업로드 시간',
  PRIMARY KEY (`attachment_id`),
  KEY `idx_attachment_inquiry` (`inquiry_id`),
  CONSTRAINT `fk_attachment_inquiry` FOREIGN KEY (`inquiry_id`) REFERENCES `INQUIRY_POST` (`inquiry_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 첨부파일';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.INQUIRY_POST 구조 내보내기
CREATE TABLE IF NOT EXISTS `INQUIRY_POST` (
  `inquiry_id` bigint NOT NULL AUTO_INCREMENT COMMENT '문의 PK',
  `user_idx` bigint NOT NULL COMMENT 'USERS.user_idx 참조',
  `title` varchar(200) NOT NULL COMMENT '문의 제목',
  `content` text NOT NULL COMMENT '문의 내용',
  `category` varchar(20) NOT NULL DEFAULT 'etc' COMMENT '문의 유형 (service/payment/account/bug/etc)',
  `is_private` tinyint NOT NULL DEFAULT '0' COMMENT '비공개 여부 (0=공개, 1=비공개)',
  `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT '처리 상태 (PENDING/IN_PROGRESS/COMPLETED)',
  `view_count` int NOT NULL DEFAULT '0' COMMENT '조회수',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `in_progress_at` datetime DEFAULT NULL COMMENT '처리중 전환 시간',
  `completed_at` datetime DEFAULT NULL COMMENT '완료 처리 시간',
  `cancelled_at` datetime DEFAULT NULL COMMENT '유저 취소 시간',
  `delete_requested_at` datetime DEFAULT NULL COMMENT '삭제 요청 시간',
  `visibility_requested_at` datetime DEFAULT NULL COMMENT '공개/비공개 요청 시간',
  `ai_flagged` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`inquiry_id`),
  KEY `idx_inquiry_post_user` (`user_idx`),
  KEY `idx_inquiry_post_status` (`status`),
  CONSTRAINT `fk_inquiry_post_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 게시글';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.IP_BLOCK_BATCH 구조 내보내기
CREATE TABLE IF NOT EXISTS `IP_BLOCK_BATCH` (
  `ip_block_batch_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'IP 차단 배치 PK',
  `batch_code` varchar(50) NOT NULL COMMENT '배치 코드 (예: VPN_FEED_202604 / SPAM_FEED_20260401)',
  `batch_name` varchar(100) NOT NULL COMMENT '배치명',
  `source_type` varchar(50) NOT NULL COMMENT '배치 출처 유형 (MANUAL / VPN_FEED / SPAM_FEED / GEO_POLICY / AUTO_DETECTION)',
  `source_name` varchar(255) DEFAULT NULL COMMENT '출처명 (예: known VPN ranges / 운영자 수동 등록)',
  `batch_rule_action` varchar(10) NOT NULL DEFAULT 'BLOCK' COMMENT '배치 기본 규칙 동작 (BLOCK / ALLOW)',
  `default_rule_priority` int NOT NULL DEFAULT '1' COMMENT '배치 기본 우선순위',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '배치 활성 여부',
  `description` varchar(500) DEFAULT NULL COMMENT '설명',
  `default_disable_strategy` varchar(50) NOT NULL DEFAULT 'BATCH_ONLY' COMMENT '배치 OFF 기본 전략 (BATCH_ONLY / CASCADE_ACTIVE_RULES)',
  `default_enable_strategy` varchar(50) NOT NULL DEFAULT 'BATCH_ONLY' COMMENT '배치 ON 기본 전략 (BATCH_ONLY / RESTORE_BATCH_CONTROL / FORCE_ENABLE_ALL)',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`ip_block_batch_idx`),
  UNIQUE KEY `batch_code` (`batch_code`),
  KEY `fk_ibb_created_by` (`created_by_user_idx`),
  KEY `fk_ibb_updated_by` (`updated_by_user_idx`),
  KEY `idx_ibb_active_source` (`is_active`,`source_type`),
  CONSTRAINT `fk_ibb_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ibb_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='전역 IP 차단 규칙을 배치 단위로 묶어 관리하는 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.IP_BLOCK_BATCH_OPERATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `IP_BLOCK_BATCH_OPERATION` (
  `ip_block_batch_operation_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '배치 작업 PK',
  `ip_block_batch_idx` bigint NOT NULL COMMENT '대상 배치 PK',
  `operation_type` varchar(50) NOT NULL COMMENT '작업 종류 (BATCH_ACTIVATE / BATCH_DEACTIVATE / BATCH_BIND_RULE / BATCH_UNBIND_RULE / RESTORE_BATCH_CONTROL)',
  `operation_option` varchar(50) NOT NULL COMMENT '작업 옵션 (BATCH_ONLY / CASCADE_ACTIVE_RULES / RESTORE_BATCH_CONTROL / FORCE_ENABLE_ALL / KEEP_MANUAL_OVERRIDE)',
  `requested_rule_count` int NOT NULL DEFAULT '0' COMMENT '대상으로 잡힌 규칙 수',
  `affected_rule_count` int NOT NULL DEFAULT '0' COMMENT '실제 변경된 규칙 수',
  `description` varchar(500) DEFAULT NULL COMMENT '관리자 메모',
  `requested_by_user_idx` bigint DEFAULT NULL COMMENT '작업 요청 관리자 PK',
  `requested_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작업 시각',
  PRIMARY KEY (`ip_block_batch_operation_idx`),
  KEY `idx_ibbo_batch_time` (`ip_block_batch_idx`,`requested_at`),
  KEY `fk_ibbo_requested_by` (`requested_by_user_idx`),
  CONSTRAINT `fk_ibbo_batch` FOREIGN KEY (`ip_block_batch_idx`) REFERENCES `IP_BLOCK_BATCH` (`ip_block_batch_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_ibbo_requested_by` FOREIGN KEY (`requested_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='IP 차단 배치 작업 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.IP_BLOCK_BATCH_OPERATION_RULE 구조 내보내기
CREATE TABLE IF NOT EXISTS `IP_BLOCK_BATCH_OPERATION_RULE` (
  `ip_block_batch_operation_rule_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '배치 작업 규칙 상세 PK',
  `ip_block_batch_operation_idx` bigint NOT NULL COMMENT '배치 작업 PK',
  `ip_blocklist_idx` bigint NOT NULL COMMENT '대상 규칙 PK',
  `operation_effect` varchar(50) NOT NULL COMMENT '규칙별 결과 (NO_CHANGE / BATCH_ONLY / RULE_DISABLED / RULE_ENABLED / SKIPPED_MANUAL_OVERRIDE)',
  `before_is_active` tinyint(1) NOT NULL COMMENT '작업 전 개별 활성 상태',
  `after_is_active` tinyint(1) NOT NULL COMMENT '작업 후 개별 활성 상태',
  `before_control_mode` varchar(20) DEFAULT NULL COMMENT '작업 전 제어 모드',
  `after_control_mode` varchar(20) DEFAULT NULL COMMENT '작업 후 제어 모드',
  `memo` varchar(500) DEFAULT NULL COMMENT '상세 메모',
  PRIMARY KEY (`ip_block_batch_operation_rule_idx`),
  KEY `idx_ibbor_operation` (`ip_block_batch_operation_idx`),
  KEY `idx_ibbor_rule` (`ip_blocklist_idx`),
  CONSTRAINT `fk_ibbor_operation` FOREIGN KEY (`ip_block_batch_operation_idx`) REFERENCES `IP_BLOCK_BATCH_OPERATION` (`ip_block_batch_operation_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_ibbor_rule` FOREIGN KEY (`ip_blocklist_idx`) REFERENCES `IP_BLOCKLIST` (`ip_blocklist_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='배치 작업 시 규칙별 변경 상세';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.IP_BLOCKLIST 구조 내보내기
CREATE TABLE IF NOT EXISTS `IP_BLOCKLIST` (
  `ip_blocklist_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'IP_BLOCKLIST PK',
  `ip_address` varchar(45) NOT NULL COMMENT '차단된 IP 주소',
  `block_request_id` varchar(36) DEFAULT NULL COMMENT '연결된 USER_BLOCK_HISTORY.block_request_id',
  `block_target_key` varchar(120) DEFAULT NULL COMMENT '차단 규칙 식별 키 (예: IP:1.2.3.4 / CIDR:203.0.113.0/24 / RANGE:1.1.1.1~1.1.1.255 / COUNTRY:CN / ASN:AS12345)',
  `rule_action` varchar(10) NOT NULL DEFAULT 'BLOCK' COMMENT '규칙 동작 (BLOCK / ALLOW)',
  `control_mode` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT '제어 모드 (MANUAL / BATCH / MANUAL_OVERRIDE)',
  `rule_origin_type` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT '최초 생성 출처 (MANUAL / FEED / AUTO / MIGRATION / POLICY)',
  `source_history_block_idx` bigint DEFAULT NULL COMMENT '원본 USER_BLOCK_HISTORY.block_idx',
  `source_blocklist_idx` bigint DEFAULT NULL COMMENT '원본 USER_BLOCKLIST.block_idx',
  `ip_block_batch_idx` bigint DEFAULT NULL COMMENT '연결된 IP_BLOCK_BATCH PK',
  `batch_bound_at` datetime DEFAULT NULL COMMENT '배치에 편입된 시각',
  `batch_bound_by_user_idx` bigint DEFAULT NULL COMMENT '배치에 편입한 관리자 PK',
  `batch_detached_at` datetime DEFAULT NULL COMMENT '배치에서 분리된 시각',
  `batch_detached_by_user_idx` bigint DEFAULT NULL COMMENT '배치에서 분리한 관리자 PK',
  `match_type` varchar(30) NOT NULL DEFAULT 'SINGLE_IP' COMMENT '매칭 방식 (SINGLE_IP / CIDR / RANGE / COUNTRY / ASN)',
  `cidr_notation` varchar(64) DEFAULT NULL COMMENT 'CIDR 표기 (예: 203.0.113.0/24)',
  `range_start_ip` varchar(45) DEFAULT NULL COMMENT 'IP 범위 시작값',
  `range_end_ip` varchar(45) DEFAULT NULL COMMENT 'IP 범위 끝값',
  `country_code` varchar(10) DEFAULT NULL COMMENT '국가 코드(예: CN / RU / VN). 전역 정책성 차단 참고용',
  `asn` varchar(20) DEFAULT NULL COMMENT 'ASN 코드',
  `source_scope` varchar(30) NOT NULL DEFAULT 'GLOBAL' COMMENT '차단 출처 범위 (GLOBAL / USER_ACTION / AUTO_DETECTION)',
  `block_category` varchar(30) NOT NULL DEFAULT 'SPAM' COMMENT '차단 분류 (SPAM / ABUSE / BRUTE_FORCE / GEO / VPN / MANUAL / SECURITY)',
  `user_idx` bigint DEFAULT NULL COMMENT '연관 회원 PK (회원+IP 차단일 때 사용)',
  `block_type` varchar(20) DEFAULT NULL COMMENT '연관 차단 유형 (IP_ONLY / USER_IP)',
  `blocked_by_user_idx` bigint DEFAULT NULL COMMENT '차단 처리 관리자 PK',
  `blocked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '차단 일시',
  `reason` varchar(500) DEFAULT NULL COMMENT '차단 사유',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '현재 유효한 IP 차단 여부',
  `is_effective_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '현재 실제 평가 대상 여부',
  `effective_status` varchar(50) NOT NULL DEFAULT 'EFFECTIVE' COMMENT 'EFFECTIVE / RULE_INACTIVE / BATCH_INACTIVE / EXPIRED',
  `effective_status_reason` varchar(500) DEFAULT NULL COMMENT '최종 상태 설명',
  `effective_synced_at` datetime DEFAULT NULL COMMENT '최종 상태 동기화 시각',
  `effective_synced_by_source` varchar(30) NOT NULL DEFAULT 'SYSTEM' COMMENT 'SYSTEM / ADMIN / BATCH / SCHEDULER / MIGRATION',
  `expires_at` datetime DEFAULT NULL COMMENT 'IP 차단 만료 시각',
  `released_at` datetime DEFAULT NULL COMMENT 'IP 차단 해제 시각',
  `released_by_user_idx` bigint DEFAULT NULL COMMENT 'IP 차단 해제 관리자 PK',
  `manual_override_by_user_idx` bigint DEFAULT NULL COMMENT '배치 규칙을 개별 예외 처리한 관리자 PK',
  `manual_override_at` datetime DEFAULT NULL COMMENT '배치 규칙을 개별 예외 처리한 시각',
  `manual_override_reason` varchar(255) DEFAULT NULL COMMENT '배치 규칙을 개별 예외 처리한 사유',
  `last_control_action` varchar(50) NOT NULL DEFAULT 'CREATE' COMMENT '마지막 제어 작업 (CREATE / BATCH_BIND / BATCH_UNBIND / MANUAL_ENABLE / MANUAL_DISABLE / RETURN_TO_BATCH / FORCE_ENABLE)',
  `last_control_by_user_idx` bigint DEFAULT NULL COMMENT '마지막 제어 작업 관리자 PK',
  `last_control_at` datetime DEFAULT NULL COMMENT '마지막 제어 작업 시각',
  `last_control_reason` varchar(255) DEFAULT NULL COMMENT '마지막 제어 작업 사유',
  `risk_score` int DEFAULT NULL COMMENT '위험 점수(0~100). 자동 탐지/운영 판단 참고용',
  `is_auto_block` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'AUTO_DETECTION으로 인한 자동 차단인지 여부',
  `auto_block_source` varchar(50) DEFAULT NULL COMMENT '자동 차단 주체/출처 (RULE / AI / POLICY_SYNC / FEED 등)',
  `detail_message` varchar(1000) DEFAULT NULL COMMENT '상세 메모',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선순위. 높을수록 먼저 평가',
  `last_synced_at` datetime DEFAULT NULL COMMENT '마지막 동기화 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정 시각',
  `source_action_type` varchar(40) DEFAULT NULL COMMENT '차단 조치 유형. 예: USER_AND_IP_BLOCK',
  `source_action_group_id` varchar(36) DEFAULT NULL COMMENT '같은 보안 조치 묶음 ID',
  `source_user_idx` bigint DEFAULT NULL COMMENT '조치 기준 사용자 PK',
  `source_ip_address` varchar(45) DEFAULT NULL COMMENT '조치 기준 IP',
  PRIMARY KEY (`ip_blocklist_idx`),
  KEY `fk_ipb_blocked_by` (`blocked_by_user_idx`),
  KEY `fk_ipb_released_by` (`released_by_user_idx`),
  KEY `fk_ipb_source_history` (`source_history_block_idx`),
  KEY `fk_ipb_source_blocklist` (`source_blocklist_idx`),
  KEY `idx_ipb_request_id` (`block_request_id`),
  KEY `idx_ipb_ip_active` (`ip_address`,`is_active`),
  KEY `idx_ipb_user_active` (`user_idx`,`is_active`),
  KEY `idx_ipb_active_expires` (`is_active`,`expires_at`),
  KEY `idx_ipb_match_type_active` (`match_type`,`is_active`),
  KEY `idx_ipb_scope_category` (`source_scope`,`block_category`,`is_active`),
  KEY `idx_ipb_batch_active` (`ip_block_batch_idx`,`is_active`),
  KEY `idx_ipb_country_active` (`country_code`,`is_active`),
  KEY `idx_ipb_asn_active` (`asn`,`is_active`),
  KEY `idx_ipb_target_key` (`block_target_key`),
  KEY `idx_ipb_action_mode_active` (`rule_action`,`control_mode`,`is_active`),
  KEY `idx_ipb_batch_mode_active` (`ip_block_batch_idx`,`control_mode`,`is_active`),
  KEY `idx_ipb_action_priority_active` (`rule_action`,`priority`,`is_active`),
  KEY `fk_ipb_batch_bound_by_user` (`batch_bound_by_user_idx`),
  KEY `fk_ipb_batch_detached_by_user` (`batch_detached_by_user_idx`),
  KEY `fk_ipb_manual_override_by_user` (`manual_override_by_user_idx`),
  KEY `fk_ipb_last_control_by_user` (`last_control_by_user_idx`),
  KEY `idx_ipb_effective_status` (`is_effective_active`,`effective_status`),
  KEY `idx_ipb_batch_effective_status` (`ip_block_batch_idx`,`is_effective_active`,`effective_status`),
  KEY `idx_ipb_source_action_group` (`source_action_group_id`,`blocked_at`),
  KEY `idx_ipb_source_user_ip` (`source_user_idx`,`source_ip_address`,`blocked_at`),
  CONSTRAINT `fk_ipb_batch` FOREIGN KEY (`ip_block_batch_idx`) REFERENCES `IP_BLOCK_BATCH` (`ip_block_batch_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_batch_bound_by_user` FOREIGN KEY (`batch_bound_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_batch_detached_by_user` FOREIGN KEY (`batch_detached_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_blocked_by` FOREIGN KEY (`blocked_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_last_control_by_user` FOREIGN KEY (`last_control_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_manual_override_by_user` FOREIGN KEY (`manual_override_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_released_by` FOREIGN KEY (`released_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_source_blocklist` FOREIGN KEY (`source_blocklist_idx`) REFERENCES `USER_BLOCKLIST` (`block_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_source_history` FOREIGN KEY (`source_history_block_idx`) REFERENCES `USER_BLOCK_HISTORY` (`block_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ipb_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4058 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='IP 차단 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LEVEL_UP_REWARD_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `LEVEL_UP_REWARD_POLICY` (
  `level_up_reward_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '레벨업 보상 정책 PK',
  `reward_code` varchar(50) NOT NULL COMMENT '보상 코드',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `level_no` int NOT NULL COMMENT '보상 지급 레벨',
  `reward_type` varchar(30) NOT NULL COMMENT '보상 유형 (POINT / MILEAGE / CASH / ITEM)',
  `reward_amount` bigint DEFAULT NULL COMMENT '수치형 보상 값',
  `item_code` varchar(50) DEFAULT NULL COMMENT '아이템 보상일 경우 POINT_SHOP_ITEM.item_code',
  `is_repeatable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '반복 지급 가능 여부',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `sort_order` int NOT NULL DEFAULT '1' COMMENT '같은 레벨 내 노출/처리 순서',
  `description` varchar(500) DEFAULT NULL COMMENT '정책 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선순위',
  PRIMARY KEY (`level_up_reward_policy_idx`),
  UNIQUE KEY `uq_lurp_reward_code` (`reward_code`),
  KEY `idx_lurp_level_active` (`level_no`,`is_active`),
  KEY `idx_lurp_item_code` (`item_code`),
  KEY `fk_lurp_created_by` (`created_by_user_idx`),
  KEY `fk_lurp_updated_by` (`updated_by_user_idx`),
  CONSTRAINT `fk_lurp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_lurp_item_code` FOREIGN KEY (`item_code`) REFERENCES `POINT_SHOP_ITEM` (`item_code`) ON DELETE SET NULL,
  CONSTRAINT `fk_lurp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='레벨업 보상 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_AI_ASSESSMENT 구조 내보내기
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 AI 판단 결과/스텁';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_COUNTER 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_COUNTER` (
  `counter_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `subject_type` varchar(20) NOT NULL COMMENT 'USER / IP',
  `subject_key` varchar(120) NOT NULL,
  `attempt_count` int NOT NULL DEFAULT '0',
  `action_type` varchar(40) DEFAULT NULL,
  `blocked_until` datetime DEFAULT NULL,
  `detail_message` varchar(1000) DEFAULT NULL,
  `observed_started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_event_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`counter_idx`),
  UNIQUE KEY `uk_lrc_policy_subject` (`policy_code`,`subject_type`,`subject_key`),
  KEY `idx_lrc_subject` (`subject_type`,`subject_key`),
  KEY `idx_lrc_blocked_until` (`blocked_until`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 카운터/일시 제한 상태';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_EVENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_EVENT` (
  `event_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `event_type` varchar(40) NOT NULL COMMENT 'WARNING / THRESHOLD_REACHED / PROTECTION_REQUIRED / REVIEW_CREATED',
  `subject_type` varchar(20) NOT NULL,
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `login_identifier` varchar(255) DEFAULT NULL,
  `threshold_count` int DEFAULT NULL,
  `observed_count` int DEFAULT NULL,
  `action_type` varchar(40) DEFAULT NULL,
  `decision_status` varchar(30) DEFAULT NULL COMMENT 'RECORDED / AUTO_APPLIED / REVIEW_PENDING',
  `review_required` tinyint(1) NOT NULL DEFAULT '0',
  `blocked_until` datetime DEFAULT NULL,
  `request_id` varchar(36) DEFAULT NULL,
  `flow_trace_id` varchar(36) DEFAULT NULL,
  `detail_message` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_idx`),
  KEY `idx_lre_policy_created` (`policy_code`,`created_at`),
  KEY `idx_lre_user_created` (`user_idx`,`created_at`),
  KEY `idx_lre_ip_created` (`ip_address`,`created_at`),
  KEY `idx_lre_request_id` (`request_id`),
  CONSTRAINT `fk_lre_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 정책 판정 이벤트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_EXTERNAL_ASSESSMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_EXTERNAL_ASSESSMENT` (
  `assessment_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_kind` varchar(40) NOT NULL COMMENT 'AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / ASSESSMENT_PIPELINE',
  `source_code` varchar(80) NOT NULL COMMENT '판단 모듈/기관/알고리즘 코드',
  `source_name` varchar(160) NOT NULL COMMENT '판단 출처 표시명',
  `source_version` varchar(60) DEFAULT NULL,
  `source_type` varchar(40) DEFAULT NULL COMMENT 'LOGIN_RISK_EVENT / LOGIN_RISK_REVIEW 등',
  `source_id` bigint DEFAULT NULL,
  `policy_code` varchar(60) DEFAULT NULL,
  `subject_type` varchar(30) NOT NULL COMMENT 'USER / IP / IP_RANGE / ASN / COUNTRY',
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `asn` varchar(20) DEFAULT NULL,
  `risk_score` int DEFAULT NULL COMMENT '0~100 위험 점수',
  `risk_level` varchar(20) DEFAULT NULL COMMENT 'LOW / MEDIUM / HIGH / CRITICAL / PENDING',
  `confidence_score` int DEFAULT NULL COMMENT '0~100 신뢰도',
  `recommendation_action` varchar(40) DEFAULT NULL COMMENT 'MONITOR / REVIEW / LOCK_ACCOUNT / BLOCK_IP / BLOCK_CIDR / ALLOW',
  `recommendation_reason` varchar(500) DEFAULT NULL,
  `evidence_summary` varchar(1000) DEFAULT NULL,
  `decision_status` varchar(30) NOT NULL DEFAULT 'PROPOSED' COMMENT 'PROPOSED / APPLIED / IGNORED / PENDING',
  `raw_payload` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessment_idx`),
  KEY `idx_lrea_source_kind_created` (`source_kind`,`created_at`),
  KEY `idx_lrea_risk_level_created` (`risk_level`,`created_at`),
  KEY `idx_lrea_decision_status` (`decision_status`,`created_at`),
  KEY `idx_lrea_subject` (`subject_type`,`subject_key`,`created_at`),
  KEY `idx_lrea_source_ref` (`source_type`,`source_id`),
  KEY `idx_lrea_user_created` (`user_idx`,`created_at`),
  KEY `idx_lrea_ip_created` (`ip_address`,`created_at`),
  CONSTRAINT `fk_lrea_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 외부/보조 판단 결과';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `policy_name` varchar(120) NOT NULL,
  `policy_type` varchar(40) NOT NULL COMMENT 'ACCOUNT_FAILURE / ACCOUNT_LOCK_REPEAT / IP_FAILURE / IP_REVIEW / IP_BURST',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `observation_minutes` int DEFAULT NULL COMMENT 'NULL/0이면 기간 제한 없이 카운트',
  `threshold_count` int DEFAULT NULL,
  `distinct_account_threshold` int DEFAULT NULL COMMENT 'IP 기반 정책에서 서로 다른 로그인 식별자 수',
  `lock_duration_minutes` int DEFAULT NULL COMMENT 'NULL/0이면 운영자 해제 전까지 유지',
  `warning_before_count` int DEFAULT NULL COMMENT '임계값 도달 전 경고를 시작할 남은 횟수',
  `reset_on_success` tinyint(1) NOT NULL DEFAULT '1',
  `action_type` varchar(40) NOT NULL COMMENT 'WARN / ACCOUNT_TEMP_LOCK / ACCOUNT_PROTECTION_REQUIRED / IP_LOGIN_LOCK / ADMIN_REVIEW / AUTO_IP_BLOCK',
  `require_admin_review` tinyint(1) NOT NULL DEFAULT '0',
  `review_severity` varchar(20) DEFAULT 'MEDIUM',
  `notification_category` varchar(60) DEFAULT 'LOGIN_RISK',
  `description` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ai_assist_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'AI 판단 보조 사용 여부',
  `ai_risk_score_threshold` int DEFAULT NULL COMMENT 'AI 위험 점수 기준값',
  `waf_sync_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '승인 후 WAF/CDN 동기화 후보 생성 여부',
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uk_lrp_policy_code` (`policy_code`),
  KEY `idx_lrp_active_type` (`is_active`,`policy_type`),
  KEY `idx_lrp_ai_waf` (`ai_assist_enabled`,`waf_sync_enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 실패/위험 판단 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_POLICY_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_POLICY_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '로그인 위험 정책 변경 이력 PK',
  `policy_idx` bigint NOT NULL COMMENT 'LOGIN_RISK_POLICY.policy_idx',
  `policy_code` varchar(80) NOT NULL COMMENT '정책 코드',
  `version_no` int NOT NULL COMMENT '정책별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / IMPORT / RESET',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 정책 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 정책 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_lrph_policy_version` (`policy_idx`,`version_no`),
  KEY `idx_lrph_code_created` (`policy_code`,`created_at`),
  KEY `idx_lrph_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_lrph_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_lrph_policy` FOREIGN KEY (`policy_idx`) REFERENCES `LOGIN_RISK_POLICY` (`policy_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 정책 변경 이력/버전';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_REVIEW_QUEUE 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_REVIEW_QUEUE` (
  `review_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `review_type` varchar(40) NOT NULL COMMENT 'ACCOUNT_PROTECTION / IP_LOGIN_RISK / IP_BURST',
  `severity` varchar(20) DEFAULT 'MEDIUM',
  `subject_type` varchar(20) NOT NULL,
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `request_id` varchar(36) DEFAULT NULL,
  `flow_trace_id` varchar(36) DEFAULT NULL,
  `summary` varchar(300) NOT NULL,
  `detail_message` varchar(1000) DEFAULT NULL,
  `review_status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING / APPROVED / REJECTED / HOLD',
  `reviewed_by_user_idx` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_comment` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_idx`),
  KEY `idx_lrr_status_created` (`review_status`,`created_at`),
  KEY `idx_lrr_policy_created` (`policy_code`,`created_at`),
  KEY `idx_lrr_user_created` (`user_idx`,`created_at`),
  KEY `idx_lrr_ip_created` (`ip_address`,`created_at`),
  KEY `fk_lrr_reviewed_by` (`reviewed_by_user_idx`),
  CONSTRAINT `fk_lrr_reviewed_by` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_lrr_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 검토가 필요한 로그인 위험 건';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.LOGIN_RISK_WAF_SYNC_QUEUE 구조 내보내기
CREATE TABLE IF NOT EXISTS `LOGIN_RISK_WAF_SYNC_QUEUE` (
  `sync_idx` bigint NOT NULL AUTO_INCREMENT,
  `source_type` varchar(40) NOT NULL COMMENT 'LOGIN_RISK_REVIEW 등',
  `source_id` bigint DEFAULT NULL COMMENT '원천 검토/이벤트 ID',
  `sync_action` varchar(20) NOT NULL COMMENT 'BLOCK / ALLOW / REMOVE',
  `target_type` varchar(20) NOT NULL COMMENT 'IP / CIDR / COUNTRY / ASN',
  `target_value` varchar(120) NOT NULL,
  `status` varchar(40) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING / SYNCED / FAILED / SKIPPED / EXTERNAL_PROVIDER_PENDING',
  `detail_message` varchar(1000) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sync_idx`),
  KEY `idx_lrws_status_created` (`status`,`created_at`),
  KEY `idx_lrws_target` (`target_type`,`target_value`),
  KEY `idx_lrws_source` (`source_type`,`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='외부 WAF/CDN 동기화 후보 큐';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.MEMBER_GRADE_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `MEMBER_GRADE_POLICY` (
  `member_grade_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '회원 등급 정책 PK',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `member_grade` varchar(20) NOT NULL COMMENT '정책이 적용되는 대상 회원 등급 (BRONZE / SILVER / GOLD / DIAMOND / PLATINUM)',
  `min_monthly_payment` bigint NOT NULL COMMENT '직전 달 최소 결제액',
  `discount_rate` decimal(5,2) NOT NULL COMMENT '할인율 (%)',
  `sort_order` int NOT NULL COMMENT '등급 정렬 순서',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `description` varchar(500) DEFAULT NULL COMMENT '정책 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`member_grade_idx`),
  UNIQUE KEY `member_grade` (`member_grade`),
  KEY `fk_mgp_created_by` (`created_by_user_idx`),
  KEY `fk_mgp_updated_by` (`updated_by_user_idx`),
  KEY `idx_mgp_active_sort` (`is_active`,`sort_order`),
  CONSTRAINT `fk_mgp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_mgp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='직전 달 결제액 기준 회원 등급 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.MYPAGE_FEED_NOTIFICATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `MYPAGE_FEED_NOTIFICATION` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL COMMENT '알림 받을 유저',
  `source_type` varchar(20) NOT NULL COMMENT 'community / inquiry / plan / ...',
  `source_id` bigint NOT NULL COMMENT 'post_id / inquiry_id / ...',
  `message` varchar(200) NOT NULL COMMENT '알림 메시지',
  `target_url` varchar(255) DEFAULT NULL COMMENT '알림 클릭 시 이동할 상대경로 (contextPath 제외)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` tinyint NOT NULL DEFAULT '0' COMMENT '읽음 여부 (0:안읽음, 1:읽음)',
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_read` (`user_idx`),
  KEY `idx_user_unread` (`user_idx`,`is_read`,`created_at` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='마이페이지 피드 알림';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.plan_spot 구조 내보내기
CREATE TABLE IF NOT EXISTS `plan_spot` (
  `plan_spot_id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint NOT NULL,
  `spot_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `place_name` varchar(255) NOT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_order` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plan_spot_id`),
  UNIQUE KEY `uq_plan_spot_order` (`plan_id`,`visit_date`,`visit_order`) USING BTREE,
  KEY `fk_plan_spot_spot` (`spot_id`),
  CONSTRAINT `fk_plan_spot_plan` FOREIGN KEY (`plan_id`) REFERENCES `TRAVEL_PLAN` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_plan_spot_spot` FOREIGN KEY (`spot_id`) REFERENCES `SPOT_TRAVEL` (`spot_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=616 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.POINT_REWARD_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `POINT_REWARD_POLICY` (
  `point_reward_policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 지급 정책 PK',
  `reward_code` varchar(30) NOT NULL COMMENT '보상 코드 (COMMUNITY_POST / COMMUNITY_COMMENT / SPOT_REVIEW / SPOT_REVIEW_COMMENT 등)',
  `policy_name` varchar(100) NOT NULL COMMENT '정책명',
  `reward_type` varchar(20) NOT NULL COMMENT '지급 방식 (FIXED / PER_AMOUNT)',
  `reward_value` int NOT NULL COMMENT '지급 값 (FIXED면 포인트, PER_AMOUNT면 기준당 포인트)',
  `unit_amount` bigint DEFAULT NULL COMMENT 'PER_AMOUNT일 때 기준 값 (예: 1000)',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 여부',
  `description` varchar(500) DEFAULT NULL COMMENT '정책 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선도. 높을수록 우선순위가 높음',
  PRIMARY KEY (`point_reward_policy_idx`),
  UNIQUE KEY `reward_code` (`reward_code`),
  KEY `fk_prp_created_by` (`created_by_user_idx`),
  KEY `fk_prp_updated_by` (`updated_by_user_idx`),
  KEY `idx_prp_active` (`is_active`),
  CONSTRAINT `fk_prp_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_prp_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='행동별 포인트 지급 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.POINT_SHOP_ITEM 구조 내보내기
CREATE TABLE IF NOT EXISTS `POINT_SHOP_ITEM` (
  `point_shop_item_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 상점 아이템 PK',
  `item_code` varchar(50) NOT NULL COMMENT '아이템 코드',
  `item_name` varchar(100) NOT NULL COMMENT '아이템명',
  `item_type` varchar(30) NOT NULL COMMENT '아이템 유형 (EMOTICON / BADGE / EFFECT 등)',
  `point_price` bigint NOT NULL COMMENT '포인트 가격',
  `is_repeatable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '중복 구매 가능 여부',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '판매 여부',
  `item_payload_json` json DEFAULT NULL COMMENT '아이템 메타데이터(JSON)',
  `description` varchar(255) DEFAULT NULL COMMENT '아이템 설명',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`point_shop_item_idx`),
  UNIQUE KEY `item_code` (`item_code`),
  KEY `fk_psi_created_by` (`created_by_user_idx`),
  KEY `fk_psi_updated_by` (`updated_by_user_idx`),
  KEY `idx_psi_type_active` (`item_type`,`is_active`),
  CONSTRAINT `fk_psi_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_psi_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='포인트 상점 아이템';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.POLICY_CHANGE_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `POLICY_CHANGE_HISTORY` (
  `policy_change_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '정책 변경 이력 PK',
  `policy_type` varchar(50) NOT NULL COMMENT '정책 유형 (EXP_REWARD / EXP_LEVEL / EXP_LEVEL_OVERRIDE / MEMBER_GRADE / ADMIN_POSITION 등)',
  `policy_key` varchar(100) NOT NULL COMMENT '정책 식별 키 (예: COMMUNITY_POST / GOLD / LEVEL_10)',
  `change_type` varchar(20) NOT NULL COMMENT '변경 유형 (CREATE / UPDATE / DELETE / ACTIVATE / DEACTIVATE)',
  `before_value_json` json DEFAULT NULL COMMENT '변경 전 값 JSON',
  `after_value_json` json DEFAULT NULL COMMENT '변경 후 값 JSON',
  `changed_by_user_idx` bigint DEFAULT NULL COMMENT '변경한 관리자 PK',
  `change_reason` varchar(255) DEFAULT NULL COMMENT '변경 사유',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '변경 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`policy_change_history_idx`),
  KEY `idx_pch_policy_type_key` (`policy_type`,`policy_key`,`changed_at`),
  KEY `idx_pch_changed_by` (`changed_by_user_idx`,`changed_at`),
  KEY `idx_pch_changed_at` (`changed_at`),
  CONSTRAINT `fk_pch_changed_by` FOREIGN KEY (`changed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='각종 운영 정책의 생성/수정/비활성화 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.REPORT 구조 내보내기
CREATE TABLE IF NOT EXISTS `REPORT` (
  `report_id` bigint NOT NULL AUTO_INCREMENT COMMENT '신고 PK (자동 증가)',
  `user_idx` bigint NOT NULL COMMENT '신고한 유저 FK →\r\n  USERS.user_idx',
  `target_type` varchar(20) NOT NULL COMMENT '신고 대상 유형 (POST /\r\n  COMMENT / REPLY / USER)',
  `target_id` bigint NOT NULL COMMENT '신고 대상의 PK',
  `reason` varchar(50) DEFAULT NULL COMMENT '신고 사유 카테고리 (예:\r\n  스팸, 욕설, 음란물)',
  `description` varchar(500) DEFAULT NULL COMMENT '신고자가 직접 입력한 상세\r\n  설명',
  `status` varchar(20) NOT NULL DEFAULT 'IN_REVIEW' COMMENT '처리 상태 (IN_REVIEW /\r\n  RESOLVED / DISMISSED)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '신고 접수 시각',
  `resolved_at` datetime DEFAULT NULL COMMENT '처리 완료 시각 (관리자\r\n  기입)',
  `updated_at` datetime DEFAULT NULL COMMENT '마지막 수정 시각 (관리자\r\n  기입)',
  `resolver_idx` bigint DEFAULT NULL COMMENT '처리한 관리자 FK →\r\n  USERS.user_idx',
  `resolve_action` varchar(50) DEFAULT NULL COMMENT '처리 결과 (예: 경고,\r\n  게시글삭제, 계정정지)',
  `source_type` varchar(20) DEFAULT NULL COMMENT '신고 출처 모듈 (예:\r\n  COMMUNITY, INQUIRY)',
  `source_id` bigint DEFAULT NULL COMMENT '출처 모듈 내 컨텍스트 ID\r\n  (예: 댓글이 속한 게시글 ID)',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `uq_report` (`user_idx`,`target_type`,`target_id`),
  KEY `resolver_idx` (`resolver_idx`),
  CONSTRAINT `REPORT_ibfk_1` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`),
  CONSTRAINT `REPORT_ibfk_2` FOREIGN KEY (`resolver_idx`) REFERENCES `USERS` (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='신고게시판';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SALARY_CHANGE_AUDIT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SALARY_CHANGE_AUDIT` (
  `salary_change_audit_idx` bigint NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(40) NOT NULL COMMENT '동일 업로드 묶음 ID (UUID)',
  `target_user_idx` bigint NOT NULL COMMENT '대상 관리자 PK',
  `target_user_email` varchar(200) NOT NULL COMMENT '매칭 시점 이메일',
  `field_name` varchar(30) NOT NULL COMMENT 'adminSeniority/Tier/Level/Band/Grade/Step',
  `old_value` varchar(50) DEFAULT NULL,
  `new_value` varchar(50) DEFAULT NULL,
  `changed_by_user_idx` bigint DEFAULT NULL COMMENT '업로드 수행 SuperAdmin',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`salary_change_audit_idx`),
  KEY `idx_sca_target` (`target_user_idx`),
  KEY `idx_sca_batch` (`batch_id`),
  KEY `idx_sca_changed_at` (`changed_at`),
  KEY `fk_sca_changed_by` (`changed_by_user_idx`),
  CONSTRAINT `fk_sca_changed_by` FOREIGN KEY (`changed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_sca_target` FOREIGN KEY (`target_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='급여/역량 일괄 변경 감사 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SCHEMA_MIGRATION_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SCHEMA_MIGRATION_HISTORY` (
  `migration_id` varchar(120) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `checksum_hint` varchar(128) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'APPLIED' COMMENT 'APPLIED / FAILED / ROLLED_BACK / MANUAL_CHECK_REQUIRED',
  `applied_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `applied_by` varchar(100) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`migration_id`),
  KEY `idx_smh_status_applied` (`status`,`applied_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='수동 SQL 마이그레이션 적용 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_ACTION_APPEAL 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_ACTION_APPEAL` (
  `appeal_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint DEFAULT NULL,
  `target_type` varchar(40) NOT NULL COMMENT 'USER_BLOCK / IP_BLOCK / CONTENT_MODERATION',
  `target_key` varchar(160) NOT NULL,
  `source_assessment_idx` bigint DEFAULT NULL,
  `appeal_status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING / ACCEPTED / REJECTED / HOLD',
  `appeal_title` varchar(200) NOT NULL,
  `appeal_content` varchar(2000) NOT NULL,
  `reviewed_by_user_idx` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_comment` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `appeal_token_idx` bigint DEFAULT NULL COMMENT 'SECURITY_ACTION_APPEAL_TOKEN.token_idx',
  `block_request_id` varchar(36) DEFAULT NULL COMMENT '차단 규칙 생성 요청 ID',
  `block_access_request_id` varchar(36) DEFAULT NULL COMMENT '차단 접근 로그 request_id',
  `inquiry_id` bigint DEFAULT NULL COMMENT '연동된 비공개 문의 ID',
  `submitter_email` varchar(200) DEFAULT NULL COMMENT '비로그인/토큰 접수 연락 이메일',
  `public_request_id` varchar(40) DEFAULT NULL COMMENT '사용자에게 표시하는 접수번호',
  PRIMARY KEY (`appeal_idx`),
  KEY `idx_saa2_status_created` (`appeal_status`,`created_at`),
  KEY `idx_saa2_user_created` (`user_idx`,`created_at`),
  KEY `idx_saa2_target` (`target_type`,`target_key`),
  KEY `idx_saa2_assessment` (`source_assessment_idx`),
  KEY `fk_security_action_appeal_reviewed_by` (`reviewed_by_user_idx`),
  KEY `idx_saa2_token` (`appeal_token_idx`),
  KEY `idx_saa2_block_request` (`block_request_id`),
  KEY `idx_saa2_block_access_request` (`block_access_request_id`),
  KEY `idx_saa2_public_request` (`public_request_id`),
  KEY `idx_saa2_inquiry` (`inquiry_id`),
  KEY `idx_saa2_duplicate_guard` (`target_type`,`target_key`,`block_access_request_id`,`appeal_status`),
  KEY `idx_saa_public_request` (`public_request_id`),
  CONSTRAINT `fk_security_action_appeal_reviewed_by` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_action_appeal_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 조치 이의제기/오탐 검토';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_ACTION_APPEAL_TOKEN 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_ACTION_APPEAL_TOKEN` (
  `token_idx` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `target_type` varchar(40) NOT NULL COMMENT 'USER_BLOCK / IP_BLOCK / CONTENT_MODERATION',
  `target_key` varchar(160) NOT NULL,
  `source_assessment_idx` bigint DEFAULT NULL,
  `block_request_id` varchar(36) DEFAULT NULL,
  `block_access_request_id` varchar(36) DEFAULT NULL,
  `submitter_email` varchar(320) DEFAULT NULL COMMENT '이의제기 제출 전 인증한 이메일',
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT 'ACTIVE / USED / EXPIRED / REVOKED',
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_idx`),
  UNIQUE KEY `uk_saat_token` (`token`),
  KEY `idx_saat_user_created` (`user_idx`,`created_at`),
  KEY `idx_saat_target` (`target_type`,`target_key`),
  KEY `idx_saat_status_expires` (`status`,`expires_at`),
  KEY `idx_saat_assessment` (`source_assessment_idx`),
  KEY `idx_saat_submitter_email_created` (`submitter_email`,`created_at`),
  CONSTRAINT `fk_security_action_appeal_token_assessment` FOREIGN KEY (`source_assessment_idx`) REFERENCES `SECURITY_RISK_ASSESSMENT` (`assessment_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_action_appeal_token_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 조치 이의제기 이메일/차단 안내 접수 토큰';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_ACTION_AUDIT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_ACTION_AUDIT` (
  `audit_idx` bigint NOT NULL AUTO_INCREMENT,
  `action_type` varchar(60) NOT NULL COMMENT 'SECURITY_REVIEW_APPROVED / ASSESSMENT_USER_BLOCK_APPLIED 등',
  `actor_user_idx` bigint DEFAULT NULL,
  `target_type` varchar(40) DEFAULT NULL,
  `target_key` varchar(160) DEFAULT NULL,
  `source_type` varchar(60) DEFAULT NULL,
  `source_id` bigint DEFAULT NULL,
  `summary` varchar(300) DEFAULT NULL,
  `detail_message` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason_code` varchar(100) DEFAULT NULL COMMENT '감사 사유 코드. 예: SECURITY.APPEAL.ACCEPTED',
  `reason_args` json DEFAULT NULL COMMENT '감사 사유 파라미터 JSON',
  PRIMARY KEY (`audit_idx`),
  KEY `idx_saa_action_created` (`action_type`,`created_at`),
  KEY `idx_saa_actor_created` (`actor_user_idx`,`created_at`),
  KEY `idx_saa_target` (`target_type`,`target_key`,`created_at`),
  KEY `idx_saa_source` (`source_type`,`source_id`),
  KEY `idx_saa_reason_code` (`reason_code`,`created_at`),
  CONSTRAINT `fk_security_action_audit_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 판단/검토/차단 집행 감사 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_APPEAL_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_APPEAL_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '보안 이의제기 정책 PK',
  `policy_code` varchar(60) NOT NULL DEFAULT 'DEFAULT' COMMENT '정책 코드. 현재 DEFAULT 단일 정책 사용',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '정책 활성 여부',
  `allow_multiple_open_appeals` tinyint(1) NOT NULL DEFAULT '1' COMMENT '동일 차단 건의 복수 PENDING/HOLD 접수 허용 여부',
  `max_open_appeals_per_case` int NOT NULL DEFAULT '3' COMMENT '동일 차단 건 동시 PENDING/HOLD 접수 허용 수',
  `closed_blocks_new_appeals` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'CLOSED 처리된 동일 차단 건의 추가 접수 차단 여부',
  `rejected_cooldown_minutes` int NOT NULL DEFAULT '10080' COMMENT 'REJECTED 후 재접수 제한 시간(분)',
  `max_rejected_count` int NOT NULL DEFAULT '2' COMMENT '동일 차단 건 최대 반려 횟수',
  `ip_daily_appeal_limit` int NOT NULL DEFAULT '3' COMMENT '동일 IP 대상 일일 이의제기 접수 제한',
  `verification_window_minutes` int NOT NULL DEFAULT '60' COMMENT '인증 메일 발송 제한 관찰 시간(분)',
  `max_verification_emails` int NOT NULL DEFAULT '3' COMMENT '동일 requestId/email 인증 메일 발송 한도',
  `verification_token_ttl_minutes` int NOT NULL DEFAULT '30' COMMENT '이메일 인증 링크 유효 시간(분)',
  `protected_appeal_token_ttl_days` int NOT NULL DEFAULT '7' COMMENT '계정 보호 조치 안내 메일의 이의제기 링크 유효 기간(일)',
  `result_lookup_window_minutes` int NOT NULL DEFAULT '60' COMMENT '결과 조회 실패 제한 관찰 시간(분)',
  `max_result_lookup_failures` int NOT NULL DEFAULT '5' COMMENT 'publicRequestId 결과 조회 실패 허용 횟수',
  `result_lookup_retention_days` int NOT NULL DEFAULT '365' COMMENT '비로그인 결과 조회 가능 기간(일). 0이면 제한 없음',
  `allowed_email_domains` varchar(1000) DEFAULT NULL COMMENT '허용 이메일 도메인 CSV. 비어 있으면 전체 허용',
  `blocked_email_domains` varchar(1000) DEFAULT NULL COMMENT '차단 이메일 도메인 CSV',
  `captcha_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'CAPTCHA/Turnstile 사용 준비 토글. 실제 연동은 별도 Provider',
  `captcha_provider_code` varchar(80) DEFAULT 'MOCK_TURNSTILE' COMMENT 'CAPTCHA Provider 코드',
  `description` varchar(1000) DEFAULT NULL COMMENT '관리자 설명',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uk_sap_policy_code` (`policy_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 이의제기 채널/쿨타임/rate-limit 전용 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_APPEAL_POLICY_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_APPEAL_POLICY_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '정책 변경 이력 PK',
  `policy_idx` bigint NOT NULL COMMENT 'SECURITY_APPEAL_POLICY.policy_idx',
  `policy_code` varchar(60) NOT NULL COMMENT '정책 코드',
  `version_no` int NOT NULL COMMENT '정책별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / RESET / IMPORT',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 정책 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 정책 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_saph_policy_version` (`policy_idx`,`version_no`),
  KEY `idx_saph_policy_created` (`policy_code`,`created_at`),
  KEY `idx_saph_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_saph_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_saph_policy` FOREIGN KEY (`policy_idx`) REFERENCES `SECURITY_APPEAL_POLICY` (`policy_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 이의제기 정책 변경 이력/버전';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_ASSESSMENT_PROVIDER_CONFIG 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_ASSESSMENT_PROVIDER_CONFIG` (
  `provider_idx` bigint NOT NULL AUTO_INCREMENT,
  `provider_code` varchar(80) NOT NULL,
  `provider_kind` varchar(40) NOT NULL COMMENT 'AI_MODEL / POLICY_AUTHORITY / RULE_ALGORITHM',
  `provider_name` varchar(160) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `endpoint_url` varchar(500) DEFAULT NULL,
  `api_key_ref` varchar(160) DEFAULT NULL COMMENT '실제 키값이 아니라 환경변수명/Secret Manager 참조명',
  `model_name` varchar(160) DEFAULT NULL,
  `timeout_millis` int NOT NULL DEFAULT '3000',
  `fail_open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1이면 Provider 실패 시 운영 차단하지 않음',
  `status` varchar(30) NOT NULL DEFAULT 'DISABLED' COMMENT 'DISABLED / READY_NEEDS_SECRET / READY / ERROR',
  `description` varchar(1000) DEFAULT NULL,
  `last_checked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`provider_idx`),
  UNIQUE KEY `uk_sapc_provider_code` (`provider_code`),
  KEY `idx_sapc_enabled_kind` (`is_enabled`,`provider_kind`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 판단 Provider 연결 설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'Provider 설정 변경 이력 PK',
  `provider_idx` bigint NOT NULL COMMENT 'SECURITY_ASSESSMENT_PROVIDER_CONFIG.provider_idx',
  `provider_code` varchar(80) NOT NULL COMMENT 'Provider 코드',
  `provider_kind` varchar(40) NOT NULL COMMENT 'Provider 종류',
  `version_no` int NOT NULL COMMENT 'Provider별 버전 번호',
  `change_type` varchar(30) NOT NULL COMMENT 'CREATE / UPDATE / HEALTH_CHECK / IMPORT / RESET',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수정 관리자 user_idx',
  `before_config_json` json DEFAULT NULL COMMENT '변경 전 설정 스냅샷',
  `after_config_json` json DEFAULT NULL COMMENT '변경 후 설정 스냅샷',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이력 생성 시각',
  PRIMARY KEY (`history_idx`),
  KEY `idx_sapch_provider_version` (`provider_idx`,`version_no`),
  KEY `idx_sapch_code_created` (`provider_code`,`created_at`),
  KEY `idx_sapch_kind_created` (`provider_kind`,`created_at`),
  KEY `idx_sapch_actor_created` (`actor_user_idx`,`created_at`),
  CONSTRAINT `fk_sapch_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_sapch_provider` FOREIGN KEY (`provider_idx`) REFERENCES `SECURITY_ASSESSMENT_PROVIDER_CONFIG` (`provider_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 평가 Provider 설정 변경 이력/버전';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_PROVIDER_HEALTH_CHECK_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_PROVIDER_HEALTH_CHECK_HISTORY` (
  `health_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'Provider 헬스체크 이력 PK',
  `provider_idx` bigint NOT NULL COMMENT 'SECURITY_ASSESSMENT_PROVIDER_CONFIG.provider_idx',
  `provider_code` varchar(80) NOT NULL COMMENT 'Provider 코드',
  `provider_kind` varchar(40) NOT NULL COMMENT 'Provider 종류',
  `check_source` varchar(30) NOT NULL COMMENT 'MANUAL / SCHEDULED',
  `status_before` varchar(30) DEFAULT NULL COMMENT '점검 전 상태',
  `status_after` varchar(30) NOT NULL COMMENT '점검 후 상태',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '수동 점검 관리자 user_idx. 스케줄러는 NULL',
  `detail_message` varchar(1000) DEFAULT NULL COMMENT '점검 상세 메시지',
  `checked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '점검 시각',
  PRIMARY KEY (`health_history_idx`),
  KEY `idx_sphh_provider_checked` (`provider_idx`,`checked_at`),
  KEY `idx_sphh_code_checked` (`provider_code`,`checked_at`),
  KEY `idx_sphh_kind_checked` (`provider_kind`,`checked_at`),
  KEY `idx_sphh_source_checked` (`check_source`,`checked_at`),
  KEY `idx_sphh_actor_checked` (`actor_user_idx`,`checked_at`),
  CONSTRAINT `fk_sphh_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_sphh_provider` FOREIGN KEY (`provider_idx`) REFERENCES `SECURITY_ASSESSMENT_PROVIDER_CONFIG` (`provider_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Provider 수동/스케줄러 헬스체크 결과 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_REVIEW_QUEUE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_REVIEW_QUEUE` (
  `review_idx` bigint NOT NULL AUTO_INCREMENT,
  `assessment_idx` bigint DEFAULT NULL,
  `review_type` varchar(40) NOT NULL COMMENT 'USER_SECURITY_REVIEW / ACCESS_ENVIRONMENT_REVIEW / CONTENT_MODERATION_REVIEW',
  `severity` varchar(20) DEFAULT 'MEDIUM',
  `subject_type` varchar(30) NOT NULL,
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `summary` varchar(300) NOT NULL,
  `detail_message` varchar(1000) DEFAULT NULL,
  `review_status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING / APPROVED / REJECTED / HOLD',
  `reviewed_by_user_idx` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_comment` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_idx`),
  KEY `idx_sr_status_created` (`review_status`,`created_at`),
  KEY `idx_sr_assessment` (`assessment_idx`),
  KEY `idx_sr_subject` (`subject_type`,`subject_key`,`created_at`),
  KEY `idx_sr_user_created` (`user_idx`,`created_at`),
  KEY `fk_security_review_queue_reviewed_by` (`reviewed_by_user_idx`),
  CONSTRAINT `fk_security_review_queue_assessment` FOREIGN KEY (`assessment_idx`) REFERENCES `SECURITY_RISK_ASSESSMENT` (`assessment_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_review_queue_reviewed_by` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_review_queue_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='일반 보안 위험 관리자 검토 큐';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SECURITY_RISK_ASSESSMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SECURITY_RISK_ASSESSMENT` (
  `assessment_idx` bigint NOT NULL AUTO_INCREMENT,
  `assessment_scope` varchar(40) NOT NULL COMMENT 'LOGIN_RISK / USER_SECURITY / CONTENT_MODERATION / IP_REPUTATION / POLICY_SYNC',
  `source_kind` varchar(40) NOT NULL COMMENT 'AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / ASSESSMENT_PIPELINE',
  `source_code` varchar(80) NOT NULL COMMENT '판단 모듈/기관/알고리즘 코드',
  `source_name` varchar(160) NOT NULL COMMENT '판단 출처 표시명',
  `source_version` varchar(60) DEFAULT NULL,
  `source_type` varchar(40) DEFAULT NULL COMMENT 'LOGIN_RISK_EVENT / LOGIN_RISK_REVIEW / REPORT / COMMUNITY_POST 등',
  `source_id` bigint DEFAULT NULL,
  `policy_code` varchar(60) DEFAULT NULL,
  `subject_type` varchar(30) NOT NULL COMMENT 'USER / IP / IP_RANGE / ASN / COUNTRY / CONTENT',
  `subject_key` varchar(120) NOT NULL,
  `user_idx` bigint DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `country_code` varchar(10) DEFAULT NULL,
  `asn` varchar(20) DEFAULT NULL,
  `content_type` varchar(40) DEFAULT NULL,
  `content_id` bigint DEFAULT NULL,
  `risk_score` int DEFAULT NULL COMMENT '0~100 위험 점수',
  `risk_level` varchar(20) DEFAULT NULL COMMENT 'LOW / MEDIUM / HIGH / CRITICAL / PENDING',
  `confidence_score` int DEFAULT NULL COMMENT '0~100 신뢰도',
  `recommendation_action` varchar(40) DEFAULT NULL COMMENT 'MONITOR / REVIEW / LOCK_ACCOUNT / BLOCK_USER / BLOCK_IP / BLOCK_CIDR / HIDE_CONTENT / ALLOW',
  `recommendation_reason` varchar(500) DEFAULT NULL,
  `evidence_summary` varchar(1000) DEFAULT NULL,
  `decision_status` varchar(30) NOT NULL DEFAULT 'PROPOSED' COMMENT 'PROPOSED / APPLIED / IGNORED / PENDING',
  `raw_payload` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessment_idx`),
  KEY `idx_sra_scope_created` (`assessment_scope`,`created_at`),
  KEY `idx_sra_source_kind_created` (`source_kind`,`created_at`),
  KEY `idx_sra_risk_level_created` (`risk_level`,`created_at`),
  KEY `idx_sra_decision_status` (`decision_status`,`created_at`),
  KEY `idx_sra_subject` (`subject_type`,`subject_key`,`created_at`),
  KEY `idx_sra_source_ref` (`source_type`,`source_id`),
  KEY `idx_sra_user_created` (`user_idx`,`created_at`),
  KEY `idx_sra_ip_created` (`ip_address`,`created_at`),
  CONSTRAINT `fk_sra_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI/알고리즘/상위 정책기관 기반 일반 보안 위험 판단 결과';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_FAVORITE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_FAVORITE` (
  `fav_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '찜 PK',
  `fav_id` varchar(255) DEFAULT NULL COMMENT '외부용 찜 ID',
  `user_idx` bigint NOT NULL COMMENT '유저 FK',
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '찜 시각',
  PRIMARY KEY (`fav_idx`),
  UNIQUE KEY `uk_user_spot` (`user_idx`,`spot_idx`),
  UNIQUE KEY `fav_id` (`fav_id`),
  KEY `fk_favorite_spot` (`spot_idx`),
  CONSTRAINT `fk_favorite_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_favorite_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 찜 목록 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_IMAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_IMAGE` (
  `image_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '이미지 PK',
  `image_id` varchar(255) DEFAULT NULL COMMENT '외부용 이미지 ID',
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `image_url` varchar(500) NOT NULL COMMENT '이미지 URL',
  PRIMARY KEY (`image_idx`),
  UNIQUE KEY `image_id` (`image_id`),
  KEY `fk_spot_image_spot` (`spot_idx`),
  CONSTRAINT `fk_spot_image_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 이미지 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_LIKE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_LIKE` (
  `user_idx` bigint NOT NULL COMMENT '유저 FK',
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 시각',
  PRIMARY KEY (`user_idx`,`spot_idx`),
  KEY `fk_like_spot` (`spot_idx`),
  CONSTRAINT `fk_like_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_like_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 좋아요 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_RECOMMEND 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_RECOMMEND` (
  `rec_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `user_idx` bigint NOT NULL COMMENT 'FK → USERS.user_idx',
  `spot_idx` bigint NOT NULL COMMENT '추천된 여행지 FK → SPOT_TRAVEL',
  `rec_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'AI 추천 이유 (최대 500자)',
  `rec_score` tinyint NOT NULL DEFAULT '0' COMMENT '추천 점수 1~10',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '추천 생성 시각',
  PRIMARY KEY (`rec_idx`),
  KEY `idx_sr_user` (`user_idx`),
  KEY `idx_sr_created` (`user_idx`,`created_at`),
  KEY `fk_sr_spot` (`spot_idx`),
  CONSTRAINT `fk_sr_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_sr_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1342 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 여행지 추천 결과 캐시 (5분 TTL)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_REVIEW 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_REVIEW` (
  `review_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '리뷰 PK',
  `review_id` varchar(255) DEFAULT NULL COMMENT '외부용 리뷰 ID',
  `user_idx` bigint NOT NULL COMMENT '유저 FK',
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `rating` int DEFAULT NULL COMMENT '평점',
  `content` text COMMENT '리뷰 내용',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '작성 시각',
  `review_block` int DEFAULT '0',
  `like_count` int NOT NULL DEFAULT '0' COMMENT '리뷰 좋아요 수 캐시',
  `report_count` int NOT NULL DEFAULT '0' COMMENT '리뷰 신고 수',
  PRIMARY KEY (`review_idx`),
  UNIQUE KEY `review_id` (`review_id`),
  KEY `fk_review_user` (`user_idx`),
  KEY `fk_review_spot` (`spot_idx`),
  CONSTRAINT `fk_review_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE,
  CONSTRAINT `SPOT_REVIEW_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=9125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 리뷰 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_REVIEW_LIKE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_REVIEW_LIKE` (
  `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '리뷰 좋아요 PK',
  `review_idx` bigint NOT NULL COMMENT 'SPOT_REVIEW.review_idx 참조',
  `user_idx` bigint NOT NULL COMMENT 'USERS.user_idx 참조',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '좋아요 누른 시각',
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `uq_spot_review_like` (`review_idx`,`user_idx`),
  KEY `idx_srl_review` (`review_idx`),
  KEY `idx_srl_user` (`user_idx`),
  CONSTRAINT `fk_srl_review` FOREIGN KEY (`review_idx`) REFERENCES `SPOT_REVIEW` (`review_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_srl_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행지 리뷰 좋아요';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_TAG 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_TAG` (
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `tag_idx` bigint NOT NULL COMMENT '태그 FK',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`spot_idx`,`tag_idx`),
  KEY `fk_spot_tag_tag` (`tag_idx`),
  CONSTRAINT `fk_spot_tag_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_spot_tag_tag` FOREIGN KEY (`tag_idx`) REFERENCES `SPOT_TAG_LIST` (`tag_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 - 스팟 연결 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_TAG_LIST 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_TAG_LIST` (
  `tag_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '태그 PK',
  `tag_id` varchar(255) DEFAULT NULL COMMENT '외부용 태그 ID',
  `tag_name` varchar(100) NOT NULL COMMENT '태그 이름',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`tag_idx`),
  UNIQUE KEY `tag_name` (`tag_name`),
  UNIQUE KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_TEXT_TRANSLATION_CACHE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_TEXT_TRANSLATION_CACHE` (
  `cache_idx` bigint NOT NULL AUTO_INCREMENT,
  `cache_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_pk` bigint NOT NULL DEFAULT '0',
  `field_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_text_hash` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_lang` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'google-cloud-translation-v2',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cache_idx`),
  UNIQUE KEY `uk_spot_text_translation_cache` (`source_type`,`source_pk`,`field_name`,`source_text_hash`,`target_lang`),
  UNIQUE KEY `uk_spot_text_translation_cache_id` (`cache_id`),
  KEY `idx_spot_text_translation_lookup` (`source_type`,`field_name`,`target_lang`,`source_text_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=1161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_TRAVEL 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_TRAVEL` (
  `spot_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '여행지 PK',
  `spot_id` varchar(255) DEFAULT NULL COMMENT '외부용 식별자 (API/노출용)',
  `name` varchar(255) NOT NULL COMMENT '여행지 이름',
  `region` varchar(255) DEFAULT NULL COMMENT '지역',
  `address` varchar(500) DEFAULT NULL COMMENT '주소',
  `latitude` double DEFAULT NULL COMMENT '위도',
  `longitude` double DEFAULT NULL COMMENT '경도',
  `description` text COMMENT '설명',
  `rating_avg` float DEFAULT '0' COMMENT '평균 평점',
  `review_count` int DEFAULT '0' COMMENT '리뷰 수',
  `spot_active` int NOT NULL DEFAULT '0' COMMENT '게시글 삭제',
  `user_idx` bigint NOT NULL COMMENT '여행지 등록자 FK',
  PRIMARY KEY (`spot_idx`),
  UNIQUE KEY `spot_id` (`spot_id`),
  KEY `fk_spot_travel_user` (`user_idx`),
  CONSTRAINT `fk_spot_travel_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 스팟 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_VIEW_LOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_VIEW_LOG` (
  `log_idx` bigint NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `user_idx` bigint NOT NULL COMMENT 'FK → USERS.user_idx',
  `spot_idx` bigint NOT NULL COMMENT 'FK → SPOT_TRAVEL.spot_idx',
  `stay_seconds` int NOT NULL DEFAULT '0' COMMENT '해당 방문의 체류 시간(초)',
  `viewed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '방문 시각',
  PRIMARY KEY (`log_idx`),
  KEY `idx_svl_user` (`user_idx`),
  KEY `idx_svl_spot` (`spot_idx`),
  KEY `idx_svl_viewed` (`user_idx`,`viewed_at`),
  CONSTRAINT `fk_svl_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_svl_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=620 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 여행지 페이지 체류 기록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SYSTEM_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SYSTEM_POLICY` (
  `policy_code` varchar(100) NOT NULL COMMENT '정책 코드 (예: DORMANT_ACCOUNT_POLICY)',
  `policy_name` varchar(100) NOT NULL COMMENT '관리 화면 표시용 정책명',
  `policy_group` varchar(50) NOT NULL DEFAULT 'GENERAL' COMMENT '정책 그룹 (AUTH / REWARD / SECURITY / OPERATIONS)',
  `config_json` text NOT NULL COMMENT '정책 본문 설정 JSON',
  `schedule_type` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT '실행 방식 (MANUAL / DAILY_TIME / INTERVAL_HOURS / MONTHLY_DAY_TIME)',
  `schedule_interval_hours` int DEFAULT NULL COMMENT 'INTERVAL_HOURS 일 때 주기 시간',
  `schedule_day_of_month` int DEFAULT NULL COMMENT 'MONTHLY_DAY_TIME 일 때 실행 일자',
  `schedule_time` varchar(5) DEFAULT NULL COMMENT '실행 시각 HH:mm',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '정책 활성 여부',
  `last_executed_at` datetime DEFAULT NULL COMMENT '최근 실행 시각',
  `next_execute_at` datetime DEFAULT NULL COMMENT '다음 예정 시각',
  `last_execution_status` varchar(30) DEFAULT NULL COMMENT '최근 실행 상태 (SUCCESS / FAIL / SKIPPED)',
  `last_execution_message` varchar(500) DEFAULT NULL COMMENT '최근 실행 메시지',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성 관리자',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '최근 수정 관리자',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`policy_code`),
  KEY `idx_system_policy_group_active` (`policy_group`,`is_active`),
  KEY `idx_system_policy_next_execute_at` (`next_execute_at`),
  KEY `fk_system_policy_created_by` (`created_by_user_idx`),
  KEY `fk_system_policy_updated_by` (`updated_by_user_idx`),
  CONSTRAINT `fk_system_policy_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_system_policy_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='운영 정책 현재 설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SYSTEM_POLICY_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SYSTEM_POLICY_HISTORY` (
  `system_policy_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '정책 변경 이력 PK',
  `policy_code` varchar(100) NOT NULL COMMENT '정책 코드',
  `change_type` varchar(30) NOT NULL COMMENT '변경 유형 (CREATE / UPDATE / EXECUTE / MANUAL_RUN)',
  `before_config_json` text COMMENT '변경 전 설정 JSON',
  `after_config_json` text COMMENT '변경 후 설정 JSON',
  `before_schedule_type` varchar(30) DEFAULT NULL COMMENT '변경 전 실행 방식',
  `after_schedule_type` varchar(30) DEFAULT NULL COMMENT '변경 후 실행 방식',
  `before_schedule_interval_hours` int DEFAULT NULL COMMENT '변경 전 간격 실행 시간',
  `after_schedule_interval_hours` int DEFAULT NULL COMMENT '변경 후 간격 실행 시간',
  `before_schedule_day_of_month` int DEFAULT NULL COMMENT '변경 전 월간 실행 일자',
  `after_schedule_day_of_month` int DEFAULT NULL COMMENT '변경 후 월간 실행 일자',
  `before_schedule_time` varchar(5) DEFAULT NULL COMMENT '변경 전 실행 시각',
  `after_schedule_time` varchar(5) DEFAULT NULL COMMENT '변경 후 실행 시각',
  `before_active` tinyint(1) DEFAULT NULL COMMENT '변경 전 활성 여부',
  `after_active` tinyint(1) DEFAULT NULL COMMENT '변경 후 활성 여부',
  `execution_status` varchar(30) DEFAULT NULL COMMENT '실행 결과 상태',
  `execution_message` varchar(500) DEFAULT NULL COMMENT '실행 결과 메시지',
  `changed_by_user_idx` bigint DEFAULT NULL COMMENT '변경 관리자',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '변경 시각',
  PRIMARY KEY (`system_policy_history_idx`),
  KEY `idx_system_policy_history_code_changed_at` (`policy_code`,`changed_at`),
  KEY `fk_system_policy_history_changed_by` (`changed_by_user_idx`),
  CONSTRAINT `fk_system_policy_history_changed_by` FOREIGN KEY (`changed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_system_policy_history_code` FOREIGN KEY (`policy_code`) REFERENCES `SYSTEM_POLICY` (`policy_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='운영 정책 변경 및 실행 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PACKAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PACKAGE` (
  `package_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '패키지 상품 PK',
  `seller_user_idx` bigint NOT NULL COMMENT '패키지 등록자 USERS.user_idx (BUSINESS/PARTNER)',
  `spot_idx` bigint NOT NULL COMMENT '연결 여행지 SPOT_TRAVEL.spot_idx',
  `package_title` varchar(150) NOT NULL COMMENT '패키지 상품명',
  `package_summary` varchar(300) DEFAULT NULL COMMENT '목록/카드용 짧은 소개',
  `package_content` longtext NOT NULL COMMENT '패키지 상세 설명',
  `package_price` bigint NOT NULL DEFAULT '0' COMMENT '패키지 가격',
  `currency_code` varchar(10) NOT NULL DEFAULT 'KRW' COMMENT '통화 코드',
  `start_date` date DEFAULT NULL COMMENT '패키지 시작일',
  `end_date` date DEFAULT NULL COMMENT '패키지 종료일',
  `min_people` int NOT NULL DEFAULT '1' COMMENT '최소 인원',
  `max_people` int DEFAULT NULL COMMENT '최대 인원',
  `package_status` varchar(30) NOT NULL DEFAULT 'DRAFT' COMMENT '상태: DRAFT/PENDING/APPROVED/REJECTED/BLOCKED/DELETED',
  `reject_reason` varchar(500) DEFAULT NULL COMMENT '최근 반려 사유',
  `main_image_path` varchar(500) DEFAULT NULL COMMENT '대표 이미지 경로',
  `view_count` int NOT NULL DEFAULT '0' COMMENT '조회수',
  `like_count` int NOT NULL DEFAULT '0' COMMENT '관심/좋아요 수',
  `booking_count` int NOT NULL DEFAULT '0' COMMENT '예약/구매 수',
  `is_home_featured` tinyint NOT NULL DEFAULT '0' COMMENT '홈 추천 패키지 수동 노출 여부',
  `home_featured_order` int DEFAULT NULL COMMENT '홈 추천 패키지 수동 노출 순서',
  `home_featured_start_at` datetime DEFAULT NULL COMMENT '홈 추천 노출 시작 시각',
  `home_featured_end_at` datetime DEFAULT NULL COMMENT '홈 추천 노출 종료 시각',
  `home_exposure_count` int NOT NULL DEFAULT '0' COMMENT '홈 화면 노출 수',
  `home_click_count` int NOT NULL DEFAULT '0' COMMENT '홈 화면 클릭 수',
  `approved_by_user_idx` bigint DEFAULT NULL COMMENT '승인 관리자 USERS.user_idx',
  `approved_at` datetime DEFAULT NULL COMMENT '승인 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`package_idx`),
  KEY `idx_travel_package_seller` (`seller_user_idx`),
  KEY `idx_travel_package_spot` (`spot_idx`),
  KEY `idx_travel_package_status` (`package_status`),
  KEY `idx_travel_package_created_at` (`created_at`),
  KEY `idx_travel_package_approved_at` (`approved_at`),
  KEY `fk_travel_package_approved_by` (`approved_by_user_idx`),
  KEY `idx_travel_package_home_featured` (`package_status`,`is_home_featured`,`home_featured_order`,`approved_at`),
  KEY `idx_travel_package_home_valid` (`package_status`,`end_date`,`approved_at`),
  CONSTRAINT `fk_travel_package_approved_by` FOREIGN KEY (`approved_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_travel_package_seller` FOREIGN KEY (`seller_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_travel_package_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 패키지 상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PACKAGE_BOOKING 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PACKAGE_BOOKING` (
  `package_booking_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '패키지 예약 PK',
  `booking_no` varchar(50) NOT NULL COMMENT '예약 번호',
  `package_idx` bigint NOT NULL COMMENT 'TRAVEL_PACKAGE.package_idx',
  `user_idx` bigint NOT NULL COMMENT '예약 회원 USERS.user_idx',
  `people_count` int NOT NULL DEFAULT '1' COMMENT '예약 인원',
  `unit_price` bigint NOT NULL DEFAULT '0' COMMENT '1인 또는 기본 단가',
  `total_price` bigint NOT NULL DEFAULT '0' COMMENT '총 금액',
  `used_cash` bigint NOT NULL DEFAULT '0' COMMENT '사용 캐시',
  `used_mileage` bigint NOT NULL DEFAULT '0' COMMENT '사용 마일리지',
  `booking_status` varchar(30) NOT NULL DEFAULT 'BOOKED' COMMENT 'BOOKED/CANCELLED/COMPLETED',
  `booked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '예약 시각',
  `cancelled_at` datetime DEFAULT NULL COMMENT '취소 시각',
  `cancel_reason` varchar(500) DEFAULT NULL COMMENT '예약 취소 사유',
  PRIMARY KEY (`package_booking_idx`),
  UNIQUE KEY `uq_package_booking_no` (`booking_no`),
  KEY `idx_package_booking_package` (`package_idx`),
  KEY `idx_package_booking_user` (`user_idx`),
  KEY `idx_package_booking_status` (`booking_status`),
  CONSTRAINT `fk_package_booking_package` FOREIGN KEY (`package_idx`) REFERENCES `TRAVEL_PACKAGE` (`package_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_package_booking_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 패키지 예약/구매 시뮬레이션';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PACKAGE_IMAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PACKAGE_IMAGE` (
  `package_image_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '패키지 이미지 PK',
  `package_idx` bigint NOT NULL COMMENT 'TRAVEL_PACKAGE.package_idx',
  `image_path` varchar(500) NOT NULL COMMENT '이미지 경로',
  `original_name` varchar(255) DEFAULT NULL COMMENT '원본 파일명',
  `sort_order` int NOT NULL DEFAULT '1' COMMENT '정렬 순서',
  `is_main` tinyint(1) NOT NULL DEFAULT '0' COMMENT '대표 이미지 여부',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`package_image_idx`),
  KEY `idx_package_image_package` (`package_idx`),
  KEY `idx_package_image_sort` (`package_idx`,`sort_order`),
  CONSTRAINT `fk_package_image_package` FOREIGN KEY (`package_idx`) REFERENCES `TRAVEL_PACKAGE` (`package_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 패키지 이미지';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PACKAGE_REVIEW_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PACKAGE_REVIEW_HISTORY` (
  `package_review_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '패키지 검토 이력 PK',
  `package_idx` bigint NOT NULL COMMENT 'TRAVEL_PACKAGE.package_idx',
  `previous_status` varchar(30) DEFAULT NULL COMMENT '이전 상태',
  `new_status` varchar(30) NOT NULL COMMENT '변경 상태',
  `review_reason` varchar(500) DEFAULT NULL COMMENT '승인/반려/차단 사유',
  `reviewed_by_user_idx` bigint NOT NULL COMMENT '검토 관리자 USERS.user_idx',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '검토 시각',
  PRIMARY KEY (`package_review_idx`),
  KEY `idx_package_review_package` (`package_idx`),
  KEY `idx_package_review_reviewer` (`reviewed_by_user_idx`),
  KEY `idx_package_review_created_at` (`created_at`),
  CONSTRAINT `fk_package_review_package` FOREIGN KEY (`package_idx`) REFERENCES `TRAVEL_PACKAGE` (`package_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_package_review_reviewer` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 패키지 관리자 검토 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PACKAGE_REVISION 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PACKAGE_REVISION` (
  `package_revision_idx` bigint NOT NULL AUTO_INCREMENT,
  `package_idx` bigint NOT NULL,
  `seller_user_idx` bigint NOT NULL,
  `package_title` varchar(150) NOT NULL,
  `package_summary` varchar(300) DEFAULT NULL,
  `package_content` longtext NOT NULL,
  `package_price` bigint NOT NULL DEFAULT '0',
  `currency_code` varchar(10) NOT NULL DEFAULT 'KRW',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `min_people` int NOT NULL DEFAULT '1',
  `max_people` int DEFAULT NULL,
  `main_image_path` varchar(500) DEFAULT NULL,
  `revision_status` varchar(30) NOT NULL DEFAULT 'PENDING',
  `reject_reason` varchar(500) DEFAULT NULL,
  `requested_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_by_user_idx` bigint DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`package_revision_idx`),
  KEY `idx_package_revision_package` (`package_idx`),
  KEY `idx_package_revision_seller` (`seller_user_idx`),
  KEY `idx_package_revision_status` (`revision_status`),
  KEY `fk_package_revision_reviewer` (`reviewed_by_user_idx`),
  CONSTRAINT `fk_package_revision_package` FOREIGN KEY (`package_idx`) REFERENCES `TRAVEL_PACKAGE` (`package_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_package_revision_reviewer` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_package_revision_seller` FOREIGN KEY (`seller_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.TRAVEL_PLAN 구조 내보내기
CREATE TABLE IF NOT EXISTS `TRAVEL_PLAN` (
  `plan_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `share_token` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT (now()),
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `plan_source` varchar(20) NOT NULL DEFAULT 'MANUAL',
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`plan_id`),
  UNIQUE KEY `uq_travel_plan_share_token` (`share_token`),
  KEY `fk_travel_plan_user` (`user_idx`),
  CONSTRAINT `fk_travel_plan_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_ACTIVITY_LOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_ACTIVITY_LOG` (
  `activity_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '일반 활동 로그 PK',
  `request_id` varchar(36) NOT NULL COMMENT '단일 HTTP 요청 식별자(UUID). 보안 이력 및 이메일 요청/토큰 이력과 상관관계 추적용',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 동일 활동 흐름 식별자(UUID)',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 사용자 PK (비회원은 NULL)',
  `session_id` varchar(100) DEFAULT NULL COMMENT '세션 식별자',
  `request_uri` varchar(255) NOT NULL COMMENT '요청 URI',
  `http_method` varchar(10) NOT NULL COMMENT 'HTTP 메서드',
  `activity_domain` varchar(30) NOT NULL DEFAULT 'GENERAL' COMMENT '도메인 분류 (GENERAL / AUTH / ADMIN / COMMUNITY / MYPAGE / INQUIRY 등)',
  `activity_type` varchar(30) NOT NULL COMMENT '활동 분류 (PAGE_VIEW / ACTION / AJAX / API)',
  `activity_code` varchar(50) DEFAULT NULL COMMENT '구체적 활동 코드 (예: VIEW_LOGIN_PAGE / CREATE_POST / CLICK_FIND_ID / SEND_PROFILE_EMAIL_VERIFY)',
  `activity_provider` varchar(20) DEFAULT NULL COMMENT '인증/연동 제공자 (LOCAL / KAKAO / NAVER / GOOGLE)',
  `auth_event_type` varchar(20) DEFAULT NULL COMMENT 'AUTH 도메인 세부 이벤트 (LOGIN / LOGOUT / LINK / UNLINK)',
  `target_type` varchar(30) DEFAULT NULL COMMENT '대상 유형 (예: POST / COMMENT / INQUIRY / SOCIAL / EMAIL_VERIFICATION_REQUEST)',
  `target_id` varchar(100) DEFAULT NULL COMMENT '대상 식별자',
  `handler_name` varchar(200) DEFAULT NULL COMMENT '처리 핸들러 (예: AuthController#loginPage)',
  `query_string` varchar(1000) DEFAULT NULL COMMENT '쿼리 문자열',
  `referer` varchar(500) DEFAULT NULL COMMENT '이전 페이지 Referer',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '접속 IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '브라우저 / 디바이스 정보',
  `response_status` int DEFAULT NULL COMMENT '응답 상태 코드',
  `response_time_ms` int DEFAULT NULL COMMENT '요청 처리 시간(ms)',
  `is_success` tinyint(1) DEFAULT NULL COMMENT '성공 여부 (예: 2xx/3xx = TRUE, 예외/4xx/5xx = FALSE)',
  `detail_summary` varchar(500) DEFAULT NULL COMMENT '활동 요약',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '로그 시각',
  PRIMARY KEY (`activity_idx`),
  KEY `idx_ual_request_id` (`request_id`),
  KEY `idx_ual_user_created` (`user_idx`,`created_at`),
  KEY `idx_ual_activity_type_created` (`activity_type`,`created_at`),
  KEY `idx_ual_activity_code_created` (`activity_code`,`created_at`),
  KEY `idx_ual_target` (`target_type`,`target_id`),
  KEY `idx_ual_request_uri` (`request_uri`),
  KEY `idx_ual_created_at` (`created_at`),
  KEY `idx_ual_flow_trace_id` (`flow_trace_id`),
  KEY `idx_ual_domain_created` (`activity_domain`,`created_at`),
  KEY `idx_ual_provider_created` (`activity_provider`,`created_at`),
  KEY `idx_ual_auth_event_created` (`auth_event_type`,`created_at`),
  CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=24303 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원/비회원의 일반 활동(페이지 방문, 요청 호출 등)을 기록하는 범용 활동 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_BLOCK_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_BLOCK_HISTORY` (
  `block_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '차단 이력 PK',
  `block_request_id` varchar(36) DEFAULT NULL COMMENT '차단 요청 식별자(UUID). USER_BLOCKLIST/IP_BLOCKLIST 와 매칭용',
  `block_target_key` varchar(120) DEFAULT NULL COMMENT '차단 대상 식별 키 (예: USER:15 / IP:1.2.3.4 / USER_IP:15:1.2.3.4 / CIDR:203.0.113.0/24 / RANGE:1.1.1.1~1.1.1.255)',
  `user_blocklist_idx` bigint DEFAULT NULL COMMENT '현재 연결된 USER_BLOCKLIST.block_idx',
  `ip_blocklist_idx` bigint DEFAULT NULL COMMENT '현재 연결된 IP_BLOCKLIST.ip_blocklist_idx',
  `rule_action` varchar(10) NOT NULL DEFAULT 'BLOCK' COMMENT '규칙 동작 (BLOCK / ALLOW)',
  `control_mode` varchar(30) DEFAULT NULL COMMENT '기록 시점의 제어 모드 (MANUAL / BATCH / MANUAL_OVERRIDE)',
  `operation_source` varchar(50) NOT NULL DEFAULT 'ADMIN' COMMENT '변경 주체 (ADMIN / BATCH / SYSTEM / AUTO)',
  `history_kind` varchar(50) NOT NULL DEFAULT 'BLOCK' COMMENT '이력 종류 (BLOCK / RELEASE / EXPIRE_SYNC / REBLOCK_SYNC)',
  `block_scope` varchar(30) NOT NULL DEFAULT 'USER_ACTION' COMMENT '차단 출처 범위 (USER_ACTION / GLOBAL / AUTO_DETECTION)',
  `user_idx` bigint DEFAULT NULL COMMENT '차단 대상 회원 PK (IP 단독 차단이면 NULL 가능)',
  `block_type` varchar(20) NOT NULL COMMENT '차단 유형 (USER_ONLY / IP_ONLY / USER_IP)',
  `blocked_ip` varchar(45) DEFAULT NULL COMMENT '차단 대상 IP (USER ID 단독 차단이면 NULL 가능)',
  `ip_match_type` varchar(20) DEFAULT NULL COMMENT 'IP 매칭 방식 (SINGLE_IP / CIDR / RANGE / COUNTRY / ASN)',
  `cidr_notation` varchar(64) DEFAULT NULL COMMENT 'CIDR 표기 (예: 203.0.113.0/24)',
  `range_start_ip` varchar(45) DEFAULT NULL COMMENT 'IP 범위 시작값',
  `range_end_ip` varchar(45) DEFAULT NULL COMMENT 'IP 범위 끝값',
  `ip_block_batch_idx` bigint DEFAULT NULL COMMENT '연결된 IP_BLOCK_BATCH PK',
  `batch_operation_idx` bigint DEFAULT NULL COMMENT '연결된 배치 작업 PK',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 차단 여부',
  `before_rule_is_active` tinyint(1) DEFAULT NULL COMMENT '변경 전 개별 규칙 활성 여부',
  `after_rule_is_active` tinyint(1) DEFAULT NULL COMMENT '변경 후 개별 규칙 활성 여부',
  `before_batch_is_active` tinyint(1) DEFAULT NULL COMMENT '변경 전 배치 활성 스냅샷',
  `after_batch_is_active` tinyint(1) DEFAULT NULL COMMENT '변경 후 배치 활성 스냅샷',
  `before_effective_active` tinyint(1) DEFAULT NULL COMMENT '변경 전 최종 평가 대상 여부',
  `after_effective_active` tinyint(1) DEFAULT NULL COMMENT '변경 후 최종 평가 대상 여부',
  `before_effective_status` varchar(50) DEFAULT NULL COMMENT '변경 전 최종 상태 코드',
  `after_effective_status` varchar(50) DEFAULT NULL COMMENT '변경 후 최종 상태 코드',
  `reason` varchar(500) DEFAULT NULL COMMENT '차단 사유',
  `blocked_by_user_idx` bigint DEFAULT NULL COMMENT '차단 처리한 관리자 PK',
  `blocked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '차단 시각',
  `ip_block_registered_at` datetime DEFAULT NULL COMMENT 'IP_BLOCKLIST 에 현재 차단 목록으로 반영된 시각',
  `released_by_user_idx` bigint DEFAULT NULL COMMENT '차단 해제한 관리자 PK',
  `released_at` datetime DEFAULT NULL COMMENT '차단 해제 시각',
  `ip_block_released_at` datetime DEFAULT NULL COMMENT 'IP_BLOCKLIST 에서 현재 차단 목록 해제 처리된 시각',
  `expires_at` datetime DEFAULT NULL COMMENT '차단 만료 시각',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `list_synced_at` datetime DEFAULT NULL COMMENT 'USER_BLOCKLIST/IP_BLOCKLIST 반영 시각',
  `effective_result` varchar(50) DEFAULT NULL COMMENT '기록 시점 최종 결과 (APPLIED / SKIPPED_BATCH_OFF / SKIPPED_RULE_INACTIVE / SKIPPED_EXPIRED / OVERRIDDEN)',
  `control_reason` varchar(500) DEFAULT NULL COMMENT '제어 변경 사유',
  `source_action_type` varchar(40) DEFAULT NULL COMMENT '차단 조치 유형. 예: USER_AND_IP_BLOCK',
  `source_action_group_id` varchar(36) DEFAULT NULL COMMENT '같은 보안 조치 묶음 ID',
  `source_user_idx` bigint DEFAULT NULL COMMENT '조치 기준 사용자 PK',
  `source_ip_address` varchar(45) DEFAULT NULL COMMENT '조치 기준 IP',
  `rule_origin_type` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT 'MANUAL / AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / FEED / SYSTEM',
  `source_scope` varchar(30) NOT NULL DEFAULT 'GLOBAL' COMMENT 'GLOBAL / USER_ACTION / AUTO_DETECTION / CONTENT_MODERATION / LOGIN_RISK',
  `block_category` varchar(40) NOT NULL DEFAULT 'SECURITY' COMMENT 'SPAM / ABUSE / BRUTE_FORCE / CONTENT_VIOLATION / FRAUD / SECURITY / MANUAL',
  `risk_score` int DEFAULT NULL COMMENT '위험 점수 0~100',
  `is_auto_block` tinyint(1) NOT NULL DEFAULT '0' COMMENT '자동 차단 여부',
  `auto_block_source` varchar(50) DEFAULT NULL COMMENT 'RULE / AI / POLICY_SYNC / FEED / SYSTEM',
  `detail_message` varchar(1000) DEFAULT NULL COMMENT '상세 판단 메모',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선순위',
  `is_effective_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '현재 실제 평가 대상 여부',
  `effective_status` varchar(50) NOT NULL DEFAULT 'EFFECTIVE' COMMENT 'EFFECTIVE / RULE_INACTIVE / EXPIRED / MANUAL_RELEASED',
  `effective_status_reason` varchar(500) DEFAULT NULL COMMENT '최종 상태 설명',
  `effective_synced_at` datetime DEFAULT NULL COMMENT '최종 상태 동기화 시각',
  `last_control_action` varchar(50) NOT NULL DEFAULT 'CREATE' COMMENT 'CREATE / AUTO_BLOCK / MANUAL_ENABLE / MANUAL_DISABLE / RELEASE / OVERRIDE',
  `last_control_by_user_idx` bigint DEFAULT NULL COMMENT '마지막 제어 작업자',
  `last_control_at` datetime DEFAULT NULL COMMENT '마지막 제어 시각',
  `last_control_reason` varchar(255) DEFAULT NULL COMMENT '마지막 제어 사유',
  `source_assessment_idx` bigint DEFAULT NULL COMMENT 'SECURITY_RISK_ASSESSMENT.assessment_idx',
  PRIMARY KEY (`block_idx`),
  UNIQUE KEY `uq_ubh_request_id` (`block_request_id`),
  KEY `fk_user_block_history_blocked_by` (`blocked_by_user_idx`),
  KEY `fk_user_block_history_released_by` (`released_by_user_idx`),
  KEY `fk_user_block_history_created_by` (`created_by_user_idx`),
  KEY `fk_user_block_history_updated_by` (`updated_by_user_idx`),
  KEY `idx_ubh_user_active` (`user_idx`,`is_active`),
  KEY `idx_ubh_ip_active` (`blocked_ip`,`is_active`),
  KEY `idx_ubh_type_active` (`block_type`,`is_active`),
  KEY `idx_ubh_blocked_at` (`blocked_at`),
  KEY `idx_ubh_target_key` (`block_target_key`),
  KEY `idx_ubh_history_kind` (`history_kind`),
  KEY `idx_ubh_block_scope` (`block_scope`),
  KEY `idx_ubh_ip_match_type` (`ip_match_type`),
  KEY `idx_ubh_batch` (`ip_block_batch_idx`),
  KEY `idx_ubh_rule_action_active` (`rule_action`,`is_active`),
  KEY `idx_ubh_control_mode` (`control_mode`),
  KEY `idx_ubh_batch_operation` (`batch_operation_idx`),
  KEY `idx_ubh_effective_after` (`after_effective_active`,`after_effective_status`),
  KEY `idx_ubh_rule_after` (`after_rule_is_active`),
  KEY `idx_ubh_user_blocklist_idx` (`user_blocklist_idx`),
  KEY `idx_ubh_ip_blocklist_idx` (`ip_blocklist_idx`),
  KEY `idx_ubh_source_action_group` (`source_action_group_id`,`created_at`),
  KEY `idx_ubh_source_user_ip` (`source_user_idx`,`source_ip_address`,`created_at`),
  KEY `idx_ubh_origin_category` (`rule_origin_type`,`block_category`,`created_at`),
  KEY `idx_ubh_auto_source` (`is_auto_block`,`auto_block_source`,`created_at`),
  KEY `idx_ubh_risk_score` (`risk_score`,`created_at`),
  KEY `idx_ubh_source_assessment` (`source_assessment_idx`),
  CONSTRAINT `fk_ubh_batch` FOREIGN KEY (`ip_block_batch_idx`) REFERENCES `IP_BLOCK_BATCH` (`ip_block_batch_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ubh_batch_operation` FOREIGN KEY (`batch_operation_idx`) REFERENCES `IP_BLOCK_BATCH_OPERATION` (`ip_block_batch_operation_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ubh_ip_blocklist` FOREIGN KEY (`ip_blocklist_idx`) REFERENCES `IP_BLOCKLIST` (`ip_blocklist_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ubh_user_blocklist` FOREIGN KEY (`user_blocklist_idx`) REFERENCES `USER_BLOCKLIST` (`block_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_block_history_blocked_by` FOREIGN KEY (`blocked_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_block_history_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_block_history_released_by` FOREIGN KEY (`released_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_block_history_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_block_history_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2072 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원/아이피 차단 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_BLOCKLIST 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_BLOCKLIST` (
  `block_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '차단 이력 PK',
  `source_history_block_idx` bigint DEFAULT NULL COMMENT '현재 차단 상태의 원본 USER_BLOCK_HISTORY.block_idx',
  `block_request_id` varchar(36) DEFAULT NULL COMMENT '현재 차단 상태를 만든 요청 식별자(UUID)',
  `block_target_key` varchar(120) DEFAULT NULL COMMENT '현재 차단 대상 식별 키',
  `user_idx` bigint DEFAULT NULL COMMENT '차단 대상 회원 PK (IP 단독 차단이면 NULL 가능)',
  `block_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '차단 유형 (USER_ONLY / IP_ONLY / USER_IP)',
  `blocked_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '차단 대상 IP (USER ID 단독 차단이면 NULL 가능)',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '활성 차단 여부',
  `snapshot_status` varchar(30) NOT NULL DEFAULT 'ACTIVE' COMMENT '스냅샷 상태 (ACTIVE / RELEASED / EXPIRED)',
  `reason` varchar(500) DEFAULT NULL COMMENT '차단 사유',
  `blocked_by_user_idx` bigint DEFAULT NULL COMMENT '차단 처리한 관리자 PK',
  `blocked_at` datetime NOT NULL DEFAULT (now()) COMMENT '차단 시각',
  `released_by_user_idx` bigint DEFAULT NULL COMMENT '차단 해제한 관리자 PK',
  `released_at` datetime DEFAULT NULL COMMENT '차단 해제 시각',
  `expires_at` datetime DEFAULT NULL COMMENT '차단 만료 시각',
  `created_by_user_idx` bigint DEFAULT NULL COMMENT '생성한 관리자 PK',
  `created_at` datetime NOT NULL DEFAULT (now()) COMMENT '생성 시각',
  `updated_by_user_idx` bigint DEFAULT NULL COMMENT '수정한 관리자 PK',
  `updated_at` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  `last_history_at` datetime DEFAULT NULL COMMENT '원본 USER_BLOCK_HISTORY 최종 반영 시각',
  `synced_at` datetime DEFAULT NULL COMMENT '스냅샷 동기화 시각',
  `source_action_type` varchar(40) DEFAULT NULL COMMENT '차단 조치 유형. 예: USER_AND_IP_BLOCK',
  `source_action_group_id` varchar(36) DEFAULT NULL COMMENT '같은 보안 조치 묶음 ID',
  `source_user_idx` bigint DEFAULT NULL COMMENT '조치 기준 사용자 PK',
  `source_ip_address` varchar(45) DEFAULT NULL COMMENT '조치 기준 IP',
  `rule_action` varchar(10) NOT NULL DEFAULT 'BLOCK' COMMENT '규칙 동작 BLOCK / ALLOW',
  `control_mode` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT 'MANUAL / AUTO / BATCH / MANUAL_OVERRIDE',
  `rule_origin_type` varchar(30) NOT NULL DEFAULT 'MANUAL' COMMENT 'MANUAL / AI_MODEL / RULE_ALGORITHM / POLICY_AUTHORITY / FEED / SYSTEM',
  `source_scope` varchar(30) NOT NULL DEFAULT 'GLOBAL' COMMENT 'GLOBAL / USER_ACTION / AUTO_DETECTION / CONTENT_MODERATION / LOGIN_RISK',
  `block_category` varchar(40) NOT NULL DEFAULT 'SECURITY' COMMENT 'SPAM / ABUSE / BRUTE_FORCE / CONTENT_VIOLATION / FRAUD / SECURITY / MANUAL',
  `risk_score` int DEFAULT NULL COMMENT '위험 점수 0~100',
  `is_auto_block` tinyint(1) NOT NULL DEFAULT '0' COMMENT '자동 차단 여부',
  `auto_block_source` varchar(50) DEFAULT NULL COMMENT 'RULE / AI / POLICY_SYNC / FEED / SYSTEM',
  `detail_message` varchar(1000) DEFAULT NULL COMMENT '상세 판단 메모',
  `priority` int NOT NULL DEFAULT '1' COMMENT '우선순위. 높을수록 먼저 평가',
  `is_effective_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '현재 실제 평가 대상 여부',
  `effective_status` varchar(50) NOT NULL DEFAULT 'EFFECTIVE' COMMENT 'EFFECTIVE / RULE_INACTIVE / EXPIRED / MANUAL_RELEASED',
  `effective_status_reason` varchar(500) DEFAULT NULL COMMENT '최종 상태 설명',
  `effective_synced_at` datetime DEFAULT NULL COMMENT '최종 상태 동기화 시각',
  `last_control_action` varchar(50) NOT NULL DEFAULT 'CREATE' COMMENT 'CREATE / AUTO_BLOCK / MANUAL_ENABLE / MANUAL_DISABLE / RELEASE / OVERRIDE',
  `last_control_by_user_idx` bigint DEFAULT NULL COMMENT '마지막 제어 작업자',
  `last_control_at` datetime DEFAULT NULL COMMENT '마지막 제어 시각',
  `last_control_reason` varchar(255) DEFAULT NULL COMMENT '마지막 제어 사유',
  `source_assessment_idx` bigint DEFAULT NULL COMMENT 'SECURITY_RISK_ASSESSMENT.assessment_idx',
  PRIMARY KEY (`block_idx`) USING BTREE,
  UNIQUE KEY `uq_ubl_target_key` (`block_target_key`),
  KEY `fk_user_blocklist_blocked_by` (`blocked_by_user_idx`) USING BTREE,
  KEY `fk_user_blocklist_released_by` (`released_by_user_idx`) USING BTREE,
  KEY `fk_user_blocklist_created_by` (`created_by_user_idx`) USING BTREE,
  KEY `fk_user_blocklist_updated_by` (`updated_by_user_idx`) USING BTREE,
  KEY `idx_ubl_user_active` (`user_idx`,`is_active`) USING BTREE,
  KEY `idx_ubl_ip_active` (`blocked_ip`,`is_active`) USING BTREE,
  KEY `idx_ubl_type_active` (`block_type`,`is_active`) USING BTREE,
  KEY `idx_ubl_blocked_at` (`blocked_at`) USING BTREE,
  KEY `idx_ubl_request_id` (`block_request_id`),
  KEY `idx_ubl_snapshot_status` (`snapshot_status`),
  KEY `idx_ubl_source_history` (`source_history_block_idx`),
  KEY `idx_ubl_source_action_group` (`source_action_group_id`,`blocked_at`),
  KEY `idx_ubl_source_user_ip` (`source_user_idx`,`source_ip_address`,`blocked_at`),
  KEY `idx_ubl_origin_category` (`rule_origin_type`,`block_category`,`is_active`),
  KEY `idx_ubl_auto_source` (`is_auto_block`,`auto_block_source`,`blocked_at`),
  KEY `idx_ubl_risk_score` (`risk_score`,`blocked_at`),
  KEY `idx_ubl_effective_status2` (`is_effective_active`,`effective_status`),
  KEY `idx_ubl_source_assessment` (`source_assessment_idx`),
  CONSTRAINT `fk_ubl_source_history` FOREIGN KEY (`source_history_block_idx`) REFERENCES `USER_BLOCK_HISTORY` (`block_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_blocklist_blocked_by` FOREIGN KEY (`blocked_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_blocklist_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_blocklist_released_by` FOREIGN KEY (`released_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_blocklist_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_user_blocklist_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3034 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원/아이피 차단 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_EXP_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_EXP_HISTORY` (
  `exp_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '경험치 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '회원 PK',
  `source_type` varchar(30) NOT NULL COMMENT '경험치 원천 (COMMUNITY_POST / COMMUNITY_COMMENT / SPOT_REVIEW / SPOT_REVIEW_COMMENT / PAYMENT 등)',
  `source_id` bigint DEFAULT NULL COMMENT '원천 객체 ID',
  `exp_amount` int NOT NULL COMMENT '획득 경험치',
  `level_after` int NOT NULL COMMENT '적용 후 레벨',
  `exp_after` bigint NOT NULL COMMENT '적용 후 누적 경험치',
  `detail_message` varchar(255) DEFAULT NULL COMMENT '상세 메시지',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '적용 시각',
  PRIMARY KEY (`exp_history_idx`),
  KEY `idx_ueh_user_created` (`user_idx`,`created_at`),
  KEY `idx_ueh_source` (`source_type`,`source_id`),
  CONSTRAINT `fk_ueh_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 경험치 획득 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_GRADE_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_GRADE_HISTORY` (
  `grade_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '회원 등급 변경 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '회원 PK',
  `base_year_month` char(6) NOT NULL COMMENT '등급 산정 기준월 (YYYYMM)',
  `prev_grade` varchar(20) DEFAULT NULL COMMENT '이전 등급',
  `new_grade` varchar(20) NOT NULL COMMENT '변경 등급',
  `monthly_paid_amount` bigint NOT NULL DEFAULT '0' COMMENT '직전 달 결제 총액',
  `applied_discount_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '적용 할인율(%)',
  `calculated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '산정 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`grade_history_idx`),
  UNIQUE KEY `uq_ugh_user_month` (`user_idx`,`base_year_month`),
  KEY `idx_ugh_month_grade` (`base_year_month`,`new_grade`),
  CONSTRAINT `fk_ugh_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 월별 결제액 기준 등급 산정 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_LEVEL_UP_REWARD_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_LEVEL_UP_REWARD_HISTORY` (
  `user_level_up_reward_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '회원 레벨업 보상 수령 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '회원 PK',
  `level_up_reward_policy_idx` bigint NOT NULL COMMENT '적용된 레벨업 보상 정책 PK',
  `level_no` int NOT NULL COMMENT '보상 지급 당시 레벨',
  `reward_type` varchar(30) NOT NULL COMMENT '보상 유형 스냅샷',
  `reward_amount` bigint DEFAULT NULL COMMENT '지급 수량/금액 스냅샷',
  `item_code` varchar(50) DEFAULT NULL COMMENT '지급 아이템 코드 스냅샷',
  `point_inventory_idx` bigint DEFAULT NULL COMMENT '아이템 지급 시 생성된 인벤토리 PK',
  `grant_status` varchar(20) NOT NULL DEFAULT 'GRANTED' COMMENT '지급 상태 (GRANTED / CANCELLED)',
  `granted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '지급 시각',
  `granted_by_user_idx` bigint DEFAULT NULL COMMENT '지급 처리 관리자 또는 시스템 사용자 PK',
  `note` varchar(255) DEFAULT NULL COMMENT '비고',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`user_level_up_reward_history_idx`),
  UNIQUE KEY `uq_ulurh_user_policy` (`user_idx`,`level_up_reward_policy_idx`),
  KEY `idx_ulurh_user_level` (`user_idx`,`level_no`),
  KEY `idx_ulurh_item_code` (`item_code`),
  KEY `idx_ulurh_inventory` (`point_inventory_idx`),
  KEY `fk_ulurh_policy` (`level_up_reward_policy_idx`),
  KEY `fk_ulurh_granted_by` (`granted_by_user_idx`),
  CONSTRAINT `fk_ulurh_granted_by` FOREIGN KEY (`granted_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ulurh_inventory` FOREIGN KEY (`point_inventory_idx`) REFERENCES `USER_POINT_ITEM_INVENTORY` (`point_inventory_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_ulurh_item_code` FOREIGN KEY (`item_code`) REFERENCES `POINT_SHOP_ITEM` (`item_code`) ON DELETE SET NULL,
  CONSTRAINT `fk_ulurh_policy` FOREIGN KEY (`level_up_reward_policy_idx`) REFERENCES `LEVEL_UP_REWARD_POLICY` (`level_up_reward_policy_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_ulurh_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 레벨업 보상 수령 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_LOGIN_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_LOGIN_HISTORY` (
  `login_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '로그인 이력 PK',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 성공 시 사용자 ID (실패 시 NULL 허용)',
  `event_type` varchar(20) NOT NULL DEFAULT 'LOGIN' COMMENT '인증 이벤트 유형 (LOGIN / LOGOUT)',
  `auth_type` varchar(20) NOT NULL COMMENT '인증 방식 (PASSWORD / SOCIAL)',
  `auth_provider` varchar(20) NOT NULL DEFAULT 'LOCAL' COMMENT '인증 제공자 (LOCAL / KAKAO / NAVER / GOOGLE)',
  `login_method` varchar(50) NOT NULL COMMENT '로그인 경로 (ID / EMAIL / KAKAO / NAVER / GOOGLE 등)',
  `auth_flow` varchar(30) DEFAULT NULL COMMENT '세부 흐름 (PASSWORD_ID / PASSWORD_EMAIL / SOCIAL_LOGIN / SOCIAL_REGISTER / LOGOUT_LOCAL / LOGOUT_SOCIAL)',
  `login_identifier` varchar(255) DEFAULT NULL COMMENT '입력값 (user_id 또는 email 또는 provider_user_id)',
  `session_id` varchar(128) DEFAULT NULL COMMENT 'HTTP 세션 식별자',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '인증/로그아웃 요청 URI',
  `logout_callback_uri` varchar(255) DEFAULT NULL COMMENT '로그아웃 완료 콜백 URI(소셜 로그아웃 시)',
  `request_id` varchar(36) DEFAULT NULL COMMENT 'USER_ACTIVITY_LOG.request_id 와 연결되는 현재 요청 식별자(UUID)',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 인증/로그아웃 흐름 식별자(UUID)',
  `is_success` tinyint(1) NOT NULL COMMENT '인증 이벤트 성공 여부 (LOGIN / LOGOUT 공통)',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '실패 또는 예외 사유',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '접속 IP 주소 (IPv4/IPv6 지원)',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '브라우저 및 디바이스 정보',
  `login_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '인증 이벤트 시각',
  PRIMARY KEY (`login_idx`),
  KEY `fk_login_user` (`user_idx`),
  KEY `idx_ulh_event_type_login_at` (`event_type`,`login_at`),
  KEY `idx_ulh_provider_event_login_at` (`auth_provider`,`event_type`,`login_at`),
  KEY `idx_ulh_user_event_login_at` (`user_idx`,`event_type`,`login_at`),
  KEY `idx_ulh_session_id` (`session_id`),
  KEY `idx_ulh_request_id` (`request_id`),
  KEY `idx_ulh_flow_trace_id` (`flow_trace_id`),
  CONSTRAINT `fk_login_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1676 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 시도 및 결과 이력 (보안, 감사, 통계 분석용)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_PAYMENT_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_PAYMENT_HISTORY` (
  `payment_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '결제 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '결제 회원 PK',
  `payment_type` varchar(20) NOT NULL COMMENT '결제 유형 (CHARGE / PURCHASE / REFUND)',
  `payment_method` varchar(20) NOT NULL COMMENT '결제 수단 (CASH / MILEAGE / CASH_MILEAGE / TEST)',
  `order_name` varchar(200) NOT NULL COMMENT '주문/결제명',
  `source_type` varchar(30) DEFAULT NULL COMMENT '결제 대상 유형 (TEST_PRODUCT / PLAN / SUBSCRIPTION / MANUAL_CHARGE 등)',
  `source_id` bigint DEFAULT NULL COMMENT '결제 대상 ID',
  `original_amount` bigint NOT NULL COMMENT '원금액',
  `discount_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '회원 등급 할인율(%)',
  `discount_amount` bigint NOT NULL DEFAULT '0' COMMENT '할인 금액',
  `final_amount` bigint NOT NULL COMMENT '최종 결제 금액',
  `used_cash` bigint NOT NULL DEFAULT '0' COMMENT '사용 캐쉬',
  `used_mileage` bigint NOT NULL DEFAULT '0' COMMENT '사용 마일리지',
  `earned_mileage` bigint NOT NULL DEFAULT '0' COMMENT '적립 마일리지',
  `payment_status` varchar(20) NOT NULL DEFAULT 'COMPLETED' COMMENT '결제 상태 (READY / COMPLETED / CANCELLED / REFUNDED)',
  `toss_order_id` varchar(100) DEFAULT NULL COMMENT '토스 주문 번호(orderId)',
  `toss_payment_key` varchar(200) DEFAULT NULL COMMENT '토스 결제 키(paymentKey)',
  `toss_status` varchar(30) DEFAULT NULL COMMENT '토스 결제 상태값',
  `toss_approved_at` datetime DEFAULT NULL COMMENT '토스 승인 시각',
  `paid_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '결제 시각',
  `cancelled_at` datetime DEFAULT NULL COMMENT '취소 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`payment_idx`),
  UNIQUE KEY `uq_uph_toss_order_id` (`toss_order_id`),
  UNIQUE KEY `uq_uph_toss_payment_key` (`toss_payment_key`),
  KEY `idx_uph_user_paid_at` (`user_idx`,`paid_at`),
  KEY `idx_uph_status_paid_at` (`payment_status`,`paid_at`),
  KEY `idx_uph_source` (`source_type`,`source_id`),
  CONSTRAINT `fk_uph_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 결제/구매 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_POINT_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_POINT_HISTORY` (
  `point_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 변동 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '대상 회원 PK',
  `change_type` varchar(30) NOT NULL COMMENT '변동 유형 (EARN / USE / REFUND / ADJUST / EXPIRE)',
  `source_type` varchar(30) DEFAULT NULL COMMENT '발생 원천 (COMMUNITY_POST / COMMUNITY_COMMENT / SHOP_PURCHASE / ADMIN_ADJUST 등)',
  `source_id` bigint DEFAULT NULL COMMENT '원천 객체 ID',
  `amount` bigint NOT NULL COMMENT '변동 포인트 (+/-)',
  `balance_after` bigint NOT NULL COMMENT '변동 후 포인트 잔액',
  `detail_message` varchar(255) DEFAULT NULL COMMENT '상세 사유',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '처리 주체 관리자 PK',
  `related_purchase_idx` bigint DEFAULT NULL COMMENT '연관 구매 이력 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`point_history_idx`),
  KEY `fk_upoint_actor` (`actor_user_idx`),
  KEY `idx_upoint_user_created` (`user_idx`,`created_at`),
  KEY `idx_upoint_source` (`source_type`,`source_id`),
  KEY `idx_upoint_purchase` (`related_purchase_idx`),
  CONSTRAINT `fk_upoint_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_upoint_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 포인트 변동 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_POINT_ITEM_EQUIP 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_POINT_ITEM_EQUIP` (
  `point_equip_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 아이템 장착 PK',
  `user_idx` bigint NOT NULL COMMENT '장착 사용자 PK',
  `equip_slot` varchar(30) NOT NULL COMMENT '장착 슬롯: NICKNAME_COLOR / NICKNAME_EFFECT / PROFILE_BADGE / BUBBLE_STYLE',
  `item_code` varchar(50) NOT NULL COMMENT '장착한 아이템 코드',
  `equipped_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '장착 시각',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`point_equip_idx`),
  UNIQUE KEY `uq_upie_user_slot` (`user_idx`,`equip_slot`),
  KEY `idx_upie_user` (`user_idx`),
  KEY `idx_upie_item` (`item_code`),
  KEY `fk_upie_inventory` (`user_idx`,`item_code`),
  CONSTRAINT `fk_upie_inventory` FOREIGN KEY (`user_idx`, `item_code`) REFERENCES `USER_POINT_ITEM_INVENTORY` (`user_idx`, `item_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_upie_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE,
  CONSTRAINT `chk_upie_equip_slot` CHECK ((`equip_slot` in (_utf8mb4'NICKNAME_COLOR',_utf8mb4'NICKNAME_EFFECT',_utf8mb4'PROFILE_BADGE',_utf8mb4'BUBBLE_STYLE')))
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='유저 포인트 아이템 장착 상태';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_POINT_ITEM_INVENTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_POINT_ITEM_INVENTORY` (
  `point_inventory_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 아이템 인벤토리 PK',
  `user_idx` bigint NOT NULL COMMENT '보유 회원 PK',
  `item_code` varchar(50) NOT NULL COMMENT '보유 아이템 코드',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '보유 수량',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '사용 가능 여부',
  `acquired_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '획득 시각',
  `last_used_at` datetime DEFAULT NULL COMMENT '마지막 사용 시각',
  `related_purchase_idx` bigint DEFAULT NULL COMMENT '연관 구매 이력 PK',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 시각',
  PRIMARY KEY (`point_inventory_idx`),
  UNIQUE KEY `uq_upii_user_item` (`user_idx`,`item_code`),
  KEY `fk_upii_item` (`item_code`),
  KEY `fk_upii_purchase` (`related_purchase_idx`),
  KEY `idx_upii_user_active` (`user_idx`,`is_active`),
  CONSTRAINT `fk_upii_item` FOREIGN KEY (`item_code`) REFERENCES `POINT_SHOP_ITEM` (`item_code`) ON DELETE RESTRICT,
  CONSTRAINT `fk_upii_purchase` FOREIGN KEY (`related_purchase_idx`) REFERENCES `USER_POINT_PURCHASE_HISTORY` (`point_purchase_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_upii_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 포인트 아이템 보유 인벤토리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_POINT_PURCHASE_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_POINT_PURCHASE_HISTORY` (
  `point_purchase_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '포인트 구매 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '구매 회원 PK',
  `item_code` varchar(50) NOT NULL COMMENT '구매한 아이템 코드',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '구매 수량',
  `unit_price` bigint NOT NULL COMMENT '개당 포인트 가격',
  `total_price` bigint NOT NULL COMMENT '총 사용 포인트',
  `purchase_status` varchar(20) NOT NULL DEFAULT 'COMPLETED' COMMENT '구매 상태 (READY / COMPLETED / CANCELLED / REFUNDED)',
  `purchased_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '구매 시각',
  `cancelled_at` datetime DEFAULT NULL COMMENT '취소 시각',
  `detail_message` varchar(255) DEFAULT NULL COMMENT '상세 메시지',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`point_purchase_idx`),
  KEY `idx_upph_user_created` (`user_idx`,`created_at`),
  KEY `idx_upph_item_created` (`item_code`,`created_at`),
  CONSTRAINT `fk_upph_item` FOREIGN KEY (`item_code`) REFERENCES `POINT_SHOP_ITEM` (`item_code`) ON DELETE RESTRICT,
  CONSTRAINT `fk_upph_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='포인트 상점 구매 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_ROLE_CHANGE_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_ROLE_CHANGE_HISTORY` (
  `role_history_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `previous_role` varchar(30) NOT NULL,
  `new_role` varchar(30) NOT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `changed_by_user_idx` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_history_idx`),
  KEY `fk_role_history_user` (`user_idx`),
  KEY `fk_role_history_changed_by` (`changed_by_user_idx`),
  CONSTRAINT `fk_role_history_changed_by` FOREIGN KEY (`changed_by_user_idx`) REFERENCES `USERS` (`user_idx`),
  CONSTRAINT `fk_role_history_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_SECURITY_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_SECURITY_HISTORY` (
  `security_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '보안 이벤트 PK',
  `user_idx` bigint DEFAULT NULL COMMENT '대상 사용자 PK (식별 가능 시)',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '실행 사용자 PK (로그인 상태에서 본인이 변경한 경우 등)',
  `event_type` varchar(50) NOT NULL COMMENT '이벤트 유형 (FIND_ID_REQUEST / FIND_ID_VERIFY / FIND_PASSWORD_REQUEST / RESET_PASSWORD / PASSWORD_CHANGE / EMAIL_VERIFY / EMAIL_LOGIN_TOGGLE 등)',
  `event_stage` varchar(20) DEFAULT NULL COMMENT '단계 (REQUEST / VERIFY / COMPLETE)',
  `input_identifier` varchar(255) DEFAULT NULL COMMENT '입력값 (이메일, 아이디 등)',
  `target_email` varchar(255) DEFAULT NULL COMMENT '대상 이메일',
  `is_success` tinyint(1) NOT NULL COMMENT '성공 여부',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '실패 사유 (EMAIL_NOT_FOUND / EMAIL_NOT_VERIFIED / TOKEN_EXPIRED / WRONG_PASSWORD 등)',
  `detail_message` varchar(500) DEFAULT NULL COMMENT '관리자 참고용 상세 메시지',
  `request_id` varchar(36) DEFAULT NULL COMMENT '연결된 HTTP 요청 식별자(UUID). USER_ACTIVITY_LOG.request_id 와 연결',
  `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 흐름 식별자(UUID). 이메일 발송→검증 등 다단계 추적용',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '접속 IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '브라우저 / 디바이스 정보',
  `occurred_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '이벤트 시각',
  PRIMARY KEY (`security_idx`),
  KEY `idx_ush_occurred_at` (`occurred_at` DESC),
  KEY `idx_ush_event_type_stage` (`event_type`,`event_stage`,`occurred_at` DESC),
  KEY `idx_ush_user_idx` (`user_idx`,`occurred_at` DESC),
  KEY `idx_ush_actor_user_idx` (`actor_user_idx`,`occurred_at` DESC),
  KEY `idx_ush_target_email` (`target_email`),
  KEY `idx_ush_success` (`is_success`,`occurred_at` DESC),
  KEY `idx_ush_request_id` (`request_id`),
  KEY `idx_ush_flow_trace_id` (`flow_trace_id`),
  CONSTRAINT `fk_security_actor_user` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='계정 복구 / 인증 / 비밀번호 변경 등 보안 이벤트 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_SOCIAL 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_SOCIAL` (
  `social_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `provider` varchar(50) NOT NULL COMMENT 'KAKAO, NAVER, GOOGLE',
  `provider_user_id` varchar(255) NOT NULL COMMENT '소셜 고유 ID',
  `linked_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`social_idx`),
  UNIQUE KEY `uk_provider_user` (`provider`,`provider_user_id`),
  UNIQUE KEY `uk_user_provider` (`user_idx`,`provider`),
  CONSTRAINT `fk_social_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='유저 소셜 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_VIEW_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_VIEW_HISTORY` (
  `history_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `content_type` enum('community','spot','plan','package') NOT NULL,
  `content_id` bigint NOT NULL,
  `viewed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_idx`),
  UNIQUE KEY `uk_user_content` (`user_idx`,`content_type`,`content_id`),
  KEY `idx_user_viewed` (`user_idx`,`viewed_at` DESC),
  CONSTRAINT `fk_uvh_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_WALLET_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_WALLET_HISTORY` (
  `wallet_history_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '자산 변동 이력 PK',
  `user_idx` bigint NOT NULL COMMENT '대상 회원 PK',
  `asset_type` varchar(20) NOT NULL COMMENT '자산 유형 (CASH / MILEAGE)',
  `change_type` varchar(30) NOT NULL COMMENT '변동 유형 (CHARGE / USE / REFUND / EARN / ADJUST)',
  `amount` bigint NOT NULL COMMENT '변동 금액 (+/-)',
  `balance_after` bigint NOT NULL COMMENT '변동 후 잔액',
  `related_payment_idx` bigint DEFAULT NULL COMMENT '연관 결제 PK',
  `detail_message` varchar(255) DEFAULT NULL COMMENT '상세 사유',
  `actor_user_idx` bigint DEFAULT NULL COMMENT '처리 주체 (관리자 수동 조정 시)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 시각',
  PRIMARY KEY (`wallet_history_idx`),
  KEY `fk_uwh_actor` (`actor_user_idx`),
  KEY `idx_uwh_user_asset_created` (`user_idx`,`asset_type`,`created_at`),
  KEY `idx_uwh_related_payment` (`related_payment_idx`),
  CONSTRAINT `fk_uwh_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_uwh_payment` FOREIGN KEY (`related_payment_idx`) REFERENCES `USER_PAYMENT_HISTORY` (`payment_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_uwh_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 캐쉬/마일리지 변동 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USERS 구조 내보내기
CREATE TABLE IF NOT EXISTS `USERS` (
  `user_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '회원 PK',
  `user_id` varchar(255) DEFAULT NULL COMMENT '일반 로그인 ID (선택)',
  `user_email` varchar(255) DEFAULT NULL COMMENT '이메일 (선택)',
  `user_password` varchar(255) DEFAULT NULL COMMENT '비밀번호',
  `password_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '비밀번호 로그인 가능 여부',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0' COMMENT '이메일 인증 여부',
  `email_login_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '이메일 로그인 허용 여부 (email_verified=TRUE 일 때만 의미 있음)',
  `account_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVE' COMMENT '계정 상태 (ACTIVE, DORMANT, BLOCKED, DELETED)',
  `member_grade` varchar(20) NOT NULL DEFAULT 'BRONZE' COMMENT '회원 등급 (BRONZE / SILVER / GOLD / DIAMOND / PLATINUM)',
  `is_verified_member` tinyint(1) NOT NULL DEFAULT '0' COMMENT '인증 회원 여부 (소셜 연동 회원 또는 이메일 인증 회원)',
  `cash_balance` bigint NOT NULL DEFAULT '0' COMMENT '보유 캐쉬 잔액',
  `mileage_balance` bigint NOT NULL DEFAULT '0' COMMENT '보유 마일리지 잔액',
  `point_balance` bigint NOT NULL DEFAULT '0' COMMENT '보유 포인트 잔액',
  `level_no` int NOT NULL DEFAULT '1' COMMENT '현재 레벨',
  `exp_points` bigint NOT NULL DEFAULT '0' COMMENT '누적 경험치',
  `total_post_count` int NOT NULL DEFAULT '0' COMMENT '작성 게시글 수',
  `total_comment_count` int NOT NULL DEFAULT '0' COMMENT '작성 댓글 수',
  `last_login_at` datetime DEFAULT NULL COMMENT '마지막 로그인 시각',
  `dormant_at` datetime DEFAULT NULL COMMENT '휴면 전환 시각',
  `dormant_release_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '로그인 시 휴면 해제 확인 필요 여부',
  `blocked_until` datetime DEFAULT NULL COMMENT '차단 만료 시각 (영구 차단은 NULL + BLOCKED 유지)',
  `blocked_reason` varchar(255) DEFAULT NULL COMMENT '차단 사유',
  `status_changed_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '상태 변경 시각',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '닉네임',
  `nationality` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '국가',
  `preferred_lang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '선호 언어',
  `created_at` datetime DEFAULT (now()) COMMENT '계정 생성일',
  `user_role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'USER' COMMENT '권한 (USER, ADMIN)',
  `admin_organization` varchar(30) DEFAULT NULL COMMENT '관리자 소속 조직',
  `admin_division` varchar(30) DEFAULT NULL COMMENT '관리자 소속 본부',
  `admin_department` varchar(30) DEFAULT NULL COMMENT '관리자 소속 부서',
  `admin_unit` varchar(30) DEFAULT NULL COMMENT '관리자 소속 유닛',
  `admin_team` varchar(30) DEFAULT NULL COMMENT '관리자 소속 팀',
  `admin_track` varchar(30) DEFAULT NULL COMMENT '관리자 직무 경로',
  `admin_family` varchar(30) DEFAULT NULL COMMENT '관리자 직무 계열',
  `admin_function` varchar(30) DEFAULT NULL COMMENT '관리자 직무 기능군',
  `admin_discipline` varchar(30) DEFAULT NULL COMMENT '관리자 직무 세부 분야',
  `admin_role` varchar(30) DEFAULT NULL COMMENT '관리자 직무 역할',
  `admin_position` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '관리자 조직내 보직(직책)',
  `admin_position_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '관리자 조직내 보직(직책) 코드',
  `admin_title` varchar(30) DEFAULT NULL COMMENT '관리자 대외 공식 직함',
  `admin_rank` varchar(30) DEFAULT NULL COMMENT '관리자 조직내 서열',
  `admin_seniority` varchar(30) DEFAULT NULL COMMENT '관리자 조직내 직무 숙련도(사내 평가에 의해 갱신됨)',
  `admin_tier` varchar(30) DEFAULT NULL COMMENT '관리자 조직내 직무 티어(최종학력, 경력, 사내 평가에 의해 달라짐)',
  `admin_level` varchar(30) DEFAULT NULL COMMENT '관리자 직무 단계',
  `admin_band` varchar(30) DEFAULT NULL COMMENT '관리자 실제 급여 구간',
  `admin_grade` varchar(30) DEFAULT NULL COMMENT '관리자 급여 등급',
  `admin_step` varchar(30) DEFAULT NULL COMMENT '관리자 급여 호봉',
  `admin_responsibility` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '관리자의 사이트내 실제 책임 업무 범위',
  `admin_permission` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '관리자의 사이트내 적용되는 실제 권한',
  `admin_permission_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '관리자의 사이트내 적용되는 실제 권한 코드(똑같은 권한들이면 같은 코드(예를들어서 그룹1로묶인권한+그룹2로묶인권한+개별1개의권한 조합이 하나의 코드로 묶일 수 있음))',
  `admin_location` varchar(30) DEFAULT NULL COMMENT '관리자 소속 지사',
  `admin_manager` bigint DEFAULT NULL COMMENT '해당 관리자의 상급자. 경우에 따라 없을 수 있음.',
  PRIMARY KEY (`user_idx`),
  UNIQUE KEY `nickname` (`nickname`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `user_email` (`user_email`),
  KEY `fk_admin_manager` (`admin_manager`),
  KEY `idx_users_admin_permission_code` (`admin_permission_code`),
  CONSTRAINT `fk_admin_manager` FOREIGN KEY (`admin_manager`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_users_admin_permission_code` FOREIGN KEY (`admin_permission_code`) REFERENCES `ADMIN_PERMISSION_CODE_POLICY` (`admin_permission_code`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 뷰 team1_db.V_IP_BLOCK_RULE_ADMIN_STATUS 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `V_IP_BLOCK_RULE_ADMIN_STATUS` (
	`ip_blocklist_idx` BIGINT NOT NULL COMMENT 'IP_BLOCKLIST PK',
	`ip_block_batch_idx` BIGINT NULL COMMENT '연결된 IP_BLOCK_BATCH PK',
	`block_request_id` VARCHAR(1) NULL COMMENT '연결된 USER_BLOCK_HISTORY.block_request_id' COLLATE 'utf8mb4_0900_ai_ci',
	`block_target_key` VARCHAR(1) NULL COMMENT '차단 규칙 식별 키 (예: IP:1.2.3.4 / CIDR:203.0.113.0/24 / RANGE:1.1.1.1~1.1.1.255 / COUNTRY:CN / ASN:AS12345)' COLLATE 'utf8mb4_0900_ai_ci',
	`rule_action` VARCHAR(1) NOT NULL COMMENT '규칙 동작 (BLOCK / ALLOW)' COLLATE 'utf8mb4_0900_ai_ci',
	`control_mode` VARCHAR(1) NOT NULL COMMENT '제어 모드 (MANUAL / BATCH / MANUAL_OVERRIDE)' COLLATE 'utf8mb4_0900_ai_ci',
	`match_type` VARCHAR(1) NOT NULL COMMENT '매칭 방식 (SINGLE_IP / CIDR / RANGE / COUNTRY / ASN)' COLLATE 'utf8mb4_0900_ai_ci',
	`ip_address` VARCHAR(1) NOT NULL COMMENT '차단된 IP 주소' COLLATE 'utf8mb4_0900_ai_ci',
	`cidr_notation` VARCHAR(1) NULL COMMENT 'CIDR 표기 (예: 203.0.113.0/24)' COLLATE 'utf8mb4_0900_ai_ci',
	`range_start_ip` VARCHAR(1) NULL COMMENT 'IP 범위 시작값' COLLATE 'utf8mb4_0900_ai_ci',
	`range_end_ip` VARCHAR(1) NULL COMMENT 'IP 범위 끝값' COLLATE 'utf8mb4_0900_ai_ci',
	`country_code` VARCHAR(1) NULL COMMENT '국가 코드(예: CN / RU / VN). 전역 정책성 차단 참고용' COLLATE 'utf8mb4_0900_ai_ci',
	`asn` VARCHAR(1) NULL COMMENT 'ASN 코드' COLLATE 'utf8mb4_0900_ai_ci',
	`target_display_value` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`source_scope` VARCHAR(1) NOT NULL COMMENT '차단 출처 범위 (GLOBAL / USER_ACTION / AUTO_DETECTION)' COLLATE 'utf8mb4_0900_ai_ci',
	`block_category` VARCHAR(1) NOT NULL COMMENT '차단 분류 (SPAM / ABUSE / BRUTE_FORCE / GEO / VPN / MANUAL / SECURITY)' COLLATE 'utf8mb4_0900_ai_ci',
	`priority` INT NOT NULL COMMENT '우선순위. 높을수록 먼저 평가',
	`rule_is_active` TINYINT(1) NOT NULL COMMENT '현재 유효한 IP 차단 여부',
	`batch_is_active` INT NOT NULL,
	`is_effective_active` TINYINT(1) NOT NULL COMMENT '현재 실제 평가 대상 여부',
	`effective_status` VARCHAR(1) NOT NULL COMMENT 'EFFECTIVE / RULE_INACTIVE / BATCH_INACTIVE / EXPIRED' COLLATE 'utf8mb4_0900_ai_ci',
	`effective_status_reason` VARCHAR(1) NULL COMMENT '최종 상태 설명' COLLATE 'utf8mb4_0900_ai_ci',
	`effective_synced_at` DATETIME NULL COMMENT '최종 상태 동기화 시각',
	`effective_synced_by_source` VARCHAR(1) NOT NULL COMMENT 'SYSTEM / ADMIN / BATCH / SCHEDULER / MIGRATION' COLLATE 'utf8mb4_0900_ai_ci',
	`blocked_at` DATETIME NOT NULL COMMENT '차단 일시',
	`expires_at` DATETIME NULL COMMENT 'IP 차단 만료 시각',
	`released_at` DATETIME NULL COMMENT 'IP 차단 해제 시각',
	`reason` VARCHAR(1) NULL COMMENT '차단 사유' COLLATE 'utf8mb4_0900_ai_ci',
	`detail_message` VARCHAR(1) NULL COMMENT '상세 메모' COLLATE 'utf8mb4_0900_ai_ci',
	`batch_code` VARCHAR(1) NULL COMMENT '배치 코드 (예: VPN_FEED_202604 / SPAM_FEED_20260401)' COLLATE 'utf8mb4_0900_ai_ci',
	`batch_name` VARCHAR(1) NULL COMMENT '배치명' COLLATE 'utf8mb4_0900_ai_ci',
	`batch_source_type` VARCHAR(1) NULL COMMENT '배치 출처 유형 (MANUAL / VPN_FEED / SPAM_FEED / GEO_POLICY / AUTO_DETECTION)' COLLATE 'utf8mb4_0900_ai_ci',
	`batch_source_name` VARCHAR(1) NULL COMMENT '출처명 (예: known VPN ranges / 운영자 수동 등록)' COLLATE 'utf8mb4_0900_ai_ci'
);

-- 테이블 team1_db.WALLET_LIMIT_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `WALLET_LIMIT_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT,
  `member_grade` varchar(20) NOT NULL COMMENT '회원 등급 (BRONZE/SILVER/GOLD/DIAMOND/PLATINUM)',
  `single_limit` bigint DEFAULT NULL COMMENT '1회 충전 한도 (NULL = 무제한)',
  `daily_limit` bigint DEFAULT NULL COMMENT '일일 충전 한도',
  `monthly_limit` bigint DEFAULT NULL COMMENT '월 충전 한도',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by_user_idx` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by_user_idx` bigint DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uq_wlp_grade` (`member_grade`),
  KEY `idx_wlp_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 등급별 충전 한도 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.WALLET_REFUND_LOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `WALLET_REFUND_LOG` (
  `refund_log_idx` bigint NOT NULL AUTO_INCREMENT,
  `payment_idx` bigint NOT NULL COMMENT 'USER_PAYMENT_HISTORY.payment_idx',
  `user_idx` bigint NOT NULL COMMENT '환불 대상 회원',
  `refund_amount` bigint NOT NULL COMMENT '환불 금액(KRW)',
  `refund_reason` varchar(500) NOT NULL COMMENT '환불 사유 (어드민 입력)',
  `toss_cancel_status` varchar(50) DEFAULT NULL COMMENT '토스 취소 응답 상태(있을 경우)',
  `refunded_by_user_idx` bigint NOT NULL COMMENT '환불 처리한 어드민 user_idx',
  `refunded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`refund_log_idx`),
  KEY `idx_wrl_payment` (`payment_idx`),
  KEY `idx_wrl_user` (`user_idx`),
  KEY `idx_wrl_admin` (`refunded_by_user_idx`),
  CONSTRAINT `fk_wrl_admin` FOREIGN KEY (`refunded_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wrl_payment` FOREIGN KEY (`payment_idx`) REFERENCES `USER_PAYMENT_HISTORY` (`payment_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_wrl_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='어드민 내지갑 환불 audit 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.WALLET_REWARD_POLICY 구조 내보내기
CREATE TABLE IF NOT EXISTS `WALLET_REWARD_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT,
  `event_type` varchar(50) NOT NULL COMMENT '이벤트 코드 (CASH_CHARGE_BONUS / COMMUNITY_POST / PLAN_COMPLETE / LEVEL_UP ...)',
  `member_grade` varchar(20) NOT NULL DEFAULT 'ALL' COMMENT '회원 등급 (ALL = 전체)',
  `reward_type` varchar(20) NOT NULL COMMENT 'MILEAGE / POINT',
  `reward_rate` decimal(5,2) DEFAULT NULL COMMENT '적립률(%) — 비율형',
  `reward_fixed` bigint DEFAULT NULL COMMENT '고정 적립량 — 정액형',
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_by_user_idx` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by_user_idx` bigint DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uq_wrp_event_grade` (`event_type`,`member_grade`),
  KEY `idx_wrp_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='이벤트별 적립률/고정량 정책';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `ADMIN_EFFECTIVE_PERMISSION_VW`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `ADMIN_EFFECTIVE_PERMISSION_VW` AS select distinct `p`.`user_idx` AS `user_idx`,`p`.`permission_code` AS `permission_code`,'DIRECT' AS `permission_source`,NULL AS `source_group_code` from `ADMIN_PERMISSION` `p` where (`p`.`is_active` = 1) union select distinct `g`.`user_idx` AS `user_idx`,`gi`.`permission_code` AS `permission_code`,'GROUP' AS `permission_source`,`g`.`group_code` AS `source_group_code` from (((`ADMIN_PERMISSION_GROUP` `g` join `ADMIN_PERMISSION_GROUP_POLICY` `gp` on(((`gp`.`group_code` = `g`.`group_code`) and (`gp`.`is_active` = 1)))) join `ADMIN_PERMISSION_GROUP_ITEM` `gi` on(((`gi`.`group_code` = `g`.`group_code`) and (`gi`.`is_active` = 1)))) join `ADMIN_PERMISSION_POLICY` `pp` on(((`pp`.`permission_code` = `gi`.`permission_code`) and (`pp`.`is_active` = 1)))) where (`g`.`is_active` = 1) union select distinct `u`.`user_idx` AS `user_idx`,`ci`.`permission_code` AS `permission_code`,'CODE_DIRECT' AS `permission_source`,`u`.`admin_permission_code` AS `source_group_code` from (((`USERS` `u` join `ADMIN_PERMISSION_CODE_POLICY` `cp` on(((`cp`.`admin_permission_code` = `u`.`admin_permission_code`) and (`cp`.`is_active` = 1)))) join `ADMIN_PERMISSION_CODE_PERMISSION_ITEM` `ci` on(((`ci`.`admin_permission_code` = `u`.`admin_permission_code`) and (`ci`.`is_active` = 1)))) join `ADMIN_PERMISSION_POLICY` `pp` on(((`pp`.`permission_code` = `ci`.`permission_code`) and (`pp`.`is_active` = 1)))) where ((`u`.`user_role` = 'ADMIN') and (`u`.`admin_permission_code` is not null)) union select distinct `u`.`user_idx` AS `user_idx`,`gi`.`permission_code` AS `permission_code`,'CODE_GROUP' AS `permission_source`,`cg`.`group_code` AS `source_group_code` from (((((`USERS` `u` join `ADMIN_PERMISSION_CODE_POLICY` `cp` on(((`cp`.`admin_permission_code` = `u`.`admin_permission_code`) and (`cp`.`is_active` = 1)))) join `ADMIN_PERMISSION_CODE_GROUP_ITEM` `cg` on(((`cg`.`admin_permission_code` = `u`.`admin_permission_code`) and (`cg`.`is_active` = 1)))) join `ADMIN_PERMISSION_GROUP_POLICY` `gp` on(((`gp`.`group_code` = `cg`.`group_code`) and (`gp`.`is_active` = 1)))) join `ADMIN_PERMISSION_GROUP_ITEM` `gi` on(((`gi`.`group_code` = `cg`.`group_code`) and (`gi`.`is_active` = 1)))) join `ADMIN_PERMISSION_POLICY` `pp` on(((`pp`.`permission_code` = `gi`.`permission_code`) and (`pp`.`is_active` = 1)))) where ((`u`.`user_role` = 'ADMIN') and (`u`.`admin_permission_code` is not null))
;

-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `V_IP_BLOCK_RULE_ADMIN_STATUS`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `V_IP_BLOCK_RULE_ADMIN_STATUS` AS select `l`.`ip_blocklist_idx` AS `ip_blocklist_idx`,`l`.`ip_block_batch_idx` AS `ip_block_batch_idx`,`l`.`block_request_id` AS `block_request_id`,`l`.`block_target_key` AS `block_target_key`,`l`.`rule_action` AS `rule_action`,`l`.`control_mode` AS `control_mode`,`l`.`match_type` AS `match_type`,`l`.`ip_address` AS `ip_address`,`l`.`cidr_notation` AS `cidr_notation`,`l`.`range_start_ip` AS `range_start_ip`,`l`.`range_end_ip` AS `range_end_ip`,`l`.`country_code` AS `country_code`,`l`.`asn` AS `asn`,(case when (`l`.`match_type` = 'SINGLE_IP') then `l`.`ip_address` when (`l`.`match_type` = 'CIDR') then `l`.`cidr_notation` when (`l`.`match_type` = 'RANGE') then concat(`l`.`range_start_ip`,' ~ ',`l`.`range_end_ip`) when (`l`.`match_type` = 'COUNTRY') then `l`.`country_code` when (`l`.`match_type` = 'ASN') then `l`.`asn` else `l`.`block_target_key` end) AS `target_display_value`,`l`.`source_scope` AS `source_scope`,`l`.`block_category` AS `block_category`,`l`.`priority` AS `priority`,`l`.`is_active` AS `rule_is_active`,(case when (`l`.`ip_block_batch_idx` is null) then 1 else coalesce(`b`.`is_active`,0) end) AS `batch_is_active`,`l`.`is_effective_active` AS `is_effective_active`,`l`.`effective_status` AS `effective_status`,`l`.`effective_status_reason` AS `effective_status_reason`,`l`.`effective_synced_at` AS `effective_synced_at`,`l`.`effective_synced_by_source` AS `effective_synced_by_source`,`l`.`blocked_at` AS `blocked_at`,`l`.`expires_at` AS `expires_at`,`l`.`released_at` AS `released_at`,`l`.`reason` AS `reason`,`l`.`detail_message` AS `detail_message`,`b`.`batch_code` AS `batch_code`,`b`.`batch_name` AS `batch_name`,`b`.`source_type` AS `batch_source_type`,`b`.`source_name` AS `batch_source_name` from (`IP_BLOCKLIST` `l` left join `IP_BLOCK_BATCH` `b` on((`b`.`ip_block_batch_idx` = `l`.`ip_block_batch_idx`)))
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
