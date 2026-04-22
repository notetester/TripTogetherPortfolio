package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminCourseSearchVO;
import org.triptogether.admin.vo.AdminCourseSpotVO;
import org.triptogether.admin.vo.AdminCourseStatsVO;
import org.triptogether.admin.vo.AdminCourseVO;

import java.util.List;

/**
 * 어드민 전용 여행코스(TRAVEL_PLAN/plan_spot) 조회/조작 매퍼.
 * SJ의 courses 모듈 매퍼와 별개. 읽기 + is_deleted 토글만 허용.
 */
@Mapper
public interface AdminCourseMapper {

    // ===== 통계 =====
    AdminCourseStatsVO getStats();

    // ===== 목록/상세 =====
    List<AdminCourseVO> findPlans(AdminCourseSearchVO search);
    int countPlans(AdminCourseSearchVO search);

    AdminCourseVO findPlanDetail(@Param("planId") Long planId);
    List<AdminCourseSpotVO> findSpotsByPlan(@Param("planId") Long planId);

    // ===== 소프트 삭제 / 복구 =====
    void updateIsDeleted(@Param("planId") Long planId, @Param("isDeleted") int isDeleted);
    void bulkUpdateIsDeleted(@Param("ids") List<Long> ids, @Param("isDeleted") int isDeleted);
}
