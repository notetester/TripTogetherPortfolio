package org.triptogether.myPage.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 회원 등급별 충전 한도 정책 (WALLET_LIMIT_POLICY).
 *
 * <p>NULL 값은 해당 한도가 무제한임을 의미한다 (예: monthlyLimit = null → 월 한도 없음).</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WalletLimitPolicyVO {

    private Long policyIdx;
    private String memberGrade;
    private Long singleLimit;
    private Long dailyLimit;
    private Long monthlyLimit;
    private Boolean isActive;
    private Long createdByUserIdx;
    private LocalDateTime createdAt;
    private Long updatedByUserIdx;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

}
