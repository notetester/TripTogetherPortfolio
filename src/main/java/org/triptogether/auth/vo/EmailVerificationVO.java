package org.triptogether.auth.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * EMAIL_VERIFICATION 테이블 VO.
 *
 * <p>실제 이메일 링크(토큰) 인스턴스를 저장한다.</p>
 * <p>아이디 찾기, 비밀번호 재설정, 이메일 인증 링크 등 "발급된 토큰 그 자체"를 관리한다.</p>
 * <p>요청 헤더/워크플로우는 EMAIL_VERIFICATION_REQUEST 가 맡고,
 * 이 테이블은 그 요청에 의해 발급된 개별 토큰을 저장하는 역할을 맡는다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailVerificationVO {

    private Long          verifyIdx;
    private Long          emailVerificationRequestIdx;
    private String        requestId;
    private Long          userIdx;       // 비회원 아이디 찾기는 null 가능
    private String        email;
    private String        token;         // UUID
    private String        purpose;       // VERIFY / FIND_ID / RESET_PW / PROFILE_EMAIL
    private LocalDateTime expiredAt;
    private boolean       used;
    private LocalDateTime usedAt;
    private LocalDateTime cancelledAt;
    private LocalDateTime updatedAt;
    private LocalDateTime createdAt;
}
