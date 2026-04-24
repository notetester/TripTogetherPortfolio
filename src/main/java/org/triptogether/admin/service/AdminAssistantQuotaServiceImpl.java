package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminAssistantQuotaMapper;
import org.triptogether.admin.vo.AdminAssistantQuotaVO;
import org.triptogether.auth.vo.UsersVO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAssistantQuotaServiceImpl implements AdminAssistantQuotaService {

    private static final String GRADE_GUEST = "GUEST";

    private final AdminAssistantQuotaMapper quotaMapper;

    @Override
    public String resolveGrade(UsersVO user) {
        if (user == null) return GRADE_GUEST;
        String grade = user.getMemberGrade();
        if (grade == null || grade.isBlank()) return "BRONZE";
        return grade;
    }

    @Override
    public boolean isQuotaExempt(UsersVO user) {
        if (user == null) return false;
        String role = user.getUserRole();
        return "ADMIN".equals(role) || "SUPERADMIN".equals(role);
    }

    @Override
    public AdminAssistantQuotaVO getQuotaByGrade(String grade) {
        AdminAssistantQuotaVO quota = quotaMapper.selectQuotaByGrade(grade);
        if (quota == null) {
            quota = quotaMapper.selectQuotaByGrade(GRADE_GUEST);
        }
        return quota;
    }

    @Override
    public List<AdminAssistantQuotaVO> getAllQuotas() {
        return quotaMapper.selectAllQuotas();
    }

    @Override
    public void updateQuota(AdminAssistantQuotaVO quota) {
        quotaMapper.updateQuota(quota);
        log.info("[AssistantQuota] 등급 한도 수정 grade={}, updatedBy={}",
                quota.getGrade(), quota.getUpdatedBy());
    }

    @Override
    public LocalDateTime calculateCurrentPeriodStart(AdminAssistantQuotaVO quota) {
        int periodDays  = (quota != null && quota.getPeriodDays()  != null) ? quota.getPeriodDays()  : 1;
        int resetHour   = (quota != null && quota.getResetHour()   != null) ? quota.getResetHour()   : 0;
        int resetMinute = (quota != null && quota.getResetMinute() != null) ? quota.getResetMinute() : 0;
        if (periodDays < 1) periodDays = 1;
        if (resetHour < 0 || resetHour > 23) resetHour = 0;
        if (resetMinute < 0 || resetMinute > 59) resetMinute = 0;

        LocalDateTime anchor = LocalDate.of(2000, 1, 1).atTime(resetHour, resetMinute);
        LocalDateTime now = LocalDateTime.now();
        long periodHours = periodDays * 24L;
        long hoursSinceAnchor = ChronoUnit.HOURS.between(anchor, now);
        if (hoursSinceAnchor < 0) return anchor;
        long periodIndex = hoursSinceAnchor / periodHours;
        return anchor.plusHours(periodIndex * periodHours);
    }
}
