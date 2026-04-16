package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MyPagePlanDto {
    private Long    planId;
    private String  title;
    private String  destination;
    private Date    startDate;
    private Date    endDate;
    private Boolean isPublic;
    private String  planSource;
    private Date    createdAt;
}
