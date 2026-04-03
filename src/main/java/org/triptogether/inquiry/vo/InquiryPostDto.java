package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryPostDto {
    private Long    inquiryId;
    private Long    userIdx;
    private String  nickname;
    private String  title;
    private String  content;
    private String  category;
    private int     isPrivate;
    private String  status;
    private int     viewCount;
    private Date    createdAt;
    private Date    updatedAt;
}
