-- TripTogether 로그인 위험 외부/보조 판단 레이어
-- 실제 AI 모델은 나중에 붙이고, 지금은 AI/알고리즘/상위 정책기관 판단 결과를 저장·조회·시연할 수 있는 구조를 만든다.
--
-- source_kind 예시:
--   AI_MODEL          : 향후 LLM/ML 모델 판단
--   RULE_ALGORITHM    : 내부 알고리즘/스코어링 엔진 판단
--   POLICY_AUTHORITY  : 상위 보안 정책기관/관제센터/외부 보안 정책 판단
--   ASSESSMENT_PIPELINE : 외부 판단 Provider 연결 대기/파이프라인 상태

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='로그인 위험 외부/보조 판단 결과';

-- 기존 AI 스텁 테이블이 있으면 운영 화면 통합용으로 외부 판단 테이블에도 복사한다.
INSERT INTO LOGIN_RISK_EXTERNAL_ASSESSMENT
(source_kind, source_code, source_name, source_version, source_type, source_id,
 policy_code, subject_type, subject_key, user_idx, ip_address, country_code, asn,
 risk_score, risk_level, confidence_score, recommendation_action, recommendation_reason,
 evidence_summary, decision_status, raw_payload, created_at)
SELECT
 'AI_MODEL',
 COALESCE(a.model_name, 'legacy-ai-stub'),
 'Legacy AI assessment stub',
 'legacy',
 a.source_type,
 a.source_id,
 NULL,
 COALESCE(rq.subject_type, 'UNKNOWN'),
 COALESCE(rq.subject_key, CONCAT(a.source_type, ':', COALESCE(a.source_id, 0))),
 rq.user_idx,
 rq.ip_address,
 NULL,
 NULL,
 a.risk_score,
 COALESCE(a.risk_label, 'PENDING'),
 NULL,
 CASE
   WHEN a.risk_label = 'CRITICAL' THEN 'BLOCK_CIDR'
   WHEN a.risk_label = 'HIGH' THEN 'BLOCK_IP'
   WHEN a.risk_label = 'MEDIUM' THEN 'REVIEW'
   ELSE 'MONITOR'
 END,
 a.summary,
 a.summary,
 'PROPOSED',
 a.raw_payload,
 a.created_at
FROM LOGIN_RISK_AI_ASSESSMENT a
LEFT JOIN LOGIN_RISK_REVIEW_QUEUE rq
       ON a.source_type = 'LOGIN_RISK_REVIEW'
      AND a.source_id = rq.review_idx
WHERE NOT EXISTS (
    SELECT 1
    FROM LOGIN_RISK_EXTERNAL_ASSESSMENT existing
    WHERE existing.source_kind = 'AI_MODEL'
      AND existing.source_code = COALESCE(a.model_name, 'legacy-ai-stub')
      AND existing.source_type = a.source_type
      AND COALESCE(existing.source_id, -1) = COALESCE(a.source_id, -1)
);

-- 시연 데이터
START TRANSACTION;

SET @DEMO_EXTERNAL_TAG := 'DEMO-EXT-ASSESS-20260501';

SELECT @demo_user_idx := user_idx FROM USERS WHERE user_id = 'demo_user' LIMIT 1;
SELECT @demo_business_idx := user_idx FROM USERS WHERE user_id = 'demo_business' LIMIT 1;
SELECT @demo_partner_idx := user_idx FROM USERS WHERE user_id = 'demo_partner' LIMIT 1;
SELECT @demo_abuse_target_idx := user_idx FROM USERS WHERE user_id = 'demo_abuse_target' LIMIT 1;
SELECT @demo_block_target_idx := user_idx FROM USERS WHERE user_id = 'demo_block_target' LIMIT 1;

DELETE FROM LOGIN_RISK_EXTERNAL_ASSESSMENT
WHERE raw_payload IS NOT NULL
  AND JSON_UNQUOTE(JSON_EXTRACT(raw_payload, '$.demoTag')) = @DEMO_EXTERNAL_TAG;

INSERT INTO LOGIN_RISK_EXTERNAL_ASSESSMENT
(source_kind, source_code, source_name, source_version, source_type, source_id,
 policy_code, subject_type, subject_key, user_idx, ip_address, country_code, asn,
 risk_score, risk_level, confidence_score, recommendation_action, recommendation_reason,
 evidence_summary, decision_status, raw_payload, created_at)
VALUES
('AI_MODEL', 'LOGIN_RISK_AI_V1', 'TripTogether AI Risk Model', 'v1.0-demo',
 'LOGIN_RISK_REVIEW', NULL, 'IP_BURST_AUTO_BLOCK_RECOMMENDATION',
 'IP_RANGE', '203.0.113.0/24', NULL, '203.0.113.0/24', 'US', '64513',
 94, 'CRITICAL', 87, 'BLOCK_CIDR',
 '5분 내 다계정 실패가 급증했고 식별자 분산 패턴이 자동화 도구와 유사합니다.',
 '58회 실패, 서로 다른 식별자 24개, 성공 로그인 0회. CIDR 단위 제한을 권고합니다.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'ai', 'features', JSON_OBJECT('failures', 58, 'distinctIdentifiers', 24, 'successCount', 0)),
 '2026-05-01 09:20:00'),

