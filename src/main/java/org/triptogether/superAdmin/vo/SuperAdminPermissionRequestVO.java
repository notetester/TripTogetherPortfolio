package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SuperAdminPermissionRequestVO {
    private Long adminPermissionIdx;
    private Long userIdx;
    private String userNickname;
    private String permissionCode;
    private String permissionDisplayName;
    private String requestedByNickname;
    private String description;
    private LocalDateTime createdAt;

    public Date getCreatedAtDate() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
