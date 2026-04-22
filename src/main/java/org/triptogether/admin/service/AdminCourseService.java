package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminCourseSearchVO;
import org.triptogether.admin.vo.AdminCourseStatsVO;

import java.util.List;
import java.util.Map;

/**
 * 어드민 여행코스 관리 서비스.
 * 읽기 전용 조회 + is_deleted 토글(소프트 삭제/복구)만 제공.
 */
public interface AdminCourseService {

    // ===== 통계 =====
    AdminCourseStatsVO getStats();

    // ===== 목록/상세 =====
    Map<String, Object> getPlanList(AdminCourseSearchVO search);
    Map<String, Object> getPlanDetail(Long planId);

    // ===== 소프트 삭제 / 복구 =====
    void deletePlan(Long planId);
    void restorePlan(Long planId);
    void bulkDelete(List<Long> ids);
    void bulkRestore(List<Long> ids);
}
