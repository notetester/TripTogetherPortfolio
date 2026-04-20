package org.triptogether.superAdmin.enums;

public enum AdminFamilyEnum {
    백엔드("백엔드"),
    프론트엔드("프론트엔드"),
    모바일("모바일"),
    데브옵스("데브옵스"),
    데이터("데이터"),
    인공지능("인공지능"),
    보안("보안"),
    품질보증("품질보증"),
    커뮤니티("커뮤니티"),
    고객지원("고객지원"),
    마케팅("마케팅"),
    재무("재무"),
    인사("인사"),
    법무("법무"),
    제품기획("제품기획"),
    사업개발("사업개발"),
    영업("영업");

    private final String displayName;
    AdminFamilyEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
