package org.triptogether.assistant.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatCommentVO {
    private Long chat_comment_idx;
    private Long chat_post_idx;
    private Long user_idx;
    private String comment_role;   // USER / ASSISTANT
    private String content;
    private Integer comment_order;
    private Date created_at;

    public java.util.Date getCreated_atDate() {
        return created_at;
    }

}