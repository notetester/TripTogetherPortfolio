package org.triptogether.superAdmin.enums;

public enum AdminDepartmentEnum {
    커뮤니티운영팀("커뮤니티운영팀"),
    여행서비스팀("여행서비스팀"),
    고객지원팀("고객지원팀"),
    플랫폼개발팀("플랫폼개발팀"),
    인프라팀("인프라팀"),
    AI팀("AI팀"),
    마케팅팀("마케팅팀"),
    재무팀("재무팀"),
    인사팀("인사팀"),
    법무팀("법무팀"),
    사업개발팀("사업개발팀"),
    보안팀("보안팀"),
    개인정보보호팀("개인정보보호팀");

    private final String displayName;
    AdminDepartmentEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
