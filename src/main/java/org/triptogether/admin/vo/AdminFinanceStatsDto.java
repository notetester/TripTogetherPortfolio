package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 어드민 내지갑 대시보드 - 자산 집계 통계.
 */
@Data
public class AdminFinanceStatsDto {

    private long totalCashBalance;
    private long totalMileageBalance;
    private long totalPointBalance;

    private int totalUsers;
    private int activeUsers;     // ACTIVE 상태
    private int blockedUsers;    // BLOCKED

    private long todayChargeTotal;     // 오늘 충전 합계 (CASH)
    private long lastMonthChargeTotal; // 지난 30일 충전 합계
}
