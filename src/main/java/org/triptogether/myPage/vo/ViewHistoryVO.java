package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ViewHistoryVO {
    private Long   historyIdx;
    private Long   userIdx;
    private String contentType;
    private Long   contentId;
    private Date   viewedAt;

    public Date getViewedAtDate() {
        return viewedAt;
    }

}
