package org.triptogether.assistant.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatPostVO {
    private Long chat_post_idx;
    private Long user_idx;
    private String title;
    private Date created_at;
}