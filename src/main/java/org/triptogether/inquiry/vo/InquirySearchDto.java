package org.triptogether.inquiry.vo;

import lombok.Data;

/**
 * =============================================
 * InquirySearchDto - 문의 목록 검색 조건 객체
 * =============================================
 * 유저가 목록 페이지에서 검색/필터링을 하면 그 조건들이 이 객체에 담겨서 DB 쿼리에 사용
 */
@Data
public class InquirySearchDto {

    /** 문의 유형 필터 (service/payment/account/bug/etc) */
    private String category;

    /** 처리 상태 필터 (PENDING/IN_PROGRESS/COMPLETED) */
    private String status;

    /** 검색 키워드 (제목 + 내용 검색) */
    private String keyword;

    /** 현재 페이지 번호 (기본값: 1) */
    private int page = 1;

    /** 페이지당 게시글 수 (기본값: 10) */
    private int pageSize = 10;

    /** 로그인한 유저의 고유 번호 (본인 글만 볼 때 사용) */
    private Long userIdx;

    /**
     * DB 조회 시작 위치 계산
     * 예) 2페이지, 10개씩 → (2-1) * 10 = 10번째부터 조회
     */
    public int getOffset() {
        return (page - 1) * pageSize;
    }
}