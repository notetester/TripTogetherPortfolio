package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MyPageInquiryDto {
    private Long   inquiryId;
    private String title;
    private String category;
    private String status;
    private int    isPrivate;
    private int    viewCount;
    private Date   createdAt;
}