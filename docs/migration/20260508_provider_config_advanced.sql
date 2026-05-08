-- TripTogether Provider 설정 고도화 (Phase A 데이터 모델 + Phase B 호출 메타)
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
-- 적용 일자: 2026-05-08
--
-- 범위:
-- 1. SECURITY_ASSESSMENT_PROVIDER_CONFIG 컬럼 보강
--    - 소프트 삭제 / 표준 감사 컬럼 (created_by, updated_by, version)
--    - Provider별 헬스체크 주기 / 다음 예정시각
--    - 사용 카테고리 / 트리거 이벤트 (어떤 흐름에서 호출되는지 분기)
--    - HTTP 호출 메타: method / 추가 헤더 JSON / 요청 본문 템플릿 JSON / 응답 매핑 JSON
--    - 운영 한계: 동시성 / 분당 호출 한계 / 재시도 횟수와 백오프
--    - 우선순위(높을수록 우선) / 태그
-- 2. provider_kind 확장 (CHECK 제약 없으므로 ALTER 불필요. 신규 등록 모달 옵션만 추가)
--    추가될 종류: WAF_PROVIDER / CONTENT_MODERATION / IP_REPUTATION /
--                EMAIL_REPUTATION / CUSTOM_WEBHOOK
-- 3. 인덱스 보강 (소프트 삭제·다음 점검 예정 조회·우선순위 정렬 최적화)
--
-- 호환성 메모:
-- - 모든 신규 컬럼은 NULL 허용 또는 안전한 기본값 보유 → 기존 어댑터/쿼리 호환성 유지.
-- - 기존 어댑터 호출부는 신규 컬럼이 NULL이면 기존 하드코딩 동작을 유지하도록 Phase B에서 처리.
-- - SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY / SECURITY_PROVIDER_HEALTH_CHECK_HISTORY 는 변경 없음.

-- ----------------------------------------------------------------------
-- 1. 컬럼 추가
-- ----------------------------------------------------------------------
ALTER TABLE `SECURITY_ASSESSMENT_PROVIDER_CONFIG`
  ADD COLUMN `deleted_at` datetime DEFAULT NULL COMMENT '소프트 삭제 시각. NULL 이면 활성 상태' AFTER `updated_at`,
  ADD COLUMN `deleted_by_user_idx` bigint DEFAULT NULL COMMENT '소프트 삭제 수행 관리자 user_idx' AFTER `deleted_at`,
  ADD COLUMN `created_by_user_idx` bigint DEFAULT NULL COMMENT '최초 등록 관리자 user_idx' AFTER `deleted_by_user_idx`,
  ADD COLUMN `updated_by_user_idx` bigint DEFAULT NULL COMMENT '최근 수정 관리자 user_idx' AFTER `created_by_user_idx`,
  ADD COLUMN `current_version_no` int NOT NULL DEFAULT 1 COMMENT '현재 설정 버전. 수정마다 +1 (이력 테이블 version_no 와 동기)' AFTER `updated_by_user_idx`,
  ADD COLUMN `priority` int NOT NULL DEFAULT 100 COMMENT '동일 카테고리 내 호출 우선순위. 값이 클수록 우선 (DESC 정렬)' AFTER `current_version_no`,
  ADD COLUMN `health_check_interval_sec` int NOT NULL DEFAULT 300 COMMENT 'Provider별 헬스체크 주기(초). 기본 5분' AFTER `priority`,
  ADD COLUMN `next_health_check_at` datetime DEFAULT NULL COMMENT '다음 헬스체크 예정 시각. NULL 이면 즉시 점검 대상' AFTER `health_check_interval_sec`,
  ADD COLUMN `usage_categories` varchar(255) DEFAULT NULL COMMENT '쉼표 구분 카테고리. 어떤 흐름에서 호출할지 결정. 예: LOGIN_RISK,WAF_SYNC,CONTENT_MODERATION,IP_REPUTATION,EMAIL_REPUTATION' AFTER `next_health_check_at`,
  ADD COLUMN `trigger_events` varchar(255) DEFAULT NULL COMMENT '쉼표 구분 트리거 이벤트. 예: LOGIN_ATTEMPT,SIGNUP,REPORT_CREATED,COMMUNITY_POST_CREATED' AFTER `usage_categories`,
  ADD COLUMN `request_method` varchar(10) DEFAULT NULL COMMENT 'HTTP 메서드. NULL 이면 어댑터 기본값(보통 POST)' AFTER `trigger_events`,
  ADD COLUMN `request_headers_json` json DEFAULT NULL COMMENT '요청 시 추가 헤더 JSON 객체. 예: {"X-Custom":"value"}' AFTER `request_method`,
  ADD COLUMN `request_template_json` json DEFAULT NULL COMMENT '요청 본문 템플릿 JSON. placeholder: {{ip}}, {{userId}}, {{loginIdentifier}}, {{userAgent}}, {{requestId}}' AFTER `request_headers_json`,
  ADD COLUMN `response_mapping_json` json DEFAULT NULL COMMENT '응답 매핑. JSON Pointer 4종 키. 예: {"score":"/risk/score","label":"/risk/level","decision":"/recommendation","confidence":"/confidence"}' AFTER `request_template_json`,
  ADD COLUMN `max_concurrent` int DEFAULT NULL COMMENT '동시 호출 최대치. NULL 이면 제한 없음 (어댑터 기본 동작)' AFTER `response_mapping_json`,
  ADD COLUMN `rate_per_minute` int DEFAULT NULL COMMENT '분당 호출 한계. NULL 이면 제한 없음. 인스턴스 단위 in-memory 카운터 기반' AFTER `max_concurrent`,
  ADD COLUMN `retry_count` int NOT NULL DEFAULT 0 COMMENT '실패 시 재시도 횟수. 0 이면 재시도 없음' AFTER `rate_per_minute`,
  ADD COLUMN `retry_backoff_ms` int NOT NULL DEFAULT 500 COMMENT '재시도 간 백오프 ms (선형)' AFTER `retry_count`,
  ADD COLUMN `tags` varchar(255) DEFAULT NULL COMMENT '운영자 자유 태그(쉼표 구분). 검색 키워드' AFTER `retry_backoff_ms`;

