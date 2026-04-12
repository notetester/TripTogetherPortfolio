package org.triptogether.inquiry.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryAttachmentDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

/**
 * =============================================
 * InquiryMapper - 문의 게시판 DB 쿼리 인터페이스
 * =============================================
 */
@Mapper
public interface InquiryMapper {

    /* =============================================
       1. 목록 조회
       - 검색 조건에 맞는 문의 목록 반환
       - 페이지네이션 포함
       ============================================= */
    List<InquiryPostDto> selectInquiryList(InquirySearchDto search);

    /* =============================================
       2. 전체 개수 조회
       - 페이지네이션 계산에 사용
       ============================================= */
    int selectTotalCount(InquirySearchDto search);

    /* =============================================
       3. 문의 상세 조회
       - inquiryId로 단건 문의 조회
       ============================================= */
    InquiryPostDto selectInquiry(@Param("inquiryId") Long inquiryId);

    /* =============================================
       4. 답변 조회
       - 해당 문의에 달린 운영진 답변 조회
       - 답변이 없으면 null 반환
       ============================================= */
    InquiryAnswerDto selectAnswer(@Param("inquiryId") Long inquiryId);

    /* =============================================
       5. 조회수 증가
       - 상세 페이지 진입 시 호출
       ============================================= */
    void updateViewCount(@Param("inquiryId") Long inquiryId);

    /* =============================================
       6. 문의 등록
       - 새 문의를 DB에 저장
       ============================================= */
    void insertInquiry(InquiryPostDto inquiry);

    /* =============================================
       7. 답변 등록
       - 운영진이 문의에 답변을 저장
       - 답변 등록 시 문의 status → COMPLETED 로 변경 필요
         (Service에서 updateStatus 함께 호출)
       ============================================= */
    void insertAnswer(InquiryAnswerDto answer);

    /* =============================================
       8. 문의 상태 변경
       - status 값: PENDING(대기중) / IN_PROGRESS(처리중) / COMPLETED(완료)
       - 답변 등록 시 COMPLETED로 변경하는 데 사용
       ============================================= */
    void updateStatus(@Param("inquiryId") Long inquiryId,
                      @Param("status") String status);

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
    void deleteInquiry(@Param("inquiryId") Long inquiryId);

    // ===== 상태 변경 (시간 기록 포함) =====
    void updateStatusWithTime(@Param("inquiryId") Long inquiryId,
                              @Param("status") String status);

    // ===== 공개여부 변경 =====
    void updateIsPrivate(@Param("inquiryId") Long inquiryId,
                         @Param("isPrivate") int isPrivate);

    // ===== 답변 수정 =====
    void updateAnswer(InquiryAnswerDto answer);

    // ===== 답변 삭제 =====
    void deleteAnswer(@Param("inquiryId") Long inquiryId);

    // ===== 첨부파일 =====
    void insertAttachment(InquiryAttachmentDto attachment);
    List<InquiryAttachmentDto> selectAttachmentList(@Param("inquiryId") Long inquiryId);
    void deleteAttachment(@Param("attachmentId") Long attachmentId);

    // ===== 도배 방지 =====
    int countRecentInquiriesByUser(@Param("userIdx") Long userIdx, @Param("minutes") int minutes);
}