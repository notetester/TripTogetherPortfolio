-- TripTogether WAF mock provider routing and WAF sync status length fix
-- 적용 대상: MySQL 8.x / 기존 TripTogether 스키마
--
-- 원인:
-- - 데모/Mock WAF provider가 mock:// endpoint를 사용한다.
-- - 코드가 이를 실제 HTTP client로 흘려 보내면 invalid URI scheme mock 경고가 반복된다.
-- - 실패/pending 상태값 EXTERNAL_PROVIDER_PENDING은 25자이므로 기존 varchar(20)에 들어가지 않는다.
--
-- 코드 패치:
-- - MockWafSyncAdapter: DEMO_*, *_MOCK_*, MOCK_WAF_SERVICE, mock://, mock-* modelName을 로컬 mock 처리
-- - WafSyncHttpClient: http/https 외부 endpoint만 실제 HTTP 호출하고, mock/demo는 최후 방어선에서 SYNCED 처리

ALTER TABLE `LOGIN_RISK_WAF_SYNC_QUEUE`
  MODIFY `status` varchar(40) NOT NULL DEFAULT 'PENDING'
  COMMENT 'PENDING / SYNCED / FAILED / SKIPPED / EXTERNAL_PROVIDER_PENDING';

-- 기존 실패 큐 중 mock/demo provider invalid URI로 실패했던 건은 재처리할 수 있도록 필요 시 수동 실행
-- UPDATE LOGIN_RISK_WAF_SYNC_QUEUE
-- SET status = 'PENDING', detail_message = '[FIX] retry after local mock WAF routing fix', synced_at = NULL, updated_at = NOW()
-- WHERE status = 'FAILED'
--   AND detail_message LIKE '%invalid URI scheme mock%';
