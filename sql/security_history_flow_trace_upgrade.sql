-- USER_SECURITY_HISTORY 에 request_id / flow_trace_id 컬럼 추가
-- 목적: 보안 이벤트를 USER_ACTIVITY_LOG 및 EMAIL_VERIFICATION 과 흐름(flow_trace_id)으로 연결

ALTER TABLE `USER_SECURITY_HISTORY`
    ADD COLUMN `request_id`    varchar(36) DEFAULT NULL COMMENT '연결된 HTTP 요청 식별자(UUID). USER_ACTIVITY_LOG.request_id 와 연결'
        AFTER `detail_message`,
    ADD COLUMN `flow_trace_id` varchar(36) DEFAULT NULL COMMENT '여러 요청에 걸친 흐름 식별자(UUID). 이메일 발송→검증 등 다단계 추적용'
        AFTER `request_id`,
    ADD KEY `idx_ush_request_id`    (`request_id`),
    ADD KEY `idx_ush_flow_trace_id` (`flow_trace_id`);
