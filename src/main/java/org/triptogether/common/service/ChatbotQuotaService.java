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

    // 오늘자 사용량 조회 (없으면 0 반환). 비로그인은 IP 기준.
    public int getTodayUsage(Long userIdx, String ipAddress) {
        ChatbotDailyUsageVO usage = quotaMapper.selectDailyUsage(userIdx, ipAddress, LocalDate.now());
        return usage != null && usage.getMessageCount() != null ? usage.getMessageCount() : 0;
    }

    // 사용량 +1 (INSERT or UPDATE). 비로그인은 IP 기준.
    @Transactional
    public void incrementTodayUsage(Long userIdx, String ipAddress) {
        quotaMapper.upsertDailyUsageIncrement(userIdx, ipAddress, LocalDate.now());
    }

    // 사용량 -N (대화 삭제 시 환급). amount <= 0 이면 무시. 비로그인은 IP 기준.
    @Transactional
    public void decreaseTodayUsage(Long userIdx, String ipAddress, int amount) {
        if (amount <= 0) return;
        quotaMapper.decreaseDailyUsage(userIdx, ipAddress, LocalDate.now(), amount);
    }
}
