package org.triptogether.myPage.service;

import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;

import java.util.List;

public interface MyPageService {

    List<MyPageCommunityDto> getMyCommunityList(Long userIdx);
    int getMyCommunityCount(Long userIdx);
    List<MyPageInquiryDto> getMyInquiryList(Long userIdx);
    int getMyInquiryCount(Long userIdx);

    // ===== 알림 =====
    List<FeedNotificationDto> getNotifications(Long userIdx);
    void addNotification(FeedNotificationDto notification);
    void readNotification(Long notificationId);
}