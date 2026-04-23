package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 관리자 AI 도우미(assistant) 대화 세션 목록 VO.
 * CHAT_POST + 집계(메시지 수, 마지막 활동) + USERS JOIN.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminAssistantSessionVO {

    private Long chatPostIdx;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String title;
    private Date createdAt;

    private Integer messageCount;
    private Date lastMessageAt;
}
