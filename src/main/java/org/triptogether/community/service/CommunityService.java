package org.triptogether.community.service;

import org.triptogether.community.vo.*;
import java.util.List;

public interface CommunityService {

    // ===== 목록 =====
    List<CommunityPostDto> getPostList(CommunitySearchDto search);
    int getTotalCount(CommunitySearchDto search);
    int getTotalPage(CommunitySearchDto search);

    // ===== 상세 =====
    CommunityPostDto getPost(Long postId);
    List<CommunityPostImageDto> getImageList(Long postId);
    List<String> getTagList(Long postId);
    List<CommunityCommentDto> getCommentList(Long postId);
    String getTipCategory(Long postId);
    boolean isSolved(Long postId);
    List<CommunityPostDto> getRelatedList(Long postId);

    // ===== 조회수 =====
    void increaseViewCount(Long postId);

    // ===== 글쓰기 =====
    Long writePost(CommunityWriteDto writeDto, Long userIdx);

    // ===== 삭제 =====
    void deletePost(Long postId);

    // ===== 좋아요 =====
    boolean isLiked(Long postId, Long userIdx);
    boolean toggleLike(Long postId, Long userIdx);
    int getLikeCount(Long postId);

    // ===== 댓글 =====
    void addComment(Long postId, Long userIdx, String content);
    void deleteComment(Long commentId);

    // ===== 태그 공출현 =====
    void updateTagRelation(Long postId);

    // ===== 신고 =====
    void reportPost(Long postId, Long userIdx);
}
