package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminSystemPolicyVO;

import java.util.Map;

public interface AdminPolicyService {
    Map<String, Object> getPolicyDashboard();
    AdminSystemPolicyVO getPolicy(String policyCode);
    void updatePolicy(String policyCode,
                      String configJson,
                      String scheduleType,
                      Integer scheduleIntervalHours,
                      Integer scheduleDayOfMonth,
                      String scheduleTime,
                      boolean active,
                      Long actorUserIdx);
    void runPolicyNow(String policyCode, Long actorUserIdx);
    void processDuePolicies();
}
