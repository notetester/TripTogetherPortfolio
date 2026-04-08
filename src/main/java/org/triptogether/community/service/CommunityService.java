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

    // ===== 수정 =====
    void editPost(Long postId, CommunityWriteDto writeDto, List<String> existingImages, Long userIdx);

    // ===== 태그 공출현 =====
    void updateTagRelation(Long postId);

    // ===== 대댓글 =====
    void addReply(Long postId, Long userIdx, String content, Long parentCommentId);

    // ===== 질문 채택 =====
    void acceptComment(Long postId, Long commentId);
    Long getAcceptedCommentId(Long postId);

    // ===== 댓글 좋아요 =====
    boolean isCommentLiked(Long commentId, Long userIdx);
    boolean toggleCommentLike(Long commentId, Long userIdx);
    int getCommentLikeCount(Long commentId);

    // ===== 신고 =====
    boolean reportPost(Long postId, Long userIdx);
    boolean reportComment(Long commentId, Long userIdx);
    int getPostReportCount(Long postId);
    int getCommentReportCount(Long commentId);



    List<CommunityPostDto> getPopularPostList();

    void blockUser(Long userIdx);

    void unblockUser(Long userIdx);

    void blockPost(Long postId);
    void unblockPost(Long postId);
    void blockComment(Long commentId);
    void unblockComment(Long commentId);

}
