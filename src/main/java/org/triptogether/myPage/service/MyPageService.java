package org.triptogether.myPage.service;

import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.admin.vo.BusinessAccountApplicationVO;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPageFlightBookingDto;
import org.triptogether.myPage.vo.MyPagePlanDto;
import org.triptogether.myPage.vo.MyPageReportDto;
import org.triptogether.myPage.vo.MyPageReviewDto;

import java.util.List;

public interface MyPageService {

    // ===== 커뮤니티 =====

    List<MyPageCommunityDto> getMyCommunityList(Long userIdx);
    int getMyCommunityCount(Long userIdx);

    // ===== 문의 =====

    List<MyPageInquiryDto> getMyInquiryList(Long userIdx);
    int getMyInquiryCount(Long userIdx);

    // ===== 신고 =====

    List<MyPageReportDto> getMyReportList(Long userIdx);
    int getMyReportCount(Long userIdx);

    // ===== 리뷰 =====

    List<MyPageReviewDto> getMyReviewList(Long userIdx);
    int getMyReviewCount(Long userIdx);

    // ===== 여행 일정 =====

    List<MyPagePlanDto> getMyPlanList(Long userIdx);
    int getMyPlanCount(Long userIdx);

    // ===== 항공권 예매 =====

    List<MyPageFlightBookingDto> getMyFlightBookingList(Long userIdx);
    int getMyFlightBookingCount(Long userIdx);

    // ===== 기업 회원 신청 =====

    BusinessAccountApplicationVO getLatestBusinessApplication(Long userIdx);
    void submitBusinessApplication(BusinessAccountApplicationVO application, String currentUserRole);

    // ===== 알림 =====

    // 알림 목록 조회 (최신순 10개)
    List<FeedNotificationDto> getNotifications(Long userIdx);

    // 헤더 드롭다운용 최근 N개 조회
    List<FeedNotificationDto> getRecentNotifications(Long userIdx, int limit);

    // 알림 총 개수 조회
    int getNotificationCount(Long userIdx);

    // 안읽은 알림 개수 조회 (배지용)
    int getUnreadCount(Long userIdx);

    // 알림 단건 조회
    FeedNotificationDto getNotification(Long notificationId);

    // 알림 등록 (크로스모듈 호출 - community/inquiry/report → myPage)
    void addNotification(FeedNotificationDto notification);

    // 알림 단건 읽음 처리
    void markAsRead(Long notificationId);

    // 알림 전체 읽음 처리
    void markAllAsRead(Long userIdx);

    // 알림 단건 삭제
    void deleteNotification(Long notificationId);

    // 알림 전체 목록 조회 (무제한)
    List<FeedNotificationDto> getAllNotifications(Long userIdx);

    // 알림 전체 삭제
    void deleteAllNotifications(Long userIdx);

}
