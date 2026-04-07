package org.triptogether.community.vo;

import lombok.Data;
import java.util.Date;

/**
 * 커뮤니티 댓글 DTO
 * COMMUNITY_COMMENT + USERS JOIN 결과
 */
@Data
public class CommunityCommentDto {

    private Long    commentId;
    private Long    postId;
    private Long    userIdx;
    private String  content;
    private String  commentStatus;  // ACTIVE/DELETED
    private int     likeCount;
    private Date    createdAt;
    private Date    updatedAt;

    // USERS JOIN (닉네임)
    private String  nickname;

    // NULL이면 일반 댓글, 값 있으면 대댓글
    private Long parentCommentId;

    private String accountStatus;

    private int reportCount;
}
