-- TripTogether 정책 이력/버전 관리 보강
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 범위:
-- 1. LOGIN_RISK_POLICY_HISTORY 생성
-- 2. SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY 생성
-- 3. 현재 LOGIN_RISK_POLICY / SECURITY_ASSESSMENT_PROVIDER_CONFIG 기준 초기 CREATE 이력 seed
--
-- 통합 정책 이력 화면은 다음 이력 테이블을 UNION으로 조회한다.
-- - SYSTEM_POLICY_HISTORY
-- - LOGIN_RISK_POLICY_HISTORY
-- - SECURITY_APPEAL_POLICY_HISTORY
-- - APPLICATION_RUNTIME_SETTING_HISTORY
-- - SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY

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
  CONSTRAINT `fk_lrph_policy` FOREIGN KEY (`policy_idx`) REFERENCES `LOGIN_RISK_POLICY` (`policy_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_lrph_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 정책 변경 이력/버전';

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
  CONSTRAINT `fk_sapch_provider` FOREIGN KEY (`provider_idx`) REFERENCES `SECURITY_ASSESSMENT_PROVIDER_CONFIG` (`provider_idx`) ON DELETE CASCADE,
  CONSTRAINT `fk_sapch_actor` FOREIGN KEY (`actor_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='보안 평가 Provider 설정 변경 이력/버전';

INSERT INTO LOGIN_RISK_POLICY_HISTORY
(policy_idx, policy_code, version_no, change_type, actor_user_idx, before_config_json, after_config_json, created_at)
SELECT
 p.policy_idx,
 p.policy_code,
 1,
 'CREATE',
 NULL,
 NULL,
 JSON_OBJECT(
   'policyIdx', p.policy_idx,
   'policyCode', p.policy_code,
   'policyName', p.policy_name,
   'policyType', p.policy_type,
   'active', p.is_active,
   'observationMinutes', p.observation_minutes,
   'thresholdCount', p.threshold_count,
   'distinctAccountThreshold', p.distinct_account_threshold,
   'lockDurationMinutes', p.lock_duration_minutes,
   'warningBeforeCount', p.warning_before_count,
   'resetOnSuccess', p.reset_on_success,
   'actionType', p.action_type,
   'requireAdminReview', p.require_admin_review,
   'reviewSeverity', p.review_severity,
   'notificationCategory', p.notification_category,
   'aiAssistEnabled', p.ai_assist_enabled,
   'aiRiskScoreThreshold', p.ai_risk_score_threshold,
   'wafSyncEnabled', p.waf_sync_enabled,
   'description', p.description
 ),
 NOW()
FROM LOGIN_RISK_POLICY p
WHERE NOT EXISTS (
  SELECT 1 FROM LOGIN_RISK_POLICY_HISTORY h WHERE h.policy_idx = p.policy_idx
);

INSERT INTO SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY
(provider_idx, provider_code, provider_kind, version_no, change_type, actor_user_idx, before_config_json, after_config_json, created_at)
SELECT
 p.provider_idx,
 p.provider_code,
 p.provider_kind,
 1,
 'CREATE',
 NULL,
 NULL,
 JSON_OBJECT(
   'providerIdx', p.provider_idx,
   'providerKind', p.provider_kind,
   'providerCode', p.provider_code,
   'providerName', p.provider_name,
   'enabled', p.is_enabled,
   'endpointUrl', p.endpoint_url,
   'apiKeyRef', p.api_key_ref,
   'modelName', p.model_name,
   'timeoutMillis', p.timeout_millis,
   'failOpen', p.fail_open,
   'status', p.status,
   'description', p.description
 ),
 NOW()
FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG p
WHERE NOT EXISTS (
  SELECT 1 FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY h WHERE h.provider_idx = p.provider_idx
);

-- 확인용
-- SELECT * FROM LOGIN_RISK_POLICY_HISTORY ORDER BY created_at DESC, history_idx DESC;
-- SELECT * FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY ORDER BY created_at DESC, history_idx DESC;
