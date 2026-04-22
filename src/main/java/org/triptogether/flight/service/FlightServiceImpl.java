package org.triptogether.flight.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.flight.mapper.FlightMapper;
import org.triptogether.flight.provider.FlightOfferProvider;
import org.triptogether.flight.vo.FlightOfferDto;
import org.triptogether.flight.vo.FlightPurchaseCreateDto;
import org.triptogether.flight.vo.FlightPurchaseRequestDto;
import org.triptogether.flight.vo.FlightPurchaseResultDto;
import org.triptogether.flight.vo.FlightPurchaseVO;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FlightServiceImpl implements FlightService {

    private static final long MAX_MILEAGE_RATE = 30;

    private final ExploreService exploreService;
    private final FlightOfferProvider flightOfferProvider;
    private final FlightMapper flightMapper;
    private final WalletMapper walletMapper;

    @Override
    public boolean isFlightAvailable(Long spotIdx) {
        return getSpot(spotIdx)
                .map(flightOfferProvider::supports)
                .orElse(false);
    }

    @Override
    public Optional<FlightOfferDto> getLowestOffer(Long spotIdx) {
        return getLowestOffer(spotIdx, null);
    }

    @Override
    public Optional<FlightOfferDto> getLowestOffer(Long spotIdx, Long userIdx) {
        LocalDate departureDate = LocalDate.now().plusDays(14);
        LocalDate returnDate = departureDate.plusDays(5);
        return getOffers(spotIdx, departureDate, returnDate, userIdx).stream()
                .min((left, right) -> Long.compare(left.getFinalPrice(), right.getFinalPrice()));
    }

    @Override
    public List<FlightOfferDto> getOffers(Long spotIdx) {
        LocalDate departureDate = LocalDate.now().plusDays(14);
        LocalDate returnDate = departureDate.plusDays(5);
        return getOffers(spotIdx, departureDate, returnDate);
    }

    @Override
    public List<FlightOfferDto> getOffers(Long spotIdx, LocalDate departureDate, LocalDate returnDate) {
        return getOffers(spotIdx, departureDate, returnDate, null);
    }

    @Override
    public List<FlightOfferDto> getOffers(Long spotIdx, LocalDate departureDate, LocalDate returnDate, Long userIdx) {
        LocalDate safeDepartureDate = resolveDepartureDate(departureDate);
        LocalDate safeReturnDate = resolveReturnDate(safeDepartureDate, returnDate);
        UsersVO user = userIdx != null ? walletMapper.selectUserByIdx(userIdx) : null;
        BigDecimal discountRate = resolveDiscountRate(user);

        return getSpot(spotIdx)
                .filter(flightOfferProvider::supports)
                .map(spot -> flightOfferProvider.getOffers(spot, safeDepartureDate, safeReturnDate))
                .map(offers -> applyMemberDiscounts(offers, user, discountRate))
                .orElse(List.of());
    }

    @Override
    @Transactional
    public FlightPurchaseResultDto purchase(Long userIdx, FlightPurchaseRequestDto request) {
        validatePurchaseRequest(userIdx, request);

        ExploreVO spot = getSpot(request.getSpotIdx())
                .orElseThrow(() -> new IllegalArgumentException("여행지 정보를 찾을 수 없습니다."));

        FlightOfferDto offer = flightOfferProvider.getOffer(spot, request.getDepartureDate(), request.getReturnDate(), request.getOfferId())
                .orElseThrow(() -> new IllegalArgumentException("항공권 견적 정보를 찾을 수 없습니다."));

        final UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        BigDecimal discountRate = resolveDiscountRate(user);
        applyMemberDiscount(offer, user, discountRate);

        long finalPrice = offer.getFinalPrice();
        long cashAmount = request.getCashAmount();
        long mileageAmount = request.getMileageAmount();

        if (cashAmount < 0 || mileageAmount < 0) {
            throw new IllegalArgumentException("결제 금액은 0 이상이어야 합니다.");
        }
        if (cashAmount + mileageAmount != finalPrice) {
            throw new IllegalArgumentException("캐시와 마일리지 합계가 항공권 금액과 일치해야 합니다.");
        }

        long maxMileageUse = floorToThousand(finalPrice * MAX_MILEAGE_RATE / 100);
        if (mileageAmount > maxMileageUse) {
            throw new IllegalArgumentException("마일리지는 항공권 금액의 30%까지만 사용할 수 있습니다.");
        }

        if (user == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (user.getCashBalance() < cashAmount) {
            throw new IllegalStateException("캐시 잔액이 부족합니다.");
        }
        if (user.getMileageBalance() < mileageAmount) {
            throw new IllegalStateException("마일리지 잔액이 부족합니다.");
        }

        long cashAfter = user.getCashBalance() - cashAmount;
        long mileageAfter = user.getMileageBalance() - mileageAmount;
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        WalletPaymentDto payment = buildPaymentHistory(userIdx, spot, offer, cashAmount, mileageAmount);
        walletMapper.insertPaymentHistory(payment);

        insertWalletHistory(userIdx, "CASH", cashAmount, cashAfter, payment.getPaymentIdx(), spot.getName() + " 항공권 캐시 결제");
        if (mileageAmount > 0) {
            insertWalletHistory(userIdx, "MILEAGE", mileageAmount, mileageAfter, payment.getPaymentIdx(), spot.getName() + " 항공권 마일리지 결제");
        }

        FlightPurchaseCreateDto purchase = buildFlightPurchase(userIdx, spot, offer, payment.getPaymentIdx(), cashAmount, mileageAmount);
        flightMapper.insertFlightPurchase(purchase);

        UsersVO updatedUser = walletMapper.selectUserByIdx(userIdx);
        return new FlightPurchaseResultDto(purchase.getFlightPurchaseIdx(), purchase.getPurchaseNo(), offer, updatedUser);
    }

    @Override
    @Transactional
    public UsersVO cancelPurchase(Long userIdx, Long flightPurchaseIdx, String cancelReason) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (flightPurchaseIdx == null) {
            throw new IllegalArgumentException("취소할 항공권 예매 정보가 없습니다.");
        }

        FlightPurchaseVO purchase = flightMapper.selectFlightPurchaseForUpdate(flightPurchaseIdx, userIdx);
        if (purchase == null) {
            throw new IllegalArgumentException("취소할 항공권 예매 정보를 찾을 수 없습니다.");
        }
        if (!"COMPLETED".equals(purchase.getStatus())) {
            throw new IllegalStateException("예매완료 상태의 항공권만 취소할 수 있습니다.");
        }

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("회원 정보를 찾을 수 없습니다.");
        }

        long cashAfter = safeAdd(user.getCashBalance(), purchase.getUsedCash());
        long mileageAfter = safeAdd(user.getMileageBalance(), purchase.getUsedMileage());
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        String reason = normalizeCancelReason(cancelReason);
        int updated = flightMapper.cancelFlightPurchase(flightPurchaseIdx, userIdx, reason);
        if (updated == 0) {
            throw new IllegalStateException("이미 취소되었거나 취소할 수 없는 항공권입니다.");
        }

        if (purchase.getPaymentIdx() != null) {
            walletMapper.cancelPaymentHistory(purchase.getPaymentIdx(), userIdx);
        }

        insertRefundWalletHistory(userIdx, "CASH", purchase.getUsedCash(), cashAfter, purchase.getPaymentIdx(),
                purchase.getPurchaseNo() + " 항공권 예매 취소 캐시 환불");
        if (purchase.getUsedMileage() > 0) {
            insertRefundWalletHistory(userIdx, "MILEAGE", purchase.getUsedMileage(), mileageAfter, purchase.getPaymentIdx(),
                    purchase.getPurchaseNo() + " 항공권 예매 취소 마일리지 환불");
        }

        return walletMapper.selectUserByIdx(userIdx);
    }

    private Optional<ExploreVO> getSpot(Long spotIdx) {
        if (spotIdx == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(exploreService.getSpotDetail(spotIdx, null));
    }

    private void validatePurchaseRequest(Long userIdx, FlightPurchaseRequestDto request) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (request == null || request.getSpotIdx() == null || request.getOfferId() == null || request.getOfferId().isBlank()) {
            throw new IllegalArgumentException("항공권 구매 정보가 올바르지 않습니다.");
        }
        validateTravelDates(request.getDepartureDate(), request.getReturnDate());
    }

    private void validateTravelDates(LocalDate departureDate, LocalDate returnDate) {
        if (departureDate == null || returnDate == null) {
            throw new IllegalArgumentException("출발일과 귀국일을 선택해주세요.");
        }
        LocalDate today = LocalDate.now();
        if (!departureDate.isAfter(today)) {
            throw new IllegalArgumentException("출발일은 오늘 이후 날짜로 선택해주세요.");
        }
        if (!returnDate.isAfter(departureDate)) {
            throw new IllegalArgumentException("귀국일은 출발일 이후 날짜로 선택해주세요.");
        }
    }

    private LocalDate resolveDepartureDate(LocalDate departureDate) {
        LocalDate defaultDepartureDate = LocalDate.now().plusDays(14);
        if (departureDate == null || !departureDate.isAfter(LocalDate.now())) {
            return defaultDepartureDate;
        }
        return departureDate;
    }

    private LocalDate resolveReturnDate(LocalDate departureDate, LocalDate returnDate) {
        if (returnDate == null || !returnDate.isAfter(departureDate)) {
            return departureDate.plusDays(5);
        }
        return returnDate;
    }

    private List<FlightOfferDto> applyMemberDiscounts(List<FlightOfferDto> offers,
                                                       UsersVO user,
                                                       BigDecimal discountRate) {
        offers.forEach(offer -> applyMemberDiscount(offer, user, discountRate));
        return offers;
    }

    private void applyMemberDiscount(FlightOfferDto offer,
                                     UsersVO user,
                                     BigDecimal discountRate) {
        BigDecimal safeDiscountRate = discountRate != null ? discountRate : BigDecimal.ZERO;
        long originalPrice = offer.getTotalPrice();
        long discountAmount = calculateDiscountAmount(originalPrice, safeDiscountRate);
        long finalPrice = Math.max(0, originalPrice - discountAmount);

        offer.setMemberGrade(user != null ? user.getMemberGrade() : "BRONZE");
        offer.setDiscountRate(safeDiscountRate.doubleValue());
        offer.setDiscountAmount(discountAmount);
        offer.setFinalPrice(finalPrice);
        // 할인 적용 후 실제 결제금액 기준으로 마일리지 최대 사용 가능액을 다시 계산합니다.
        offer.setMaxMileageUse(floorToThousand(finalPrice * MAX_MILEAGE_RATE / 100));
    }

    private BigDecimal resolveDiscountRate(UsersVO user) {
        if (user == null || user.getMemberGrade() == null || user.getMemberGrade().isBlank()) {
            return BigDecimal.ZERO;
        }

        WalletMemberGradePolicyDto policy = walletMapper.selectActiveMemberGradePolicyByGrade(user.getMemberGrade());
        if (policy == null || policy.getDiscountRate() == null) {
            return BigDecimal.ZERO;
        }
        return policy.getDiscountRate();
    }

    private long calculateDiscountAmount(long originalPrice, BigDecimal discountRate) {
        if (originalPrice <= 0 || discountRate == null || discountRate.compareTo(BigDecimal.ZERO) <= 0) {
            return 0;
        }
        return BigDecimal.valueOf(originalPrice)
                .multiply(discountRate)
                .divide(BigDecimal.valueOf(100), 0, RoundingMode.DOWN)
                .longValue();
    }

    private long floorToThousand(long value) {
        return (value / 1000) * 1000;
    }

    private WalletPaymentDto buildPaymentHistory(Long userIdx,
                                                 ExploreVO spot,
                                                 FlightOfferDto offer,
                                                 long cashAmount,
                                                 long mileageAmount) {
        WalletPaymentDto payment = new WalletPaymentDto();
        payment.setUserIdx(userIdx);
        payment.setPaymentType("PURCHASE");
        payment.setPaymentMethod(mileageAmount > 0 ? "CASH_MILEAGE" : "CASH");
        payment.setOrderName(spot.getName() + " 왕복 항공권");
        payment.setSourceType("FLIGHT_TICKET");
        payment.setSourceId(spot.getSpotIdx());
        payment.setOriginalAmount(offer.getTotalPrice());
        payment.setDiscountRate(offer.getDiscountRate());
        payment.setDiscountAmount(offer.getDiscountAmount());
        payment.setFinalAmount(offer.getFinalPrice());
        payment.setUsedCash(cashAmount);
        payment.setUsedMileage(mileageAmount);
        payment.setEarnedMileage(0);
        payment.setPaymentStatus("COMPLETED");
        return payment;
    }

    private void insertWalletHistory(Long userIdx,
                                     String assetType,
                                     long amount,
                                     long balanceAfter,
                                     Long paymentIdx,
                                     String detailMessage) {
        if (amount <= 0) {
            return;
        }

        WalletHistoryDto history = new WalletHistoryDto();
        history.setUserIdx(userIdx);
        history.setAssetType(assetType);
        history.setChangeType("USE");
        history.setAmount(-amount);
        history.setBalanceAfter(balanceAfter);
        history.setRelatedPaymentIdx(paymentIdx);
        history.setDetailMessage(detailMessage);
        history.setActorUserIdx(userIdx);
        walletMapper.insertWalletHistory(history);
    }

    private void insertRefundWalletHistory(Long userIdx,
                                           String assetType,
                                           long amount,
                                           long balanceAfter,
                                           Long paymentIdx,
                                           String detailMessage) {
        if (amount <= 0) {
            return;
        }

        WalletHistoryDto history = new WalletHistoryDto();
        history.setUserIdx(userIdx);
        history.setAssetType(assetType);
        history.setChangeType("REFUND");
        history.setAmount(amount);
        history.setBalanceAfter(balanceAfter);
        history.setRelatedPaymentIdx(paymentIdx);
        history.setDetailMessage(detailMessage);
        history.setActorUserIdx(userIdx);
        walletMapper.insertWalletHistory(history);
    }

    private long safeAdd(long baseAmount, long refundAmount) {
        try {
            return Math.addExact(baseAmount, refundAmount);
        } catch (ArithmeticException e) {
            throw new IllegalStateException("환불 처리 후 잔액이 너무 큽니다.");
        }
    }

    private String normalizeCancelReason(String cancelReason) {
        String reason = cancelReason == null ? null : cancelReason.trim();
        if (reason == null || reason.isEmpty()) {
            return "사용자 직접 취소";
        }
        if (reason.length() > 500) {
            return reason.substring(0, 500);
        }
        return reason;
    }

    private FlightPurchaseCreateDto buildFlightPurchase(Long userIdx,
                                                        ExploreVO spot,
                                                        FlightOfferDto offer,
                                                        Long paymentIdx,
                                                        long cashAmount,
                                                        long mileageAmount) {
        FlightPurchaseCreateDto purchase = new FlightPurchaseCreateDto();
        purchase.setPurchaseNo("FLT-" + UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase());
        purchase.setUserIdx(userIdx);
        purchase.setSpotIdx(spot.getSpotIdx());
        purchase.setOfferId(offer.getOfferId());
        purchase.setProviderType("MOCK");
        purchase.setPaymentIdx(paymentIdx);
        purchase.setTripType(offer.getTripType());
        purchase.setAirlineName(offer.getAirlineName());
        purchase.setFlightNo(offer.getFlightNo());
        purchase.setOriginAirportCode(offer.getOriginAirportCode());
        purchase.setDestinationAirportCode(offer.getDestinationAirportCode());
        purchase.setDepartureTime(offer.getDepartureTime());
        purchase.setArrivalTime(offer.getArrivalTime());
        purchase.setReturnAirlineName(offer.getReturnAirlineName());
        purchase.setReturnFlightNo(offer.getReturnFlightNo());
        purchase.setReturnOriginAirportCode(offer.getReturnOriginAirportCode());
        purchase.setReturnDestinationAirportCode(offer.getReturnDestinationAirportCode());
        purchase.setReturnDepartureTime(offer.getReturnDepartureTime());
        purchase.setReturnArrivalTime(offer.getReturnArrivalTime());
        purchase.setOutboundPrice(offer.getOutboundPrice());
        purchase.setReturnPrice(offer.getReturnPrice());
        purchase.setTotalPrice(offer.getFinalPrice());
        purchase.setUsedCash(cashAmount);
        purchase.setUsedMileage(mileageAmount);
        purchase.setStatus("COMPLETED");
        return purchase;
    }
}
