package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityReportVO {
    private Long reportId;
    private Long reporterIdx;
    private String reporterUserId;
    private String reporterNickname;
    private String reason;
    private String status;
    private Date createdAt;
    private Date resolvedAt;
    private String resolveAction;
}
