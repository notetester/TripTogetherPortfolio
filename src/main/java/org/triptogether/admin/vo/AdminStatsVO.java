package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 관리자 대시보드 통계 VO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminStatsVO {

    // ── 회원 통계 ──
    private long totalMembers;
    private long activeMembers;
    private long dormantMembers;
    private long deletedMembers;
    private long todayNewMembers;
    private long todayLogins;
    private long todayFailedLogins;

    // ── 소셜 연동 통계 ──
    private long kakaoLinked;
    private long naverLinked;
    private long googleLinked;

    // ── 향후 확장용 (게시판) ──
    // private long totalPosts;
    // private long todayPosts;
}
