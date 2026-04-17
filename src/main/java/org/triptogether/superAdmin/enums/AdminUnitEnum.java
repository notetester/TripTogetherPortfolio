package org.triptogether.superAdmin.enums;

public enum AdminUnitEnum {
    콘텐츠유닛("콘텐츠유닛"),
    신뢰안전유닛("신뢰안전유닛"),
    결제유닛("결제유닛"),
    검색유닛("검색유닛");

    private final String displayName;
    AdminUnitEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
