package org.triptogether.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 챗봇 API 응답 VO
 * Claude 가 생성한 메시지 + 링크 버튼 + 빠른 답변 칩
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
