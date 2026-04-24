package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminAssistantMapper;
import org.triptogether.admin.mapper.AdminAssistantModerationMapper;
import org.triptogether.admin.vo.AdminAssistantModerationVO;
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.perspective.PerspectiveService;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAssistantModerationServiceImpl implements AdminAssistantModerationService {

    private final AdminAssistantModerationMapper moderationMapper;
    private final AdminAssistantMapper assistantMapper;
    private final PerspectiveService perspectiveService;
    private final ModerationPolicyService moderationPolicyService;

    @Override
    public List<AdminAssistantModerationVO> getInappropriateMessages(int page, int pageSize) {
        int offset = Math.max(0, (page - 1) * pageSize);
        return moderationMapper.selectInappropriateMessages(offset, pageSize);
    }

    @Override
    public int countInappropriateMessages() {
        return moderationMapper.countInappropriateMessages();
    }

    @Override
    public List<Long> getPendingUserCommentIds(int limit) {
        return moderationMapper.selectPendingUserCommentIds(limit);
    }

    @Override
    @Transactional
    public void scanAndSaveOne(Long chatCommentIdx) {
        if (chatCommentIdx == null) return;
        String content = assistantMapper.selectCommentContent(chatCommentIdx);
        if (content == null || content.isBlank()) {
            // 빈 내용은 비독성으로 기록해 재스캔 방지
            moderationMapper.insertModeration(chatCommentIdx, false, null);
            return;
        }

        Double score = perspectiveService.getToxicityScore(content);
        BigDecimal scoreBd = (score != null)
                ? BigDecimal.valueOf(score).setScale(3, RoundingMode.HALF_UP)
                : null;

        boolean inappropriate = false;
        if (score != null) {
            double threshold = moderationPolicyService.getPolicy().getToxicityThreshold();
            inappropriate = score >= threshold;
        }

        moderationMapper.insertModeration(chatCommentIdx, inappropriate, scoreBd);
        if (inappropriate) {
            log.info("[AssistantModeration] 부적절 감지 chatCommentIdx={}, score={}", chatCommentIdx, scoreBd);
        }
    }
}
