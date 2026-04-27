-- =========================================================================
-- wallet_limit_policy_upgrade.sql
--
-- 회원 등급별 충전 한도 정책 (D안 진행 / Phase 12)
--
-- - WALLET_LIMIT_POLICY : 등급별 (1회/일/월) 충전 한도 정의
-- - 정책 행이 없는 등급은 한도 무제한으로 간주 (FAIL-OPEN)
-- - AOP 가 WalletService.simulateCashCharge / prepareTossCharge 진입 시 검증
-- =========================================================================

CREATE TABLE IF NOT EXISTS `WALLET_LIMIT_POLICY` (
    `policy_idx`           BIGINT AUTO_INCREMENT PRIMARY KEY,
    `member_grade`         VARCHAR(20)  NOT NULL COMMENT '회원 등급 (BRONZE/SILVER/GOLD/DIAMOND/PLATINUM)',
    `single_limit`         BIGINT       DEFAULT NULL COMMENT '1회 충전 한도 (NULL = 무제한)',
    `daily_limit`          BIGINT       DEFAULT NULL COMMENT '일일 충전 한도',
    `monthly_limit`        BIGINT       DEFAULT NULL COMMENT '월 충전 한도',
    `is_active`            TINYINT(1)   NOT NULL DEFAULT 1,
    `created_by_user_idx`  BIGINT       DEFAULT NULL,
    `created_at`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_by_user_idx`  BIGINT       DEFAULT NULL,
    `updated_at`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `uq_wlp_grade` (`member_grade`),
    KEY `idx_wlp_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 등급별 충전 한도 정책';

-- 초기 시드 (운영 시 어드민에서 자유롭게 조정)
INSERT INTO `WALLET_LIMIT_POLICY` (`member_grade`, `single_limit`, `daily_limit`, `monthly_limit`, `is_active`) VALUES
    ('BRONZE',    300000,   500000,  3000000, 1),
    ('SILVER',    500000,  1000000,  5000000, 1),
    ('GOLD',      800000,  2000000, 10000000, 1),
    ('DIAMOND',  1500000,  3000000, 20000000, 1),
    ('PLATINUM', 3000000,  5000000, 50000000, 1) AS new_row
ON DUPLICATE KEY UPDATE
    `single_limit`  = new_row.`single_limit`,
    `daily_limit`   = new_row.`daily_limit`,
    `monthly_limit` = new_row.`monthly_limit`,
    `is_active`     = new_row.`is_active`;
