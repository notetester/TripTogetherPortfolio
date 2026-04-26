package org.triptogether.inquiry;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.common.util.MessageUtil;
import org.triptogether.inquiry.mapper.InquiryMapper;
import org.triptogether.inquiry.service.InquiryServiceImpl;
import org.triptogether.inquiry.vo.InquiryAnswerDto;
import org.triptogether.inquiry.vo.InquiryAnswerHistoryDto;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

/**
 * InquiryServiceImpl 단위 테스트.
 *
 * 정책 검증 대상:
 * - 답변 수정/삭제 이력 보존 (INQUIRY_ANSWER_HISTORY)
 * - 도배 방지 (ADR-0009 정책 외부화 활용)
 * - P0 보안: 첨부파일 검증 (잘못된 파일 silently skip)
 */
@ExtendWith(MockitoExtension.class)
class InquiryServiceTest {

    @Mock InquiryMapper inquiryMapper;
    @Mock CloudinaryService cloudinaryService;
    @Mock ModerationPolicyService moderationPolicyService;
    @Mock MessageUtil msg;

    @InjectMocks InquiryServiceImpl inquiryService;

    private static final Long INQUIRY_ID = 10L;
    private static final Long USER_IDX   = 7L;
    private static final Long ADMIN_IDX  = 99L;
    private static final Long ANSWER_ID  = 33L;

    @BeforeEach
    void setUp() {
        ContentModerationPolicyVO policy = new ContentModerationPolicyVO();
        policy.setInquiryWindowMinutes(5);
        policy.setInquiryMaxCount(3);
        lenient().when(moderationPolicyService.getPolicy()).thenReturn(policy);
        lenient().when(msg.get(eq("inquiry.service.error.rateLimit"), any(), any()))
                .thenReturn("5분 내 문의를 3개 이상 작성할 수 없습니다.");
    }

    // ===== 도배 방지 =====

    @Test
    @DisplayName("문의 도배 방지 - 5분 내 3개 이상이면 IllegalStateException")
    void writeInquiry_floodLimit_throwsException() {
        InquiryPostDto inquiry = new InquiryPostDto();
        inquiry.setUserIdx(USER_IDX);
        given(inquiryMapper.countRecentInquiriesByUser(USER_IDX, 5)).willReturn(3);

        assertThatThrownBy(() -> inquiryService.writeInquiry(inquiry))
                .isInstanceOf(IllegalStateException.class)
                .hasMessageContaining("3개 이상");
    }

    // ===== 답변 등록 / 상태 변경 =====

    @Test
    @DisplayName("답변 등록 - INSERT + 문의 status를 IN_PROGRESS 로 변경")
    void writeAnswer_insertsAndUpdatesStatus() {
        inquiryService.writeAnswer(INQUIRY_ID, ADMIN_IDX, "답변");

        verify(inquiryMapper).insertAnswer(any(InquiryAnswerDto.class));
        verify(inquiryMapper).updateStatus(INQUIRY_ID, "IN_PROGRESS");
    }

    @Test
    @DisplayName("답변 등록(complete=true) - status 를 COMPLETED 로 변경")
    void writeAnswer_complete_setsCompletedStatus() {
        inquiryService.writeAnswer(INQUIRY_ID, ADMIN_IDX, "답변", true);

        verify(inquiryMapper).insertAnswer(any(InquiryAnswerDto.class));
        verify(inquiryMapper).updateStatus(INQUIRY_ID, "COMPLETED");
    }

    // ===== 답변 수정 - INQUIRY_ANSWER_HISTORY 이력 보존 =====

