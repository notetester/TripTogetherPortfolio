package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * CHATBOT_DAILY_USAGE 테이블 매핑.
 * 유저(user_idx) / 비로그인(ip_address) 별 주기당 메시지 발송 횟수 집계 (한도 체크용).
 * 주기 시작 시각(period_start)은 ChatbotQuotaService.calculateCurrentPeriodStart 로 계산.
 */
@Data
public class ChatbotDailyUsageVO {

    private Long usageId;
    private Long userIdx;
    private String ipAddress;          // 비로그인 식별자 (IP)
    private LocalDateTime periodStart; // 현재 주기의 시작 시각
    private Integer messageCount;
}
