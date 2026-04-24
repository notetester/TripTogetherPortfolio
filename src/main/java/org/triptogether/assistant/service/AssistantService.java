package org.triptogether.assistant.service;

import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;

import java.util.List;
import java.util.Map;

public interface AssistantService {
    Map<String, Object> chat(
            String userMessage,
            List<Map<String, String>> history,
            Long userIdx,
            Long chatPostIdx
    );

    List<ChatPostVO> getRecentChatPosts(Long userIdx);

    List<ChatCommentVO> getChatComments(Long chatPostIdx, Long userIdx);

    boolean updateChatPostTitle(Long chatPostIdx, Long userIdx, String title);

    boolean deleteChatPost(Long chatPostIdx, Long userIdx);
}

