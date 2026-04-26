package org.triptogether.report;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.report.mapper.ReportMapper;
import org.triptogether.report.service.ReportServiceImpl;
import org.triptogether.report.vo.ReportDto;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

/**
 * ReportServiceImpl 단위 테스트.
 *
 * 정책 검증 대상:
 * - ADR-0001 (신고는 어드민 판단 큐 — 자동 제재 없이 INSERT)
 * - ADR-0004 (중복 신고 방지 3중 방어 — 사전 SELECT + CANCELLED 재활성화 + DataIntegrityViolation 처리)
 */
@ExtendWith(MockitoExtension.class)
class ReportServiceTest {

    @Mock ReportMapper reportMapper;
    @Mock MyPageService myPageService;

    @InjectMocks ReportServiceImpl reportService;

    private static final Long USER_IDX  = 7L;
    private static final Long TARGET_ID = 100L;
    private static final String TARGET_TYPE = "post";

    // ===== submitReport — ADR-0004 (3중 방어) =====

    @Test
    @DisplayName("신고 신규 INSERT - 기존 신고 없으면 정상 등록 → true")
    void submitReport_newInsert_returnsTrue() {
        given(reportMapper.selectReportByUserAndTarget(USER_IDX, TARGET_TYPE, TARGET_ID))
                .willReturn(null);
        given(reportMapper.insertReport(any(ReportDto.class))).willReturn(1);

        boolean result = reportService.submitReport(
                TARGET_TYPE, TARGET_ID, USER_IDX, "spam", "광고성", null, null);

        assertThat(result).isTrue();
        verify(reportMapper).insertReport(any(ReportDto.class));
    }

    @Test
    @DisplayName("중복 신고 거부 - IN_REVIEW 상태 기존 신고가 있으면 false (INSERT 안 함)")
    void submitReport_duplicateInReview_returnsFalse() {
        ReportDto existing = new ReportDto();
        existing.setReportId(99L);
        existing.setStatus("IN_REVIEW");
        given(reportMapper.selectReportByUserAndTarget(USER_IDX, TARGET_TYPE, TARGET_ID))
                .willReturn(existing);

        boolean result = reportService.submitReport(
                TARGET_TYPE, TARGET_ID, USER_IDX, "spam", "광고성", null, null);

        assertThat(result).isFalse();
        verify(reportMapper, never()).insertReport(any());
        verify(reportMapper, never()).reactivateCancelledReport(anyLong(), anyString(), anyString(), any(), any());
    }

    @Test
    @DisplayName("CANCELLED 재활성화 - 취소된 신고가 있으면 reactivate 호출 → true")
    void submitReport_cancelledReactivation_returnsTrue() {
        ReportDto cancelled = new ReportDto();
        cancelled.setReportId(50L);
        cancelled.setStatus("CANCELLED");
        given(reportMapper.selectReportByUserAndTarget(USER_IDX, TARGET_TYPE, TARGET_ID))
                .willReturn(cancelled);

        boolean result = reportService.submitReport(
                TARGET_TYPE, TARGET_ID, USER_IDX, "abuse", "재신고", "comment", 200L);

        assertThat(result).isTrue();
        verify(reportMapper).reactivateCancelledReport(eq(50L), eq("abuse"), eq("재신고"), eq("comment"), eq(200L));
        verify(reportMapper, never()).insertReport(any());
    }

    @Test
    @DisplayName("Race condition 방어 - DB UNIQUE 위반(DataIntegrityViolationException) 시 false 반환")
    void submitReport_dataIntegrityViolation_returnsFalse() {
        given(reportMapper.selectReportByUserAndTarget(USER_IDX, TARGET_TYPE, TARGET_ID))
                .willReturn(null);
        given(reportMapper.insertReport(any(ReportDto.class)))
                .willThrow(new DataIntegrityViolationException("uq_report violated"));

        boolean result = reportService.submitReport(
                TARGET_TYPE, TARGET_ID, USER_IDX, "spam", "광고성", null, null);

        assertThat(result).isFalse();
    }

    // ===== updateReportStatus — 처리 결과 알림 =====

    @Test
    @DisplayName("RESOLVED 처리 - 신고자에게 알림 발송")
    void updateReportStatus_resolved_sendsNotification() {
        Long reportId = 33L;
        ReportDto report = new ReportDto();
        report.setReportId(reportId);
        report.setUserIdx(USER_IDX);
        given(reportMapper.selectReport(reportId)).willReturn(report);

        reportService.updateReportStatus(reportId, "RESOLVED", 1L, "글 삭제");

        verify(reportMapper).updateReportStatus(reportId, "RESOLVED", 1L, "글 삭제");
        ArgumentCaptor<FeedNotificationDto> captor = ArgumentCaptor.forClass(FeedNotificationDto.class);
        verify(myPageService).addNotification(captor.capture());
        FeedNotificationDto sent = captor.getValue();
        assertThat(sent.getUserIdx()).isEqualTo(USER_IDX);
        assertThat(sent.getSourceType()).isEqualTo("report");
        assertThat(sent.getMessage()).contains("처리");
    }
}
