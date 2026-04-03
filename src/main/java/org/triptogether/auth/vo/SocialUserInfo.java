package org.triptogether.auth.vo;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SocialUserInfo {
    private String provider;          // KAKAO / NAVER / GOOGLE
    private String providerUserId;
    private String email;
    private String nickname;
}
