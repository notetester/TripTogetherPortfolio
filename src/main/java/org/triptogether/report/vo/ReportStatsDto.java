package org.triptogether.report.vo;

import lombok.Data;

/**
 * 어드민 신고 관리 통계 VO
 */
@Data
public class ReportStatsDto {
    private int totalReports;
    private int inReviewReports;
    private int resolvedReports;
    private int dismissedReports;
}
