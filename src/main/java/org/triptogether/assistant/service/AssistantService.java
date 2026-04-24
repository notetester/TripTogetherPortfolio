package org.triptogether.assistant.service;

import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;

import java.util.List;
import java.util.Map;

public interface AssistantService {

    /**
     * AI 여행 도우미에게 메시지를 전송하고 응답을 받는다.
     *
     * @param userMessage  사용자가 입력한 질문 텍스트
     * @param history      이전 대화 이력 (role + content 쌍의 리스트)
     * @param userIdx      로그인한 사용자의 PK
     * @param chatPostIdx  현재 대화 세션의 PK (신규 대화면 null)
     * @param lang         사용자의 현재 언어 코드 (예: "ko", "en", "ja", "zh")
     *                     → GPT 시스템 프롬프트에서 응답 언어를 지정하는 데 사용된다.
     * @return 응답 결과 Map (success, answer, history, chatPostIdx 포함)
     */
    Map<String, Object> chat(
            String userMessage,
            List<Map<String, String>> history,
            Long userIdx,
            Long chatPostIdx,
            String lang       // ← 다국어 응답을 위해 추가된 파라미터
    );

    List<ChatPostVO> getRecentChatPosts(Long userIdx);

    List<ChatCommentVO> getChatComments(Long chatPostIdx, Long userIdx);

    boolean updateChatPostTitle(Long chatPostIdx, Long userIdx, String title);

    boolean deleteChatPost(Long chatPostIdx, Long userIdx);
}
