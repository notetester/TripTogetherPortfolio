package org.triptogether.flight.service;

import org.triptogether.flight.vo.FlightOfferDto;
import org.triptogether.flight.vo.FlightPurchaseRequestDto;
import org.triptogether.flight.vo.FlightPurchaseResultDto;
import org.triptogether.auth.vo.UsersVO;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface FlightService {

    boolean isFlightAvailable(Long spotIdx);

    Optional<FlightOfferDto> getLowestOffer(Long spotIdx);

    Optional<FlightOfferDto> getLowestOffer(Long spotIdx, Long userIdx);

    List<FlightOfferDto> getOffers(Long spotIdx);

    List<FlightOfferDto> getOffers(Long spotIdx, LocalDate departureDate, LocalDate returnDate);

    List<FlightOfferDto> getOffers(Long spotIdx, LocalDate departureDate, LocalDate returnDate, Long userIdx);

    FlightPurchaseResultDto purchase(Long userIdx, FlightPurchaseRequestDto request);

    UsersVO cancelPurchase(Long userIdx, Long flightPurchaseIdx, String cancelReason);
}
