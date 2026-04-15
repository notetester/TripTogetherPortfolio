package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminExploreSpotVO {

    private Long spotIdx;
    private String spotId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String name;
    private String region;
    private String address;
    private Double latitude;
    private Double longitude;
    private String description;
    private Integer spotActive;
    private String thumbUrl;

    private Double ratingAvg;
    private Integer reviewCount;
    private Integer likeCount;
    private Integer tagCount;
    private Date createdAt;

    public String getDisplayStatus() {
        return spotActive != null && spotActive == 1 ? "DELETED" : "ACTIVE";
    }
}
