package org.triptogether.auth.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * EMAIL_VERIFICATION_REQUEST 테이블 VO.
 *
 * <p>이메일 링크를 발급하는 모든 요청의 헤더/워크플로우 상태를 저장한다.</p>
 * <p>현재는 PROFILE_EMAIL 중심으로 사용 중이지만, 아이디 찾기 / 비밀번호 재설정 등
 * 다른 이메일 액션 요청도 같은 구조로 확장 가능하도록 설계한다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailVerificationRequestVO {

    private Long emailVerificationRequestIdx;
    private String requestId;
    private String flowTraceId;
    private Long userIdx; // 식별 가능 시만 사용. 비회원/미식별 요청은 null 가능
    private String purpose;
    private String pendingEmail; // 의미상 요청 대상 이메일
    private String token;        // 현재 시스템 호환을 위해 유지하는 토큰 복사본
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

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getRequestedAtDate() {
        return fromLocalDateTime(requestedAt);
    }

    public Date getVerifiedAtDate() {
        return fromLocalDateTime(verifiedAt);
    }

    public Date getAppliedAtDate() {
        return fromLocalDateTime(appliedAt);
    }

    public Date getExpiredAtDate() {
        return fromLocalDateTime(expiredAt);
    }

    public Date getCancelledAtDate() {
        return fromLocalDateTime(cancelledAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
