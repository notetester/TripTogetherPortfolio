package org.triptogether.assistant.service;

import org.triptogether.assistant.vo.ChatMessageVO;

import java.util.List;
import java.util.Map;

public interface AssistantService {
    /**
     * Claude API를 통한 AI 여행 어시스턴트 응답
     * @param userMessage 사용자 입력 메시지
     * @param history 이전 대화 기록 (다중턴)
     * @return answer(응답), history(업데이트된 기록) 포함 Map
     */
    Map<String, Object> chat(String userMessage, List<Map<String, String>> history);
}
