package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Data
public class SuperAdminMemberVO {

    // ── USERS 기본 정보 ──
    private Long          userIdx;
    private String        userId;
    private String        userEmail;
    private String        nickname;
    private String        accountStatus;
    private String        userRole;
    private LocalDateTime createdAt;
    private LocalDateTime lastLoginAt;

    // ── 조직 정보 ──
    private String adminOrganization;
    private String adminDivision;
    private String adminDepartment;
    private String adminUnit;
    private String adminTeam;
    private String adminLocation;

    // ── 직무 정보 ──
    private String adminTrack;
    private String adminFamily;
    private String adminFunction;
    private String adminDiscipline;
    private String adminRole;

    // ── 직급/직책 ──
    private String adminPosition;
    private String adminPositionCode;
    private String adminTitle;
    private String adminRank;

    // ── 역량/평가 ──
    private String adminSeniority;
    private String adminTier;
    private String adminLevel;

    // ── 급여 ──
    private String adminBand;
    private String adminGrade;
    private String adminStep;

    // ── 권한 ──
    private String adminResponsibility;
    private String adminPermission;
    private String adminPermissionCode;

    // ── 상급자 ──
    private Long   adminManager;
    private String adminManagerNickname;

    // ── 보유 권한 목록 (ADMIN_PERMISSION JOIN) ──
    private List<SuperAdminPermissionVO> permissions;

    public Date getCreatedAtDate() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastLoginAtDate() {
        if (lastLoginAt == null) return null;
        return Date.from(lastLoginAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
