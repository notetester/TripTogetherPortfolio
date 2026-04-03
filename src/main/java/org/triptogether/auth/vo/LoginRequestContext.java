package org.triptogether.auth.vo;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LoginRequestContext {
    private String ipAddress;
    private String userAgent;
}