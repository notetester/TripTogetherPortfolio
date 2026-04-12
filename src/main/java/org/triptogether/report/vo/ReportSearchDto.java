package org.triptogether.report.vo;

import lombok.Data;

/**
 * =============================================
 * ReportSearchDto - 신고 목록 검색 조건 객체
 * =============================================
 */
@Data
public class ReportSearchDto {

    /** 처리 상태 필터 (PENDING / RESOLVED / DISMISSED) */
    private String status;

    /** 신고 대상 유형 필터 (post / comment / user) */
    private String targetType;

    /** 신고자 유저 idx 필터 (본인 신고내역 조회용, null이면 전체) */
    private Long userIdx;

    /** 현재 페이지 번호 (기본값: 1) */
    private int page = 1;

    /** 페이지당 항목 수 (기본값: 10) */
    private int pageSize = 10;

    /**
     * DB 조회 시작 위치 계산
     * 예) 2페이지, 10개씩 → (2-1) * 10 = 10번째부터 조회
     */
    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
