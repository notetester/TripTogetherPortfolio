-- TripTogether BLOCK_ACCESS_LOG 시연 데이터
-- 전제:
-- 1) docs/migration/20260429_block_access_log_and_cache.sql 적용
-- 2) docs/migration/20260430_block_action_group_enrichment.sql 적용
-- 3) 시연용 demo_* 계정 데이터 적용
--
-- 목적:
-- - 관리자 차단 접근 로그 화면에서 "계정+IP 동시 차단 조치에서 파생된 IP 규칙" 여부를 보여준다.
-- - 실제 요청이 원래 조치 대상 계정 + 원래 조치 대상 IP의 교집합인지 분석할 수 있게 한다.

START TRANSACTION;

SELECT @demo_block_target_idx := user_idx FROM USERS WHERE user_id = 'demo_block_target' LIMIT 1;
SELECT @demo_abuse_target_idx := user_idx FROM USERS WHERE user_id = 'demo_abuse_target' LIMIT 1;
SELECT @demo_partner_idx := user_idx FROM USERS WHERE user_id = 'demo_partner' LIMIT 1;
SELECT @demo_business_idx := user_idx FROM USERS WHERE user_id = 'demo_business' LIMIT 1;
SELECT @demo_user_idx := user_idx FROM USERS WHERE user_id = 'demo_user' LIMIT 1;

SET @grp_user_block     := 'ba000001-2026-4030-9000-000000000001';
SET @grp_user_and_ip    := 'ba000001-2026-4030-9000-000000000002';
SET @grp_cidr           := 'ba000001-2026-4030-9000-000000000003';
SET @grp_range          := 'ba000001-2026-4030-9000-000000000004';
SET @grp_country_cn     := 'ba000001-2026-4030-9000-000000000005';
SET @grp_country_ru     := 'ba000001-2026-4030-9000-000000000006';
SET @grp_asn            := 'ba000001-2026-4030-9000-000000000007';
SET @grp_partner_user   := 'ba000001-2026-4030-9000-000000000008';
SET @grp_business_user  := 'ba000001-2026-4030-9000-000000000009';
SET @grp_unknown        := 'ba000001-2026-4030-9000-000000000010';

DELETE FROM BLOCK_ACCESS_LOG
 WHERE request_id IN (
    'bd000001-2026-4030-8000-000000000001',
    'bd000001-2026-4030-8000-000000000002',
    'bd000001-2026-4030-8000-000000000003',
    'bd000001-2026-4030-8000-000000000004',
    'bd000001-2026-4030-8000-000000000005',
    'bd000001-2026-4030-8000-000000000006',
    'bd000001-2026-4030-8000-000000000007',
    'bd000001-2026-4030-8000-000000000008',
    'bd000001-2026-4030-8000-000000000009',
    'bd000001-2026-4030-8000-000000000010',
    'bd000001-2026-4030-8000-000000000011',
    'bd000001-2026-4030-8000-000000000012'
 );

