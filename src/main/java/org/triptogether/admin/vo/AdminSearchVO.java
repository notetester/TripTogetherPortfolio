package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 관리자 공통 검색 파라미터 VO
 * 회원 관리 / 게시글 관리 등 모든 관리자 목록에서 재사용
 */
@Data
public class AdminSearchVO {

    // ── 공통 검색 ──
    private String keyword;           // 검색어
    private String searchType;        // 검색 대상 (userId / nickname / email / all)

    // ── 회원 전용 필터 ──
    private String status;            // 계정 상태 (ALL / ACTIVE / DORMANT / BLOCKED / DELETED)
    private String role;              // 권한 (ALL / USER / ADMIN)
    private String provider;          // 소셜 필터 (ALL / KAKAO / NAVER / GOOGLE / NONE)
    private String dateFrom;          // 가입일 시작 (yyyy-MM-dd)
    private String dateTo;            // 가입일 종료 (yyyy-MM-dd)

    // ── 정렬 ──
    private String sortBy;            // createdAt / lastLoginAt / nickname
    private String sortDir;           // ASC / DESC

    // ── 페이징 ──
    private int page    = 1;
    private int size    = 20;

    public int getOffset() {
        return (page - 1) * size;
    }

    // 기본값 보정
    public String getSortBy()   { return sortBy   != null ? sortBy   : "createdAt"; }
    public String getSortDir()  { return sortDir  != null ? sortDir  : "DESC"; }
    public String getStatus()   { return status   != null ? status   : "ALL"; }
    public String getRole()     { return role     != null ? role     : "ALL"; }
    public String getProvider() { return provider != null ? provider : "ALL"; }
    public String getSearchType(){ return searchType != null ? searchType : "all"; }
}
