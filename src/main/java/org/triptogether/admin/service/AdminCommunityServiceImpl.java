package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminCommunityMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.community.mapper.CommunityMapper;
import org.triptogether.community.vo.CommunityCommentDto;
import org.triptogether.community.vo.CommunityPostDto;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminCommunityServiceImpl implements AdminCommunityService {

    private final AdminCommunityMapper adminCommunityMapper;
    private final CommunityMapper communityMapper;
    private final MyPageService myPageService;

    // ===== 통계 =====

    @Override
    public AdminCommunityStatsVO getStats() {
        return adminCommunityMapper.getStats();
    }

    // ===== 게시글 목록/상세 =====

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

    // ===== 게시글 차단/삭제 =====

    @Override
    public void blockPost(Long postId) {
        adminCommunityMapper.updatePostStatus(postId, "BLOCKED");
        notifyPostBlocked(postId);
    }

    @Override
    public void deletePost(Long postId) {
        adminCommunityMapper.updatePostStatus(postId, "DELETED");
        notifyPostDeleted(postId);
    }

    @Override
    public void bulkBlockPosts(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdatePostStatus(ids, "BLOCKED");
            for (Long postId : ids) {
                notifyPostBlocked(postId);
            }
        }
    }

    @Override
    public void bulkDeletePosts(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdatePostStatus(ids, "DELETED");
            for (Long postId : ids) {
                notifyPostDeleted(postId);
            }
        }
    }

    // ===== 댓글 차단/삭제 =====

    @Override
    public void blockComment(Long commentId) {
        adminCommunityMapper.updateCommentStatus(commentId, "BLOCKED");
        notifyCommentBlocked(commentId);
    }

    @Override
    public void deleteComment(Long commentId) {
        adminCommunityMapper.updateCommentStatus(commentId, "DELETED");
        notifyCommentDeleted(commentId);
    }

    @Override
    public void bulkBlockComments(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdateCommentStatus(ids, "BLOCKED");
            for (Long commentId : ids) {
                notifyCommentBlocked(commentId);
            }
        }
    }

    @Override
    public void bulkDeleteComments(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminCommunityMapper.bulkUpdateCommentStatus(ids, "DELETED");
            for (Long commentId : ids) {
                notifyCommentDeleted(commentId);
            }
        }
    }

    // ===== 알림 헬퍼 =====

    // 글 차단 시 작성자에게 알림 발송
    private void notifyPostBlocked(Long postId) {
        try {
            CommunityPostDto post = communityMapper.selectPost(postId);
            if (post == null) return;
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("작성하신 글이 운영 정책에 따라 차단되었어요.");
            notification.setTargetUrl(NotificationUrlBuilder.community(postId));
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("글 차단 알림 발송 실패: postId={}", postId, e);
        }
    }

    // 댓글 차단 시 작성자에게 알림 발송
    private void notifyCommentBlocked(Long commentId) {
        try {
            CommunityCommentDto comment = communityMapper.selectComment(commentId);
            if (comment == null) return;
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(comment.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(comment.getPostId());
            notification.setMessage("작성하신 댓글이 운영 정책에 따라 차단되었어요.");
            notification.setTargetUrl(NotificationUrlBuilder.communityComment(comment.getPostId(), comment.getCommentId()));
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("댓글 차단 알림 발송 실패: commentId={}", commentId, e);
        }
    }

    // 글 삭제 시 작성자에게 알림 발송 (targetUrl은 /mypage로 fallback)
    private void notifyPostDeleted(Long postId) {
        try {
            CommunityPostDto post = communityMapper.selectPost(postId);
            if (post == null) return;
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("작성하신 글이 운영 정책에 따라 삭제되었어요.");
            notification.setTargetUrl(NotificationUrlBuilder.mypage());
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("글 삭제 알림 발송 실패: postId={}", postId, e);
        }
    }

    // 댓글 삭제 시 작성자에게 알림 발송 (targetUrl은 /mypage로 fallback)
    private void notifyCommentDeleted(Long commentId) {
        try {
            CommunityCommentDto comment = communityMapper.selectComment(commentId);
            if (comment == null) return;
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(comment.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(comment.getPostId());
            notification.setMessage("작성하신 댓글이 운영 정책에 따라 삭제되었어요.");
            notification.setTargetUrl(NotificationUrlBuilder.mypage());
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("댓글 삭제 알림 발송 실패: commentId={}", commentId, e);
        }
    }

}
