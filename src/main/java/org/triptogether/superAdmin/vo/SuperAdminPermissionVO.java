package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SuperAdminPermissionVO {

    // ── ADMIN_PERMISSION ──
    private Long   adminPermissionIdx;
    private Long   userIdx;
    private String permissionCode;
    private boolean active;
    private LocalDateTime createdAt;

    // ── ADMIN_PERMISSION_POLICY JOIN ──
    private String displayName;
    private String description;
}
