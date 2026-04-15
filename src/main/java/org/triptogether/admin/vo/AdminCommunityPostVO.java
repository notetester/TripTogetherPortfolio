package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityPostVO {
    private Long postId;
    private Long userIdx;
    private String userId;          // 작성자 로그인 ID
    private String nickname;        // 작성자 닉네임
    private String accountStatus;   // 작성자 계정 상태 (ACTIVE / BLOCKED)
    private String lastIp;          // 작성자 최근 로그인 IP
    private String title;
    private String content;
    private String postType;        // 게시글 유형 (review / photo / tip / question)
    private String region;
    private String postStatus;      // 게시글 상태 (ACTIVE / BLOCKED / DELETED)
    private int viewCount;
    private int likeCount;
    private int commentCount;
    private int reportCount;
    private Date createdAt;
    private Date updatedAt;
    private String thumbUrl;        // 대표 이미지 URL (sort_order=1)
    private String tipCategory;     // 팁 카테고리 (postType=tip일 때만 사용)
    private int authorResolveCount30d; // 작성자의 최근 30일 신고 처리 건수 (위험도 지표)
}
