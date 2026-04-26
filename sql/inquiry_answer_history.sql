-- =============================================
-- INQUIRY_ANSWER_HISTORY - 문의 답변 수정/삭제 이력
-- =============================================
-- 답변 변경/삭제 시 이전 본문 보존용.
-- answer_id 는 답변 삭제 후에도 이력 보존을 위해 SET NULL 정책.
-- inquiry_id 는 문의 삭제 시 일괄 정리하도록 CASCADE.
-- =============================================

CREATE TABLE IF NOT EXISTS `INQUIRY_ANSWER_HISTORY` (
  `history_idx`         bigint      NOT NULL AUTO_INCREMENT          COMMENT '이력 PK',
  `answer_id`           bigint      DEFAULT NULL                     COMMENT '대상 답변 FK (답변 삭제 시 NULL)',
  `inquiry_id`          bigint      NOT NULL                         COMMENT '문의 FK (조회 편의용)',
  `prev_content`        text        NOT NULL                         COMMENT '변경 전 본문',
  `prev_admin_user_idx` bigint      NOT NULL                         COMMENT '변경 전 답변자',
  `changed_at`          datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '변경 시각',
  `changed_by`          bigint      NOT NULL                         COMMENT '변경/삭제 수행 어드민',
  `change_type`         varchar(10) NOT NULL                         COMMENT 'UPDATE / DELETE',
  PRIMARY KEY (`history_idx`),
  KEY `idx_iah_answer`  (`answer_id`,  `changed_at` DESC),
  KEY `idx_iah_inquiry` (`inquiry_id`, `changed_at` DESC),
  CONSTRAINT `fk_iah_answer`
      FOREIGN KEY (`answer_id`)  REFERENCES `INQUIRY_ANSWER` (`answer_id`)
      ON DELETE SET NULL,
  CONSTRAINT `fk_iah_inquiry`
      FOREIGN KEY (`inquiry_id`) REFERENCES `INQUIRY_POST`   (`inquiry_id`)
      ON DELETE CASCADE,
  CONSTRAINT `fk_iah_changed_by`
      FOREIGN KEY (`changed_by`) REFERENCES `USERS`          (`user_idx`)
      ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='문의 답변 변경 이력';
