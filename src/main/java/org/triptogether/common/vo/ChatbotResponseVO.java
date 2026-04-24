package org.triptogether.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 챗봇 API 응답 VO.
 * Gemini가 생성한 메시지 + 링크 버튼 + 빠른 답변 칩 + 부적절 플래그.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatbotResponseVO {

    /** 챗봇 텍스트 응답 */
    private String message;

    /** 내부 링크 버튼 목록 */
    private List<SiteLink> links;

    /** 빠른 답변 칩 (클릭하면 해당 질문을 입력) */
    private List<String> quickReplies;

    /** AI가 부적절 메시지로 판단한 경우 true */
    private boolean inappropriate;

    /** 대화 ID (신규 대화 생성 시 클라이언트가 저장) */
    private Long conversationId;

    /** assistant 메시지 ID (프론트에서 링크 클릭 로깅 시 참조) */
    private Long messageId;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SiteLink {
        private String label;   // 버튼 텍스트
        private String url;     // 내부 경로 (contextPath 포함)
        private String icon;    // 이모지 아이콘
    }
}
