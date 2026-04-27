package org.triptogether.inquiry.service;

import org.springframework.web.multipart.MultipartFile;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryAnswerHistoryDto;
import org.triptogether.inquiry.vo.InquiryAttachmentDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

public interface InquiryService {

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 문의 목록 가져옴
    List<InquiryPostDto> getInquiryList(InquirySearchDto search);

    // 검색 조건에 맞는 문의 총 개수 가져옴 (페이지네이션용)
    int getTotalCount(InquirySearchDto search);

    // 총 페이지 수 계산함
    int getTotalPage(InquirySearchDto search);

    // ===== 단건 조회 =====

    // 문의 하나 가져옴
    InquiryPostDto getInquiry(Long inquiryId);

    // 해당 문의에 달린 답변 가져옴 (답변 없으면 null)
    InquiryAnswerDto getAnswer(Long inquiryId);

    // ===== 조회수 증가 =====

    // 조회수 1 올림 (상세 페이지 진입 시 호출)
    void increaseViewCount(Long inquiryId);

    // ===== 문의 등록 =====

    // 문의 등록함. 생성된 inquiryId 반환
    Long writeInquiry(InquiryPostDto inquiry);

    // 문의 등록함 (이미지 첨부 포함). 생성된 inquiryId 반환
    Long writeInquiry(InquiryPostDto inquiry, List<MultipartFile> images);

    // ===== 문의 수정 =====

    // 문의 수정함 (제목/내용/카테고리/공개여부). PENDING 상태일 때만 가능
    void updateInquiry(InquiryPostDto inquiry);

    // ===== 문의 삭제 =====

    // 문의 삭제함. PENDING 상태일 때만 가능
    void deleteInquiry(Long inquiryId);

    // ===== 답변 등록 =====

    // 답변 등록함. 등록 후 문의 status → IN_PROGRESS로 바꿈
    void writeAnswer(Long inquiryId, Long adminUserIdx, String content);

    // 답변 등록함. complete=true면 status → COMPLETED로 바꿈
    void writeAnswer(Long inquiryId, Long adminUserIdx, String content, boolean complete);

    // ===== 답변 수정 =====

    // 답변 내용 수정함 (어드민 전용). 수정 전 본문은 INQUIRY_ANSWER_HISTORY 에 보존됨
    void updateAnswer(Long inquiryId, String content, Long changedBy);

    // ===== 답변 삭제 =====

    // 답변 삭제함. 삭제 전 본문은 INQUIRY_ANSWER_HISTORY 에 보존됨. 삭제 후 status → IN_PROGRESS
    void deleteAnswer(Long inquiryId, Long changedBy);

    // ===== 답변 수정/삭제 이력 =====

    // 특정 문의의 답변 변경 이력 조회 (어드민 전용, 최신순)
    List<InquiryAnswerHistoryDto> getAnswerHistoryByInquiry(Long inquiryId);

    // ===== 상태 변경 =====

    // 문의 상태 변경함 (처리 시각도 함께 기록)
    void updateStatusWithTime(Long inquiryId, String status);

    // ===== 공개여부 변경 (어드민) =====

    // 문의 공개여부 변경함. type: "public" / "private"
    void approveVisibility(Long inquiryId, String type);

    // ===== 첨부파일 =====

    // 첨부파일 추가함 (URL + 파일명 직접 전달)
    void addAttachment(Long inquiryId, String fileUrl, String fileName);

    // 첨부파일 추가함 (MultipartFile 업로드)
    void addAttachment(Long inquiryId, MultipartFile file);

    // 첨부파일 목록 가져옴
    List<InquiryAttachmentDto> getAttachmentList(Long inquiryId);

    // 첨부파일 삭제함
    void removeAttachment(Long attachmentId);

    // ===== AI 독성 감지 BLUR =====

    // AI 독성 감지 플래그 설정 (PerspectiveService가 @Async 쓰레드에서 호출)
    void flagInquiryAsToxic(Long inquiryId);

    // 관리자 BLUR 해제
    void clearInquiryBlur(Long inquiryId);

}
