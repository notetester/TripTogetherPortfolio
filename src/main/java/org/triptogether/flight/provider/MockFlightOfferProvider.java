package org.triptogether.flight.provider;

import org.springframework.stereotype.Component;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.flight.vo.FlightOfferDto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * 외부 항공권 API가 없을 때 사용하는 Mock 항공권 견적 제공자.
 *
 * 같은 여행지에는 항상 비슷한 가격이 나오도록 spotIdx 기반으로 가격을 계산한다.
 * 국내 여행지는 항공권 표시 대상에서 제외한다.
 */
@Component
public class MockFlightOfferProvider implements FlightOfferProvider {

    private static final double KOREA_MIN_LAT = 33.0;
    private static final double KOREA_MAX_LAT = 39.6;
    private static final double KOREA_MIN_LNG = 124.0;
    private static final double KOREA_MAX_LNG = 132.0;

    @Override
    public boolean supports(ExploreVO spot) {
        return spot != null
                && spot.getSpotIdx() != null
                && spot.getLatitude() != null
                && spot.getLongitude() != null
                && !isDomesticKorea(spot);
    }

    @Override
    public List<FlightOfferDto> getOffers(ExploreVO spot) {
        if (!supports(spot)) {
            return List.of();
        }

        AirportInfo destination = resolveDestinationAirport(spot);
        PriceRange priceRange = resolvePriceRange(spot);
        long seed = Math.abs(Objects.hash(spot.getSpotIdx(), destination.code()));
        long basePrice = priceRange.min() + (seed % Math.max(1, priceRange.max() - priceRange.min()));
        basePrice = roundToThousand(basePrice);

        LocalDateTime firstDeparture = LocalDateTime.now().plusDays(14).withHour(9).withMinute(20).withSecond(0).withNano(0);

        List<FlightOfferDto> offers = new ArrayList<>();
        offers.add(buildOffer(spot, destination, "Korean Air", "KE" + (700 + seed % 90), firstDeparture, 2, basePrice + 28000));
        offers.add(buildOffer(spot, destination, "Asiana Airlines", "OZ" + (300 + seed % 80), firstDeparture.plusHours(3), 2, basePrice + 45000));
        offers.add(buildOffer(spot, destination, resolveBudgetAirline(spot), "TT" + (100 + seed % 70), firstDeparture.plusHours(6), 2, basePrice));

        offers.sort(Comparator.comparingLong(FlightOfferDto::getTotalPrice));
        return offers;
    }

    private FlightOfferDto buildOffer(ExploreVO spot,
                                      AirportInfo destination,
                                      String airlineName,
                                      String flightNo,
                                      LocalDateTime departureTime,
                                      int durationOffset,
                                      long totalPrice) {
        FlightOfferDto offer = new FlightOfferDto();
        offer.setOfferId("MOCK-" + spot.getSpotIdx() + "-" + flightNo);
        offer.setSpotIdx(spot.getSpotIdx());
        offer.setAirlineName(airlineName);
        offer.setFlightNo(flightNo);
        offer.setOriginAirportCode("ICN");
        offer.setOriginAirportName("Seoul Incheon");
        offer.setDestinationAirportCode(destination.code());
        offer.setDestinationAirportName(destination.name());
        offer.setDepartureTime(departureTime);
        offer.setArrivalTime(departureTime.plusHours(destination.durationHours() + durationOffset));
        offer.setDurationText(destination.durationHours() + durationOffset + "시간");
        offer.setSeatClass("ECONOMY");
        offer.setTotalPrice(roundToThousand(totalPrice));
        // 서버 결제 검증도 "총액의 30%"를 상한으로 보므로 화면의 최대 사용값은
        // 반올림이 아니라 내림 처리해야 검증 상한을 넘지 않는다.
        offer.setMaxMileageUse(floorToThousand(offer.getTotalPrice() * 30 / 100));
        return offer;
    }

    private boolean isDomesticKorea(ExploreVO spot) {
        Double lat = spot.getLatitude();
        Double lng = spot.getLongitude();
        if (lat != null && lng != null
                && lat >= KOREA_MIN_LAT && lat <= KOREA_MAX_LAT
                && lng >= KOREA_MIN_LNG && lng <= KOREA_MAX_LNG) {
            return true;
        }

        String text = spotText(spot);
        return containsAny(text, "대한민국", "한국", "서울", "부산", "제주", "강원", "경기", "인천", "대구", "대전", "광주", "울산");
    }

