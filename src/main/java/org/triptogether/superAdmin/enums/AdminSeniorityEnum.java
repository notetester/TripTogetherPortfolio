package org.triptogether.superAdmin.enums;

public enum AdminSeniorityEnum {
    어소시에이트("어소시에이트"),
    주니어("주니어"),
    미드레벨("미드레벨"),
    시니어("시니어"),
    리드("리드"),
    프린시펄("프린시펄"),
    스태프("스태프"),
    펠로우("펠로우");

    private final String displayName;
    AdminSeniorityEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
