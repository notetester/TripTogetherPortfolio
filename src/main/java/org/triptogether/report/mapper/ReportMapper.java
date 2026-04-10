package org.triptogether.report.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;

import java.util.List;

/**
 * =============================================
 * ReportMapper - 신고 게시판 DB 쿼리 인터페이스
 * =============================================
 */
@Mapper
public interface ReportMapper {

    /* =============================================
       1. 신고 목록 조회
       - 검색 조건(status, targetType)에 맞는 신고 목록 반환
       - USERS JOIN으로 신고자 닉네임 포함
       - 페이지네이션 포함
       ============================================= */
    List<ReportDto> selectReportList(ReportSearchDto search);

    /* =============================================
       2. 전체 개수 조회
       - 페이지네이션 계산에 사용
       ============================================= */
    int selectTotalCount(ReportSearchDto search);

    /* =============================================
       3. 신고 단건 조회
       ============================================= */
    ReportDto selectReport(@Param("reportId") Long reportId);

    /* =============================================
       4. 대상별 신고 수 조회
       - 특정 게시글/댓글의 신고 횟수 반환
       ============================================= */
    int selectReportCountByTarget(@Param("targetType") String targetType,
                                  @Param("targetId") Long targetId);

    /* =============================================
       5. 신고 등록
       - INSERT IGNORE: 동일 유저의 중복 신고 방지
       ============================================= */
    int insertReport(ReportDto report);

    /* =============================================
       6. 신고 상태 변경
       - status, resolverIdx, resolved_at, updated_at 업데이트
       ============================================= */
    void updateReportStatus(@Param("reportId") Long reportId,
                            @Param("status") String status,
                            @Param("resolverIdx") Long resolverIdx);
}
