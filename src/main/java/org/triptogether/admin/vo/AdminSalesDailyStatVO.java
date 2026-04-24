package org.triptogether.admin.vo;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

/**
 * 관리자 매출 통계의 일자별 집계 DTO.
 *
 * <p>현재 프로젝트의 결제는 실제 PG 결제가 아니라 캐시/마일리지 차감 시뮬레이션이므로,
 * 총 거래 규모(totalPrice)와 실제 현금성 매출(usedCash)을 분리해서 보여준다.</p>
 */
@Getter
@Setter
public class AdminSalesDailyStatVO {

    private LocalDate salesDate;
    private long grossSales;
    private long cashSales;
    private long mileageUsed;
    private long cancelAmount;
    private long netSales;
    private long flightBookingCount;
    private long packageBookingCount;
    private long cancelCount;
}
