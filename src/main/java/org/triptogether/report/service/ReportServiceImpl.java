package org.triptogether.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.report.mapper.ReportMapper;
import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;

import java.util.List;

/**
 * =============================================
 * ReportServiceImpl - 신고 게시판 서비스 구현체
 * =============================================
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private final ReportMapper reportMapper;
    private final MyPageService myPageService;

    /* =============================================
       1. 신고 목록 조회
       ============================================= */
    @Override
    public List<ReportDto> getReportList(ReportSearchDto search) {
        return reportMapper.selectReportList(search);
    }

    /* =============================================
       2. 전체 개수 조회
       ============================================= */
    @Override
    public int getTotalCount(ReportSearchDto search) {
        return reportMapper.selectTotalCount(search);
    }

    /* =============================================
       3. 전체 페이지 수 계산
       ============================================= */
    @Override
    public int getTotalPage(ReportSearchDto search) {
        int total = getTotalCount(search);
        return (int) Math.ceil((double) total / search.getPageSize());
    }

    /* =============================================
       4. 신고 단건 조회
       ============================================= */
    @Override
    public ReportDto getReport(Long reportId) {
        return reportMapper.selectReport(reportId);
    }

    /* =============================================
       5. 대상별 신고 수 조회
       ============================================= */
    @Override
    public int getReportCountByTarget(String targetType, Long targetId) {
        return reportMapper.selectReportCountByTarget(targetType, targetId);
    }

    /* =============================================
       6. 신고 접수
       - 기존 CANCELLED 신고가 있으면 재활성화
       - 이미 IN_REVIEW/RESOLVED/DISMISSED 상태면 false 반환
       - 신규 신고면 INSERT
       ============================================= */
    @Override
    @Transactional
    public boolean submitReport(String targetType, Long targetId, Long userIdx, String reason, String description,
                                String sourceType, Long sourceId) {
        ReportDto existing = reportMapper.selectReportByUserAndTarget(userIdx, targetType, targetId);
        if (existing != null) {
            if ("CANCELLED".equals(existing.getStatus())) {
                reportMapper.reactivateCancelledReport(existing.getReportId(), reason, description, sourceType, sourceId);
                return true;
            }
            return false;
        }

        ReportDto report = new ReportDto();
        report.setTargetType(targetType);
        report.setUserIdx(userIdx);
        report.setReason(reason);
        report.setDescription(description);
        report.setTargetId(targetId);
        report.setSourceType(sourceType);
        report.setSourceId(sourceId);

        int inserted = reportMapper.insertReport(report);
        return inserted > 0;
    }

    /* =============================================
       7. 신고 상태 변경
       - RESOLVED/DISMISSED 시 신고자에게 알림 발송
       ============================================= */
    @Override
    @Transactional
    public void updateReportStatus(Long reportId, String status, Long resolverIdx, String resolveAction) {
        reportMapper.updateReportStatus(reportId, status, resolverIdx, resolveAction);

        if ("RESOLVED".equals(status) || "DISMISSED".equals(status)) {
            ReportDto report = reportMapper.selectReport(reportId);
            if (report != null) {
                FeedNotificationDto notification = new FeedNotificationDto();
                notification.setUserIdx(report.getUserIdx());
                notification.setSourceType("report");
                notification.setSourceId(reportId);
                notification.setMessage("RESOLVED".equals(status)
                        ? "접수하신 신고가 처리되었습니다."
                        : "접수하신 신고가 반려되었습니다.");
                myPageService.addNotification(notification);
            }
        }
    }

    /* =============================================
       8. 신고 반려 취소 → PENDING 복원
       ============================================= */
    @Override
    @Transactional
    public void revertReportToPending(Long reportId) {
        reportMapper.revertReportToPending(reportId);
    }

    /* =============================================
       9. 신고 내용 수정
       ============================================= */
    @Override
    @Transactional
    public void updateReport(Long reportId, String reason, String description) {
        reportMapper.updateReport(reportId, reason, description);
    }

    /* =============================================
       10. 신고 삭제
       ============================================= */
    @Override
    @Transactional
    public void deleteReport(Long reportId) {
        reportMapper.deleteReport(reportId);
    }

    /* =============================================
       11. 신고 취소 → CANCELLED
       ============================================= */
    @Override
    @Transactional
    public void cancelReport(Long reportId) {
        reportMapper.cancelReport(reportId);
    }
}
