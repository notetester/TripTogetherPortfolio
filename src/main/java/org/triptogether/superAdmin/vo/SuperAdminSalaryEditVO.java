package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminSalaryEditVO {
    private Long   userIdx;
    private String adminSeniority;
    private String adminTier;
    private String adminLevel;
    private String adminBand;
    private String adminGrade;
    private String adminStep;
}
