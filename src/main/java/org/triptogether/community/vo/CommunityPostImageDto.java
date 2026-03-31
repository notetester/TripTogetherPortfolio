package org.triptogether.community.vo;

import lombok.Data;

/**
 * 커뮤니티 게시글 이미지 DTO
 * COMMUNITY_POST_IMAGE 매핑
 */
@Data
public class CommunityPostImageDto {

    private Long    imageId;
    private Long    postId;
    private String  imageUrl;
    private int     sortOrder;  // 1번이 대표 이미지
}
