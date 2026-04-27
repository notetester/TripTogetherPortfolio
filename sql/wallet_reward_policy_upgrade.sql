-- =========================================================================
-- wallet_reward_policy_upgrade.sql
--
-- 적립률 / 고정 적립량 정책 (D안 진행 / Phase 13 즉시 단계)
--
-- 즉시 단계: 정책 정의 + 어드민 CRUD + 조회 API 만 제공.
-- 적용 단계: 기존 적립 호출부를 정책 조회로 교체하는 작업은 다음 phase 에서 점진적 진행.
-- =========================================================================

CREATE TABLE IF NOT EXISTS `WALLET_REWARD_POLICY` (
    `policy_idx`           BIGINT       AUTO_INCREMENT PRIMARY KEY,
    `event_type`           VARCHAR(50)  NOT NULL COMMENT '이벤트 코드 (CASH_CHARGE_BONUS / COMMUNITY_POST / PLAN_COMPLETE / LEVEL_UP ...)',
    `member_grade`         VARCHAR(20)  NOT NULL DEFAULT 'ALL' COMMENT '회원 등급 (ALL = 전체)',
    `reward_type`          VARCHAR(20)  NOT NULL COMMENT 'MILEAGE / POINT',
    `reward_rate`          DECIMAL(5,2) DEFAULT NULL COMMENT '적립률(%) — 비율형',
    `reward_fixed`         BIGINT       DEFAULT NULL COMMENT '고정 적립량 — 정액형',
    `description`          VARCHAR(255) DEFAULT NULL,
    `is_active`            TINYINT(1)   NOT NULL DEFAULT 1,
    `created_by_user_idx`  BIGINT       DEFAULT NULL,
    `created_at`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_by_user_idx`  BIGINT       DEFAULT NULL,
    `updated_at`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `uq_wrp_event_grade` (`event_type`, `member_grade`),
    KEY `idx_wrp_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='이벤트별 적립률/고정량 정책';

-- 초기 시드 (현재 코드와 동일한 디폴트, 정책으로 선언만 해두어 향후 변경 추적 가능)
INSERT INTO `WALLET_REWARD_POLICY`
    (`event_type`, `member_grade`, `reward_type`, `reward_rate`, `reward_fixed`, `description`, `is_active`)
VALUES
    ('CASH_CHARGE_BONUS', 'ALL',      'MILEAGE', 10.00, NULL, '캐시 충전 시 마일리지 적립률 (기본)', 1),
    ('CASH_CHARGE_BONUS', 'GOLD',     'MILEAGE', 12.00, NULL, '골드 등급 캐시 충전 적립률',          1),
    ('CASH_CHARGE_BONUS', 'DIAMOND',  'MILEAGE', 13.00, NULL, '다이아 등급 캐시 충전 적립률',        1),
    ('CASH_CHARGE_BONUS', 'PLATINUM', 'MILEAGE', 15.00, NULL, '플래티넘 등급 캐시 충전 적립률',      1),
    ('COMMUNITY_POST',    'ALL',      'POINT',   NULL,  50,   '커뮤니티 글 작성 보상 (포인트)',      1),
    ('COMMUNITY_COMMENT', 'ALL',      'POINT',   NULL,  5,    '커뮤니티 댓글 작성 보상',            1),
    ('PLAN_COMPLETE',     'ALL',      'POINT',   NULL,  200,  '여행 일정 완료 보상',                1),
    ('LEVEL_UP',          'ALL',      'MILEAGE', NULL,  1000, '레벨 업 보너스 마일리지',            1)
ON DUPLICATE KEY UPDATE
    `reward_type`  = VALUES(`reward_type`),
    `reward_rate`  = VALUES(`reward_rate`),
    `reward_fixed` = VALUES(`reward_fixed`),
    `description`  = VALUES(`description`),
    `is_active`    = VALUES(`is_active`);
