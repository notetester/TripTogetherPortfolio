package org.triptogether.myPage.service;

import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPageReportDto;

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

    // ===== 알림 =====

    // 알림 목록 조회 (최신순 10개)
    List<FeedNotificationDto> getNotifications(Long userIdx);

    // 알림 총 개수 조회
    int getNotificationCount(Long userIdx);

    // 알림 단건 조회
    FeedNotificationDto getNotification(Long notificationId);

    // 알림 등록 (크로스모듈 호출 - community/inquiry/report → myPage)
    void addNotification(FeedNotificationDto notification);

    // 알림 단건 삭제
    void deleteNotification(Long notificationId);

    // 알림 전체 목록 조회 (무제한)
    List<FeedNotificationDto> getAllNotifications(Long userIdx);

    // 알림 전체 삭제
    void deleteAllNotifications(Long userIdx);

}
