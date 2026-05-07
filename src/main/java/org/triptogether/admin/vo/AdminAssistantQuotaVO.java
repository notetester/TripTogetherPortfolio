package org.triptogether.admin.vo;

import lombok.Data;
import java.util.Date;

/**
 * ADMIN_ASSISTANT_GRADE_QUOTA 테이블 매핑.
 * 등급별 AI 도우미 사용 한도. 관리자 페이지에서 편집 가능.
 */
@Data
public class AdminAssistantQuotaVO {

    private Integer quotaId;
    private String grade;                  // GUEST/BRONZE/SILVER/GOLD/DIAMOND/PLATINUM
    private Integer maxSessions;           // 동시 보유 세션(CHAT_POST) 수 한도
    private Integer maxMessagesPerPeriod;  // 주기당 유저 메시지 한도
    private Integer periodDays;            // 한도 주기 (일)
    private Integer resetHour;             // 리셋 시각 시 (0-23)
    private Integer resetMinute;           // 리셋 시각 분 (0-59)
    private Boolean quotaRefundEnabled;    // 세션 삭제 시 사용량 환급 허용 여부
    private Long updatedBy;
    private Date updatedAt;  // JSP fmt:formatDate 호환 위해 Date 사용

    /** JOIN으로 채움 (DB 컬럼 아님) - 마지막 수정자 표시용 */
    private String updaterNickname;
    public Date getUpdatedAtDate() {
        return updatedAt;
    }

}
