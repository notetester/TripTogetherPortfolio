package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * CHATBOT_GRADE_QUOTA 테이블 매핑.
 * 관리자 페이지에서 등급별 한도를 편집 가능.
 */
@Data
public class ChatbotQuotaVO {

    private Integer quotaId;
    private String grade;                  // GUEST/BRONZE/SILVER/GOLD/DIAMOND/PLATINUM
    private Integer maxConversations;      // 동시 보유 대화 수 한도
    private Integer maxMessagesPerPeriod;  // 주기당 메시지 한도
    private Integer maxContextMessages;    // AI에 전달할 최근 메시지 수
    private Integer periodDays;            // 한도 주기 (일: 1/2/3/4/5/7/14/30)
    private Integer resetHour;             // 리셋 시각 시 (0-23)
    private Integer resetMinute;           // 리셋 시각 분 (0-59)
    private Boolean quotaRefundEnabled;    // 대화 삭제 시 사용량 환급 허용 여부 (true=허용)
    private Long updatedBy;
    private String updaterNickname;        // JOIN으로 채움 (DB 컬럼 아님) — 마지막 수정자 표시용
    private LocalDateTime updatedAt;
}
