package org.triptogether.superAdmin.enums;

public enum AdminPositionEnum {
    사원("사원"),
    주임("주임"),
    대리("대리"),
    선임("선임"),
    과장("과장"),
    차장("차장"),
    책임("책임"),
    부장("부장"),
    수석("수석"),
    이사("이사"),
    상무("상무"),
    전무("전무"),
    부사장("부사장"),
    사장("사장"),
    회장("회장");

    private final String displayName;
    AdminPositionEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
