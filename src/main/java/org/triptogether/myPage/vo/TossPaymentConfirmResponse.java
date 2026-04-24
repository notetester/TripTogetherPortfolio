package org.triptogether.myPage.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

/**
 * Toss 결제 승인 응답 중 지갑 충전에 필요한 최소 필드만 받는 DTO다.
 *
 * <p>approvedAt은 Toss가 오프셋이 포함된 ISO 문자열로 내려줄 수 있어서
 * 바로 LocalDateTime으로 받지 않고 문자열로 받은 뒤 서비스에서 안전하게 파싱한다.</p>
 */
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class TossPaymentConfirmResponse {

    private String paymentKey;
    private String orderId;
    private String orderName;
    private String method;
    private String status;
    private long totalAmount;
    private String approvedAt;
}
