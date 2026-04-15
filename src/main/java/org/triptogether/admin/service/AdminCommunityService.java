package org.triptogether.admin.service;

import org.triptogether.admin.vo.*;

import java.util.List;
import java.util.Map;

public interface AdminCommunityService {

    // ===== 통계 =====

    AdminCommunityStatsVO getStats();

    // ===== 게시글 목록/상세 =====

    Map<String, Object> getPostList(AdminCommunitySearchVO search);
    Map<String, Object> getPostDetail(Long postId);
    Map<String, Object> getCommentList(AdminCommunitySearchVO search);

    // ===== 게시글 차단/삭제 =====

    void blockPost(Long postId);
    void deletePost(Long postId);
    void bulkBlockPosts(List<Long> ids);
    void bulkDeletePosts(List<Long> ids);

    // ===== 댓글 차단/삭제 =====

    void blockComment(Long commentId);
    void deleteComment(Long commentId);
    void bulkBlockComments(List<Long> ids);
    void bulkDeleteComments(List<Long> ids);

}
