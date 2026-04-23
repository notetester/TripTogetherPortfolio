package org.triptogether.auth.vo;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * USER_LOGIN_HISTORY 테이블 VO
 * - 로그인 시도 / 결과 이력 기록 (보안·감사·통계 분석용)
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserLoginHistoryVO {

    private Long loginIdx;          // PK

    /** 로그인 성공 시 연결 유저 (실패 시 null) */
    private Long userIdx;
    private String eventType;

    /**
     * 인증 방식
     *  - PASSWORD : 아이디/이메일 + 비밀번호
     *  - SOCIAL   : 소셜 OAuth
     */
    private String authType;
    private String authProvider;
    private String authFlow;

    /**
     * 로그인 경로
     *  - ID / EMAIL / KAKAO / NAVER / GOOGLE
     */
    private String loginMethod;

    /** 입력값 (user_id / email / provider_user_id) */
    private String loginIdentifier;
    private String sessionId;
    private String requestUri;
    private String logoutCallbackUri;
    private String requestId;
    private String flowTraceId;

    /** 성공 여부 */
    private boolean success;

    /**
     * 실패 사유
     *  USER_NOT_FOUND / WRONG_PASSWORD / ACCOUNT_DORMANT /
     *  ACCOUNT_DELETED / SOCIAL_NOT_LINKED / UNKNOWN
     */
    private String failReason;

    private String ipAddress;       // IPv4/IPv6
    private String userAgent;       // 브라우저·디바이스 정보

    private LocalDateTime loginAt;
}