    @Test
    @DisplayName("답변 수정 - 기존 답변을 history 에 INSERT 한 뒤 UPDATE 수행")
    void updateAnswer_archivesPreviousThenUpdates() {
        InquiryAnswerDto existing = new InquiryAnswerDto();
        existing.setAnswerId(ANSWER_ID);
        existing.setInquiryId(INQUIRY_ID);
        existing.setAdminUserIdx(ADMIN_IDX);
        existing.setContent("이전 답변 본문");
        given(inquiryMapper.selectAnswer(INQUIRY_ID)).willReturn(existing);

        inquiryService.updateAnswer(INQUIRY_ID, "수정된 답변", ADMIN_IDX);

        ArgumentCaptor<InquiryAnswerHistoryDto> historyCaptor =
                ArgumentCaptor.forClass(InquiryAnswerHistoryDto.class);
        verify(inquiryMapper).insertAnswerHistory(historyCaptor.capture());
        InquiryAnswerHistoryDto history = historyCaptor.getValue();
        assertThat(history.getAnswerId()).isEqualTo(ANSWER_ID);
        assertThat(history.getInquiryId()).isEqualTo(INQUIRY_ID);
        assertThat(history.getPrevContent()).isEqualTo("이전 답변 본문");
        assertThat(history.getPrevAdminUserIdx()).isEqualTo(ADMIN_IDX);
        assertThat(history.getChangeType()).isEqualTo("UPDATE");
        verify(inquiryMapper).updateAnswer(any(InquiryAnswerDto.class));
    }

    @Test
    @DisplayName("답변 수정 - 기존 답변이 없으면 history INSERT 안 함 (UPDATE 만 수행)")
    void updateAnswer_noExisting_skipsHistory() {
        given(inquiryMapper.selectAnswer(INQUIRY_ID)).willReturn(null);

        inquiryService.updateAnswer(INQUIRY_ID, "수정된 답변", ADMIN_IDX);

        verify(inquiryMapper, never()).insertAnswerHistory(any());
        verify(inquiryMapper).updateAnswer(any(InquiryAnswerDto.class));
    }

    // ===== 답변 삭제 - history 에 DELETE 타입으로 보존 =====

    @Test
    @DisplayName("답변 삭제 - history 에 DELETE 타입으로 INSERT + DELETE + status IN_PROGRESS 복원")
    void deleteAnswer_archivesAsDeleteThenRemoves() {
        InquiryAnswerDto existing = new InquiryAnswerDto();
        existing.setAnswerId(ANSWER_ID);
        existing.setInquiryId(INQUIRY_ID);
        existing.setAdminUserIdx(ADMIN_IDX);
        existing.setContent("삭제할 답변");
        given(inquiryMapper.selectAnswer(INQUIRY_ID)).willReturn(existing);

        inquiryService.deleteAnswer(INQUIRY_ID, ADMIN_IDX);

        ArgumentCaptor<InquiryAnswerHistoryDto> captor =
                ArgumentCaptor.forClass(InquiryAnswerHistoryDto.class);
        verify(inquiryMapper).insertAnswerHistory(captor.capture());
        assertThat(captor.getValue().getChangeType()).isEqualTo("DELETE");
        assertThat(captor.getValue().getPrevContent()).isEqualTo("삭제할 답변");
        verify(inquiryMapper).deleteAnswer(INQUIRY_ID);
        verify(inquiryMapper).updateStatus(INQUIRY_ID, "IN_PROGRESS");
    }

    // ===== P0 보안: 첨부파일 검증 =====

    @Test
    @DisplayName("첨부파일 검증 - .exe 파일 silently skip (mapper INSERT 안 함)")
    void addAttachment_invalidExtension_skipped() {
        MultipartFile evil = new MockMultipartFile(
                "file", "malware.exe", "application/octet-stream", new byte[]{1, 2, 3});

        inquiryService.addAttachment(INQUIRY_ID, evil);

        verify(inquiryMapper, never()).insertAttachment(any());
    }

    @Test
    @DisplayName("첨부파일 검증 - 5MB 초과 시 silently skip")
    void addAttachment_oversize_skipped() {
        byte[] big = new byte[6 * 1024 * 1024]; // 6MB
        MultipartFile huge = new MockMultipartFile(
                "file", "big.jpg", "image/jpeg", big);

        inquiryService.addAttachment(INQUIRY_ID, huge);

        verify(inquiryMapper, never()).insertAttachment(any());
    }
}