INSERT INTO BLOCK_ACCESS_LOG (
    request_id, flow_trace_id, user_idx, session_id, request_uri, http_method,
    activity_domain, activity_type, activity_code, activity_provider, auth_event_type,
    target_type, target_id, handler_name, query_string, referer,
    ip_address, user_agent, response_status, response_time_ms, is_success, detail_summary,
    block_kind, block_match_type, block_target_key, block_request_id, block_rule_idx,
    block_reason, country_code, asn, cache_source,
    source_action_type, source_action_group_id, source_user_idx, source_ip_address,
    is_source_user_match, is_source_ip_match, is_source_user_ip_intersection,
    created_at
) VALUES
    (
      'bd000001-2026-4030-8000-000000000001', @grp_user_block,
      @demo_block_target_idx, 'DEMO-BLOCK-USER-KO', '/TripTogether/mypage/profile', 'GET',
      'MYPAGE', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'USER', 'demo_block_target', 'MyPageController#profile', NULL, '/TripTogether/auth/login',
      '192.0.2.31', 'DemoBrowser/1.0 Chrome', 403, 2, 0,
      'DEMO-BLOCK-LOG 계정 상태 BLOCKED에 따른 마이페이지 접근 제한',
      'USER', 'ACCOUNT_STATUS', 'USER:demo_block_target', 'd2000000-2026-4029-8000-000000000013', NULL,
      '계정 보안 정책에 따른 이용 제한', 'KR', '4766', 'DB',
      'ACCOUNT_STATUS_BLOCK', @grp_user_block, @demo_block_target_idx, NULL,
      1, 0, 0,
      '2026-04-30 09:00:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000002', @grp_user_and_ip,
      @demo_abuse_target_idx, 'DEMO-BLOCK-SIMULTANEOUS-IP', '/TripTogether/auth/login', 'POST',
      'AUTH', 'ACTION', 'BLOCKED_ACCESS', 'LOCAL', 'LOGIN',
      'USER', 'demo_abuse_target', 'AuthController#loginProcess', 'identifier=demo_abuse_target', '/TripTogether/auth/login',
      '198.51.100.77', 'DemoBot/1.0 Chrome', 403, 1, 0,
      'DEMO-BLOCK-LOG 계정+IP 동시 조치 대상 계정이 대상 IP에서 다시 접근한 교집합 사례',
      'IP', 'SINGLE_IP', 'IP:198.51.100.77', 'd2000000-2026-4029-8000-000000000014', NULL,
      '계정+IP 동시 조치 중 IP 접근 환경 제한', 'US', '64512', 'FILE',
      'USER_AND_IP_BLOCK', @grp_user_and_ip, @demo_abuse_target_idx, '198.51.100.77',
      1, 1, 1,
      '2026-04-30 09:02:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000003', @grp_user_and_ip,
      @demo_user_idx, 'DEMO-BLOCK-SAME-IP-DIFFERENT-USER', '/TripTogether/admin', 'GET',
      'ADMIN', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'ADMIN', 'admin-home', 'AdminController#dashboard', NULL, '-',
      '198.51.100.77', 'curl/8.1 DemoScanner', 403, 1, 0,
      'DEMO-BLOCK-LOG 계정+IP 동시 조치에서 생성된 IP에 다른 계정이 걸린 사례',
      'IP', 'SINGLE_IP', 'IP:198.51.100.77', 'd2000000-2026-4029-8000-000000000014', NULL,
      '관리자 영역 반복 접근 제한', 'US', '64512', 'FILE',
      'USER_AND_IP_BLOCK', @grp_user_and_ip, @demo_abuse_target_idx, '198.51.100.77',
      0, 1, 0,
      '2026-04-30 09:04:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000004', @grp_user_and_ip,
      @demo_abuse_target_idx, 'DEMO-BLOCK-SAME-USER-DIFFERENT-IP', '/TripTogether/auth/login', 'POST',
      'AUTH', 'ACTION', 'BLOCKED_ACCESS', 'LOCAL', 'LOGIN',
      'USER', 'demo_abuse_target', 'AuthController#loginProcess', 'identifier=demo_abuse_target', '/TripTogether/auth/login',
      '203.0.113.10', 'DemoBrowser/1.0 Chrome', 403, 2, 0,
      'DEMO-BLOCK-LOG 계정+IP 동시 조치 대상 계정이 다른 IP에서 접근한 사례',
      'USER', 'USER_ONLY', 'USER:demo_abuse_target', 'd2000000-2026-4029-8000-000000000013', NULL,
      '계정+IP 동시 조치 중 계정 이용 제한', 'US', '64516', 'DB',
      'USER_AND_IP_BLOCK', @grp_user_and_ip, @demo_abuse_target_idx, '198.51.100.77',
      1, 0, 0,
      '2026-04-30 09:05:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000005', @grp_cidr,
      NULL, 'DEMO-BLOCK-CIDR', '/TripTogether/api/assistant/message', 'POST',
      'AI', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'AI_CHAT', 'assistant-message', 'AssistantController#message', NULL, '/TripTogether/assistant',
      '203.0.113.45', 'DemoApiClient/2.0', 403, 1, 0,
      'DEMO-BLOCK-LOG CIDR 대역 정책에 따른 AI API 요청 제한',
      'IP', 'CIDR', 'CIDR:203.0.113.0/24', 'd2000000-2026-4029-8000-000000000015', NULL,
      '고위험 CIDR 대역 접근 제한', 'US', '64513', 'DB',
      'IP_BLOCK', @grp_cidr, NULL, NULL,
      0, 0, 0,
      '2026-04-30 09:06:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000006', @grp_range,
      NULL, 'DEMO-BLOCK-RANGE', '/TripTogether/community/write', 'POST',
      'COMMUNITY', 'ACTION', 'BLOCKED_ACCESS', NULL, NULL,
      'POST', 'community-write', 'CommunityController#write', NULL, '/TripTogether/community/list',
      '198.51.100.72', 'SpamClient/4.0', 403, 1, 0,
      'DEMO-BLOCK-LOG RANGE 규칙에 따른 커뮤니티 작성 제한',
      'IP', 'RANGE', 'RANGE:198.51.100.50~198.51.100.90', 'd2000000-2026-4029-8000-000000000016', NULL,
      '스팸성 요청 대역 제한', 'US', '64514', 'FILE',
      'IP_BLOCK', @grp_range, NULL, NULL,
      0, 0, 0,
      '2026-04-30 09:08:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000007', @grp_country_cn,
      NULL, 'DEMO-BLOCK-COUNTRY-CN', '/TripTogether/explore', 'GET',
      'EXPLORE', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'EXPLORE', 'explore-home', 'ExploreController#index', NULL, '-',
      '203.0.113.88', 'DemoBrowser/1.0', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가코드 CN 정책에 따른 접근 제한',
      'IP', 'COUNTRY', 'COUNTRY:CN', 'd2000000-2026-4029-8000-000000000017', NULL,
      '국가 기반 보안 정책 제한', 'CN', '4134', 'DB',
      'IP_BLOCK', @grp_country_cn, NULL, NULL,
      0, 0, 0,
      '2026-04-30 09:10:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000008', @grp_country_ru,
      NULL, 'DEMO-BLOCK-COUNTRY-RU', '/TripTogether/auth/password/find', 'POST',
      'AUTH', 'ACTION', 'BLOCKED_ACCESS', 'LOCAL', 'PASSWORD_RESET',
      'AUTH', 'password-find', 'AuthController#forgotPasswordProcess', NULL, '/TripTogether/auth/login',
      '203.0.113.99', 'DemoBot/1.0', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가코드 RU 정책에 따른 계정 복구 요청 제한',
      'IP', 'COUNTRY', 'COUNTRY:RU', 'd2000000-2026-4029-8000-000000000018', NULL,
      '국가 기반 보안 정책 제한', 'RU', '12389', 'DB',
      'IP_BLOCK', @grp_country_ru, NULL, NULL,
      0, 0, 0,
      '2026-04-30 09:12:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000009', @grp_asn,
      NULL, 'DEMO-BLOCK-ASN', '/TripTogether/chatbot/message', 'POST',
      'AI', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'CHATBOT', 'chatbot-message', 'ChatbotController#message', NULL, '/TripTogether/chatbot',
      '192.0.2.150', 'AbuseAutomation/1.2', 403, 1, 0,
      'DEMO-BLOCK-LOG ASN 정책에 따른 챗봇 남용 요청 제한',
      'IP', 'ASN', 'ASN:64515', 'd2000000-2026-4029-8000-000000000021', NULL,
      '고위험 ASN 접근 제한', 'SG', '64515', 'FILE',
      'IP_BLOCK', @grp_asn, NULL, NULL,
      0, 0, 0,
      '2026-04-30 09:14:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000010', @grp_partner_user,
      @demo_partner_idx, 'DEMO-BLOCK-USER-JA', '/TripTogether/partner/dashboard', 'GET',
      'PARTNER', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'PARTNER', 'partner-dashboard', 'PartnerController#dashboard', NULL, '/TripTogether/auth/login',
      '192.0.2.44', 'DemoBrowser/1.0', 403, 2, 0,
      'DEMO-BLOCK-LOG 파트너 계정 임시 이용 제한. 계정 선호 언어 기반 JA 안내 대상',
      'USER', 'USER_ONLY', 'USER:demo_partner', 'd2000000-2026-4029-8000-000000000022', NULL,
      '파트너 계정 보안 검토에 따른 이용 제한', 'JP', '2516', 'DB',
      'USER_BLOCK', @grp_partner_user, @demo_partner_idx, NULL,
      1, 0, 0,
      '2026-04-30 09:16:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000011', @grp_business_user,
      @demo_business_idx, 'DEMO-BLOCK-BIZ-ZH', '/TripTogether/business/package/register', 'POST',
      'PACKAGE', 'ACTION', 'BLOCKED_ACCESS', NULL, NULL,
      'BUSINESS_PACKAGE', 'package-register', 'PackageController#register', NULL, '/TripTogether/business/package',
      '203.0.113.120', 'DemoBrowser/1.0', 403, 2, 0,
      'DEMO-BLOCK-LOG 비즈니스 계정 검토 중 등록 기능 제한. 중국어 안내 시연 대상',
      'USER', 'USER_ONLY', 'USER:demo_business', 'd2000000-2026-4029-8000-000000000023', NULL,
      '비즈니스 계정 검토 중 기능 제한', 'CN', '4812', 'DB',
      'USER_BLOCK', @grp_business_user, @demo_business_idx, NULL,
      1, 0, 0,
      '2026-04-30 09:18:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000012', @grp_unknown,
      NULL, 'DEMO-BLOCK-UNKNOWN-KO', '/TripTogether/api/internal/ping', 'GET',
      'GENERAL', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'API', 'internal-ping', 'UnknownHandler', NULL, '-',
      '203.0.113.200', 'UnknownClient/0.1', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가/계정 언어 판단 불가 시 한국어 기본 안내 대상',
      'IP', 'SINGLE_IP', 'IP:203.0.113.200', 'd2000000-2026-4029-8000-000000000024', NULL,
      '정책 기반 접근 제한', NULL, NULL, 'DB',
      'IP_BLOCK', @grp_unknown, NULL, '203.0.113.200',
      0, 1, 0,
      '2026-04-30 09:22:00'
    );

COMMIT;

-- 빠른 확인
-- SELECT request_id, block_kind, block_match_type, user_idx, ip_address,
--        source_action_type, source_action_group_id, source_user_idx, source_ip_address,
--        is_source_user_match, is_source_ip_match, is_source_user_ip_intersection, created_at
-- FROM BLOCK_ACCESS_LOG
-- WHERE detail_summary LIKE 'DEMO-BLOCK-LOG%'
-- ORDER BY created_at;
