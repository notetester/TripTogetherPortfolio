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
    private Long paymentIdx;
    private String purchaseNo;
    private Long spotIdx;
    private String spotName;

    private String airlineName;
    private String flightNo;
    private String originAirportCode;
    private String destinationAirportCode;
    private Date departureTime;
    private Date arrivalTime;
    private String tripType;
    private String returnAirlineName;
    private String returnFlightNo;
    private String returnOriginAirportCode;
    private String returnDestinationAirportCode;
    private Date returnDepartureTime;
    private Date returnArrivalTime;

    private long outboundPrice;
    private long returnPrice;
    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private long originalAmount;
    private double discountRate;
    private long discountAmount;
    private long finalAmount;
    private String paymentStatus;
    private Date paidAt;
    private String status;
    private Date createdAt;
}
