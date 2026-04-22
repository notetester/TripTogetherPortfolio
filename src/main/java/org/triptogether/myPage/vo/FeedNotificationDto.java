package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class FeedNotificationDto {

    /** 알림 고유 번호 (PK) */
    private Long notificationId;

    /** 알림 받을 유저 고유 번호 */
    private Long userIdx;

    /** 알림 출처 타입 (community / inquiry / plan / ...) */
    private String sourceType;

    /** 출처 ID (post_id / inquiry_id / ...) */
    private Long sourceId;

    /** 알림 메시지 */
    private String message;

    /** 알림 클릭 시 이동할 상대경로 (contextPath 제외) */
    private String targetUrl;

    /** 알림 생성 일시 */
    private Date createdAt;

    /** 읽음 여부 (false: 안읽음, true: 읽음) */
    private Boolean isRead;
}