package org.triptogether.myPage.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 자산 변동 이력 DTO.
 * USER_WALLET_HISTORY 의 한 행을 담아 화면에서 그대로 사용한다.
 */
@Data
public class WalletHistoryDto {

    private Long walletHistoryIdx;
    private Long userIdx;

    private String assetType;
    private String changeType;
    private long amount;
    private long balanceAfter;

    private Long relatedPaymentIdx;
    private String detailMessage;
    private Long actorUserIdx;
    private LocalDateTime createdAt;
}
