package org.triptogether.auth.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * EMAIL_VERIFICATION 테이블 VO
 *
 * purpose:
 *   VERIFY   - 회원 이메일 본인 인증
 *   FIND_ID  - 아이디 찾기
 *   RESET_PW - 비밀번호 재설정
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailVerificationVO {

    private Long          verifyIdx;
    private Long          userIdx;       // 비회원 아이디 찾기는 null
    private String        email;
    private String        token;         // UUID
    private String        purpose;       // VERIFY / FIND_ID / RESET_PW
    private LocalDateTime expiredAt;
    private boolean       used;
    private LocalDateTime createdAt;
}
