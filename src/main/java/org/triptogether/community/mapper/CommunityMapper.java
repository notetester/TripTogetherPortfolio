package org.triptogether.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.community.vo.*;
import java.util.List;

@Mapper
public interface CommunityMapper {

    // ===== 목록 =====
    List<CommunityPostDto> selectPostList(CommunitySearchDto search);
    int selectTotalCount(CommunitySearchDto search);

    // ===== 상세 =====
    CommunityPostDto selectPost(@Param("postId") Long postId);
    List<CommunityPostImageDto> selectImageList(@Param("postId") Long postId);
    List<String> selectTagList(@Param("postId") Long postId);
    List<CommunityCommentDto> selectCommentList(@Param("postId") Long postId);
    String selectTipCategory(@Param("postId") Long postId);
    Integer selectIsSolved(@Param("postId") Long postId);
    List<CommunityPostDto> selectRelatedList(@Param("postId") Long postId);

    // ===== 조회수 =====
    void updateViewCount(@Param("postId") Long postId);

    // ===== 글쓰기 =====
    void insertPost(CommunityPostDto post);  // useGeneratedKeys → post.postId 자동 주입
    void insertPostDetail(@Param("postId") Long postId,
                          @Param("region") String region,
                          @Param("postType") String postType);
    void insertImage(@Param("postId") Long postId,
                     @Param("imageUrl") String imageUrl,
                     @Param("sortOrder") int sortOrder);
    void upsertTag(@Param("tagName") String tagName);
    Long selectTagId(@Param("tagName") String tagName);
    void insertPostTag(@Param("postId") Long postId, @Param("tagId") Long tagId);
    void insertPostTip(@Param("postId") Long postId, @Param("tipCategory") String tipCategory);
    void insertPostQuestion(@Param("postId") Long postId);

    // ===== 삭제 =====
    void updatePostStatus(@Param("postId") Long postId, @Param("status") String status);

    // ===== 좋아요 =====
    int selectLikeCount(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    int selectPostLikeCount(@Param("postId") Long postId);
    void insertLike(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    void deleteLike(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    void increaseLikeCount(@Param("postId") Long postId);
    void decreaseLikeCount(@Param("postId") Long postId);

    // ===== 댓글 =====
    void insertComment(@Param("postId") Long postId,
                       @Param("userIdx") Long userIdx,
                       @Param("content") String content);
    void updateCommentStatus(@Param("commentId") Long commentId, @Param("status") String status);
    Long selectPostIdByCommentId(@Param("commentId") Long commentId);
    void increaseCommentCount(@Param("postId") Long postId);
    void decreaseCommentCount(@Param("postId") Long postId);

    // ===== 태그 공출현 =====
    void upsertTagRelation(@Param("tagIdA") Long tagIdA, @Param("tagIdB") Long tagIdB);
    List<Long> selectTagIdList(@Param("postId") Long postId);

    // ===== 신고 =====
    void insertReport(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
}