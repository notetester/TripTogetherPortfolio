package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminExploreStatsVO {
    private int totalSpots;
    private int activeSpots;
    private int deletedSpots;
    private int totalReviews;
    private int activeReviews;
    private int blockedReviews;
}
