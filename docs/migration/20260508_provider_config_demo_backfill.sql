-- TripTogether Provider 설정 시연 데이터 보정
-- 범위:
-- 1. usage_categories / trigger_events 가 비어 있는 기존 Provider에 운영 흐름 카테고리 부여
-- 2. priority 가 모두 100으로 보이는 시연 부자연스러움 완화
--
-- 주의:
-- - 테이블 구조 변경 없음
-- - 운영자가 이미 입력한 usage_categories / trigger_events 값은 덮어쓰지 않는다.
-- - priority 는 알려진 시드 Provider에 한해 시연용 우선순위를 명시한다.

START TRANSACTION;

UPDATE SECURITY_ASSESSMENT_PROVIDER_CONFIG
SET usage_categories = COALESCE(
        NULLIF(TRIM(usage_categories), ''),
        CASE
            WHEN provider_code IN ('DEMO_INTERNAL_AI_GATEWAY', 'INTERNAL_AI_GATEWAY', 'OPENAI_RISK_MODEL', 'GENERIC_AI_RISK_HTTP', 'INTERNAL_RULE_ENGINE')
                THEN 'LOGIN_RISK,IP_REPUTATION'
            WHEN provider_code IN ('MANUAL_UPLOAD_FEED', 'POLICY_AUTHORITY_FEED', 'POLICY_FEED_API_SAMPLE')
                THEN 'LOGIN_RISK,WAF_SYNC,IP_REPUTATION'
            WHEN provider_code IN ('MOCK_WAF_SERVICE',
                                   'CLOUDFLARE_GATEWAY_WAF', 'CLOUDFLARE_DIRECT_WAF',
                                   'AWS_WAF_GATEWAY_WAF', 'AWS_WAF_SDK_IPSET',
                                   'NGINX_GATEWAY_WAF', 'NGINX_DIRECT_WAF')
                THEN 'WAF_SYNC,IP_REPUTATION'
            WHEN provider_kind IN ('AI_MODEL', 'RULE_ALGORITHM')
                THEN 'LOGIN_RISK,IP_REPUTATION'
            WHEN provider_kind = 'POLICY_AUTHORITY'
                THEN 'LOGIN_RISK,WAF_SYNC,IP_REPUTATION'
            WHEN provider_kind IN ('WAF_PROVIDER', 'WAF', 'WAF_CDN')
                THEN 'WAF_SYNC,IP_REPUTATION'
            WHEN provider_kind = 'CONTENT_MODERATION'
                THEN 'CONTENT_MODERATION'
            WHEN provider_kind = 'EMAIL_REPUTATION'
                THEN 'EMAIL_REPUTATION'
            WHEN provider_kind = 'IP_REPUTATION'
                THEN 'IP_REPUTATION'
            ELSE 'LOGIN_RISK'
        END
    ),
    trigger_events = COALESCE(
        NULLIF(TRIM(trigger_events), ''),
        CASE
            WHEN provider_code IN ('DEMO_INTERNAL_AI_GATEWAY', 'INTERNAL_AI_GATEWAY', 'OPENAI_RISK_MODEL', 'GENERIC_AI_RISK_HTTP', 'INTERNAL_RULE_ENGINE')
                THEN 'LOGIN_ATTEMPT,SIGNUP,PASSWORD_RESET'
            WHEN provider_code IN ('MANUAL_UPLOAD_FEED', 'POLICY_AUTHORITY_FEED', 'POLICY_FEED_API_SAMPLE')
                THEN 'LOGIN_ATTEMPT,REPORT_CREATED,PASSWORD_RESET'
            WHEN provider_code IN ('MOCK_WAF_SERVICE',
                                   'CLOUDFLARE_GATEWAY_WAF', 'CLOUDFLARE_DIRECT_WAF',
                                   'AWS_WAF_GATEWAY_WAF', 'AWS_WAF_SDK_IPSET',
                                   'NGINX_GATEWAY_WAF', 'NGINX_DIRECT_WAF')
                THEN 'LOGIN_ATTEMPT,REPORT_CREATED'
            WHEN provider_kind = 'CONTENT_MODERATION'
                THEN 'COMMUNITY_POST_CREATED,REPORT_CREATED'
            WHEN provider_kind = 'EMAIL_REPUTATION'
                THEN 'SIGNUP,PASSWORD_RESET'
            ELSE 'LOGIN_ATTEMPT'
        END
    ),
    priority = CASE provider_code
        WHEN 'DEMO_INTERNAL_AI_GATEWAY' THEN 180
        WHEN 'INTERNAL_AI_GATEWAY' THEN 170
        WHEN 'OPENAI_RISK_MODEL' THEN 160
        WHEN 'GENERIC_AI_RISK_HTTP' THEN 150
        WHEN 'INTERNAL_RULE_ENGINE' THEN 140
        WHEN 'POLICY_FEED_API_SAMPLE' THEN 130
        WHEN 'POLICY_AUTHORITY_FEED' THEN 125
        WHEN 'MANUAL_UPLOAD_FEED' THEN 120
        WHEN 'MOCK_WAF_SERVICE' THEN 110
        WHEN 'CLOUDFLARE_GATEWAY_WAF' THEN 95
        WHEN 'AWS_WAF_GATEWAY_WAF' THEN 90
        WHEN 'NGINX_GATEWAY_WAF' THEN 85
        WHEN 'CLOUDFLARE_DIRECT_WAF' THEN 75
        WHEN 'AWS_WAF_SDK_IPSET' THEN 70
        WHEN 'NGINX_DIRECT_WAF' THEN 65
        ELSE priority
    END,
    updated_at = NOW()
WHERE deleted_at IS NULL
  AND (
      usage_categories IS NULL
      OR TRIM(usage_categories) = ''
      OR trigger_events IS NULL
      OR TRIM(trigger_events) = ''
      OR provider_code IN (
          'DEMO_INTERNAL_AI_GATEWAY', 'INTERNAL_AI_GATEWAY', 'OPENAI_RISK_MODEL',
          'GENERIC_AI_RISK_HTTP', 'INTERNAL_RULE_ENGINE',
          'POLICY_FEED_API_SAMPLE', 'POLICY_AUTHORITY_FEED', 'MANUAL_UPLOAD_FEED',
          'MOCK_WAF_SERVICE',
          'CLOUDFLARE_GATEWAY_WAF', 'CLOUDFLARE_DIRECT_WAF',
          'AWS_WAF_GATEWAY_WAF', 'AWS_WAF_SDK_IPSET',
          'NGINX_GATEWAY_WAF', 'NGINX_DIRECT_WAF'
      )
  );

COMMIT;

-- 확인용
-- SELECT provider_code, provider_kind, priority, usage_categories, trigger_events
-- FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
-- WHERE deleted_at IS NULL
-- ORDER BY priority DESC, provider_kind ASC, provider_code ASC;
