package org.triptogether.superAdmin.enums;

public enum AdminStepEnum {
    S1("1호봉"), S2("2호봉"), S3("3호봉"), S4("4호봉"), S5("5호봉"),
    S6("6호봉"), S7("7호봉"), S8("8호봉"), S9("9호봉"), S10("10호봉"),
    S11("11호봉"), S12("12호봉"), S13("13호봉"), S14("14호봉"), S15("15호봉");

    private final String displayName;
    AdminStepEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
