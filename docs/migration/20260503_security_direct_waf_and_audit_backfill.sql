-- TripTogether 보안 거버넌스 후속 보강
-- 범위:
-- 1. Gateway + Direct Defense in Depth WAF Provider 설정값 추가
-- 2. 과거 SECURITY_ACTION_AUDIT reason_code/reason_args 백필
--
-- 주의:
-- - 새 테이블을 만들지 않는다.
-- - 이전 보안 마이그레이션이 적용되어 reason_code/reason_args 컬럼이 존재한다고 가정한다.

START TRANSACTION;

INSERT INTO SECURITY_ASSESSMENT_PROVIDER_CONFIG
(provider_code, provider_kind, provider_name, is_enabled, endpoint_url, api_key_ref, model_name,
 timeout_millis, fail_open, status, description, created_at, updated_at)
VALUES
('CLOUDFLARE_GATEWAY_WAF', 'WAF_CDN', 'Cloudflare Gateway WAF Provider', 0, NULL, 'ENV:TRIPTOGETHER_CLOUDFLARE_GATEWAY_TOKEN', 'method=POST', 5000, 0, 'DISABLED', 'Gateway를 통해 Cloudflare WAF/CDN으로 동기화하는 Provider입니다. endpoint_url을 Gateway URL로 설정하고 활성화합니다.', NOW(), NOW()),
('CLOUDFLARE_DIRECT_WAF', 'WAF_CDN', 'Cloudflare Direct API WAF Provider', 0, NULL, 'ENV:TRIPTOGETHER_CLOUDFLARE_TOKEN', 'method=POST', 5000, 0, 'DISABLED', 'Cloudflare API를 직접 호출하는 Provider입니다. endpoint_url에는 Cloudflare API URL 또는 템플릿을 설정합니다.', NOW(), NOW()),
('AWS_WAF_GATEWAY_WAF', 'WAF_CDN', 'AWS WAF Gateway Provider', 0, NULL, 'ENV:TRIPTOGETHER_AWS_WAF_GATEWAY_TOKEN', 'method=POST', 5000, 0, 'DISABLED', 'Gateway를 통해 AWS WAF로 동기화하는 Provider입니다. endpoint_url을 Gateway URL로 설정하고 활성화합니다.', NOW(), NOW()),
('AWS_WAF_SDK_IPSET', 'WAF_CDN', 'AWS WAF SDK IPSet Provider', 0, NULL, 'ENV:AWS_ACCESS_KEY_ID', 'region=ap-northeast-2;scope=REGIONAL;ipSetId=REPLACE_ME;ipSetName=REPLACE_ME', 5000, 0, 'DISABLED', 'AWS SDK for Java v2 WAFV2Client로 IPSet을 직접 갱신하는 Provider입니다. AWS 기본 Credential Provider 체인을 사용합니다.', NOW(), NOW()),
('NGINX_GATEWAY_WAF', 'WAF_CDN', 'Nginx Gateway WAF Provider', 0, NULL, 'ENV:TRIPTOGETHER_NGINX_GATEWAY_TOKEN', 'method=POST', 5000, 0, 'DISABLED', 'Gateway를 통해 Nginx 앞단 차단 정책을 동기화하는 Provider입니다.', NOW(), NOW()),
('NGINX_DIRECT_WAF', 'WAF_CDN', 'Nginx Direct API WAF Provider', 0, NULL, 'ENV:TRIPTOGETHER_NGINX_ADMIN_TOKEN', 'method=POST', 5000, 0, 'DISABLED', 'Nginx Plus API 또는 내부 관리 API를 직접 호출하는 Provider입니다. endpoint_url을 관리 API URL로 설정하고 활성화합니다.', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 provider_kind = VALUES(provider_kind),
 provider_name = VALUES(provider_name),
 api_key_ref = VALUES(api_key_ref),
 model_name = VALUES(model_name),
 timeout_millis = VALUES(timeout_millis),
 fail_open = VALUES(fail_open),
 description = VALUES(description),
 updated_at = NOW();

-- 과거 감사 로그 백필: 기존 detail_message/summary는 보존하고 비어 있는 reason_code/reason_args만 채운다.
UPDATE SECURITY_ACTION_AUDIT
SET reason_code = CASE action_type
    WHEN 'SECURITY_REVIEW_APPROVED' THEN 'SECURITY.REVIEW.APPROVED'
    WHEN 'SECURITY_REVIEW_REJECTED' THEN 'SECURITY.REVIEW.REJECTED'
    WHEN 'SECURITY_REVIEW_HOLD' THEN 'SECURITY.REVIEW.HOLD'
    WHEN 'SECURITY_APPEAL_ACCEPTED' THEN 'SECURITY.APPEAL.ACCEPTED'
    WHEN 'SECURITY_APPEAL_REJECTED' THEN 'SECURITY.APPEAL.REJECTED'
    WHEN 'SECURITY_APPEAL_HOLD' THEN 'SECURITY.APPEAL.HOLD'
    WHEN 'SECURITY_APPEAL_SUBMITTED' THEN 'SECURITY.APPEAL.SUBMITTED'
    WHEN 'ASSESSMENT_USER_BLOCK_APPLIED' THEN 'SECURITY.ASSESSMENT.USER_BLOCK_APPLIED'
    WHEN 'PROVIDER_CONFIG_UPDATE' THEN 'SECURITY.PROVIDER.CONFIG_UPDATE'
    WHEN 'PROVIDER_HEALTH_CHECK' THEN 'SECURITY.PROVIDER.HEALTH_CHECK'
    WHEN 'WAF_SYNC_RETRY_REQUESTED' THEN 'SECURITY.WAF_SYNC.RETRY_REQUESTED'
    ELSE CONCAT('SECURITY.AUDIT.', REPLACE(UPPER(action_type), ' ', '_'))
END,
reason_args = JSON_OBJECT(
    'auditIdx', audit_idx,
    'actionType', action_type,
    'targetType', target_type,
    'targetKey', target_key,
    'sourceType', source_type,
    'sourceId', source_id
)
WHERE reason_code IS NULL
  AND action_type IS NOT NULL
  AND (
      action_type LIKE 'SECURITY_%'
      OR action_type LIKE 'ASSESSMENT_%'
      OR action_type LIKE 'PROVIDER_%'
      OR action_type LIKE 'WAF_%'
  );

COMMIT;

-- 확인용
-- SELECT provider_code, provider_kind, is_enabled, status, endpoint_url, api_key_ref, model_name
-- FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
-- WHERE provider_code IN ('CLOUDFLARE_GATEWAY_WAF','CLOUDFLARE_DIRECT_WAF','AWS_WAF_GATEWAY_WAF','AWS_WAF_SDK_IPSET','NGINX_GATEWAY_WAF','NGINX_DIRECT_WAF')
-- ORDER BY provider_code;
--
-- SELECT action_type, reason_code, COUNT(*)
-- FROM SECURITY_ACTION_AUDIT
-- GROUP BY action_type, reason_code
-- ORDER BY action_type, reason_code;
