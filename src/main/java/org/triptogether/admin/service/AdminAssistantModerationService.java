package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminAssistantModerationVO;

import java.util.List;

/**
 * AI 도우미 부적절 메시지(Perspective 판정) 서비스.
 * 스케줄러가 미검사 user 메시지 스캔 → 결과 저장.
 * 관리자 페이지는 저장된 판정 결과를 조회.
 */
public interface AdminAssistantModerationService {

    /** 부적절로 판정된 메시지 목록 (페이징). */
    List<AdminAssistantModerationVO> getInappropriateMessages(int page, int pageSize);

    /** 부적절 메시지 총 개수. */
    int countInappropriateMessages();

    /** 아직 판정 안 된 user 메시지 chat_comment_idx 목록 (스케줄러용, LIMIT). */
    List<Long> getPendingUserCommentIds(int limit);

    /**
     * 단일 메시지 판정 후 결과 저장 (스케줄러 호출).
     * content 조회 → Perspective 점수 획득 → 임계값 비교 → 저장.
     */
    void scanAndSaveOne(Long chatCommentIdx);
}
