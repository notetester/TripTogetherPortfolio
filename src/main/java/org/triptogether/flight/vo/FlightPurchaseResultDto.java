package org.triptogether.flight.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.triptogether.auth.vo.UsersVO;

/**
 * 항공권 구매 결과 DTO.
 * 구매 후 화면에서 최신 잔액을 즉시 갱신할 수 있도록 updatedUser를 함께 반환한다.
 */
@Data
@AllArgsConstructor
public class FlightPurchaseResultDto {

    private Long flightPurchaseIdx;
    private String purchaseNo;
    private FlightOfferDto offer;
    private UsersVO updatedUser;
}
