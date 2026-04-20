package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SuperAdminAdminGroupVO {
    private Long adminPermissionGroupIdx;
    private Long userIdx;
    private String groupCode;
    private String displayName;
    private String description;
    private boolean active;
    private String grantedByNickname;
    private LocalDateTime grantedAt;
    private LocalDateTime revokedAt;
}
