package org.triptogether.admin.vo;

import lombok.Data;
import java.util.Date;

/**
 * AD_CAMPAIGN 테이블 매핑.
 * 관리자 페이지에서 편집하는 배너 광고 캠페인.
 */
@Data
public class AdCampaignVO {

    private Long    adId;
    private String  slotCode;      // community_list_top / community_detail_bottom 등
    private String  title;
    private String  imageUrl;
    private String  linkUrl;
    /** NONE / EXTERNAL / INTERNAL — 클릭 시 동작 분기 */
    private String  linkType;
    /** package / community / courses / explore / flight / shop / mypage / inquiry */
    private String  linkTargetType;
    /** 대상 리소스 ID (목록 페이지처럼 ID 불필요한 액션은 NULL) */
    private Long    linkTargetId;
    private Date    startAt;       // null = 즉시
    private Date    endAt;         // null = 무기한
    private Boolean isActive;
    private Integer sortOrder;
    private Long    viewCount;
    private Long    clickCount;
    private Date    createdAt;
    private Date    updatedAt;
    private Long    createdBy;

    /** JOIN 으로 채움 (DB 컬럼 아님) — 등록자 닉네임 표시용 */
    private String  creatorNickname;
    public Date getCreatedAtDate() {
        return createdAt;
    }

    public Date getUpdatedAtDate() {
        return updatedAt;
    }

}
