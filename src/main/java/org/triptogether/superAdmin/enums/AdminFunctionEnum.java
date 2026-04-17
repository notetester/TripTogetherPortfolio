package org.triptogether.superAdmin.enums;

public enum AdminFunctionEnum {
    개발("개발"),
    운영("운영"),
    기획("기획"),
    분석("분석"),
    디자인("디자인"),
    관리("관리"),
    영업("영업"),
    연구("연구");

    private final String displayName;
    AdminFunctionEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
