package org.triptogether.inquiry.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

@Mapper
public interface InquiryMapper {

    // ===== 목록 =====
    List<InquiryPostDto> selectInquiryList(InquirySearchDto search);
    int selectTotalCount(InquirySearchDto search);

    // ===== 상세 =====
    InquiryPostDto selectInquiry(@Param("inquiryId") Long inquiryId);
    InquiryAnswerDto selectAnswer(@Param("inquiryId") Long inquiryId);

    // ===== 조회수 =====
    void updateViewCount(@Param("inquiryId") Long inquiryId);

    // ===== 문의 등록 =====
    void insertInquiry(InquiryPostDto inquiry);

    // ===== 답변 등록 =====
    void insertAnswer(InquiryAnswerDto answer);

    // ===== 상태 변경 =====
    void updateStatus(@Param("inquiryId") Long inquiryId,
                      @Param("status") String status);
}
