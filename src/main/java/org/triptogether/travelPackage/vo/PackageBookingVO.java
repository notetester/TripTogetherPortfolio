package org.triptogether.travelPackage.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * TRAVEL_PACKAGE_BOOKING 테이블의 예약 정보를 담는 VO.
 *
 * <p>예약 취소처럼 잔액을 되돌려야 하는 작업에서는
 * 같은 예약을 동시에 취소하지 못하도록 SELECT ... FOR UPDATE로 잠근 뒤 사용한다.</p>
 */
@Data
public class PackageBookingVO {

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
    private LocalDateTime bookedAt;
    private LocalDateTime cancelledAt;
    private String cancelReason;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getBookedAtDate() {
        return fromLocalDateTime(bookedAt);
    }

    public Date getCancelledAtDate() {
        return fromLocalDateTime(cancelledAt);
    }

}
