package org.triptogether.auth.vo;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * USER_SOCIAL 테이블 VO
 * - 한 유저가 여러 소셜 계정 연동 가능 (provider별 1개)
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserSocialVO {

    private Long   socialIdx;       // PK
    private Long   userIdx;         // USERS FK

    /** 소셜 제공자: KAKAO / NAVER / GOOGLE */
    private String provider;

    /** 소셜 제공자가 발급한 고유 사용자 ID */
    private String providerUserId;

    private LocalDateTime linkedAt;
}
