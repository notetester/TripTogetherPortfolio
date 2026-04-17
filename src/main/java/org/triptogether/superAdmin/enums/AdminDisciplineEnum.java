package org.triptogether.superAdmin.enums;

public enum AdminDisciplineEnum {
    웹개발("웹개발"),
    앱개발("앱개발"),
    서버관리("서버관리"),
    데이터분석("데이터분석"),
    UX디자인("UX디자인"),
    콘텐츠("콘텐츠"),
    회계("회계"),
    보안관리("보안관리"),
    네트워크("네트워크"),
    제품기획("제품기획");

    private final String displayName;
    AdminDisciplineEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
