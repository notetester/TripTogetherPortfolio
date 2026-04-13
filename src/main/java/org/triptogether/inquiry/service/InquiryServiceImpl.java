package org.triptogether.inquiry.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.inquiry.mapper.InquiryMapper;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryAttachmentDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.util.List;

/**
 * =============================================
 * InquiryServiceImpl - 문의 게시판 서비스 구현체
 * =============================================
 * [@Transactional]
 * 여러 DB 작업을 하나로 묶어줌
 * 예) 답변 등록 + 상태 변경 → 둘 다 성공하거나 둘 다 실패
 * =============================================
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;
    private final CloudinaryService cloudinaryService;

    /* =============================================
       1. 목록 조회
       - 검색 조건에 맞는 문의 목록 반환
       ============================================= */
    @Override
    public List<InquiryPostDto> getInquiryList(InquirySearchDto search) {
        return inquiryMapper.selectInquiryList(search);
    }

    /* =============================================
       2. 전체 개수 조회
       - 페이지네이션 계산에 사용
       ============================================= */
    @Override
    public int getTotalCount(InquirySearchDto search) {
        return inquiryMapper.selectTotalCount(search);
    }

    /* =============================================
       3. 전체 페이지 수 계산
       - 전체 개수 ÷ 페이지당 개수 = 총 페이지 수
       - Math.ceil: 소수점 올림 (예: 2.1 → 3페이지)
       ============================================= */
    @Override
    public int getTotalPage(InquirySearchDto search) {
        int totalCount = inquiryMapper.selectTotalCount(search);
        return (int) Math.ceil((double) totalCount / search.getPageSize());
    }

    /* =============================================
       4. 문의 상세 조회
       - inquiryId로 단건 문의 조회
       ============================================= */
    @Override
    public InquiryPostDto getInquiry(Long inquiryId) {
        return inquiryMapper.selectInquiry(inquiryId);
    }

    /* =============================================
       5. 답변 조회
       - 해당 문의에 달린 운영진 답변 조회
       - 답변이 없으면 null 반환
       ============================================= */
    @Override
    public InquiryAnswerDto getAnswer(Long inquiryId) {
        return inquiryMapper.selectAnswer(inquiryId);
    }

    /* =============================================
       6. 조회수 증가
       - 상세 페이지 진입 시 호출
       ============================================= */
    @Override
    public void increaseViewCount(Long inquiryId) {
        inquiryMapper.updateViewCount(inquiryId);
    }

    /* =============================================
       7. 문의 등록
       - 새 문의를 DB에 저장
       - insertInquiry 실행 후 MyBatis가 자동으로
         생성된 PK(inquiryId)를 inquiry 객체에 넣어줌
       ============================================= */
    @Override
    @Transactional
    public Long writeInquiry(InquiryPostDto inquiry) {
        return writeInquiry(inquiry, null);
    }

    @Override
    @Transactional
    public Long writeInquiry(InquiryPostDto inquiry, List<MultipartFile> images) {
        // 도배 방지: 10분 내 3개 이상이면 거부
        if (inquiryMapper.countRecentInquiriesByUser(inquiry.getUserIdx(), 10) >= 3) {
            throw new IllegalStateException("10분 내 문의를 3개 이상 작성할 수 없습니다.");
        }
        inquiryMapper.insertInquiry(inquiry);
        Long inquiryId = inquiry.getInquiryId();

        if (images != null) {
            for (MultipartFile file : images) {
                if (file == null || file.isEmpty()) continue;
                String savedUrl = saveFile(file);
                if (savedUrl != null) {
                    InquiryAttachmentDto attachment = new InquiryAttachmentDto();
                    attachment.setInquiryId(inquiryId);
                    attachment.setFileUrl(savedUrl);
                    attachment.setFileName(file.getOriginalFilename());
                    inquiryMapper.insertAttachment(attachment);
                }
            }
        }

        return inquiryId;
    }

    /* =============================================
       8. 답변 등록
       - 운영진이 문의에 답변 저장
       - 답변 저장 후 문의 상태를 COMPLETED로 자동 변경
       - @Transactional: 두 작업(insertAnswer + updateStatus)을
         하나로 묶어서 둘 다 성공하거나 둘 다 실패하게 함
       ============================================= */
    @Override
    @Transactional
    public void writeAnswer(Long inquiryId, Long adminUserIdx, String content) {
        writeAnswer(inquiryId, adminUserIdx, content, false);
    }

    @Override
    @Transactional
    public void writeAnswer(Long inquiryId, Long adminUserIdx, String content, boolean complete) {
        InquiryAnswerDto answer = new InquiryAnswerDto();
        answer.setInquiryId(inquiryId);
        answer.setAdminUserIdx(adminUserIdx);
        answer.setContent(content);
        inquiryMapper.insertAnswer(answer);
        inquiryMapper.updateStatus(inquiryId, complete ? "COMPLETED" : "IN_PROGRESS");
    }

    /* =============================================
       9. 문의 수정
       - 제목, 내용, 카테고리, 공개여부 수정
       - PENDING 상태일 때만 가능 (Controller에서 체크)
       ============================================= */
    @Override
    @Transactional
    public void updateInquiry(InquiryPostDto inquiry) {
        inquiryMapper.updateInquiry(inquiry);
    }

    /* =============================================
       10. 문의 삭제
       - PENDING 상태일 때만 가능 (Controller에서 체크)
       ============================================= */
    @Override
    @Transactional
    public void deleteInquiry(Long inquiryId) {
        inquiryMapper.deleteInquiry(inquiryId);
    }

    @Override
    public void updateStatusWithTime(Long inquiryId, String status) {
        inquiryMapper.updateStatusWithTime(inquiryId, status);
    }

    @Override
    @Transactional
    public void approveVisibility(Long inquiryId, String type) {
        int isPrivate = "private".equals(type) ? 1 : 0;
        inquiryMapper.updateIsPrivate(inquiryId, isPrivate);
        inquiryMapper.updateStatus(inquiryId, "COMPLETED");
    }

    @Override
    @Transactional
    public void updateAnswer(Long inquiryId, String content) {
        InquiryAnswerDto answer = new InquiryAnswerDto();
        answer.setInquiryId(inquiryId);
        answer.setContent(content);
        inquiryMapper.updateAnswer(answer);
    }

    @Override
    @Transactional
    public void deleteAnswer(Long inquiryId) {
        inquiryMapper.deleteAnswer(inquiryId);
        inquiryMapper.updateStatus(inquiryId, "IN_PROGRESS");
    }

    @Override
    @Transactional
    public void addAttachment(Long inquiryId, String fileUrl, String fileName) {
        InquiryAttachmentDto attachment = new InquiryAttachmentDto();
        attachment.setInquiryId(inquiryId);
        attachment.setFileUrl(fileUrl);
        attachment.setFileName(fileName);
        inquiryMapper.insertAttachment(attachment);
    }

    @Override
    @Transactional
    public void addAttachment(Long inquiryId, MultipartFile file) {
        String savedUrl = saveFile(file);
        if (savedUrl != null) {
            InquiryAttachmentDto attachment = new InquiryAttachmentDto();
            attachment.setInquiryId(inquiryId);
            attachment.setFileUrl(savedUrl);
            attachment.setFileName(file.getOriginalFilename());
            inquiryMapper.insertAttachment(attachment);
        }
    }

    @Override
    public List<InquiryAttachmentDto> getAttachmentList(Long inquiryId) {
        return inquiryMapper.selectAttachmentList(inquiryId);
    }

    @Override
    @Transactional
    public void removeAttachment(Long attachmentId) {
        inquiryMapper.deleteAttachment(attachmentId);
    }

    // ===== 파일 저장 유틸 =====

    private String saveFile(MultipartFile file) {
        return cloudinaryService.uploadImage(file, "inquiry");
    }
}