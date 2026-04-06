package org.triptogether.inquiry.service;

import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

public interface InquiryService {

    // ===== 목록 =====
    List<InquiryPostDto> getInquiryList(InquirySearchDto search);
    int getTotalCount(InquirySearchDto search);
    int getTotalPage(InquirySearchDto search);

    // ===== 상세 =====
    InquiryPostDto getInquiry(Long inquiryId);
    InquiryAnswerDto getAnswer(Long inquiryId);

    // ===== 조회수 =====
    void increaseViewCount(Long inquiryId);

    // ===== 문의 등록 =====
    Long writeInquiry(InquiryPostDto inquiry);

    // ===== 답변 등록 =====
    void writeAnswer(Long inquiryId, Long adminUserIdx, String content);

    void updateInquiry(InquiryPostDto inquiry);
    void deleteInquiry(Long inquiryId);

}