-- ----------------------------------------------------------------------
-- 2. 외래키 (created_by / updated_by / deleted_by → USERS.user_idx)
-- ----------------------------------------------------------------------
ALTER TABLE `SECURITY_ASSESSMENT_PROVIDER_CONFIG`
  ADD CONSTRAINT `fk_sapc_deleted_by` FOREIGN KEY (`deleted_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_sapc_created_by` FOREIGN KEY (`created_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_sapc_updated_by` FOREIGN KEY (`updated_by_user_idx`) REFERENCES `USERS` (`user_idx`) ON DELETE SET NULL;

-- ----------------------------------------------------------------------
-- 3. 인덱스 보강
-- ----------------------------------------------------------------------
ALTER TABLE `SECURITY_ASSESSMENT_PROVIDER_CONFIG`
  ADD INDEX `idx_sapc_deleted_at` (`deleted_at`),
  ADD INDEX `idx_sapc_kind_enabled_deleted` (`provider_kind`,`is_enabled`,`deleted_at`),
  ADD INDEX `idx_sapc_next_health` (`next_health_check_at`,`is_enabled`,`deleted_at`),
  ADD INDEX `idx_sapc_priority_enabled` (`priority`,`is_enabled`,`deleted_at`),
  ADD INDEX `idx_sapc_status_deleted` (`status`,`deleted_at`),
  ADD INDEX `idx_sapc_created_by` (`created_by_user_idx`),
  ADD INDEX `idx_sapc_updated_by` (`updated_by_user_idx`);

-- ----------------------------------------------------------------------
-- 4. 기존 데이터 정합성 보정
--    - 기존 32건의 next_health_check_at 을 NULL → 즉시 점검 대상으로 두면
--      기동 직후 헬스체크가 모두 한 번에 실행되어 부담. 30초~5분 사이로 분산.
-- ----------------------------------------------------------------------
UPDATE `SECURITY_ASSESSMENT_PROVIDER_CONFIG`
SET `next_health_check_at` = DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * 300) SECOND)
WHERE `next_health_check_at` IS NULL;

-- ----------------------------------------------------------------------
-- 5. 확인용
-- ----------------------------------------------------------------------
-- DESCRIBE SECURITY_ASSESSMENT_PROVIDER_CONFIG;
-- SHOW INDEX FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG;
-- SELECT provider_code, provider_kind, priority, usage_categories,
--        request_method, max_concurrent, rate_per_minute, retry_count,
--        next_health_check_at, deleted_at
-- FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
-- ORDER BY priority DESC, provider_kind, provider_code;
