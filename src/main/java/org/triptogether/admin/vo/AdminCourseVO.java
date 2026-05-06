package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCourseVO {
    private Long planId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String accountStatus;
    private String title;
    private String destination;
    private Date startDate;
    private Date endDate;
    private int isPublic;
    private String planSource;   // MANUAL / AI
    private int isDeleted;
    private int spotCount;
    private Date createdAt;
    private Date updatedAt;
    public Date getCreatedAtDate() {
        return createdAt;
    }

    public Date getUpdatedAtDate() {
        return updatedAt;
    }

}
