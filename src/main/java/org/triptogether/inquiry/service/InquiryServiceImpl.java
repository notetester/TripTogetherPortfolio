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
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;
    private final CloudinaryService cloudinaryService;
    private final ModerationPolicyService moderationPolicyService;

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 문의 목록 가져옴
    @Override
    public List<InquiryPostDto> getInquiryList(InquirySearchDto search) {
        return inquiryMapper.selectInquiryList(search);
    }

    // 검색 조건에 맞는 문의 총 개수 가져옴
    @Override
    public int getTotalCount(InquirySearchDto search) {
        return inquiryMapper.selectTotalCount(search);
    }

    // 총 페이지 수 계산함 (올림 처리)
    @Override
    public int getTotalPage(InquirySearchDto search) {
        int totalCount = inquiryMapper.selectTotalCount(search);
        return (int) Math.ceil((double) totalCount / search.getPageSize());
    }

    // ===== 단건 조회 =====

    // 문의 하나 가져옴
    @Override
    public InquiryPostDto getInquiry(Long inquiryId) {
        return inquiryMapper.selectInquiry(inquiryId);
    }

    // 해당 문의에 달린 답변 가져옴 (답변 없으면 null)
    @Override
    public InquiryAnswerDto getAnswer(Long inquiryId) {
        return inquiryMapper.selectAnswer(inquiryId);
    }

    // ===== 조회수 증가 =====

    // 조회수 1 올림
    @Override
    public void increaseViewCount(Long inquiryId) {
        inquiryMapper.updateViewCount(inquiryId);
    }

    // ===== 문의 등록 =====

    // 문의 등록함 (이미지 없는 버전). 생성된 inquiryId 반환
    @Override
    @Transactional
    public Long writeInquiry(InquiryPostDto inquiry) {
        return writeInquiry(inquiry, null);
    }

    // 문의 등록함 (이미지 첨부 포함). 도배 방지 후 저장. 생성된 inquiryId 반환
    @Override
    @Transactional
    public Long writeInquiry(InquiryPostDto inquiry, List<MultipartFile> images) {
        ContentModerationPolicyVO policy = moderationPolicyService.getPolicy();
        if (inquiryMapper.countRecentInquiriesByUser(inquiry.getUserIdx(), policy.getInquiryWindowMinutes()) >= policy.getInquiryMaxCount()) {
            throw new IllegalStateException(
                    policy.getInquiryWindowMinutes() + "분 내 문의를 " + policy.getInquiryMaxCount() + "개 이상 작성할 수 없습니다.");
        }
        inquiryMapper.insertInquiry(inquiry);
        Long inquiryId = inquiry.getInquiryId(); // useGeneratedKeys로 자동 주입

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

    // ===== 문의 수정 =====

    // 문의 수정함 (제목/내용/카테고리/공개여부). PENDING 상태일 때만 가능
    @Override
    @Transactional
    public void updateInquiry(InquiryPostDto inquiry) {
        inquiryMapper.updateInquiry(inquiry);
    }

    // ===== 문의 삭제 =====

    // 문의 삭제함. PENDING 상태일 때만 가능
    @Override
    @Transactional
    public void deleteInquiry(Long inquiryId) {
        inquiryMapper.deleteInquiry(inquiryId);
    }

    // ===== 답변 등록 =====

    // 답변 등록함. 등록 후 문의 status → IN_PROGRESS로 바꿈
    @Override
    @Transactional
    public void writeAnswer(Long inquiryId, Long adminUserIdx, String content) {
        writeAnswer(inquiryId, adminUserIdx, content, false);
    }

    // 답변 등록함. complete=true면 status → COMPLETED, false면 → IN_PROGRESS
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

    // ===== 답변 수정 =====

    // 답변 내용 수정함 (어드민 전용)
    @Override
    @Transactional
    public void updateAnswer(Long inquiryId, String content) {
        InquiryAnswerDto answer = new InquiryAnswerDto();
        answer.setInquiryId(inquiryId);
        answer.setContent(content);
        inquiryMapper.updateAnswer(answer);
    }

    // ===== 답변 삭제 =====

    // 답변 삭제함. 삭제 후 문의 status → IN_PROGRESS로 되돌림
    @Override
    @Transactional
    public void deleteAnswer(Long inquiryId) {
        inquiryMapper.deleteAnswer(inquiryId);
        inquiryMapper.updateStatus(inquiryId, "IN_PROGRESS");
    }

    // ===== 상태 변경 =====

    // 문의 상태 변경함 (처리 시각도 함께 기록)
    @Override
    public void updateStatusWithTime(Long inquiryId, String status) {
        inquiryMapper.updateStatusWithTime(inquiryId, status);
    }

    // ===== 공개여부 변경 (어드민) =====

    // 문의 공개여부 변경함. type: "public" / "private"
    @Override
    @Transactional
    public void approveVisibility(Long inquiryId, String type) {
        int isPrivate = "private".equals(type) ? 1 : 0;
        inquiryMapper.updateIsPrivate(inquiryId, isPrivate);
        inquiryMapper.updateStatus(inquiryId, "COMPLETED");
    }

    // ===== 첨부파일 =====

    // 첨부파일 추가함 (URL + 파일명 직접 전달)
    @Override
    @Transactional
    public void addAttachment(Long inquiryId, String fileUrl, String fileName) {
        InquiryAttachmentDto attachment = new InquiryAttachmentDto();
        attachment.setInquiryId(inquiryId);
        attachment.setFileUrl(fileUrl);
        attachment.setFileName(fileName);
        inquiryMapper.insertAttachment(attachment);
    }

    // 첨부파일 추가함 (MultipartFile 업로드)
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

    // 첨부파일 목록 가져옴
    @Override
    public List<InquiryAttachmentDto> getAttachmentList(Long inquiryId) {
        return inquiryMapper.selectAttachmentList(inquiryId);
    }

    // 첨부파일 삭제함
    @Override
    @Transactional
    public void removeAttachment(Long attachmentId) {
        inquiryMapper.deleteAttachment(attachmentId);
    }

    // ===== AI 독성 감지 BLUR =====

    // AI 독성 감지 플래그 설정
    @Override
    @Transactional
    public void flagInquiryAsToxic(Long inquiryId) {
        inquiryMapper.setInquiryAiFlagged(inquiryId);
    }

    // 관리자 BLUR 해제
    @Override
    @Transactional
    public void clearInquiryBlur(Long inquiryId) {
        inquiryMapper.clearInquiryBlur(inquiryId);
    }

    // ===== private 유틸 =====

    // 이미지 파일 Cloudinary에 업로드하고 URL 반환함
    private String saveFile(MultipartFile file) {
        return cloudinaryService.uploadImage(file, "inquiry");
    }

}
