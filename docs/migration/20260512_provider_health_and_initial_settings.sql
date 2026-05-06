-- TripTogether Provider 헬스체크 이력 및 초기설정 관리 보강
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 범위:
-- 1. SECURITY_PROVIDER_HEALTH_CHECK_HISTORY 생성
-- 2. 수동/스케줄러 Provider 상태 점검 결과를 별도 이력으로 보관
--
-- 초기설정 export/import와 정책 snapshot diff UI는 DB 구조 변경이 필요 없다.

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
  CONSTRAINT `fk_sphh_provider` FOREIGN KEY (`provider_idx`) REFERENCES `SECURITY_ASSESSMENT_PROVIDER_CONFIG` (`provider_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_sphh_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Provider 수동/스케줄러 헬스체크 결과 이력';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 외 일반 관리자 조치 reason_code 감사 로그';


-- 확인용
-- SELECT * FROM SECURITY_PROVIDER_HEALTH_CHECK_HISTORY ORDER BY checked_at DESC, health_history_idx DESC;
