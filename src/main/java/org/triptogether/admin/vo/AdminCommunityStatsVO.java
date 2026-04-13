package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminCommunityStatsVO {
    private int totalPosts;
    private int activePosts;
    private int blockedPosts;
    private int deletedPosts;
    private int totalComments;
    private int activeComments;
    private int blockedComments;
    private int pendingReports;
    private int resolvedReports30d;
}
