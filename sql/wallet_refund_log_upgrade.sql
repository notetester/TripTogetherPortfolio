-- =========================================================================
-- wallet_refund_log_upgrade.sql
--
-- 어드민 환불 처리 audit (D안 진행 / Phase 11)
--
-- - WALLET_REFUND_LOG : 누가 / 언제 / 왜 / 어떤 결제를 환불했는지
-- - USER_PAYMENT_HISTORY.payment_status 는 'REFUNDED' 로 갱신
-- - USER_WALLET_HISTORY 에 REFUND 변동 행이 함께 기록됨
-- =========================================================================

CREATE TABLE IF NOT EXISTS `WALLET_REFUND_LOG` (
    `refund_log_idx`        BIGINT       AUTO_INCREMENT PRIMARY KEY,
    `payment_idx`           BIGINT       NOT NULL COMMENT 'USER_PAYMENT_HISTORY.payment_idx',
    `user_idx`              BIGINT       NOT NULL COMMENT '환불 대상 회원',
    `refund_amount`         BIGINT       NOT NULL COMMENT '환불 금액(KRW)',
    `refund_reason`         VARCHAR(500) NOT NULL COMMENT '환불 사유 (어드민 입력)',
    `toss_cancel_status`    VARCHAR(50)  DEFAULT NULL COMMENT '토스 취소 응답 상태(있을 경우)',
    `refunded_by_user_idx`  BIGINT       NOT NULL COMMENT '환불 처리한 어드민 user_idx',
    `refunded_at`           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY `idx_wrl_payment` (`payment_idx`),
    KEY `idx_wrl_user`    (`user_idx`),
    KEY `idx_wrl_admin`   (`refunded_by_user_idx`),
    CONSTRAINT `fk_wrl_payment`  FOREIGN KEY (`payment_idx`)         REFERENCES `USER_PAYMENT_HISTORY`(`payment_idx`) ON DELETE RESTRICT,
    CONSTRAINT `fk_wrl_user`     FOREIGN KEY (`user_idx`)            REFERENCES `USERS`(`user_idx`)                  ON DELETE RESTRICT,
    CONSTRAINT `fk_wrl_admin`    FOREIGN KEY (`refunded_by_user_idx`) REFERENCES `USERS`(`user_idx`)                  ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='어드민 내지갑 환불 audit 로그';
