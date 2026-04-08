package org.triptogether.myPage.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MyPageCommunityDto {
    private Long   postId;
    private String title;
    private String postType;
    private String region;
    private int    commentCount;
    private int    likeCount;
    private int    viewCount;
    private String postStatus;
    private Date   createdAt;
}