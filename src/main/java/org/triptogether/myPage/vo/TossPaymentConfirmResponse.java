package org.triptogether.myPage.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Toss Payments 결제 승인 응답 중, 충전 처리에 필요한 값만 담는 DTO.
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
    private LocalDateTime approvedAt;
}
