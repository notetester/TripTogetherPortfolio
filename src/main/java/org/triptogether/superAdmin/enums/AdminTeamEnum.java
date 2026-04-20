package org.triptogether.superAdmin.enums;

public enum AdminTeamEnum {
    프론트팀("프론트팀"),
    백엔드팀("백엔드팀"),
    QA팀("QA팀"),
    데이터팀("데이터팀"),
    디자인팀("디자인팀"),
    기획팀("기획팀");

    private final String displayName;
    AdminTeamEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
