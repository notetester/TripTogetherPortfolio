package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminPermissionCodePolicyVO {
    private String adminPermissionCode;
    private String displayName;
    private String description;
    private boolean active;
    private int permissionItemCount;
    private int groupItemCount;

    public int getTotalItemCount() { return permissionItemCount + groupItemCount; }
}
