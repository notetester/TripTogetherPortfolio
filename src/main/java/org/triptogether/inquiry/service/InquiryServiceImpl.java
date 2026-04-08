package org.triptogether.inquiry.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.inquiry.mapper.InquiryMapper;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;

    // ===== 목록 =====
    @Override
    public List<InquiryPostDto> getInquiryList(InquirySearchDto search) {
        return inquiryMapper.selectInquiryList(search);
    }

    @Override
    public int getTotalCount(InquirySearchDto search) {
        return inquiryMapper.selectTotalCount(search);
    }

    @Override
    public int getTotalPage(InquirySearchDto search) {
        int totalCount = inquiryMapper.selectTotalCount(search);
        return (int) Math.ceil((double) totalCount / search.getPageSize());
    }

    // ===== 상세 =====
    @Override
    public InquiryPostDto getInquiry(Long inquiryId) {
        return inquiryMapper.selectInquiry(inquiryId);
    }

    @Override
    public InquiryAnswerDto getAnswer(Long inquiryId) {
        return inquiryMapper.selectAnswer(inquiryId);
    }

    // ===== 조회수 =====
    @Override
    public void increaseViewCount(Long inquiryId) {
        inquiryMapper.updateViewCount(inquiryId);
    }

    // ===== 문의 등록 =====
    @Override
    @Transactional
    public Long writeInquiry(InquiryPostDto inquiry) {
        inquiryMapper.insertInquiry(inquiry);
        return inquiry.getInquiryId();
    }

    // ===== 답변 등록 =====
    @Override
    @Transactional
    public void writeAnswer(Long inquiryId, Long adminUserIdx, String content) {
        InquiryAnswerDto answer = new InquiryAnswerDto();
        answer.setInquiryId(inquiryId);
        answer.setAdminUserIdx(adminUserIdx);
        answer.setContent(content);
        inquiryMapper.insertAnswer(answer);
        inquiryMapper.updateStatus(inquiryId, "COMPLETED");
    }

    @Override
    @Transactional
    public void updateInquiry(InquiryPostDto inquiry) {
        inquiryMapper.updateInquiry(inquiry);
    }

    @Override
    @Transactional
    public void deleteInquiry(Long inquiryId) {
        inquiryMapper.deleteInquiry(inquiryId);
    }
}
