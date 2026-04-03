package org.triptogether.auth.vo;
import lombok.*;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LoginHistoryCommand {
    private Long userIdx;
    private String authType;
    private String loginMethod;
    private String loginIdentifier;
    private boolean success;
    private String failReason;
    private String ipAddress;
    private String userAgent;
}