('AI_MODEL', 'ACCOUNT_TAKEOVER_AI_V2', 'Account Takeover Classifier', 'v2.3-demo',
 'LOGIN_RISK_EVENT', NULL, 'ACCOUNT_REPEATED_LOCK_PROTECTION',
 'USER', CAST(@demo_business_idx AS CHAR), @demo_business_idx, '198.51.100.88', 'CN', '4812',
 86, 'HIGH', 81, 'LOCK_ACCOUNT',
 '비즈니스 계정에서 반복 잠금과 평소와 다른 접속 국가/ASN 조합이 감지되었습니다.',
 '비즈니스 권한 계정의 보호 조치 유지와 이메일 안내를 권고합니다.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'ai', 'accountType', 'BUSINESS', 'geoDeviation', true),
 '2026-05-01 09:21:00'),

('RULE_ALGORITHM', 'BURST_FAILURE_SCORE_V1', 'Burst Failure Scoring Algorithm', '1.0',
 'LOGIN_RISK_EVENT', NULL, 'IP_FAILED_LOGIN_LOCK',
 'IP', '198.51.100.77', @demo_abuse_target_idx, '198.51.100.77', 'US', '64512',
 78, 'HIGH', 95, 'BLOCK_IP',
 '동일 IP에서 짧은 시간 내 여러 계정 식별자에 대한 실패가 임계치를 초과했습니다.',
 '10분 내 실패 12회, 서로 다른 식별자 6개. 로그인 시도 제한 또는 IP 차단 검토 대상입니다.',
 'APPLIED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'algorithm', 'threshold', 10, 'observed', 12, 'distinctIdentifiers', 6),
 '2026-05-01 09:22:00'),

('RULE_ALGORITHM', 'SHARED_NETWORK_GUARD_V1', 'Shared Network False Positive Guard', '1.0',
 'LOGIN_RISK_REVIEW', NULL, 'IP_SUSPICIOUS_LOGIN_REVIEW',
 'IP', '203.0.113.45', NULL, '203.0.113.45', 'KR', '4766',
 54, 'MEDIUM', 72, 'REVIEW',
 '공용망 가능성이 있어 즉시 차단보다 운영자 보류 또는 추가 관찰이 적절합니다.',
 '실패는 누적되지만 계정 분산이 낮고 특정 시간대 집중 패턴입니다.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'algorithm', 'sharedNetworkLikelihood', 0.68),
 '2026-05-01 09:23:00'),

('POLICY_AUTHORITY', 'NATIONAL-CERT-ADVISORY-DEMO-001', '상위 보안 관제 정책 권고', '2026.05-demo',
 'LOGIN_RISK_REVIEW', NULL, 'IP_BURST_AUTO_BLOCK_RECOMMENDATION',
 'ASN', '64515', NULL, '192.0.2.150', 'SG', '64515',
 91, 'CRITICAL', 90, 'BLOCK_ASN',
 '상위 관제 정책에서 해당 ASN의 자동화 로그인 공격 캠페인을 긴급 주의 대상으로 분류했습니다.',
 '최근 24시간 내 유사 공격 지표와 일치합니다. ASN 단위 또는 WAF 앞단 제한 후보로 등록합니다.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'policy_authority', 'advisoryId', 'NATIONAL-CERT-ADVISORY-DEMO-001'),
 '2026-05-01 09:24:00'),

('POLICY_AUTHORITY', 'TRAVEL-ISAC-RULE-DEMO-17', '여행 플랫폼 보안 협의체 정책', '2026Q2-demo',
 'LOGIN_RISK_REVIEW', NULL, 'IP_SUSPICIOUS_LOGIN_REVIEW',
 'COUNTRY', 'RU', NULL, '203.0.113.99', 'RU', '12389',
 73, 'HIGH', 77, 'REVIEW',
 '여행 플랫폼 대상 계정 복구 엔드포인트 반복 공격 지표와 일부 일치합니다.',
 '즉시 국가 단위 차단은 과도할 수 있으므로 계정 복구 엔드포인트 한정 제한 검토를 권고합니다.',
 'PROPOSED',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'policy_authority', 'policyCode', 'TRAVEL-ISAC-RULE-DEMO-17'),
 '2026-05-01 09:25:00'),

('ASSESSMENT_PIPELINE', 'READY_FOR_PROVIDER', 'External assessment provider hook', '0.0.0',
 'LOGIN_RISK_REVIEW', NULL, 'IP_SUSPICIOUS_LOGIN_REVIEW',
 'IP', '198.51.100.200', NULL, '198.51.100.200', NULL, NULL,
 NULL, 'PENDING', NULL, 'REVIEW',
 '실제 AI/알고리즘/상위 정책기관 모듈 연결 대기 상태입니다.',
 'Provider Bean을 구현하면 이 레코드 대신 실제 평가 결과가 자동 저장됩니다.',
 'PENDING',
 JSON_OBJECT('demoTag', @DEMO_EXTERNAL_TAG, 'source', 'pipeline', 'providerConnected', false),
 '2026-05-01 09:26:00');

COMMIT;

-- 확인
-- SELECT source_kind, source_code, subject_type, subject_key, risk_score, risk_level, recommendation_action, decision_status
-- FROM LOGIN_RISK_EXTERNAL_ASSESSMENT
-- WHERE raw_payload IS NOT NULL
--   AND JSON_UNQUOTE(JSON_EXTRACT(raw_payload, '$.demoTag')) = 'DEMO-EXT-ASSESS-20260501'
-- ORDER BY created_at;
