package org.triptogether.flight.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 화면에 보여줄 항공권 Mock 견적 DTO.
 *
 * 실제 외부 항공권 API를 붙일 때도 컨트롤러/JSP는 이 DTO만 바라보게 만들면
 * provider 구현체만 교체해서 구조를 유지할 수 있다.
 */
@Data
public class FlightOfferDto {

    private String offerId;
    private Long spotIdx;
    private String tripType;

    private String airlineName;
    private String flightNo;
    private String originAirportCode;
    private String originAirportName;
    private String destinationAirportCode;
    private String destinationAirportName;

    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String returnAirlineName;
    private String returnFlightNo;
    private String returnOriginAirportCode;
    private String returnDestinationAirportCode;
    private LocalDateTime returnDepartureTime;
    private LocalDateTime returnArrivalTime;
    private String durationText;
    private String seatClass;

    private long outboundPrice;
    private long returnPrice;

    // 할인 전 왕복 항공권 금액입니다. 기존 화면 호환을 위해 totalPrice 이름을 유지합니다.
    private long totalPrice;

    // 회원 등급 정책(MEMBER_GRADE_POLICY)에 따라 계산된 할인 정보입니다.
    private String memberGrade;
    private double discountRate;
    private long discountAmount;
    private long finalPrice;

    private long maxMileageUse;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getDepartureTimeDate() {
        return fromLocalDateTime(departureTime);
    }

    public Date getArrivalTimeDate() {
        return fromLocalDateTime(arrivalTime);
    }

    public Date getReturnDepartureTimeDate() {
        return fromLocalDateTime(returnDepartureTime);
    }

    public Date getReturnArrivalTimeDate() {
        return fromLocalDateTime(returnArrivalTime);
    }

}
