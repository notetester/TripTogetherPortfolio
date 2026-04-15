package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminInquiryStatsVO {
    private int totalInquiries;       // 전체 문의 수
    private int pendingInquiries;     // 대기중 문의 수 (PENDING)
    private int inProgressInquiries;  // 처리중 문의 수 (IN_PROGRESS)
    private int completedInquiries;   // 완료 문의 수 (COMPLETED)
}
