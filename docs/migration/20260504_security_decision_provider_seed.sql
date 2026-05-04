-- TripTogether 보안 거버넌스 결정안 반영 Provider Seed
-- 범위:
-- 1. INTERNAL_AI_GATEWAY Stub Provider 설정
-- 2. MANUAL_UPLOAD_FEED 정책기관 수동 업로드 Provider 설정
-- 3. MOCK_WAF_SERVICE 시연/E2E용 WAF Provider 설정
-- 4. 런칭 전 외부 WAF Provider 기본 비활성 유지
--
-- 주의:
-- - 새 테이블 생성 없음
-- - 테이블 구조 변경 없음

START TRANSACTION;

INSERT INTO SECURITY_ASSESSMENT_PROVIDER_CONFIG
(provider_code, provider_kind, provider_name, is_enabled, endpoint_url, api_key_ref, model_name,
 timeout_millis, fail_open, status, description, created_at, updated_at)
VALUES
('INTERNAL_AI_GATEWAY', 'AI_MODEL', 'Internal AI Gateway Stub', 1, NULL, NULL, 'stub-pass-v1', 3000, 1, 'READY', '런칭 전 Stub 응답을 반환하는 내부 AI Gateway Provider입니다. 향후 사내 AI Gateway endpoint로 전환합니다.', NOW(), NOW()),
('MANUAL_UPLOAD_FEED', 'POLICY_AUTHORITY', 'Manual Upload Policy Feed', 1, NULL, NULL, 'csv-json-upload-v1', 3000, 1, 'READY', '관리자가 CSV/JSON 파일로 업로드한 정책기관/보안 피드를 기존 차단 배치와 규칙으로 반영합니다.', NOW(), NOW()),
('MOCK_WAF_SERVICE', 'WAF_CDN', 'Mock WAF Service', 1, NULL, NULL, 'mock-waf-sync-v1', 1000, 0, 'READY', '외부 WAF 키 발급 전 관리자 Provider 설정 → WAF 큐 적재 → Mock 동기화 E2E 검증을 위한 Provider입니다.', NOW(), NOW())
ON DUPLICATE KEY UPDATE
 provider_kind = VALUES(provider_kind),
 provider_name = VALUES(provider_name),
 is_enabled = VALUES(is_enabled),
 endpoint_url = VALUES(endpoint_url),
 api_key_ref = VALUES(api_key_ref),
 model_name = VALUES(model_name),
 timeout_millis = VALUES(timeout_millis),
 fail_open = VALUES(fail_open),
 status = VALUES(status),
 description = VALUES(description),
 updated_at = NOW();

-- 런칭 전 실제 외부 WAF Provider는 실수 호출을 막기 위해 기본 비활성화한다.
UPDATE SECURITY_ASSESSMENT_PROVIDER_CONFIG
SET is_enabled = 0,
    status = 'DISABLED',
    updated_at = NOW()
WHERE provider_code IN (
    'CLOUDFLARE_GATEWAY_WAF',
    'CLOUDFLARE_DIRECT_WAF',
    'AWS_WAF_GATEWAY_WAF',
    'AWS_WAF_SDK_IPSET',
    'NGINX_GATEWAY_WAF',
    'NGINX_DIRECT_WAF'
);

COMMIT;

-- 확인용
-- SELECT provider_code, provider_kind, is_enabled, status, model_name, fail_open
-- FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
-- WHERE provider_code IN ('INTERNAL_AI_GATEWAY','MANUAL_UPLOAD_FEED','MOCK_WAF_SERVICE',
--                         'CLOUDFLARE_GATEWAY_WAF','CLOUDFLARE_DIRECT_WAF',
--                         'AWS_WAF_GATEWAY_WAF','AWS_WAF_SDK_IPSET',
--                         'NGINX_GATEWAY_WAF','NGINX_DIRECT_WAF')
-- ORDER BY provider_code;
