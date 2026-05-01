package org.triptogether.reward.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 회원 레벨업 보상 지급 이력 저장용 DTO입니다.
 * USER_LEVEL_UP_REWARD_HISTORY insert 시 사용합니다.
 */
@Data
public class UserLevelUpRewardHistoryCreateDto {

    private Long userLevelUpRewardHistoryIdx;
    private Long userIdx;
    private Long levelUpRewardPolicyIdx;
    private Integer levelNo;
    private String rewardType;
    private Long rewardAmount;
    private String itemCode;
    private Long pointInventoryIdx;
    private String grantStatus;
    private LocalDateTime grantedAt;
    private Long grantedByUserIdx;
    private String note;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getGrantedAtDate() {
        return fromLocalDateTime(grantedAt);
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
