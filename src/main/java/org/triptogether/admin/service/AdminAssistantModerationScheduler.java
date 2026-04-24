package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * AI 도우미 user 메시지 Perspective 판정 스케줄러.
 *
 * <p>SJ 담당 assistant 모듈은 무수정이므로 ask() 내부에 Perspective 체크를 삽입할 수 없다.
 * 대신 주기적으로 미판정 CHAT_COMMENT(comment_role='USER')를 스캔해 Perspective 호출 후
 * 결과를 ADMIN_ASSISTANT_MODERATION 에 저장한다.</p>
 *
 * <ul>
 *   <li>최초 기동 1분 후 시작, 이후 5분 간격 (fixedDelay)</li>
 *   <li>한 번에 최대 50건 처리 (Perspective API 쿼터 보호)</li>
 *   <li>호출 간 200ms 대기</li>
 * </ul>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AdminAssistantModerationScheduler {

    private static final int BATCH_LIMIT = 50;
    private static final long INTER_CALL_DELAY_MS = 200L;

    private final AdminAssistantModerationService moderationService;

    @Scheduled(initialDelay = 60_000L, fixedDelay = 5 * 60_000L)
    public void scanPending() {
        List<Long> pending = moderationService.getPendingUserCommentIds(BATCH_LIMIT);
        if (pending == null || pending.isEmpty()) return;

        log.info("[AssistantModeration] 스캔 시작 pending={}", pending.size());
        int processed = 0;
        for (Long commentIdx : pending) {
            try {
                moderationService.scanAndSaveOne(commentIdx);
                processed++;
            } catch (Exception e) {
                log.warn("[AssistantModeration] 판정 실패 chatCommentIdx={}, err={}", commentIdx, e.getMessage());
            }
            try {
                Thread.sleep(INTER_CALL_DELAY_MS);
            } catch (InterruptedException ie) {
                Thread.currentThread().interrupt();
                break;
            }
        }
        log.info("[AssistantModeration] 스캔 완료 처리={}", processed);
    }
}
