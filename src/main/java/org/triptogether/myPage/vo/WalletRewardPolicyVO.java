package org.triptogether.myPage.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 이벤트별 적립률/고정 적립량 정책 (WALLET_REWARD_POLICY).
 *
 * <ul>
 *     <li>{@link #rewardRate} — 비율형(%) 적립. {@code null} 이면 비율형 아님</li>
 *     <li>{@link #rewardFixed} — 고정 적립량. {@code null} 이면 정액형 아님</li>
 * </ul>
 *
 * <p>정책 한 건은 비율형 또는 정액형 둘 중 하나를 사용한다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WalletRewardPolicyVO {

    private Long policyIdx;
    private String eventType;
    private String memberGrade;
    private String rewardType;
    private BigDecimal rewardRate;
    private Long rewardFixed;
    private String description;
    private Boolean isActive;
    private Long createdByUserIdx;
    private LocalDateTime createdAt;
    private Long updatedByUserIdx;
    private LocalDateTime updatedAt;
}
