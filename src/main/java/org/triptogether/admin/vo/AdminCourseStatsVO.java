package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminCourseStatsVO {
    private int totalPlans;     // 전체 계획 (is_deleted 포함)
    private int activePlans;    // is_deleted=0
    private int deletedPlans;   // is_deleted=1
    private int todayPlans;     // 오늘 생성된 계획 수
    private int aiPlans;        // plan_source=AI
    private int manualPlans;    // plan_source=MANUAL
    private int publicPlans;    // is_public=1
    private int privatePlans;   // is_public=0
}
