package org.triptogether.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.report.vo.ReportStatsDto;

import java.util.List;

@Mapper
public interface ReportMapper {

    // ===== 통계 조회 =====

    // 신고 현황 통계 조회 (어드민 대시보드용)
    ReportStatsDto selectReportStats();

    // ===== 목록 조회 =====

    // 검색 조건에 맞는 신고 목록 조회 (신고자 닉네임 JOIN 포함)
    List<ReportDto> selectReportList(ReportSearchDto search);

    // 검색 조건에 맞는 신고 총 개수 조회 (페이지네이션용)
    int selectTotalCount(ReportSearchDto search);

    // ===== 단건 조회 =====

    // 신고 하나 조회
    ReportDto selectReport(@Param("reportId") Long reportId);

    // 특정 게시글/댓글/유저의 신고 횟수 조회
    int selectReportCountByTarget(@Param("targetType") String targetType,
                                  @Param("targetId") Long targetId);

    // 대상 유저의 닉네임 조회 (신고 상세 화면에서 대상자 표시용)
    String selectTargetUserNickname(@Param("userIdx") Long userIdx);

    // ===== 신고 접수 =====

    // 신고 등록 (INSERT IGNORE: 동일 유저 중복 신고 방지)
    int insertReport(ReportDto report);

    // 동일 유저+대상 신고 조회 (재신고 여부 판별용)
    ReportDto selectReportByUserAndTarget(@Param("userIdx") Long userIdx,
                                          @Param("targetType") String targetType,
                                          @Param("targetId") Long targetId);

    // 취소된 신고 재활성화 (CANCELLED → IN_REVIEW)
    void reactivateCancelledReport(@Param("reportId") Long reportId,
                                   @Param("reason") String reason,
                                   @Param("description") String description,
                                   @Param("sourceType") String sourceType,
                                   @Param("sourceId") Long sourceId);

    // ===== 신고 수정 =====

    // 신고 내용 수정
    void updateReport(@Param("reportId") Long reportId,
                      @Param("reason") String reason,
                      @Param("description") String description);

    // ===== 신고 삭제 =====

    // 신고 삭제
    void deleteReport(@Param("reportId") Long reportId);

    // ===== 신고 취소 =====

    // 신고 취소 (status → CANCELLED)
    void cancelReport(@Param("reportId") Long reportId);

    // ===== 상태 변경 (어드민) =====

    // 신고 상태 변경 (status, resolverIdx, resolved_at, updated_at 업데이트)
    void updateReportStatus(@Param("reportId") Long reportId,
                            @Param("status") String status,
                            @Param("resolverIdx") Long resolverIdx,
                            @Param("resolveAction") String resolveAction);

    // 반려된 신고를 PENDING으로 복원 (resolver_idx, resolved_at 초기화)
    void revertReportToPending(@Param("reportId") Long reportId);

}
