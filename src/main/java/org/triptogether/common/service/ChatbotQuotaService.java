package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.mapper.ChatbotQuotaMapper;
import org.triptogether.common.vo.ChatbotDailyUsageVO;
import org.triptogether.common.vo.ChatbotQuotaVO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * 챗봇 한도 관리 서비스.
 * 등급별 한도 조회/수정 + 일일 사용량 체크 및 집계.
 * ADMIN/SUPERADMIN은 한도 체크 면제.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotQuotaService {

    private static final String GRADE_GUEST = "GUEST";

    private final ChatbotQuotaMapper quotaMapper;

    // 로그인 유저의 등급 반환 (비로그인은 GUEST, member_grade 없으면 BRONZE 기본)
    public String resolveGrade(UsersVO user) {
        if (user == null) return GRADE_GUEST;
        String grade = user.getMemberGrade();
        if (grade == null || grade.isBlank()) return "BRONZE";
        return grade;
    }

    // ADMIN/SUPERADMIN 은 한도 체크 면제
    public boolean isQuotaExempt(UsersVO user) {
        if (user == null) return false;
        String role = user.getUserRole();
        return "ADMIN".equals(role) || "SUPERADMIN".equals(role);
    }

    public ChatbotQuotaVO getQuotaByGrade(String grade) {
        ChatbotQuotaVO quota = quotaMapper.selectQuotaByGrade(grade);
        // 폴백: DB에 등급 없으면 GUEST 한도 적용
        if (quota == null) {
            quota = quotaMapper.selectQuotaByGrade(GRADE_GUEST);
        }
        return quota;
    }

    public List<ChatbotQuotaVO> getAllQuotas() {
        return quotaMapper.selectAllQuotas();
    }

    public void updateQuota(ChatbotQuotaVO quota) {
        quotaMapper.updateQuota(quota);
        log.info("[Quota] 등급 한도 수정: grade={}, updatedBy={}",
                quota.getGrade(), quota.getUpdatedBy());
    }

    // 현재 주기의 시작 시각 계산.
    //   앵커(2000-01-01 HH:MM) 기준으로 period_days * 24h 간격으로 floor.
    //   periodDays/resetHour/resetMinute 가 null 이면 기본(1일/00:00) 적용.
    public LocalDateTime calculateCurrentPeriodStart(ChatbotQuotaVO quota) {
        int periodDays  = (quota != null && quota.getPeriodDays() != null)  ? quota.getPeriodDays()  : 1;
        int resetHour   = (quota != null && quota.getResetHour() != null)   ? quota.getResetHour()   : 0;
        int resetMinute = (quota != null && quota.getResetMinute() != null) ? quota.getResetMinute() : 0;
        if (periodDays < 1) periodDays = 1;
        if (resetHour < 0 || resetHour > 23) resetHour = 0;
        if (resetMinute < 0 || resetMinute > 59) resetMinute = 0;

        LocalDateTime anchor = LocalDate.of(2000, 1, 1).atTime(resetHour, resetMinute);
        LocalDateTime now = LocalDateTime.now();
        long periodHours = periodDays * 24L;
        long hoursSinceAnchor = ChronoUnit.HOURS.between(anchor, now);
        if (hoursSinceAnchor < 0) return anchor; // 안전장치
        long periodIndex = hoursSinceAnchor / periodHours;
        return anchor.plusHours(periodIndex * periodHours);
    }

    // 현재 주기 사용량 조회 (없으면 0 반환). 비로그인은 IP 기준.
    public int getCurrentPeriodUsage(Long userIdx, String ipAddress, ChatbotQuotaVO quota) {
        LocalDateTime periodStart = calculateCurrentPeriodStart(quota);
        ChatbotDailyUsageVO usage = quotaMapper.selectDailyUsage(userIdx, ipAddress, periodStart);
        return usage != null && usage.getMessageCount() != null ? usage.getMessageCount() : 0;
    }

    // 사용량 +1 (INSERT or UPDATE). 비로그인은 IP 기준. 현재 주기로 저장.
    @Transactional
    public void incrementUsage(Long userIdx, String ipAddress, ChatbotQuotaVO quota) {
        LocalDateTime periodStart = calculateCurrentPeriodStart(quota);
        quotaMapper.upsertDailyUsageIncrement(userIdx, ipAddress, periodStart);
    }

    // 사용량 -N (대화 삭제 시 환급). amount <= 0 이면 무시. 현재 주기 row 에서 차감.
    @Transactional
    public void decreaseUsage(Long userIdx, String ipAddress, ChatbotQuotaVO quota, int amount) {
        if (amount <= 0) return;
        LocalDateTime periodStart = calculateCurrentPeriodStart(quota);
        quotaMapper.decreaseDailyUsage(userIdx, ipAddress, periodStart, amount);
    }
}
