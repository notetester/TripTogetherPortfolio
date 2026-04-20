package org.triptogether.flight.vo;

import lombok.Data;

/**
 * 항공권 구매 요청 DTO.
 * 클라이언트에서 금액을 보내더라도 서버에서 다시 Mock 견적을 조회해 가격을 검증한다.
 */
@Data
public class FlightPurchaseRequestDto {

    private Long spotIdx;
    private String offerId;
    private long cashAmount;
    private long mileageAmount;
}
