package org.triptogether.community.vo;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

/**
 * 커뮤니티 글쓰기 요청 DTO
 * POST /community/write 파라미터 바인딩
 */
@Data
public class CommunityWriteDto {

    // COMMUNITY_POST
    private String              title;
    private String              content;

    // COMMUNITY_POST_DETAIL
    private String              region   = "all";
    private String              postType = "review";

    // COMMUNITY_POST_TIP (postType = 'tip' 일 때만)
    private String              tipCategory;

    // COMMUNITY_POST_TAG (쉼표 구분 문자열 → List로 파싱)
    private String              tags;

    // 이미지 파일 (MultipartFile 배열)
    private List<MultipartFile> images;
}
