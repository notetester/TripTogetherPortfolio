package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 관리자 AI 도우미(assistant) 메시지 VO.
 * CHAT_COMMENT + USERS/CHAT_POST JOIN.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminAssistantMessageVO {

    private Long chatCommentIdx;
    private Long chatPostIdx;
    private Long userIdx;
    private String nickname;
    private String sessionTitle;
    private String commentRole;   // USER / ASSISTANT
    private String content;
    private Integer commentOrder;
    private Date createdAt;
}
