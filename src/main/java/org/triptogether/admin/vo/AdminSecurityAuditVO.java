package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 관리자 보안 이력 화면 VO.
 *
 * <p>USER_SECURITY_HISTORY 와 USERS 조인 결과를 담는다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminSecurityAuditVO {
    private Long securityIdx;
    private Long userIdx;
    private Long actorUserIdx;

    private String userId;
    private String nickname;

    private String actorUserId;
    private String actorNickname;

    private String eventType;
    private String eventStage;
    private String inputIdentifier;
    private String targetEmail;
    private boolean success;
    private String failReason;
    private String detailMessage;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime occurredAt;

    public Date getOccurredAt() {
        return occurredAt == null ? null : Date.from(occurredAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
