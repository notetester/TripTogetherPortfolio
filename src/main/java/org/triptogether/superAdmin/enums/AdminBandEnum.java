package org.triptogether.superAdmin.enums;

public enum AdminBandEnum {
    B1("B1"), B2("B2"), B3("B3"), B4("B4"), B5("B5"),
    B6("B6"), B7("B7"), B8("B8"), B9("B9"), B10("B10");

    private final String displayName;
    AdminBandEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
