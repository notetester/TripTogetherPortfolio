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

    /** 읽음 여부 (0: 안읽음, 1: 읽음) */
    private int isRead;

    /** 알림 생성 일시 */
    private Date createdAt;
}