    private AirportInfo resolveDestinationAirport(ExploreVO spot) {
        String text = spotText(spot);

        if (containsAny(text, "도쿄", "tokyo")) return new AirportInfo("NRT", "Tokyo Narita", 3);
        if (containsAny(text, "오사카", "교토", "osaka", "kyoto")) return new AirportInfo("KIX", "Osaka Kansai", 3);
        if (containsAny(text, "후쿠오카", "fukuoka")) return new AirportInfo("FUK", "Fukuoka", 2);
        if (containsAny(text, "일본", "japan")) return new AirportInfo("NRT", "Tokyo Narita", 3);

        if (containsAny(text, "상하이", "shanghai")) return new AirportInfo("PVG", "Shanghai Pudong", 3);
        if (containsAny(text, "베이징", "beijing")) return new AirportInfo("PEK", "Beijing Capital", 3);
        if (containsAny(text, "중국", "china")) return new AirportInfo("PVG", "Shanghai Pudong", 3);

        if (containsAny(text, "타이베이", "대만", "taipei", "taiwan")) return new AirportInfo("TPE", "Taipei Taoyuan", 3);
        if (containsAny(text, "방콕", "태국", "bangkok", "thailand")) return new AirportInfo("BKK", "Bangkok Suvarnabhumi", 6);
        if (containsAny(text, "다낭", "danang", "da nang")) return new AirportInfo("DAD", "Da Nang", 5);
        if (containsAny(text, "하노이", "hanoi")) return new AirportInfo("HAN", "Hanoi", 5);
        if (containsAny(text, "호치민", "hochiminh", "ho chi minh")) return new AirportInfo("SGN", "Ho Chi Minh", 5);
        if (containsAny(text, "베트남", "vietnam")) return new AirportInfo("DAD", "Da Nang", 5);

        if (containsAny(text, "파리", "프랑스", "paris", "france")) return new AirportInfo("CDG", "Paris Charles de Gaulle", 13);
        if (containsAny(text, "런던", "영국", "london", "uk", "england")) return new AirportInfo("LHR", "London Heathrow", 14);
        if (containsAny(text, "뉴욕", "new york")) return new AirportInfo("JFK", "New York JFK", 14);
        if (containsAny(text, "로스앤젤레스", "la", "los angeles")) return new AirportInfo("LAX", "Los Angeles", 12);

        return new AirportInfo("DEST", "Destination Airport", 8);
    }

    private PriceRange resolvePriceRange(ExploreVO spot) {
        String text = spotText(spot);
        if (containsAny(text, "일본", "japan", "도쿄", "오사카", "교토", "후쿠오카", "중국", "china", "상하이", "베이징", "대만", "taiwan")) {
            return new PriceRange(180_000, 450_000);
        }
        if (containsAny(text, "태국", "thailand", "방콕", "베트남", "vietnam", "다낭", "하노이", "호치민")) {
            return new PriceRange(250_000, 650_000);
        }
        if (containsAny(text, "프랑스", "france", "파리", "영국", "london", "유럽", "europe")) {
            return new PriceRange(850_000, 1_600_000);
        }
        if (containsAny(text, "미국", "usa", "new york", "뉴욕", "los angeles", "로스앤젤레스")) {
            return new PriceRange(900_000, 1_800_000);
        }
        return new PriceRange(500_000, 1_200_000);
    }

    private String resolveBudgetAirline(ExploreVO spot) {
        String text = spotText(spot);
        if (containsAny(text, "일본", "japan", "도쿄", "오사카", "후쿠오카")) return "Jeju Air";
        if (containsAny(text, "태국", "베트남", "대만")) return "T'way Air";
        return "TripTogether Air";
    }

    private String spotText(ExploreVO spot) {
        return String.join(" ",
                nullToBlank(spot.getName()),
                nullToBlank(spot.getRegion()),
                nullToBlank(spot.getAddress()),
                nullToBlank(spot.getDescription())
        ).toLowerCase(Locale.ROOT);
    }

    private boolean containsAny(String text, String... keywords) {
        for (String keyword : keywords) {
            if (text.contains(keyword.toLowerCase(Locale.ROOT))) {
                return true;
            }
        }
        return false;
    }

    private String nullToBlank(String value) {
        return value == null ? "" : value;
    }

    private long roundToThousand(long value) {
        return Math.round(value / 1000.0) * 1000;
    }

    private long floorToThousand(long value) {
        return (value / 1000) * 1000;
    }

    private record AirportInfo(String code, String name, int durationHours) {}

    private record PriceRange(long min, long max) {}
}
