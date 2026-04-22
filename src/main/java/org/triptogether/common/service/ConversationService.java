package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.common.mapper.ChatbotConversationMapper;
import org.triptogether.common.mapper.ChatbotMessageMapper;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ConversationVO;

import java.util.List;
import java.util.Objects;

/**
 * 대화 그룹 CRUD + 메시지 조회 서비스.
 * 소유자(유저 또는 anonSession) 검증 로직 포함.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationService {

    private static final int TITLE_MAX = 30;
    private static final String DEFAULT_TITLE = "새 대화";

    private final ChatbotConversationMapper conversationMapper;
    private final ChatbotMessageMapper messageMapper;

    // ===== 대화 =====

    // 신규 대화 생성. 첫 메시지가 있으면 제목에 prefix 30자 사용
    @Transactional
    public ConversationVO createConversation(Long userIdx,
                                             String anonSessionId,
                                             String ipAddress,
                                             String firstMessage) {
        ConversationVO conv = new ConversationVO();
        conv.setUserIdx(userIdx);
        conv.setAnonSessionId(userIdx != null ? null : anonSessionId);
        conv.setIpAddress(ipAddress);
        conv.setTitle(buildTitle(firstMessage));
        conversationMapper.insertConversation(conv);
        return conv;
    }

    public ConversationVO getConversation(Long conversationId) {
        return conversationMapper.selectConversation(conversationId);
    }

    // 로그인 유저의 활성 대화 목록
    public List<ConversationVO> getUserConversations(Long userIdx) {
        return conversationMapper.selectConversationsByUser(userIdx);
    }

    // 비로그인 유저의 활성 대화 목록
    public List<ConversationVO> getAnonConversations(String anonSessionId) {
        return conversationMapper.selectConversationsByAnonSession(anonSessionId);
    }

    public int countActiveConversations(Long userIdx, String anonSessionId) {
        return conversationMapper.countActiveConversations(userIdx, anonSessionId);
    }

    public void updateTitle(Long conversationId, String title) {
        conversationMapper.updateTitle(conversationId, buildTitle(title));
    }

    public void touch(Long conversationId) {
        conversationMapper.updateLastActive(conversationId);
    }

    public void softDelete(Long conversationId) {
        conversationMapper.softDelete(conversationId);
    }

    // 소유권 검증 — 요청자가 이 대화의 주인인가
    public boolean isOwner(ConversationVO conv, Long userIdx, String anonSessionId) {
        if (conv == null) return false;
        if (conv.getUserIdx() != null) {
            return Objects.equals(conv.getUserIdx(), userIdx);
        }
        return Objects.equals(conv.getAnonSessionId(), anonSessionId);
    }

    // ===== 메시지 =====

    public List<ChatMessageVO> getRecentMessages(Long conversationId, int limit) {
        return messageMapper.selectRecentMessages(conversationId, limit);
    }

    public List<ChatMessageVO> getAllMessages(Long conversationId) {
        return messageMapper.selectAllMessages(conversationId);
    }

    public void saveMessage(ChatMessageVO message) {
        messageMapper.insertMessage(message);
    }

    public void markInappropriate(Long messageId) {
        messageMapper.updateMessageInappropriate(messageId);
    }

    // ===== 관리자 =====

    public List<ConversationVO> searchConversations(String keyword, int offset, int limit) {
        return conversationMapper.selectAllConversations(keyword, offset, limit);
    }

    public int countAllConversations(String keyword) {
        return conversationMapper.countAllConversations(keyword);
    }

    public int countTodayConversations() {
        return conversationMapper.countTodayConversations();
    }

    // ===== 헬퍼 =====

    private String buildTitle(String source) {
        if (source == null || source.isBlank()) return DEFAULT_TITLE;
        String trimmed = source.strip().replaceAll("\\s+", " ");
        if (trimmed.length() <= TITLE_MAX) return trimmed;
        return trimmed.substring(0, TITLE_MAX);
    }
}
