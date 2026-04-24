package org.triptogether.myPage.vo;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Toss 결제 요청을 위해 클라이언트로 내려줄 준비 정보.
 *
 * <p>결제 요청 전에 서버가 금액과 주문번호를 확정해 두고,
 * 성공/실패 URL까지 함께 내려준다.</p>
 */
@Getter
@Setter
public class WalletTossChargeRequestDto {

    private Long userIdx;
    private long amount;
    private String orderId;
    private String orderName;
    private String customerKey;
    private String successUrl;
    private String failUrl;
    private LocalDateTime createdAt;
}
