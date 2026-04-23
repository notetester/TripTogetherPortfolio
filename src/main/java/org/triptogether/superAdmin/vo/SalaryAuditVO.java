package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SalaryAuditVO {
    private Long   salaryChangeAuditIdx;
    private String batchId;
    private Long   targetUserIdx;
    private String targetUserEmail;
    private String fieldName;
    private String oldValue;
    private String newValue;
    private Long   changedByUserIdx;
}
