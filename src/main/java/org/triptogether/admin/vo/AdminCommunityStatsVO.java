package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminCommunityStatsVO {
    private int totalPosts;         // 전체 게시글 수
    private int activePosts;        // 활성 게시글 수
    private int blockedPosts;       // 차단된 게시글 수
    private int deletedPosts;       // 삭제된 게시글 수
    private int totalComments;      // 전체 댓글 수
    private int activeComments;     // 활성 댓글 수
    private int blockedComments;    // 차단된 댓글 수
    private int pendingReports;     // 미처리 신고 수 (게시글/댓글 대상)
    private int resolvedReports30d; // 최근 30일 처리완료 신고 수
}
