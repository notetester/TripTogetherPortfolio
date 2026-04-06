package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryAnswerDto {
    private Long   answerId;
    private Long   inquiryId;
    private Long   adminUserIdx;
    private String adminNickname;
    private String content;
    private Date   createdAt;
    private Date   updatedAt;
}
