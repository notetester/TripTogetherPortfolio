package org.triptogether.inquiry.service;

import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

/**
 * =============================================
 * InquiryService - 문의 게시판 서비스 인터페이스
 * =============================================
 */
public interface InquiryService {

    /* =============================================
       1. 목록 조회
       - 검색 조건에 맞는 문의 목록 반환
       ============================================= */
    List<InquiryPostDto> getInquiryList(InquirySearchDto search);

    /* =============================================
       2. 전체 개수 조회
       - 페이지네이션 계산에 사용
       ============================================= */
    int getTotalCount(InquirySearchDto search);

    /* =============================================
       3. 전체 페이지 수 계산
       - totalCount / pageSize 로 계산
       - Mapper에는 없고 Service에서 직접 계산
       ============================================= */
    int getTotalPage(InquirySearchDto search);

    /* =============================================
       4. 문의 상세 조회
       - inquiryId로 단건 문의 조회
       ============================================= */
    InquiryPostDto getInquiry(Long inquiryId);

    /* =============================================
       5. 답변 조회
       - 해당 문의에 달린 운영진 답변 조회
       - 답변이 없으면 null 반환
       ============================================= */
    InquiryAnswerDto getAnswer(Long inquiryId);

    /* =============================================
       6. 조회수 증가
       - 상세 페이지 진입 시 호출
       ============================================= */
    void increaseViewCount(Long inquiryId);

    /* =============================================
       7. 문의 등록
       - 새 문의를 DB에 저장
       - 생성된 문의 ID 반환
       ============================================= */
    Long writeInquiry(InquiryPostDto inquiry);

    /* =============================================
       8. 답변 등록
       - 운영진이 문의에 답변 저장
       - 답변 등록 시 문의 status → COMPLETED 로 자동 변경
       ============================================= */
    void writeAnswer(Long inquiryId, Long adminUserIdx, String content);

    /* =============================================
       9. 문의 수정
       - 제목, 내용, 카테고리, 공개여부 수정
       - PENDING 상태일 때만 가능 (Controller에서 체크)
       ============================================= */
    void updateInquiry(InquiryPostDto inquiry);

    /* =============================================
       10. 문의 삭제
       - PENDING 상태일 때만 가능 (Controller에서 체크)
       ============================================= */
    void deleteInquiry(Long inquiryId);
}