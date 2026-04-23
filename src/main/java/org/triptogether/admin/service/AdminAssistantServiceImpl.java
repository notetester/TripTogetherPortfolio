package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminAssistantMapper;
import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;
import org.triptogether.admin.vo.AdminAssistantStatsVO;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminAssistantServiceImpl implements AdminAssistantService {

    private final AdminAssistantMapper mapper;

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

    @Override
    @Transactional
    public void deleteSession(Long chatPostIdx) {
        mapper.deleteSession(chatPostIdx);
    }

    private String normalize(String keyword) {
        if (keyword == null) return null;
        String trimmed = keyword.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
