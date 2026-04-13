package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityCommentVO {
    private Long commentId;
    private Long postId;
    private String postTitle;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String accountStatus;
    private String lastIp;
    private String content;
    private String commentStatus;
    private int likeCount;
    private int reportCount;
    private Date createdAt;
    private Date updatedAt;
    private Long parentCommentId;
    private int authorResolveCount30d;
}
