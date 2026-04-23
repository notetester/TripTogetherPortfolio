package org.triptogether.auth.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SocialEmailNoticeVO {

    private String noticeType; // NO_EMAIL / REFERENCE / RECOMMEND_LINK
    private String socialEmail;
    private boolean emailAvailable;
    private boolean verifiedEmailOwnerExists;
}
