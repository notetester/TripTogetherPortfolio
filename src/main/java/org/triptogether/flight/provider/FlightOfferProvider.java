package org.triptogether.flight.provider;

import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.flight.vo.FlightOfferDto;

import java.util.List;
import java.util.Optional;

/**
 * 항공권 견적 제공자 인터페이스.
 *
 * 현재는 Mock 구현체를 사용하지만, Amadeus 같은 외부 API를 도입할 때는
 * 이 인터페이스를 구현한 Provider만 새로 만들면 서비스/화면 변경을 줄일 수 있다.
 */
public interface FlightOfferProvider {

    boolean supports(ExploreVO spot);

    List<FlightOfferDto> getOffers(ExploreVO spot);

    default Optional<FlightOfferDto> getLowestOffer(ExploreVO spot) {
        return getOffers(spot).stream()
                .min((left, right) -> Long.compare(left.getTotalPrice(), right.getTotalPrice()));
    }

    default Optional<FlightOfferDto> getOffer(ExploreVO spot, String offerId) {
        return getOffers(spot).stream()
                .filter(offer -> offer.getOfferId().equals(offerId))
                .findFirst();
    }
}
