-- TripTogether BLOCK_ACCESS_LOG 시연 데이터
-- 전제: docs/migration/20260429_block_access_log_and_cache.sql 적용 후 실행
-- 목적: 관리자 차단 접근 로그 화면/검색/필터/다운로드 시연용 다양한 차단 사례 구성

START TRANSACTION;

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
    block_reason, country_code, asn, cache_source, created_at
) VALUES
    (
      'bd000001-2026-4030-8000-000000000001', 'bf000001-2026-4030-8000-000000000001',
      (SELECT user_idx FROM USERS WHERE user_id = 'demo_block_target' LIMIT 1),
      'DEMO-BLOCK-USER-KO', '/TripTogether/mypage/profile', 'GET',
      'MYPAGE', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'USER', 'demo_block_target', 'MyPageController#profile', NULL, '/TripTogether/auth/login',
      '192.0.2.31', 'DemoBrowser/1.0 Chrome', 403, 2, 0,
      'DEMO-BLOCK-LOG 계정 상태 BLOCKED에 따른 마이페이지 접근 제한',
      'USER', 'ACCOUNT_STATUS', 'USER:demo_block_target', 'd2000000-2026-4029-8000-000000000013', NULL,
      '계정 보안 정책에 따른 이용 제한', 'KR', '4766', 'DB', '2026-04-30 09:00:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000002', 'bf000001-2026-4030-8000-000000000002',
      (SELECT user_idx FROM USERS WHERE user_id = 'demo_abuse_target' LIMIT 1),
      'DEMO-BLOCK-SIMULTANEOUS-IP', '/TripTogether/auth/login', 'POST',
      'AUTH', 'ACTION', 'BLOCKED_ACCESS', 'LOCAL', 'LOGIN',
      'USER', 'demo_abuse_target', 'AuthController#loginProcess', 'identifier=demo_abuse_target', '/TripTogether/auth/login',
      '198.51.100.77', 'DemoBot/1.0 Chrome', 403, 1, 0,
      'DEMO-BLOCK-LOG 계정+IP 동시 조치 중 IP 전역 차단',
      'IP', 'SINGLE_IP', 'IP:198.51.100.77', 'd2000000-2026-4029-8000-000000000014', NULL,
      '계정+IP 동시 조치 중 IP 접근 환경 제한', 'US', '64512', 'FILE', '2026-04-30 09:02:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000003', 'bf000001-2026-4030-8000-000000000003',
      NULL, 'DEMO-BLOCK-SINGLE-IP', '/TripTogether/admin', 'GET',
      'ADMIN', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'ADMIN', 'admin-home', 'AdminController#dashboard', NULL, '-',
      '198.51.100.77', 'curl/8.1 DemoScanner', 403, 1, 0,
      'DEMO-BLOCK-LOG 단일 IP 규칙으로 관리자 영역 접근 제한',
      'IP', 'SINGLE_IP', 'IP:198.51.100.77', 'd2000000-2026-4029-8000-000000000014', NULL,
      '관리자 영역 반복 접근 제한', 'US', '64512', 'FILE', '2026-04-30 09:04:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000004', 'bf000001-2026-4030-8000-000000000004',
      NULL, 'DEMO-BLOCK-CIDR', '/TripTogether/api/assistant/message', 'POST',
      'AI', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'AI_CHAT', 'assistant-message', 'AssistantController#message', NULL, '/TripTogether/assistant',
      '203.0.113.45', 'DemoApiClient/2.0', 403, 1, 0,
      'DEMO-BLOCK-LOG CIDR 대역 정책에 따른 AI API 요청 제한',
      'IP', 'CIDR', 'CIDR:203.0.113.0/24', 'd2000000-2026-4029-8000-000000000015', NULL,
      '고위험 CIDR 대역 접근 제한', 'US', '64513', 'DB', '2026-04-30 09:06:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000005', 'bf000001-2026-4030-8000-000000000005',
      NULL, 'DEMO-BLOCK-RANGE', '/TripTogether/community/write', 'POST',
      'COMMUNITY', 'ACTION', 'BLOCKED_ACCESS', NULL, NULL,
      'POST', 'community-write', 'CommunityController#write', NULL, '/TripTogether/community/list',
      '198.51.100.72', 'SpamClient/4.0', 403, 1, 0,
      'DEMO-BLOCK-LOG RANGE 규칙에 따른 커뮤니티 작성 제한',
      'IP', 'RANGE', 'RANGE:198.51.100.50~198.51.100.90', 'd2000000-2026-4029-8000-000000000016', NULL,
      '스팸성 요청 대역 제한', 'US', '64514', 'FILE', '2026-04-30 09:08:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000006', 'bf000001-2026-4030-8000-000000000006',
      NULL, 'DEMO-BLOCK-COUNTRY-CN', '/TripTogether/explore', 'GET',
      'EXPLORE', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'EXPLORE', 'explore-home', 'ExploreController#index', NULL, '-',
      '203.0.113.88', 'DemoBrowser/1.0', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가코드 CN 정책에 따른 접근 제한',
      'IP', 'COUNTRY', 'COUNTRY:CN', 'd2000000-2026-4029-8000-000000000017', NULL,
      '국가 기반 보안 정책 제한', 'CN', '4134', 'DB', '2026-04-30 09:10:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000007', 'bf000001-2026-4030-8000-000000000007',
      NULL, 'DEMO-BLOCK-COUNTRY-RU', '/TripTogether/auth/password/find', 'POST',
      'AUTH', 'ACTION', 'BLOCKED_ACCESS', 'LOCAL', 'PASSWORD_RESET',
      'AUTH', 'password-find', 'AuthController#forgotPasswordProcess', NULL, '/TripTogether/auth/login',
      '203.0.113.99', 'DemoBot/1.0', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가코드 RU 정책에 따른 계정 복구 요청 제한',
      'IP', 'COUNTRY', 'COUNTRY:RU', 'd2000000-2026-4029-8000-000000000018', NULL,
      '국가 기반 보안 정책 제한', 'RU', '12389', 'DB', '2026-04-30 09:12:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000008', 'bf000001-2026-4030-8000-000000000008',
      NULL, 'DEMO-BLOCK-ASN', '/TripTogether/chatbot/message', 'POST',
      'AI', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'CHATBOT', 'chatbot-message', 'ChatbotController#message', NULL, '/TripTogether/chatbot',
      '192.0.2.150', 'AbuseAutomation/1.2', 403, 1, 0,
      'DEMO-BLOCK-LOG ASN 정책에 따른 챗봇 남용 요청 제한',
      'IP', 'ASN', 'ASN:64515', 'd2000000-2026-4029-8000-000000000021', NULL,
      '고위험 ASN 접근 제한', 'SG', '64515', 'FILE', '2026-04-30 09:14:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000009', 'bf000001-2026-4030-8000-000000000009',
      (SELECT user_idx FROM USERS WHERE user_id = 'demo_partner' LIMIT 1),
      'DEMO-BLOCK-USER-JA', '/TripTogether/partner/dashboard', 'GET',
      'PARTNER', 'PAGE_VIEW', 'BLOCKED_ACCESS', NULL, NULL,
      'PARTNER', 'partner-dashboard', 'PartnerController#dashboard', NULL, '/TripTogether/auth/login',
      '192.0.2.44', 'DemoBrowser/1.0', 403, 2, 0,
      'DEMO-BLOCK-LOG 파트너 계정 임시 이용 제한. 계정 선호 언어 기반 JA 안내 대상',
      'USER', 'USER_ONLY', 'USER:demo_partner', 'd2000000-2026-4029-8000-000000000022', NULL,
      '파트너 계정 보안 검토에 따른 이용 제한', 'JP', '2516', 'DB', '2026-04-30 09:16:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000010', 'bf000001-2026-4030-8000-000000000010',
      (SELECT user_idx FROM USERS WHERE user_id = 'demo_business' LIMIT 1),
      'DEMO-BLOCK-BIZ-ZH', '/TripTogether/business/package/register', 'POST',
      'PACKAGE', 'ACTION', 'BLOCKED_ACCESS', NULL, NULL,
      'BUSINESS_PACKAGE', 'package-register', 'PackageController#register', NULL, '/TripTogether/business/package',
      '203.0.113.120', 'DemoBrowser/1.0', 403, 2, 0,
      'DEMO-BLOCK-LOG 비즈니스 계정 검토 중 등록 기능 제한. 중국어 안내 시연 대상',
      'USER', 'USER_ONLY', 'USER:demo_business', 'd2000000-2026-4029-8000-000000000023', NULL,
      '비즈니스 계정 검토 중 기능 제한', 'CN', '4812', 'DB', '2026-04-30 09:18:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000011', 'bf000001-2026-4030-8000-000000000011',
      NULL, 'DEMO-BLOCK-ADMIN-PROBE', '/TripTogether/admin/security/export', 'GET',
      'ADMIN', 'ACTION', 'BLOCKED_ACCESS', NULL, NULL,
      'EXPORT', 'security-export', 'AdminSecurityController#export', 'keyword=DEMO-BLOCK-LOG', '/TripTogether/admin/security',
      '198.51.100.88', 'HeadlessChrome DemoProbe', 403, 1, 0,
      'DEMO-BLOCK-LOG 차단된 IP에서 보안 이력 다운로드 시도',
      'IP', 'RANGE', 'RANGE:198.51.100.50~198.51.100.90', 'd2000000-2026-4029-8000-000000000016', NULL,
      '보안 이력 다운로드 접근 제한', 'US', '64514', 'FILE', '2026-04-30 09:20:00'
    ),
    (
      'bd000001-2026-4030-8000-000000000012', 'bf000001-2026-4030-8000-000000000012',
      NULL, 'DEMO-BLOCK-UNKNOWN-KO', '/TripTogether/api/internal/ping', 'GET',
      'GENERAL', 'API', 'BLOCKED_ACCESS', NULL, NULL,
      'API', 'internal-ping', 'UnknownHandler', NULL, '-',
      '203.0.113.200', 'UnknownClient/0.1', 403, 1, 0,
      'DEMO-BLOCK-LOG 국가/계정 언어 판단 불가 시 한국어 기본 안내 대상',
      'IP', 'SINGLE_IP', 'IP:203.0.113.200', 'd2000000-2026-4029-8000-000000000024', NULL,
      '정책 기반 접근 제한', NULL, NULL, 'DB', '2026-04-30 09:22:00'
    );

COMMIT;

-- 빠른 확인
-- SELECT request_id, block_kind, block_match_type, ip_address, country_code, asn, cache_source, created_at
-- FROM BLOCK_ACCESS_LOG
-- WHERE detail_summary LIKE 'DEMO-BLOCK-LOG%'
-- ORDER BY created_at;
