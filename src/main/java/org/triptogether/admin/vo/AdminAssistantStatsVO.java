package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 관리자 AI 도우미(assistant) 대시보드 통계 VO.
 * CHAT_POST / CHAT_COMMENT 집계.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminAssistantStatsVO {

    private long totalSessions;
    private long totalMessages;
    private long userMessages;
    private long assistantMessages;

    private long todaySessions;
    private long todayMessages;

    private long uniqueUsers;
}
