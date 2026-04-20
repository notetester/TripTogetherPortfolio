package org.triptogether.flight.service;

import org.triptogether.flight.vo.FlightOfferDto;
import org.triptogether.flight.vo.FlightPurchaseRequestDto;
import org.triptogether.flight.vo.FlightPurchaseResultDto;

import java.util.List;
import java.util.Optional;

public interface FlightService {

    boolean isFlightAvailable(Long spotIdx);

    Optional<FlightOfferDto> getLowestOffer(Long spotIdx);

    List<FlightOfferDto> getOffers(Long spotIdx);

    FlightPurchaseResultDto purchase(Long userIdx, FlightPurchaseRequestDto request);
}
