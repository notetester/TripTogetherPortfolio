package org.triptogether.report.service;

import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.report.vo.ReportStatsDto;

import java.util.List;

/**
 * =============================================
 * ReportService - 신고 게시판 서비스 인터페이스
 * =============================================
 */
public interface ReportService {

    /* =============================================
       1. 신고 목록 조회
       - 검색 조건(status, targetType)에 맞는 신고 목록 반환
       - 페이지네이션 포함
       ============================================= */
    ReportStatsDto getReportStats();

    List<ReportDto> getReportList(ReportSearchDto search);

    /* =============================================
       2. 전체 개수 조회
       - 페이지네이션 계산에 사용
       ============================================= */
    int getTotalCount(ReportSearchDto search);

    /* =============================================
       3. 전체 페이지 수 계산
       ============================================= */
    int getTotalPage(ReportSearchDto search);

    /* =============================================
       4. 신고 단건 조회
       ============================================= */
    ReportDto getReport(Long reportId);

    /* =============================================
       5. 대상별 신고 수 조회
       - 특정 게시글/댓글/유저의 신고 횟수 반환
       ============================================= */
    int getReportCountByTarget(String targetType, Long targetId);

    /* =============================================
       6. 신고 접수
       - 동일 유저 중복 신고 방지 (INSERT IGNORE)
       - 이미 신고한 경우 false 반환
       ============================================= */
    boolean submitReport(String targetType, Long targetId, Long userIdx, String reason, String description,
                         String sourceType, Long sourceId);

    /* =============================================
       7. 신고 상태 변경 (관리자)
       - PENDING → RESOLVED / DISMISSED
       ============================================= */
    void updateReportStatus(Long reportId, String status, Long resolverIdx, String resolveAction);

    /* =============================================
       8. 신고 반려 취소 → PENDING 복원 (관리자)
       ============================================= */
    void revertReportToPending(Long reportId);

    /* =============================================
       9. 신고 내용 수정 (본인 + IN_REVIEW)
       ============================================= */
    void updateReport(Long reportId, String reason, String description);

    /* =============================================
       10. 신고 삭제 (본인)
       ============================================= */
    void deleteReport(Long reportId);

    /* =============================================
       11. 신고 취소 → CANCELLED (본인 + IN_REVIEW)
       ============================================= */
    void cancelReport(Long reportId);
}
