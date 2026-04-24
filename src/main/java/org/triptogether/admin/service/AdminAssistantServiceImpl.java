package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminAssistantMapper;
import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantQuotaVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;
import org.triptogether.admin.vo.AdminAssistantStatsVO;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAssistantServiceImpl implements AdminAssistantService {

    private final AdminAssistantMapper mapper;
    private final AdminAssistantQuotaService quotaService;
    private final AdminAssistantUsageService usageService;

    @Override
    public AdminAssistantStatsVO getStats() {
        return mapper.selectStats();
    }

    @Override
    public List<AdminAssistantSessionVO> getSessions(String keyword, int page, int pageSize) {
        int offset = Math.max(0, (page - 1) * pageSize);
        return mapper.selectSessions(normalize(keyword), offset, pageSize);
    }

    @Override
    public int countSessions(String keyword) {
        return mapper.countSessions(normalize(keyword));
    }

    @Override
    public AdminAssistantSessionVO getSession(Long chatPostIdx) {
        return mapper.selectSession(chatPostIdx);
    }

    @Override
    public List<AdminAssistantMessageVO> getMessagesByPost(Long chatPostIdx) {
        return mapper.selectMessagesByPost(chatPostIdx);
    }

    @Override
    public List<AdminAssistantMessageVO> getRecentMessages(int page, int pageSize) {
        int offset = Math.max(0, (page - 1) * pageSize);
        return mapper.selectRecentMessages(offset, pageSize);
    }

    @Override
    public int countMessages() {
        return mapper.countMessages();
    }

    /**
     * 세션 삭제 + (조건부) 쿼터 환급.
     * 환급 조건:
     *   1. 세션 소유자 user_idx 조회 가능
     *   2. 소유자 등급의 quota_refund_enabled = true
     *   3. 해당 세션에 user 메시지가 1개 이상
     * 환급 대상: 소유자의 현재 주기 message_count 를 (user 메시지 수)만큼 차감.
     */
    @Override
    @Transactional
    public void deleteSession(Long chatPostIdx) {
        // 1. 세션 소유자 조회 (없으면 삭제만)
        AdminAssistantSessionVO session = mapper.selectSession(chatPostIdx);
        Long ownerUserIdx = (session != null) ? session.getUserIdx() : null;

        // 2. 환급 가능 여부 판단 + 메시지 수 확보 (삭제 전에 해야 함)
        int msgCount = 0;
        boolean shouldRefund = false;
        AdminAssistantQuotaVO quota = null;
        if (ownerUserIdx != null) {
            String grade = mapper.selectUserGrade(ownerUserIdx);
            if (grade == null || grade.isBlank()) grade = "BRONZE";
            quota = quotaService.getQuotaByGrade(grade);
            if (quota != null && Boolean.TRUE.equals(quota.getQuotaRefundEnabled())) {
                msgCount = mapper.countUserMessagesInSession(chatPostIdx);
                if (msgCount > 0) shouldRefund = true;
            }
        }

        // 3. 삭제 (CHAT_COMMENT 도 FK CASCADE 로 함께 삭제)
        mapper.deleteSession(chatPostIdx);

        // 4. 환급 실행
        if (shouldRefund) {
            LocalDateTime periodStart = quotaService.calculateCurrentPeriodStart(quota);
            usageService.decreaseMessageCount(ownerUserIdx, null, periodStart, msgCount);
            log.info("[AssistantService] 세션 삭제 환급 chatPostIdx={}, userIdx={}, amount={}",
                    chatPostIdx, ownerUserIdx, msgCount);
        }
    }

    private String normalize(String keyword) {
        if (keyword == null) return null;
        String trimmed = keyword.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
