package org.triptogether.common.vo;

import lombok.Data;

/**
 * 챗봇 요청 VO.
 * 대화 히스토리는 서버에서 DB로 조회하므로 클라이언트가 보내지 않음.
 * 신규 대화면 conversationId = null, 이어하기면 기존 대화 ID 전달.
 */
@Data
public class ChatbotRequestVO {

    /** 현재 사용자 입력 */
    private String message;

    /** 대화 ID (신규면 null) */
    private Long conversationId;

    /** 현재 페이지 경로 (문맥 파악용) */
    private String currentPath;

    /** 로그인 여부 (서버에서 세팅) */
    private boolean loggedIn;
}
