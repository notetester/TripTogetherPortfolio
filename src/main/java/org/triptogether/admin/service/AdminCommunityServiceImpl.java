package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminCommunityMapper;
import org.triptogether.admin.vo.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminCommunityServiceImpl implements AdminCommunityService {

    private final AdminCommunityMapper adminCommunityMapper;

    @Override
    public AdminCommunityStatsVO getStats() {
        return adminCommunityMapper.getStats();
    }

    @Override
    public Map<String, Object> getPostList(AdminCommunitySearchVO search) {
        List<AdminCommunityPostVO> list = adminCommunityMapper.findPosts(search);
        int total = adminCommunityMapper.countPosts(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getCommentList(AdminCommunitySearchVO search) {
        List<AdminCommunityCommentVO> list = adminCommunityMapper.findComments(search);
        int total = adminCommunityMapper.countComments(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getPostDetail(Long postId) {
        AdminCommunityPostVO post = adminCommunityMapper.findPostDetail(postId);
        List<AdminCommunityCommentVO> comments = adminCommunityMapper.findCommentsByPost(postId);
        List<AdminCommunityReportVO> reports = adminCommunityMapper.findReportsByPost(postId);

        Map<String, Object> result = new HashMap<>();
        result.put("post", post);
        result.put("comments", comments);
        result.put("reports", reports);
        return result;
    }

    @Override
    public void blockPost(Long postId) {
        adminCommunityMapper.updatePostStatus(postId, "BLOCKED");
    }

    @Override
    public void deletePost(Long postId) {
        adminCommunityMapper.updatePostStatus(postId, "DELETED");
    }

    @Override
    public void bulkBlockPosts(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdatePostStatus(ids, "BLOCKED");
        }
    }

    @Override
    public void bulkDeletePosts(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdatePostStatus(ids, "DELETED");
        }
    }

    @Override
    public void blockComment(Long commentId) {
        adminCommunityMapper.updateCommentStatus(commentId, "BLOCKED");
    }

    @Override
    public void deleteComment(Long commentId) {
        adminCommunityMapper.updateCommentStatus(commentId, "DELETED");
    }

    @Override
    public void bulkBlockComments(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdateCommentStatus(ids, "BLOCKED");
        }
    }

    @Override
    public void bulkDeleteComments(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdateCommentStatus(ids, "DELETED");
        }
    }
}
