package org.triptogether.inquiry.vo;

import lombok.Data;

@Data
public class InquirySearchDto {
    private String category;
    private String status;
    private String keyword;
    private int    page     = 1;
    private int    pageSize = 10;
    private Long   userIdx;

    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
