package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SuperAdminGroupMemberVO {
    private Long adminPermissionGroupIdx;
    private Long userIdx;
    private String groupCode;
    private String nickname;
    private String userId;
    private boolean active;
    private String grantedByNickname;
    private LocalDateTime grantedAt;
}
