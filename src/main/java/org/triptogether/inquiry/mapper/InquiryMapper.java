package org.triptogether.inquiry.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryAnswerHistoryDto;
import org.triptogether.inquiry.vo.InquiryAttachmentDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

@Mapper
public interface InquiryMapper {

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 문의 목록 조회 (페이지네이션 포함)
    List<InquiryPostDto> selectInquiryList(InquirySearchDto search);

    // 검색 조건에 맞는 문의 총 개수 조회 (페이지네이션용)
    int selectTotalCount(InquirySearchDto search);

    // ===== 단건 조회 =====

    // 문의 하나 조회
    InquiryPostDto selectInquiry(@Param("inquiryId") Long inquiryId);

    // 해당 문의에 달린 답변 조회 (답변 없으면 null)
    InquiryAnswerDto selectAnswer(@Param("inquiryId") Long inquiryId);

    // ===== 조회수 증가 =====

    // 조회수 1 올림
    void updateViewCount(@Param("inquiryId") Long inquiryId);

    // ===== 문의 등록 =====

    // 문의 INSERT (useGeneratedKeys → inquiry.inquiryId에 자동 주입됨)
    void insertInquiry(InquiryPostDto inquiry);

    // ===== 문의 수정 =====

    // 문의 수정 (제목/내용/카테고리/공개여부)
    void updateInquiry(InquiryPostDto inquiry);

    // ===== 문의 삭제 =====

    // 문의 삭제
    void deleteInquiry(@Param("inquiryId") Long inquiryId);

    // ===== 답변 등록 =====

    // 답변 INSERT
    void insertAnswer(InquiryAnswerDto answer);

    // ===== 답변 수정 =====

    // 답변 내용 수정
    void updateAnswer(InquiryAnswerDto answer);

    // ===== 답변 삭제 =====

    // 답변 삭제
    void deleteAnswer(@Param("inquiryId") Long inquiryId);

    // ===== 답변 수정/삭제 이력 =====

    // 답변 변경 이력 INSERT (UPDATE/DELETE 직전에 호출)
    void insertAnswerHistory(InquiryAnswerHistoryDto history);

    // 특정 문의의 답변 변경 이력 조회 (최신순)
    List<InquiryAnswerHistoryDto> selectAnswerHistoryByInquiry(@Param("inquiryId") Long inquiryId);

    // ===== 상태 변경 =====

    // 문의 상태 변경 (status: PENDING / IN_PROGRESS / COMPLETED)
    void updateStatus(@Param("inquiryId") Long inquiryId,
                      @Param("status") String status);

    // 문의 상태 변경 (처리 시각도 함께 기록)
    void updateStatusWithTime(@Param("inquiryId") Long inquiryId,
                              @Param("status") String status);

    // ===== 공개여부 변경 =====

    // 문의 공개여부 변경 (isPrivate: 1=비공개 / 0=공개)
    void updateIsPrivate(@Param("inquiryId") Long inquiryId,
                         @Param("isPrivate") int isPrivate);

    // ===== 첨부파일 =====

    // 첨부파일 INSERT
    void insertAttachment(InquiryAttachmentDto attachment);

    // 첨부파일 목록 조회
    List<InquiryAttachmentDto> selectAttachmentList(@Param("inquiryId") Long inquiryId);

    // 첨부파일 삭제
    void deleteAttachment(@Param("attachmentId") Long attachmentId);

    // ===== 도배 방지 =====

    // 최근 N분 내 해당 유저의 문의 작성 수 조회
    int countRecentInquiriesByUser(@Param("userIdx") Long userIdx, @Param("minutes") int minutes);

    // ===== AI 독성 감지 BLUR =====

    // AI 독성 감지 플래그 설정 (비동기 Perspective API 결과 반영)
    void setInquiryAiFlagged(@Param("inquiryId") Long inquiryId);

    // 관리자 BLUR 해제 (ai_flagged 초기화)
    void clearInquiryBlur(@Param("inquiryId") Long inquiryId);

}
