package org.triptogether.superAdmin.enums;

public enum AdminTierEnum {
    T1("T1"), T2("T2"), T3("T3"), T4("T4"), T5("T5");

    private final String displayName;
    AdminTierEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
