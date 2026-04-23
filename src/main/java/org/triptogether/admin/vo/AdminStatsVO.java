package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 관리자 대시보드 통계 VO.
 *
 * <p>현재 범위는 auth/admin 정리 단계이므로, 운영자가 가장 먼저 봐야 할</p>
 * <ul>
 *     <li>회원 수</li>
 *     <li>오늘 로그인 현황</li>
 *     <li>소셜 연동 현황</li>
 *     <li>커뮤니티 / 문의 / 신고 개요</li>
 * </ul>
 * 만 담는다.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminStatsVO {

    private long totalMembers;
    private long activeMembers;
    private long dormantMembers;
    private long deletedMembers;
    private long todayNewMembers;
    private long todayLogins;
    private long todayFailedLogins;
    private long todayLogouts;
    private long todayLocalLogouts;
    private long todayKakaoLogouts;
    private long todayNaverLogouts;
    private long todayGoogleLogouts;

    private long kakaoLinked;
    private long naverLinked;
    private long googleLinked;

    private long totalCommunityPosts;
    private long activeCommunityPosts;
    private long activeReports;
    private long totalInquiries;
    private long pendingInquiries;
    private long completedInquiries;
}
