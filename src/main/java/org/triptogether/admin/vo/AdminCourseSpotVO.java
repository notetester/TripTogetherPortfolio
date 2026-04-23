package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCourseSpotVO {
    private Long planSpotId;
    private Long planId;
    private String spotId;
    private String placeName;
    private Date visitDate;
    private int visitOrder;
    private String spotName;     // SPOT_TRAVEL.name (있으면)
    private String spotRegion;   // SPOT_TRAVEL.region
    private Date createdAt;
}
