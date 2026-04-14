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
    List<CommunityCommentDto> getCommentList(Long postId, String sort);
    CommunityCommentDto getComment(Long commentId);
    String getTipCategory(Long postId);
    boolean isSolved(Long postId);
    List<CommunityPostDto> getRelatedList(Long postId);
    List<CommunityPostDto> getLatestList(List<Long> excludeIds, int page, int pageSize);
    int getLatestTotalCount(List<Long> excludeIds);
    int getLatestTotalPage(List<Long> excludeIds, int pageSize);

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
    Long addComment(Long postId, Long userIdx, String content);
    void deleteComment(Long commentId);

    // ===== 수정 =====
    void editPost(Long postId, CommunityWriteDto writeDto, List<String> existingImages, Long userIdx);

    // ===== 태그 공출현 =====
    void updateTagRelation(Long postId);

    // ===== 대댓글 =====
    Long addReply(Long postId, Long userIdx, String content, Long parentCommentId);

    // ===== 질문 채택 =====
    void acceptComment(Long postId, Long commentId);
    Long getAcceptedCommentId(Long postId);

    // ===== 댓글 좋아요 =====
    boolean isCommentLiked(Long commentId, Long userIdx);
    boolean toggleCommentLike(Long commentId, Long userIdx);
    int getCommentLikeCount(Long commentId);

    // ===== 신고 =====
    void updatePostReportCache(Long postId);
    void updateCommentReportCache(Long commentId);
    int getPostReportCount(Long postId);
    int getCommentReportCount(Long commentId);



    List<CommunityPostDto> getPopularPostList();
    List<CommunityPostDto> getTodayPopularList();

    void blockUser(Long userIdx);

    void unblockUser(Long userIdx);

    void blockPost(Long postId);
    void unblockPost(Long postId);
    void blockComment(Long commentId);
    void unblockComment(Long commentId);

    // ===== IP 저장 =====
    void savePostIp(Long postId, String ipAddress);
    void saveCommentIp(Long commentId, String ipAddress);

    // ===== 일괄 처리 (게시글) =====
    void bulkDeletePosts(List<Long> postIds);
    void bulkBlockUsersByPosts(List<Long> postIds);
    List<String> getIpsByPostIds(List<Long> postIds);

    // ===== 일괄 처리 (댓글/대댓글) =====
    void bulkDeleteComments(List<Long> commentIds);
    void bulkBlockUsersByComments(List<Long> commentIds);
    List<String> getIpsByCommentIds(List<Long> commentIds);

}
