package org.triptogether.travelPackage.vo;

import lombok.Data;

/**
 * 패키지 예약/결제 시뮬레이션 요청값.
 */
@Data
public class PackageBookingRequestVO {
    private Long packageIdx;
    private Integer peopleCount;
    private Long mileageAmount;
}
