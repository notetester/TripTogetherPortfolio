package org.triptogether.superAdmin.enums;

public enum AdminTrackEnum {
    기술직("기술직"),
    운영직("운영직"),
    경영직("경영직"),
    디자인직("디자인직"),
    기획직("기획직");

    private final String displayName;
    AdminTrackEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
