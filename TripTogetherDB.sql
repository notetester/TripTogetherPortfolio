-- --------------------------------------------------------
-- 호스트:                          localhost
-- 서버 버전:                        8.0.45-0ubuntu0.24.04.1 - (Ubuntu)
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- team1_db 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `team1_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `team1_db`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_COMMENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_COMMENT` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '댓글 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `user_idx` bigint NOT NULL COMMENT '작성자 ID (USERS.user_idx 참조)',
  `content` varchar(500) NOT NULL COMMENT '댓글 내용',
  `comment_status` varchar(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '상태 (ACTIVE/DELETED)',
  `like_count` int NOT NULL DEFAULT '0' COMMENT '댓글 좋아요 수',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  `parent_comment_id` bigint DEFAULT NULL COMMENT '부모 댓글 ID (NULL이면 일반 댓글)',
  `report_count` int DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `idx_cc_post` (`post_id`),
  KEY `idx_cc_user` (`user_idx`),
  KEY `idx_cc_status` (`comment_status`),
  KEY `idx_cc_created` (`created_at`),
  KEY `fk_comment_parent` (`parent_comment_id`),
  CONSTRAINT `fk_cc_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cc_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT,
  CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `COMMUNITY_COMMENT` (`comment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='댓글';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='댓글 좋아요';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '게시글 ID',
  `user_idx` bigint NOT NULL COMMENT '작성자 ID (USERS.user_idx 참조)',
  `title` varchar(100) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '본문',
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
  PRIMARY KEY (`post_id`),
  KEY `idx_cp_user` (`user_idx`),
  KEY `idx_cp_created` (`created_at` DESC),
  KEY `idx_cpd_region` (`region`),
  KEY `idx_cpd_type` (`post_type`),
  KEY `idx_cpd_status` (`post_status`),
  KEY `idx_cpd_like` (`like_count` DESC),
  CONSTRAINT `fk_cp_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='커뮤니티 게시글';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.COMMUNITY_POST_IMAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMMUNITY_POST_IMAGE` (
  `image_id` bigint NOT NULL AUTO_INCREMENT COMMENT '이미지 ID',
  `post_id` bigint NOT NULL COMMENT '게시글 ID (COMMUNITY_POST.post_id 참조)',
  `image_url` varchar(500) NOT NULL COMMENT '이미지 경로',
  `sort_order` int NOT NULL DEFAULT '1' COMMENT '이미지 순서 (1번이 대표 이미지)',
  `is_auto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '자동추천 이미지 여부 (0=유저업로드, 1=Pixabay자동)',
  PRIMARY KEY (`image_id`),
  KEY `idx_cpi_post` (`post_id`),
  KEY `idx_cpi_order` (`post_id`,`sort_order`),
  CONSTRAINT `fk_cpi_post` FOREIGN KEY (`post_id`) REFERENCES `COMMUNITY_POST` (`post_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시글 이미지 (여러 장 지원)';

-- Pixabay 자동추천 이미지 캐시 테이블
CREATE TABLE IF NOT EXISTS `COMMUNITY_IMAGE_CACHE` (
  `cache_id` bigint NOT NULL AUTO_INCREMENT COMMENT '캐시 ID',
  `region` varchar(50) NOT NULL COMMENT '지역 코드 (asia/europe/africa/north_america/south_america/oceania)',
  `image_url` varchar(500) NOT NULL COMMENT 'Pixabay webformatURL',
  `fetched_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수집 일시',
  PRIMARY KEY (`cache_id`),
  KEY `idx_cic_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pixabay 자동추천 이미지 캐시';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='커뮤니티 게시글 좋아요 (독자 관리)';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시글-태그 연결';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 목록';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 공출현 관계';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EMAIL_VERIFICATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `EMAIL_VERIFICATION` (
  `verify_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '인증 PK',
  `user_idx` bigint DEFAULT NULL COMMENT '회원 PK (비회원 아이디찾기는 NULL 가능)',
  `email` varchar(255) NOT NULL COMMENT '인증 대상 이메일',
  `token` varchar(255) NOT NULL COMMENT 'UUID 토큰',
  `purpose` varchar(20) NOT NULL COMMENT '발급 목적',
  `expired_at` datetime NOT NULL COMMENT '만료 시각 (발급 + 30분)',
  `used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '사용 여부',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verify_idx`),
  UNIQUE KEY `token` (`token`),
  KEY `fk_verify_user` (`user_idx`),
  CONSTRAINT `fk_verify_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='이메일 인증 토큰 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.EMAIL_VERIFICATION_REQUEST 구조 내보내기
CREATE TABLE IF NOT EXISTS `EMAIL_VERIFICATION_REQUEST` (
  `email_verification_request_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '이메일 인증 요청 PK',
  `request_id` varchar(36) NOT NULL COMMENT '회원정보 수정 단위의 요청 식별자(UUID)',
  `user_idx` bigint NOT NULL COMMENT '인증 요청을 발생시킨 사용자 PK',
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
  CONSTRAINT `fk_email_verification_request_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원정보 수정 과정에서 저장 전 이메일 인증 상태를 추적하는 요청 이력 테이블';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 답변';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 첨부파일';

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
  PRIMARY KEY (`inquiry_id`),
  KEY `idx_inquiry_post_user` (`user_idx`),
  KEY `idx_inquiry_post_status` (`status`),
  CONSTRAINT `fk_inquiry_post_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 게시글';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.MYPAGE_FEED_NOTIFICATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `MYPAGE_FEED_NOTIFICATION` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL COMMENT '알림 받을 유저',
  `source_type` varchar(20) NOT NULL COMMENT 'community / inquiry / plan / ...',
  `source_id` bigint NOT NULL COMMENT 'post_id / inquiry_id / ...',
  `message` varchar(200) NOT NULL COMMENT '알림 메시지',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` tinyint NOT NULL DEFAULT '0' COMMENT '읽음 여부 (0:안읽음, 1:읽음)',
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_read` (`user_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='마이페이지 피드 알림';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.PLAN_SPOT 구조 내보내기
CREATE TABLE IF NOT EXISTS `PLAN_SPOT` (
  `plan_spot_id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint NOT NULL,
  `spot_id` varchar(255) NOT NULL,
  `place_name` varchar(255) NOT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_order` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plan_spot_id`),
  UNIQUE KEY `uq_plan_spot_order` (`plan_id`,`visit_date`,`visit_order`) USING BTREE,
  KEY `fk_plan_spot_spot` (`spot_id`),
  CONSTRAINT `fk_plan_spot_plan` FOREIGN KEY (`plan_id`) REFERENCES `TRAVEL_PLAN` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_plan_spot_spot` FOREIGN KEY (`spot_id`) REFERENCES `SPOT_TRAVEL` (`spot_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.REPORT 구조 내보내기
CREATE TABLE IF NOT EXISTS `REPORT` (
  `report_id` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `target_type` varchar(20) NOT NULL,
  `target_id` bigint NOT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'IN_REVIEW',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `resolver_idx` bigint DEFAULT NULL,
  `resolve_action` varchar(50) DEFAULT NULL,
  `source_type` varchar(20) DEFAULT NULL,
  `source_id` bigint DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `uq_report` (`user_idx`,`target_type`,`target_id`),
  KEY `resolver_idx` (`resolver_idx`),
  CONSTRAINT `REPORT_ibfk_1` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`),
  CONSTRAINT `REPORT_ibfk_2` FOREIGN KEY (`resolver_idx`) REFERENCES `USERS` (`user_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 찜 목록 테이블';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 이미지 테이블';

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
  `rec_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'AI 추천 이유 (최대 500자)',
  `rec_score` tinyint NOT NULL DEFAULT '0' COMMENT '추천 점수 1~10',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '추천 생성 시각',
  PRIMARY KEY (`rec_idx`),
  KEY `idx_sr_user` (`user_idx`),
  KEY `idx_sr_created` (`user_idx`,`created_at`),
  KEY `fk_sr_spot` (`spot_idx`),
  CONSTRAINT `fk_sr_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_sr_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI 여행지 추천 결과 캐시 (5분 TTL)';

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
  PRIMARY KEY (`review_idx`),
  UNIQUE KEY `review_id` (`review_id`),
  KEY `fk_review_user` (`user_idx`),
  KEY `fk_review_spot` (`spot_idx`),
  CONSTRAINT `fk_review_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE,
  CONSTRAINT `SPOT_REVIEW_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스팟 리뷰 테이블';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='태그 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.SPOT_TRANSLATION 구조 내보내기
CREATE TABLE IF NOT EXISTS `SPOT_TRANSLATION` (
  `trans_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '번역 PK',
  `trans_id` varchar(255) DEFAULT NULL COMMENT '외부용 번역 ID',
  `spot_idx` bigint NOT NULL COMMENT '여행지 FK',
  `language_code` varchar(10) NOT NULL COMMENT '언어 코드',
  `translated_desc` text COMMENT '번역 내용',
  `translated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '번역 시각',
  PRIMARY KEY (`trans_idx`),
  UNIQUE KEY `uk_spot_lang` (`spot_idx`,`language_code`),
  UNIQUE KEY `trans_id` (`trans_id`),
  CONSTRAINT `fk_translation_spot` FOREIGN KEY (`spot_idx`) REFERENCES `SPOT_TRAVEL` (`spot_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='번역 테이블';

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
  PRIMARY KEY (`spot_idx`),
  UNIQUE KEY `spot_id` (`spot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여행 스팟 테이블';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 여행지 페이지 체류 기록';

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
  PRIMARY KEY (`plan_id`),
  UNIQUE KEY `uq_travel_plan_share_token` (`share_token`),
  KEY `fk_travel_plan_user` (`user_idx`),
  CONSTRAINT `fk_travel_plan_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 team1_db.USER_LOGIN_HISTORY 구조 내보내기
CREATE TABLE IF NOT EXISTS `USER_LOGIN_HISTORY` (
  `login_idx` bigint NOT NULL AUTO_INCREMENT COMMENT '로그인 이력 PK',
  `user_idx` bigint DEFAULT NULL COMMENT '로그인 성공 시 사용자 ID (실패 시 NULL 허용)',
  `auth_type` varchar(20) NOT NULL COMMENT '인증 방식 (PASSWORD / SOCIAL)',
  `login_method` varchar(50) NOT NULL COMMENT '로그인 경로 (ID / EMAIL / KAKAO / NAVER / GOOGLE 등)',
  `login_identifier` varchar(255) DEFAULT NULL COMMENT '입력값 (user_id 또는 email 또는 provider_user_id)',
  `is_success` tinyint(1) NOT NULL COMMENT '로그인 성공 여부 (TRUE: 성공, FALSE: 실패)',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '실패 사유 (USER_NOT_FOUND / WRONG_PASSWORD / ACCOUNT_DORMANT / ACCOUNT_DELETED / SOCIAL_NOT_LINKED 등)',
  `ip_address` varchar(45) DEFAULT NULL COMMENT '접속 IP 주소 (IPv4/IPv6 지원)',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '브라우저 및 디바이스 정보',
  `login_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '로그인 시각',
  PRIMARY KEY (`login_idx`),
  KEY `fk_login_user` (`user_idx`),
  CONSTRAINT `fk_login_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 시도 및 결과 이력 (보안, 감사, 통계 분석용)';

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
  CONSTRAINT `fk_security_actor_user` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_security_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='계정 복구 / 인증 / 비밀번호 변경 등 보안 이벤트 이력';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='유저 소셜 정보';

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
  `user_role` varchar(20) NOT NULL DEFAULT 'USER' COMMENT '권한 (USER, ADMIN)',
  `status_changed_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '상태 변경 시각',
  `nickname` varchar(100) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `preferred_lang` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_idx`),
  UNIQUE KEY `nickname` (`nickname`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `user_email` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
