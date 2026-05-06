package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MyPageReportDto {
    private Long   reportId;
    private String targetType;
    private Long   targetId;
    private String reason;
    private String status;
    private Date   createdAt;
    public Date getCreatedAtDate() {
        return createdAt;
    }

}
