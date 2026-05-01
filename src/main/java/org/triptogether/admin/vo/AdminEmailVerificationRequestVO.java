package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 관리자 이메일 인증 요청 이력 화면 VO.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminEmailVerificationRequestVO {
    private Long emailVerificationRequestIdx;
    private String requestId;
    private String flowTraceId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String purpose;
    private String pendingEmail;
    private String status;
    private LocalDateTime requestedAt;
    private LocalDateTime verifiedAt;
    private LocalDateTime appliedAt;
    private LocalDateTime expiredAt;
    private LocalDateTime cancelledAt;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime updatedAt;
    private LocalDateTime createdAt;

    public Date getRequestedAtDate() { return requestedAt == null ? null : Date.from(requestedAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getVerifiedAtDate() { return verifiedAt == null ? null : Date.from(verifiedAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getAppliedAtDate() { return appliedAt == null ? null : Date.from(appliedAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getExpiredAtDate() { return expiredAt == null ? null : Date.from(expiredAt.atZone(ZoneId.systemDefault()).toInstant()); }
    public Date getCancelledAtDate() { return cancelledAt == null ? null : Date.from(cancelledAt.atZone(ZoneId.systemDefault()).toInstant()); }

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
