package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryAttachmentDto {
    private Long attachmentId;
    private Long inquiryId;
    private String fileUrl;
    private String fileName;
    private Date createdAt;
}
