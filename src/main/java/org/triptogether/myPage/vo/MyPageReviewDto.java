package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MyPageReviewDto {
    private Long   reviewIdx;
    private Long   spotIdx;
    private String spotName;
    private int    rating;
    private String content;
    private Date   createdAt;
    public Date getCreatedAtDate() {
        return createdAt;
    }

}
