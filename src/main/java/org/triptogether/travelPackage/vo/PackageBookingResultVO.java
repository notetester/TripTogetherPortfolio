package org.triptogether.travelPackage.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.triptogether.auth.vo.UsersVO;

/**
 * 패키지 예약 완료 후 화면에 돌려줄 결과값.
 */
@Data
@AllArgsConstructor
public class PackageBookingResultVO {
    private Long packageBookingIdx;
    private String bookingNo;
    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private UsersVO user;
}
