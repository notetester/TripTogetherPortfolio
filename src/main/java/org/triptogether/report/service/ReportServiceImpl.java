package org.triptogether.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.report.mapper.ReportMapper;
import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.report.vo.ReportStatsDto;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    private final ReportMapper reportMapper;
    private final MyPageService myPageService;

    // ===== 통계 조회 =====

    // 신고 현황 통계 가져옴 (어드민 대시보드용)
    @Override
    public ReportStatsDto getReportStats() {
        return reportMapper.selectReportStats();
    }

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 신고 목록 가져옴
    @Override
    public List<ReportDto> getReportList(ReportSearchDto search) {
        return reportMapper.selectReportList(search);
    }

    // 검색 조건에 맞는 신고 총 개수 가져옴
    @Override
    public int getTotalCount(ReportSearchDto search) {
        return reportMapper.selectTotalCount(search);
    }

    // 총 페이지 수 계산함 (올림 처리)
    @Override
    public int getTotalPage(ReportSearchDto search) {
        int total = getTotalCount(search);
        return (int) Math.ceil((double) total / search.getPageSize());
    }

    // ===== 단건 조회 =====

    // 신고 하나 가져옴
    @Override
    public ReportDto getReport(Long reportId) {
        return reportMapper.selectReport(reportId);
    }

    // 특정 게시글/댓글/유저의 신고 횟수 가져옴
    @Override
    public int getReportCountByTarget(String targetType, Long targetId) {
        return reportMapper.selectReportCountByTarget(targetType, targetId);
    }

    // ===== 신고 접수 =====

    // 신고 접수함. 기존 CANCELLED 신고면 재활성화, 이미 처리 중이면 false 반환, 신규면 INSERT
    @Override
    @Transactional
    public boolean submitReport(String targetType, Long targetId, Long userIdx, String reason, String description,
                                String sourceType, Long sourceId) {
        ReportDto existing = reportMapper.selectReportByUserAndTarget(userIdx, targetType, targetId);
        if (existing != null) {
            if ("CANCELLED".equals(existing.getStatus())) {
                // 취소된 신고가 있으면 재활성화
                reportMapper.reactivateCancelledReport(existing.getReportId(), reason, description, sourceType, sourceId);
                return true;
            }
            // IN_REVIEW / RESOLVED / DISMISSED 상태면 중복 신고 거부
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

    // ===== 신고 수정 =====

    // 신고 내용 수정함 (본인 + IN_REVIEW 상태만 가능)
    @Override
    @Transactional
    public void updateReport(Long reportId, String reason, String description) {
        reportMapper.updateReport(reportId, reason, description);
    }

    // ===== 신고 삭제 =====

    // 신고 삭제함 (본인만 가능)
    @Override
    @Transactional
    public void deleteReport(Long reportId) {
        reportMapper.deleteReport(reportId);
    }

    // ===== 신고 취소 =====

    // 신고 취소함. status를 CANCELLED로 바꿈 (본인만 가능)
    @Override
    @Transactional
    public void cancelReport(Long reportId) {
        reportMapper.cancelReport(reportId);
    }

    // ===== 상태 변경 (어드민) =====

    // 신고 상태 변경함. RESOLVED/DISMISSED 시 신고자에게 알림 발송함
    @Override
    @Transactional
    public void updateReportStatus(Long reportId, String status, Long resolverIdx, String resolveAction) {
        reportMapper.updateReportStatus(reportId, status, resolverIdx, resolveAction);

        // 처리 완료 또는 반려 시 신고자에게 알림 발송
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
                notification.setTargetUrl(NotificationUrlBuilder.report());
                myPageService.addNotification(notification);
            }
        }
    }

    // 반려된 신고를 PENDING으로 복원함 (어드민 전용)
    @Override
    @Transactional
    public void revertReportToPending(Long reportId) {
        reportMapper.revertReportToPending(reportId);
    }

}
