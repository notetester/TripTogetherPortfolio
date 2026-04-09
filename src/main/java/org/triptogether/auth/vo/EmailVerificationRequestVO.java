package org.triptogether.auth.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * EMAIL_VERIFICATION_REQUEST 테이블 VO.
 *
 * <p>회원정보 수정 화면에서 입력 중인 이메일의 저장 전 인증 상태를 추적한다.</p>
 * <p>USERS.user_email / email_verified 는 최종 저장 시점에만 반영하고,
 * 그 전 단계의 인증 진행 상태는 이 테이블에서 관리한다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailVerificationRequestVO {

    private Long emailVerificationRequestIdx;
    private String requestId;
    private Long userIdx;
    private String purpose;
    private String pendingEmail;
    private String token;
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
}
