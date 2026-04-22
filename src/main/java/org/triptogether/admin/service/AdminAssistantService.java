package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;
import org.triptogether.admin.vo.AdminAssistantStatsVO;

import java.util.List;

/**
 * 관리자 AI 도우미(assistant) 관리 Service.
 * 대시보드/세션/메시지 조회 + 세션 삭제.
 */
public interface AdminAssistantService {

    AdminAssistantStatsVO getStats();

    List<AdminAssistantSessionVO> getSessions(String keyword, int page, int pageSize);
    int countSessions(String keyword);

    AdminAssistantSessionVO getSession(Long chatPostIdx);
    List<AdminAssistantMessageVO> getMessagesByPost(Long chatPostIdx);

    List<AdminAssistantMessageVO> getRecentMessages(int page, int pageSize);
    int countMessages();

    void deleteSession(Long chatPostIdx);
}
