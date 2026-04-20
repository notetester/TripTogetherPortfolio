package org.triptogether.superAdmin.enums;

public enum AdminGradeEnum {
    G1("G1"), G2("G2"), G3("G3"), G4("G4"), G5("G5"),
    G6("G6"), G7("G7"), G8("G8"), G9("G9"), G10("G10");

    private final String displayName;
    AdminGradeEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
