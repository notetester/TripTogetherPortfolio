package org.triptogether.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * USER_ACTIVITY_LOG 테이블 VO.
 *
 * <p>회원/비회원의 일반 활동(페이지 방문, 요청 호출 등)을 기록하는 범용 활동 로그이다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserActivityLogVO {
    private Long activityIdx;
    private String requestId;
    private String flowTraceId;
    private Long userIdx;
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
}
