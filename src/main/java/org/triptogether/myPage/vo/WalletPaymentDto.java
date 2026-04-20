package org.triptogether.myPage.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 내 지갑 화면에서 보여줄 충전/결제 이력 DTO.
 * USER_PAYMENT_HISTORY 한 건을 화면에서 읽기 좋은 형태로 담는다.
 */
@Data
public class WalletPaymentDto {

    private Long paymentIdx;
    private Long userIdx;

    private String paymentType;
    private String paymentMethod;
    private String orderName;
    private String sourceType;
    private Long sourceId;

    private long originalAmount;
    private double discountRate;
    private long discountAmount;
    private long finalAmount;
    private long usedCash;
    private long usedMileage;
    private long earnedMileage;

    private String paymentStatus;
    private LocalDateTime paidAt;
    private LocalDateTime cancelledAt;
    private LocalDateTime createdAt;
}
