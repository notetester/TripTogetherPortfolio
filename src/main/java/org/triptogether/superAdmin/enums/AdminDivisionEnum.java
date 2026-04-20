package org.triptogether.superAdmin.enums;

public enum AdminDivisionEnum {
    서비스본부("서비스본부"),
    플랫폼본부("플랫폼본부"),
    데이터본부("데이터본부"),
    경영지원본부("경영지원본부"),
    연구개발본부("연구개발본부"),
    보안본부("보안본부");

    private final String displayName;
    AdminDivisionEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
