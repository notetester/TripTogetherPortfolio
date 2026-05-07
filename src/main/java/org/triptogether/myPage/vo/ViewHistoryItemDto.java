package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ViewHistoryItemDto {
    private Long    historyIdx;
    private String  contentType;
    private Long    contentId;
    private Date    viewedAt;

    private String  title;
    private String  subtitle;
    private String  thumbnailUrl;
    private Boolean available;

    public Date getViewedAtDate() {
        return viewedAt;
    }

}
