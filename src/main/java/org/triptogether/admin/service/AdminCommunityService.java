package org.triptogether.admin.service;

import org.triptogether.admin.vo.*;

import java.util.List;
import java.util.Map;

public interface AdminCommunityService {

    AdminCommunityStatsVO getStats();

    Map<String, Object> getPostList(AdminCommunitySearchVO search);

    Map<String, Object> getPostDetail(Long postId);

    Map<String, Object> getCommentList(AdminCommunitySearchVO search);

    void blockPost(Long postId);
    void deletePost(Long postId);
    void bulkBlockPosts(List<Long> ids);
    void bulkDeletePosts(List<Long> ids);

    void blockComment(Long commentId);
    void deleteComment(Long commentId);
    void bulkBlockComments(List<Long> ids);
    void bulkDeleteComments(List<Long> ids);
}
