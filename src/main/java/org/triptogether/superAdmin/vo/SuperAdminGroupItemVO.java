package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminGroupItemVO {
    private Long adminPermissionGroupItemIdx;
    private String groupCode;
    private String permissionCode;
    private String displayName;
    private boolean active;
}
