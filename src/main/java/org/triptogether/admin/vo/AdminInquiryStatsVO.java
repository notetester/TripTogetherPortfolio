package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminInquiryStatsVO {
    private int totalInquiries;
    private int pendingInquiries;
    private int inProgressInquiries;
    private int completedInquiries;
}
