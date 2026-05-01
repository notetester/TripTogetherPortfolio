package org.triptogether.flight.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * FLIGHT_PURCHASE_SIMULATION 테이블 INSERT용 DTO.
 */
@Data
public class FlightPurchaseCreateDto {

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
