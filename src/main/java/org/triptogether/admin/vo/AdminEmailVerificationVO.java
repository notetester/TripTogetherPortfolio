package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 관리자 이메일 액션 토큰 이력 조회 화면 VO.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminEmailVerificationVO {
    private Long verifyIdx;
    private Long emailVerificationRequestIdx;
    private String requestId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String email;
    private String token;
    private String purpose;
    private boolean used;
    private LocalDateTime usedAt;
    private LocalDateTime expiredAt;
    private LocalDateTime cancelledAt;
    private LocalDateTime updatedAt;
    private LocalDateTime createdAt;

    public Date getUsedAtDate() { return usedAt == null ? null : Date.from(usedAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getExpiredAtDate() { return expiredAt == null ? null : Date.from(expiredAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getCancelledAtDate() { return cancelledAt == null ? null : Date.from(cancelledAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getCreatedAtDate() { return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()); }
}
