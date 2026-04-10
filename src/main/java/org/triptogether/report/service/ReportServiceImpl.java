package org.triptogether.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
       - INSERT IGNORE로 중복 신고 방지
       - 삽입된 행이 0이면 이미 신고한 것 → false 반환
       ============================================= */
    @Override
    @Transactional
    public boolean submitReport(String targetType, Long targetId, Long userIdx, String reason) {
        ReportDto report = new ReportDto();
        report.setTargetType(targetType);
        report.setUserIdx(userIdx);
        report.setReason(reason);

        report.setTargetId(targetId);

        int inserted = reportMapper.insertReport(report);
        return inserted > 0;
    }

    /* =============================================
       7. 신고 상태 변경
       ============================================= */
    @Override
    @Transactional
    public void updateReportStatus(Long reportId, String status, Long resolverIdx) {
        reportMapper.updateReportStatus(reportId, status, resolverIdx);
    }
}
