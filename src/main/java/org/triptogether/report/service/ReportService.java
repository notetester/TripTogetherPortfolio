package org.triptogether.report.service;

import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.report.vo.ReportStatsDto;

import java.util.List;

public interface ReportService {

    // ===== 통계 조회 =====

    // 신고 현황 통계 가져옴 (어드민 대시보드용)
    ReportStatsDto getReportStats();

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 신고 목록 가져옴
    List<ReportDto> getReportList(ReportSearchDto search);

    // 검색 조건에 맞는 신고 총 개수 가져옴 (페이지네이션용)
    int getTotalCount(ReportSearchDto search);

    // 총 페이지 수 계산함
    int getTotalPage(ReportSearchDto search);

    // ===== 단건 조회 =====

    // 신고 하나 가져옴
    ReportDto getReport(Long reportId);

    // 특정 게시글/댓글/유저의 신고 횟수 가져옴
    int getReportCountByTarget(String targetType, Long targetId);

    // ===== 신고 접수 =====

    // 신고 접수함. 중복 신고면 false 반환, 취소된 신고 재활성화도 처리함
    boolean submitReport(String targetType, Long targetId, Long userIdx, String reason, String description,
                         String sourceType, Long sourceId);

    // ===== 신고 수정 =====

    // 신고 내용 수정함 (본인 + IN_REVIEW 상태만 가능)
    void updateReport(Long reportId, String reason, String description);

    // ===== 신고 취소 =====

    // 신고 취소함. status를 CANCELLED로 바꿈 (본인만 가능)
    void cancelReport(Long reportId);

    // ===== 신고 삭제 =====

    // 신고 삭제함 (본인만 가능)
    void deleteReport(Long reportId);

    // ===== 상태 변경 (어드민) =====

    // 신고 상태 변경함. PENDING → RESOLVED / DISMISSED (어드민 전용)
    void updateReportStatus(Long reportId, String status, Long resolverIdx, String resolveAction);

    // 반려된 신고를 PENDING으로 복원함 (어드민 전용)
    void revertReportToPending(Long reportId);

}
