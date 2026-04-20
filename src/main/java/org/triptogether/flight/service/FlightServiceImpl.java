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
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

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
        return getSpot(spotIdx)
                .filter(flightOfferProvider::supports)
                .flatMap(flightOfferProvider::getLowestOffer);
    }

    @Override
    public List<FlightOfferDto> getOffers(Long spotIdx) {
        return getSpot(spotIdx)
                .filter(flightOfferProvider::supports)
                .map(flightOfferProvider::getOffers)
                .orElse(List.of());
    }

    @Override
    @Transactional
    public FlightPurchaseResultDto purchase(Long userIdx, FlightPurchaseRequestDto request) {
        validatePurchaseRequest(userIdx, request);

        ExploreVO spot = getSpot(request.getSpotIdx())
                .orElseThrow(() -> new IllegalArgumentException("여행지 정보를 찾을 수 없습니다."));

        FlightOfferDto offer = flightOfferProvider.getOffer(spot, request.getOfferId())
                .orElseThrow(() -> new IllegalArgumentException("항공권 견적 정보를 찾을 수 없습니다."));

        long totalPrice = offer.getTotalPrice();
        long cashAmount = request.getCashAmount();
        long mileageAmount = request.getMileageAmount();

        if (cashAmount < 0 || mileageAmount < 0) {
            throw new IllegalArgumentException("결제 금액은 0 이상이어야 합니다.");
        }
        if (cashAmount + mileageAmount != totalPrice) {
            throw new IllegalArgumentException("캐시와 마일리지 합계가 항공권 금액과 일치해야 합니다.");
        }

        long maxMileageUse = totalPrice * MAX_MILEAGE_RATE / 100;
        if (mileageAmount > maxMileageUse) {
            throw new IllegalArgumentException("마일리지는 항공권 금액의 30%까지만 사용할 수 있습니다.");
        }

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
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

        FlightPurchaseCreateDto purchase = buildFlightPurchase(userIdx, spot, offer, cashAmount, mileageAmount);
        flightMapper.insertFlightPurchase(purchase);

        UsersVO updatedUser = walletMapper.selectUserByIdx(userIdx);
        return new FlightPurchaseResultDto(purchase.getFlightPurchaseIdx(), purchase.getPurchaseNo(), offer, updatedUser);
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
        payment.setOrderName(spot.getName() + " 항공권");
        payment.setSourceType("FLIGHT_TICKET");
        payment.setSourceId(spot.getSpotIdx());
        payment.setOriginalAmount(offer.getTotalPrice());
        payment.setDiscountRate(0);
        payment.setDiscountAmount(0);
        payment.setFinalAmount(offer.getTotalPrice());
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

    private FlightPurchaseCreateDto buildFlightPurchase(Long userIdx,
                                                        ExploreVO spot,
                                                        FlightOfferDto offer,
                                                        long cashAmount,
                                                        long mileageAmount) {
        FlightPurchaseCreateDto purchase = new FlightPurchaseCreateDto();
        purchase.setPurchaseNo("FLT-" + UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase());
        purchase.setUserIdx(userIdx);
        purchase.setSpotIdx(spot.getSpotIdx());
        purchase.setOfferId(offer.getOfferId());
        purchase.setProviderType("MOCK");
        purchase.setAirlineName(offer.getAirlineName());
        purchase.setFlightNo(offer.getFlightNo());
        purchase.setOriginAirportCode(offer.getOriginAirportCode());
        purchase.setDestinationAirportCode(offer.getDestinationAirportCode());
        purchase.setDepartureTime(offer.getDepartureTime());
        purchase.setArrivalTime(offer.getArrivalTime());
        purchase.setTotalPrice(offer.getTotalPrice());
        purchase.setUsedCash(cashAmount);
        purchase.setUsedMileage(mileageAmount);
        purchase.setStatus("COMPLETED");
        return purchase;
    }
}
