package org.triptogether.superAdmin.enums;

public enum AdminRankEnum {
    IC1("IC1"), IC2("IC2"), IC3("IC3"), IC4("IC4"), IC5("IC5"), IC6("IC6"), IC7("IC7"),
    M1("M1"), M2("M2"), M3("M3"), M4("M4"), M5("M5");

    private final String displayName;
    AdminRankEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
