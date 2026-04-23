package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDate;

/**
 * CHATBOT_DAILY_USAGE 테이블 매핑.
 * 유저(user_idx) / 비로그인(ip_address) 별 일일 메시지 발송 횟수 집계 (한도 체크용).
 */
@Data
public class ChatbotDailyUsageVO {

    private Long usageId;
    private Long userIdx;
    private String ipAddress;       // 비로그인 식별자 (IP)
    private LocalDate usageDate;
    private Integer messageCount;
}
