-- =============================================
-- SPOT_TRAVEL 테이블에 spot_active, user_idx 컬럼 추가
-- =============================================
-- spot_active: 여행지 활성화 상태 (1=활성, 0=삭제됨)
-- user_idx: 여행지 등록자 FK (본인 게시글 수정/삭제 판별용)
-- ※ 프로젝트 실행 전에 반드시 실행해주세요.
-- =============================================

ALTER TABLE SPOT_TRAVEL
    ADD COLUMN spot_active INT NOT NULL DEFAULT 1
    COMMENT '여행지 활성 상태 (1=활성, 0=삭제됨)'
    AFTER review_count;

ALTER TABLE SPOT_TRAVEL
    ADD COLUMN user_idx BIGINT DEFAULT NULL
    COMMENT '등록자 FK (USERS.user_idx)'
    AFTER spot_active;
