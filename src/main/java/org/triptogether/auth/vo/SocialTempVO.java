package org.triptogether.auth.vo;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * 소셜 최초 로그인 시 추가 정보(닉네임·국적·언어) 입력 전까지
 * 세션에 임시 저장하는 VO.
 *
 * 세션 키: "socialTemp"
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SocialTempVO {

    private String provider;        // KAKAO / NAVER / GOOGLE
    private String providerUserId;  // 소셜 고유 ID
    private String email;           // 소셜에서 받아온 이메일 (없을 수 있음)
    private String nickname;        // 소셜에서 받아온 닉네임 힌트 (없을 수 있음)
}
