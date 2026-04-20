package org.triptogether.community.vo;

import lombok.Data;
import java.util.Date;

/**
 * 커뮤니티 게시글 DTO
 * COMMUNITY_POST + COMMUNITY_POST_IMAGE(대표) JOIN 결과
 */
@Data
public class CommunityPostDto {

    // COMMUNITY_POST
    private Long    postId;
    private Long    userIdx;
    private String  title;
    private String  content;
    private Date    createdAt;

    // COMMUNITY_POST (통합 필드)
    private String  region;       // all/domestic/asia/europe/americas/middle-east
    private String  postType;     // review/photo/tip/question
    private String  postStatus;   // ACTIVE/DORMANT/DELETED
    private int     viewCount;
    private int     likeCount;
    private int     commentCount;
    private Date    updatedAt;

    // COMMUNITY_POST_IMAGE (sort_order = 1, 대표 이미지)
    private String  thumbUrl;

    // USERS JOIN (닉네임)
    private String  nickname;

    // 질문 유형일 때만 사용 (null이면 질문 아님)
    private Boolean isSolved;

    private String accountStatus; // 작성자 계정 상태

    private int reportCount;

    private String tipCategory;

    // 포인트 상점 장착 아이템에서 가져온 작성자 꾸미기 정보
    private String nicknameColorClass;
    private String nicknameEffectClass;
    private String profileBadgeClass;
    private String profileBadgeLabel;
    private String bubbleClass;
}
