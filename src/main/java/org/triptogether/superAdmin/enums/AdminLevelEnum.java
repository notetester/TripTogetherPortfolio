package org.triptogether.superAdmin.enums;

public enum AdminLevelEnum {
    L1("L1"), L2("L2"), L3("L3"), L4("L4"), L5("L5"), L6("L6"), L7("L7");

    private final String displayName;
    AdminLevelEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
