package org.triptogether.superAdmin.enums;

public enum AdminTitleEnum {
    주니어_엔지니어("주니어 엔지니어"),
    엔지니어("엔지니어"),
    시니어_엔지니어("시니어 엔지니어"),
    리드_엔지니어("리드 엔지니어"),
    수석_엔지니어("수석 엔지니어"),
    스태프_엔지니어("스태프 엔지니어"),
    펠로우_엔지니어("펠로우 엔지니어"),
    매니저("매니저"),
    시니어_매니저("시니어 매니저"),
    디렉터("디렉터"),
    시니어_디렉터("시니어 디렉터"),
    부문장("부문장"),
    그룹장("그룹장"),
    사업부장("사업부장"),
    대표이사("대표이사"),
    CTO("최고기술책임자(CTO)"),
    CPO("최고제품책임자(CPO)"),
    COO("최고운영책임자(COO)"),
    CFO("최고재무책임자(CFO)");

    private final String displayName;
    AdminTitleEnum(String displayName) { this.displayName = displayName; }
    public String getDisplayName() { return displayName; }
}
