package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminEditVO {

    private Long userIdx;

    // 조직
    private String adminOrganization;
    private String adminDivision;
    private String adminDepartment;
    private String adminUnit;
    private String adminTeam;
    private String adminLocation;

    // 직무
    private String adminTrack;
    private String adminFamily;
    private String adminFunction;
    private String adminDiscipline;
    private String adminRole;

    // 직급/직책
    private String adminPosition;
    private String adminPositionCode;
    private String adminTitle;
    private String adminRank;

    // 역량/평가
    private String adminSeniority;
    private String adminTier;
    private String adminLevel;

    // 급여
    private String adminBand;
    private String adminGrade;
    private String adminStep;

    // 권한
    private String adminResponsibility;
    private String adminPermission;
    private String adminPermissionCode;

    // 상급자
    private Long adminManager;
}
