package org.triptogether.flight.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * FLIGHT_PURCHASE_SIMULATION 테이블의 항공권 예매 정보를 담는 VO.
 *
 * <p>항공권 취소 시에는 같은 예매 건이 중복 취소되지 않도록
 * SELECT ... FOR UPDATE로 잠근 뒤 잔액 환불과 상태 변경을 한 트랜잭션에서 처리한다.</p>
 */
@Data
public class FlightPurchaseVO {

    private Long flightPurchaseIdx;
    private String purchaseNo;
    private Long userIdx;
    private Long spotIdx;
    private String offerId;
    private String providerType;
    private Long paymentIdx;

    private String airlineName;
    private String flightNo;
    private String originAirportCode;
    private String destinationAirportCode;
    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String tripType;
    private String returnAirlineName;
    private String returnFlightNo;
    private String returnOriginAirportCode;
    private String returnDestinationAirportCode;
    private LocalDateTime returnDepartureTime;
    private LocalDateTime returnArrivalTime;

    private long outboundPrice;
    private long returnPrice;
    private long totalPrice;
    private long usedCash;
    private long usedMileage;
    private String status;
    private String cancelReason;
    private LocalDateTime createdAt;
}
