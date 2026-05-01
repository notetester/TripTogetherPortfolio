-- TripTogether 로그인 위험 정책/검토 큐/관리자 알림 설정
-- 적용 대상: MySQL 8.x
--
-- 용어
-- - 로그인 일시 제한: 일정 시간 동안 로그인 시도 제한
-- - 계정 보호 조치: 운영자 확인 전까지 로그인 제한 유지
-- - 관리자 검토 큐: 자동 차단하기 애매한 위험 건을 관리자가 승인/미승인/보류 판단

CREATE TABLE IF NOT EXISTS `LOGIN_RISK_POLICY` (
  `policy_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `policy_name` varchar(120) NOT NULL,
  `policy_type` varchar(40) NOT NULL COMMENT 'ACCOUNT_FAILURE / ACCOUNT_LOCK_REPEAT / IP_FAILURE / IP_REVIEW / IP_BURST',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `observation_minutes` int DEFAULT NULL COMMENT 'NULL/0이면 기간 제한 없이 카운트',
  `threshold_count` int DEFAULT NULL,
  `distinct_account_threshold` int DEFAULT NULL COMMENT 'IP 기반 정책에서 서로 다른 로그인 식별자 수',
  `lock_duration_minutes` int DEFAULT NULL COMMENT 'NULL/0이면 운영자 해제 전까지 유지',
  `warning_before_count` int DEFAULT NULL COMMENT '임계값 도달 전 경고를 시작할 남은 횟수',
  `reset_on_success` tinyint(1) NOT NULL DEFAULT 1,
  `action_type` varchar(40) NOT NULL COMMENT 'WARN / ACCOUNT_TEMP_LOCK / ACCOUNT_PROTECTION_REQUIRED / IP_LOGIN_LOCK / ADMIN_REVIEW / AUTO_IP_BLOCK',
  `require_admin_review` tinyint(1) NOT NULL DEFAULT 0,
  `review_severity` varchar(20) DEFAULT 'MEDIUM',
  `notification_category` varchar(60) DEFAULT 'LOGIN_RISK',
  `description` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`policy_idx`),
  UNIQUE KEY `uk_lrp_policy_code` (`policy_code`),
  KEY `idx_lrp_active_type` (`is_active`,`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 실패/위험 판단 정책';

CREATE TABLE IF NOT EXISTS `LOGIN_RISK_COUNTER` (
  `counter_idx` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(60) NOT NULL,
  `subject_type` varchar(20) NOT NULL COMMENT 'USER / IP',
  `subject_key` varchar(120) NOT NULL,
  `attempt_count` int NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 카운터/일시 제한 상태';

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
  `review_required` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 정책 판정 이벤트';

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
  CONSTRAINT `fk_lrr_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  CONSTRAINT `fk_lrr_reviewed_by` FOREIGN KEY (`reviewed_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 검토가 필요한 로그인 위험 건';

CREATE TABLE IF NOT EXISTS `ADMIN_NOTIFICATION_PREFERENCE` (
  `preference_idx` bigint NOT NULL AUTO_INCREMENT,
  `user_idx` bigint NOT NULL,
  `notification_category` varchar(60) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`preference_idx`),
  UNIQUE KEY `uk_anp_user_category` (`user_idx`,`notification_category`),
  CONSTRAINT `fk_anp_user` FOREIGN KEY (`user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='관리자 업무별 알림 수신 설정';

INSERT INTO LOGIN_RISK_POLICY
(policy_code, policy_name, policy_type, is_active, observation_minutes, threshold_count, distinct_account_threshold,
 lock_duration_minutes, warning_before_count, reset_on_success, action_type, require_admin_review, review_severity,
 notification_category, description)
VALUES
('ACCOUNT_PASSWORD_FAILURE_LOCK', '계정 비밀번호 오류 로그인 일시 제한', 'ACCOUNT_FAILURE', 1, 10, 5, NULL, 15, 2, 1, 'ACCOUNT_TEMP_LOCK', 0, 'MEDIUM', 'LOGIN_RISK',
 '동일 계정에 대해 지정 시간 내 비밀번호 오류가 임계값에 도달하면 로그인 일시 제한을 적용합니다.'),
('ACCOUNT_REPEATED_LOCK_PROTECTION', '반복 잠금 계정 보호 조치', 'ACCOUNT_LOCK_REPEAT', 1, 60, 3, NULL, NULL, NULL, 1, 'ACCOUNT_PROTECTION_REQUIRED', 1, 'HIGH', 'LOGIN_RISK',
 '일시 제한이 반복되는 계정은 운영자 확인 전까지 보호 조치 상태로 전환합니다.'),
('IP_FAILED_LOGIN_LOCK', 'IP 기반 반복 실패 로그인 일시 제한', 'IP_FAILURE', 1, 10, 10, 5, 30, NULL, 1, 'IP_LOGIN_LOCK', 0, 'HIGH', 'LOGIN_RISK',
 '동일 IP에서 여러 계정 또는 식별자에 대한 실패 로그인이 누적되면 해당 IP의 로그인 시도를 일시 제한합니다.'),
('IP_SUSPICIOUS_LOGIN_REVIEW', '반복 실패 IP 관리자 검토 요청', 'IP_REVIEW', 1, 60, 20, 8, NULL, NULL, 1, 'ADMIN_REVIEW', 1, 'MEDIUM', 'LOGIN_RISK',
 '자동 차단하기 애매한 반복 실패 IP를 관리자 검토 큐에 등록합니다.'),
('IP_BURST_AUTO_BLOCK_RECOMMENDATION', '대량 실패 IP 대역 긴급 검토', 'IP_BURST', 1, 5, 50, 20, NULL, NULL, 1, 'ADMIN_REVIEW', 1, 'CRITICAL', 'LOGIN_RISK',
 '짧은 시간에 대량 실패가 발생한 IP/대역은 긴급 검토 알림 대상으로 등록합니다.')
ON DUPLICATE KEY UPDATE
 policy_name = VALUES(policy_name),
 policy_type = VALUES(policy_type),
 is_active = VALUES(is_active),
 observation_minutes = VALUES(observation_minutes),
 threshold_count = VALUES(threshold_count),
 distinct_account_threshold = VALUES(distinct_account_threshold),
 lock_duration_minutes = VALUES(lock_duration_minutes),
 warning_before_count = VALUES(warning_before_count),
 reset_on_success = VALUES(reset_on_success),
 action_type = VALUES(action_type),
 require_admin_review = VALUES(require_admin_review),
 review_severity = VALUES(review_severity),
 notification_category = VALUES(notification_category),
 description = VALUES(description),
 updated_at = NOW();

-- 확인
-- SELECT policy_code, is_active, observation_minutes, threshold_count, distinct_account_threshold, lock_duration_minutes, action_type, require_admin_review
-- FROM LOGIN_RISK_POLICY
-- ORDER BY policy_idx;
