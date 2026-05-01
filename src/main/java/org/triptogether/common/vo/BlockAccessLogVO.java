package org.triptogether.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * BLOCK_ACCESS_LOG 테이블 VO.
 *
 * <p>차단된 요청은 일반 ActivityLogInterceptor의 afterCompletion까지 도달하지 못할 수 있으므로,
 * 일반 활동 로그와 동일한 요청 문맥 + 차단 판단 정보를 별도 테이블에 기록한다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BlockAccessLogVO {
    private Long blockAccessIdx;
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

    private String blockKind;
    private String blockMatchType;
    private String blockTargetKey;
    private String blockRequestId;
    private Long blockRuleIdx;
    private String blockReason;
    private String countryCode;
    private String asn;
    private String cacheSource;
    private String sourceActionType;
    private String sourceActionGroupId;
    private Long sourceUserIdx;
    private String sourceIpAddress;
    private Boolean sourceUserMatch;
    private Boolean sourceIpMatch;
    private Boolean sourceUserIpIntersection;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
