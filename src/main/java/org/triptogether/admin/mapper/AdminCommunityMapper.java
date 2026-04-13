package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.*;

import java.util.List;

@Mapper
public interface AdminCommunityMapper {

    // 대시보드 통계
    AdminCommunityStatsVO getStats();

    // 게시글 목록
    List<AdminCommunityPostVO> findPosts(AdminCommunitySearchVO search);
    int countPosts(AdminCommunitySearchVO search);

    // 게시글 상세 (작성자 IP 포함)
    AdminCommunityPostVO findPostDetail(@Param("postId") Long postId);

    // 게시글에 달린 댓글 목록 (어드민용: 작성자 IP 포함)
    List<AdminCommunityCommentVO> findCommentsByPost(@Param("postId") Long postId);

    // 게시글에 대한 신고 목록
    List<AdminCommunityReportVO> findReportsByPost(@Param("postId") Long postId);

    // 댓글 전체 목록 (어드민용)
    List<AdminCommunityCommentVO> findComments(AdminCommunitySearchVO search);
    int countComments(AdminCommunitySearchVO search);

    // 게시글 상태 변경 (단건)
    void updatePostStatus(@Param("postId") Long postId, @Param("status") String status);

    // 게시글 상태 일괄 변경
    void bulkUpdatePostStatus(@Param("ids") List<Long> ids, @Param("status") String status);

    // 댓글 상태 변경 (단건)
    void updateCommentStatus(@Param("commentId") Long commentId, @Param("status") String status);

    // 댓글 상태 일괄 변경
    void bulkUpdateCommentStatus(@Param("ids") List<Long> ids, @Param("status") String status);
}
