package org.triptogether.report.vo;

import lombok.Data;

/**
 * 어드민 신고 관리 통계 VO
 */
@Data
public class ReportStatsDto {

    /** 전체 신고 건수 */
    private int totalReports;

    /** 검토중 신고 건수 */
    private int inReviewReports;

    /** 처리완료 신고 건수 */
    private int resolvedReports;

    /** 반려 신고 건수 */
    private int dismissedReports;
}
