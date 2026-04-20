package org.triptogether.superAdmin.enums;

public enum AdminRoleEnum {
    엔지니어("엔지니어"),
    매니저("매니저"),
    분석가("분석가"),
    디자이너("디자이너"),
    전문가("전문가"),
    코디네이터("코디네이터"),
    디렉터("디렉터"),
    기획자("기획자"),
    사업개발자("사업개발자");

    private final String displayName;
    AdminRoleEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
