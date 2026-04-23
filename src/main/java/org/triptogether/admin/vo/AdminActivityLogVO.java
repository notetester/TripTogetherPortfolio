package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminActivityLogVO {
    private Long activityIdx;
    private String requestId;
    private String flowTraceId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String sessionId;
    private String requestUri;
    private String httpMethod;
    private String activityDomain;
    private String activityType;
    private String activityCode;
    private String activityProvider;
    private String authEventType;
    private String targetType;
    private String targetId;
    private String handlerName;
    private String queryString;
    private String referer;
    private String ipAddress;
    private String userAgent;
    private Integer responseStatus;
    private Integer responseTimeMs;
    private Boolean success;
    private String detailSummary;
    private LocalDateTime createdAt;

    public Date getCreatedAtDate() { return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()); }
}
