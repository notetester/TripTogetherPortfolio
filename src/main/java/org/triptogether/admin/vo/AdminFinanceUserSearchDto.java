package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 어드민 내지갑 관리 - 사용자 검색 / 페이지네이션 DTO.
 * 정책: ADR-0001 (FINANCE_ADMIN 권한 - 사용자 자산 조회용 read-only)
 */
@Data
public class AdminFinanceUserSearchDto {

    /** 닉네임/이메일 부분일치 */
    private String keyword;

    /** 회원 등급 필터 (BRONZE / SILVER / GOLD / DIAMOND / PLATINUM) */
    private String memberGrade;

    /** 정렬 키: cash | mileage | grade | latest (기본: latest) */
    private String sort = "latest";

    private int page = 1;
    private int pageSize = 20;

    public int getOffset() { return (page - 1) * pageSize; }
}
