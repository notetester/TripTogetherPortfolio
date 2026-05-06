package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminExploreReviewVO {

    private Long reviewIdx;
    private Long spotIdx;
    private String spotName;
    private Long userIdx;
    private String userId;
    private String nickname;
    private Integer rating;
    private String content;
    private Integer reviewBlock;
    private Date createdAt;

    public String getDisplayStatus() {
        return reviewBlock != null && reviewBlock == 1 ? "BLOCKED" : "ACTIVE";
    }
    public Date getCreatedAtDate() {
        return createdAt;
    }

}
