package org.triptogether.assistant.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessageVO {
    private String role;    // "user" | "assistant"
    private String content; // 메시지 내용
}
