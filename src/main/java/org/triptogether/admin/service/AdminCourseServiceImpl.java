package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminCourseMapper;
import org.triptogether.admin.vo.AdminCourseSearchVO;
import org.triptogether.admin.vo.AdminCourseSpotVO;
import org.triptogether.admin.vo.AdminCourseStatsVO;
import org.triptogether.admin.vo.AdminCourseVO;
import org.triptogether.admin.vo.AdminPageVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminCourseServiceImpl implements AdminCourseService {

    private final AdminCourseMapper adminCourseMapper;

    // ===== 통계 =====

    @Override
    public AdminCourseStatsVO getStats() {
        return adminCourseMapper.getStats();
    }

    // ===== 목록/상세 =====

    @Override
    public Map<String, Object> getPlanList(AdminCourseSearchVO search) {
        List<AdminCourseVO> list = adminCourseMapper.findPlans(search);
        int total = adminCourseMapper.countPlans(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getPlanDetail(Long planId) {
        AdminCourseVO plan = adminCourseMapper.findPlanDetail(planId);
        List<AdminCourseSpotVO> spots = adminCourseMapper.findSpotsByPlan(planId);

        Map<String, Object> result = new HashMap<>();
        result.put("plan", plan);
        result.put("spots", spots);
        return result;
    }

    // ===== 소프트 삭제 / 복구 =====

    @Override
    public void deletePlan(Long planId) {
        adminCourseMapper.updateIsDeleted(planId, 1);
    }

    @Override
    public void restorePlan(Long planId) {
        adminCourseMapper.updateIsDeleted(planId, 0);
    }

    @Override
    public void bulkDelete(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCourseMapper.bulkUpdateIsDeleted(ids, 1);
        }
    }

    @Override
    public void bulkRestore(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCourseMapper.bulkUpdateIsDeleted(ids, 0);
        }
    }
}
