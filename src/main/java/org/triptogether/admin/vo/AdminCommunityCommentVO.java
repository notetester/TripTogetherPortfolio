package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityCommentVO {
    private Long commentId;
    private Long postId;
    private String postTitle;       // 댓글이 달린 게시글 제목
    private Long userIdx;
    private String userId;          // 작성자 로그인 ID
    private String nickname;        // 작성자 닉네임
    private String accountStatus;   // 작성자 계정 상태 (ACTIVE / BLOCKED)
    private String lastIp;          // 작성자 최근 로그인 IP
    private String content;
    private String commentStatus;   // 댓글 상태 (ACTIVE / BLOCKED / DELETED)
    private int likeCount;
    private int reportCount;
    private Date createdAt;
    private Date updatedAt;
    private Long parentCommentId;   // 대댓글이면 부모 댓글 ID, 최상위 댓글이면 null
    private int authorResolveCount30d; // 작성자의 최근 30일 신고 처리 건수 (위험도 지표)
}
