package org.triptogether.superAdmin.enums;

public enum AdminLocationEnum {
    서울_본사("서울 본사"),
    부산_지사("부산 지사"),
    제주_지사("제주 지사"),
    원격근무("원격근무");

    private final String displayName;
    AdminLocationEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
