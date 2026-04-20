package org.triptogether.flight.vo;

import lombok.Data;

import java.time.LocalDateTime;

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

    private String airlineName;
    private String flightNo;
    private String originAirportCode;
    private String originAirportName;
    private String destinationAirportCode;
    private String destinationAirportName;

    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String durationText;
    private String seatClass;

    private long totalPrice;
    private long maxMileageUse;
}
