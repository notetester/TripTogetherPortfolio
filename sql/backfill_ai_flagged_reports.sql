-- =============================================================
-- 백필 스크립트 (1회성)
--
-- 목적:
--   과거에 AI(Perspective)에 의해 ai_flagged=1 로 세팅됐지만
--   SYSTEM 봇(user_idx=18) 신고 레코드가 REPORT 테이블에 남지 않은
--   게시글/댓글을 찾아 봇 이름으로 신고를 소급 등록한다.
--   이후 관리자 신고 게시판에서 기존 BLUR 콘텐츠가 정상 노출된다.
--
-- 안전성:
--   - UNIQUE (user_idx, target_type, target_id) 제약 덕분에
--     이미 봇 신고가 있는 건은 자동 skip (NOT EXISTS + INSERT IGNORE 이중 방어)
--   - 실행 전/후 건수를 로그에 남기고 싶으면 각 INSERT 뒤에 SELECT 로 확인
--
-- 실행:
--   mysql -u<user> -p <db> < sql/backfill_ai_flagged_reports.sql
--   (또는 HeidiSQL / DBeaver 등에서 통째로 실행)
--
-- 롤백:
--   DELETE FROM REPORT
--   WHERE user_idx = 18
--     AND reason  = 'toxicity'
--     AND description LIKE '%(backfill)';
-- =============================================================

-- ── 1) 게시글 백필 ──────────────────────────────────────────
INSERT IGNORE INTO REPORT
    (user_idx, target_type, target_id, reason, description,
     status,      created_at, updated_at)
SELECT
    18, 'post', p.post_id, 'toxicity', 'AI 민감도 분석 감지 (backfill)',
    'IN_REVIEW', NOW(),      NOW()
FROM COMMUNITY_POST p
WHERE p.ai_flagged = 1
  AND NOT EXISTS (
      SELECT 1 FROM REPORT r
      WHERE r.user_idx    = 18
        AND r.target_type = 'post'
        AND r.target_id   = p.post_id
  );

-- ── 2) 댓글 백필 ────────────────────────────────────────────
INSERT IGNORE INTO REPORT
    (user_idx, target_type, target_id, reason, description,
     status,      created_at, updated_at)
SELECT
    18, 'comment', c.comment_id, 'toxicity', 'AI 민감도 분석 감지 (backfill)',
    'IN_REVIEW', NOW(),         NOW()
FROM COMMUNITY_COMMENT c
WHERE c.ai_flagged = 1
  AND NOT EXISTS (
      SELECT 1 FROM REPORT r
      WHERE r.user_idx    = 18
        AND r.target_type = 'comment'
        AND r.target_id   = c.comment_id
  );

-- ── 검증 쿼리 (선택) ────────────────────────────────────────
-- 실행 후 봇 신고가 몇 건 소급 등록됐는지 확인
-- SELECT COUNT(*) AS backfilled
-- FROM REPORT
-- WHERE user_idx = 18
--   AND description LIKE '%(backfill)';
