package org.triptogether.common.vo;

import lombok.Data;

import java.util.List;

/**
 * 챗봇 요청 VO
 * 대화 히스토리 포함 (Claude API multi-turn)
 */
@Data
public class ChatbotRequestVO {

    /** 현재 사용자 입력 */
    private String message;

    /** 대화 히스토리 (role: user/assistant, content: 텍스트) */
    private List<HistoryItem> history;

    /** 현재 페이지 경로 (문맥 파악용) */
    private String currentPath;

    /** 로그인 여부 */
    private boolean loggedIn;

    @Data
    public static class HistoryItem {
        private String role;     // "user" | "assistant"
        private String content;
    }
}
