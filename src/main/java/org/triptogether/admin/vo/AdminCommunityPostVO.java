package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityPostVO {
    private Long postId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String accountStatus;
    private String lastIp;
    private String title;
    private String content;
    private String postType;
    private String region;
    private String postStatus;
    private int viewCount;
    private int likeCount;
    private int commentCount;
    private int reportCount;
    private Date createdAt;
    private Date updatedAt;
    private String thumbUrl;
    private String tipCategory;
    private int authorResolveCount30d;
}
