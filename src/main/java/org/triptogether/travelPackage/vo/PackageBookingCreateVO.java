package org.triptogether.travelPackage.vo;

import lombok.Data;

/**
 * TRAVEL_PACKAGE_BOOKING 저장용 DTO.
 */
@Data
public class PackageBookingCreateVO {
    private Long packageBookingIdx;
    private String bookingNo;
    private Long packageIdx;
    private Long userIdx;
    private int peopleCount;
    private long unitPrice;
    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private String bookingStatus;
}
