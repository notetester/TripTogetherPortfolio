package org.triptogether.myPage.vo;

import lombok.Data;

import java.util.Date;

/**
 * 마이페이지 예매 정보 화면에 표시할 항공권 구매 이력 DTO.
 * FLIGHT_PURCHASE_SIMULATION 테이블을 기준으로 여행지명만 SPOT_TRAVEL에서 함께 조회한다.
 */
@Data
public class MyPageFlightBookingDto {

    private Long flightPurchaseIdx;
    private String purchaseNo;
    private Long spotIdx;
    private String spotName;

    private String airlineName;
    private String flightNo;
    private String originAirportCode;
    private String destinationAirportCode;
    private Date departureTime;
    private Date arrivalTime;

    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private String status;
    private Date createdAt;
}
