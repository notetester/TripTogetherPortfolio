package org.triptogether.myPage.vo;

import lombok.Data;

import java.util.Date;

/**
 * 마이페이지 예매 정보 화면에서 보여줄 패키지 예약 내역 DTO.
 *
 * <p>TRAVEL_PACKAGE_BOOKING은 예약/결제 결과만 저장하고,
 * 패키지명과 여행지명은 TRAVEL_PACKAGE, SPOT_TRAVEL을 조인해서 화면 표시용으로 함께 조회한다.</p>
 */
@Data
public class MyPagePackageBookingDto {

    private Long packageBookingIdx;
    private String bookingNo;
    private Long packageIdx;
    private Long spotIdx;
    private String spotName;
    private String packageTitle;
    private String packageSummary;
    private String mainImagePath;
    private String sellerNickname;

    private Date startDate;
    private Date endDate;
    private int peopleCount;
    private long unitPrice;
    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private String bookingStatus;
    private Date bookedAt;
    private Date cancelledAt;
    private String cancelReason;
    public Date getBookedAtDate() {
        return bookedAt;
    }

    public Date getCancelledAtDate() {
        return cancelledAt;
    }

}
