package org.triptogether.myPage.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 어드민 환불 audit 로그 (WALLET_REFUND_LOG).
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WalletRefundLogVO {

    private Long refundLogIdx;
    private Long paymentIdx;
    private Long userIdx;
    private Long refundAmount;
    private String refundReason;
    private String tossCancelStatus;
    private Long refundedByUserIdx;
    private LocalDateTime refundedAt;

    /** 조회 편의용 */
    private String userNickname;
    private String adminNickname;
    private String orderName;
}
