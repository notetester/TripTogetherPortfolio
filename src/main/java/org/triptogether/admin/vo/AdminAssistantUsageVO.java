package org.triptogether.admin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * ADMIN_ASSISTANT_DAILY_USAGE 테이블 매핑.
 * 유저(user_idx) 또는 IP별 주기당 사용량 집계 (한도 enforce + 관리 통계).
 */
@Data
public class AdminAssistantUsageVO {

    private Long usageId;
    private Long userIdx;
    private String ipAddress;          // 비로그인 식별자 (현재 assistant는 로그인 필수이나 통계 확장 대비)
    private LocalDateTime periodStart; // 현재 주기 시작 시각(KST)
    private Integer sessionCount;      // 해당 주기 신규 세션 수 (참고용)
    private Integer messageCount;      // 해당 주기 유저 메시지 수 (enforce 대상)

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getPeriodStartDate() {
        return fromLocalDateTime(periodStart);
    }

}
