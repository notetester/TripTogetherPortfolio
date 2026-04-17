package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.myPage.mapper.MyPageMapper;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPagePlanDto;
import org.triptogether.myPage.vo.MyPageReportDto;
import org.triptogether.myPage.vo.MyPageReviewDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {

    private final MyPageMapper myPageMapper;

    // ===== 커뮤니티 =====

    @Override
    public List<MyPageCommunityDto> getMyCommunityList(Long userIdx) {
        return myPageMapper.selectMyCommunityList(userIdx);
    }

    @Override
    public int getMyCommunityCount(Long userIdx) {
        return myPageMapper.selectMyCommunityCount(userIdx);
    }

    // ===== 문의 =====

    @Override
    public List<MyPageInquiryDto> getMyInquiryList(Long userIdx) {
        return myPageMapper.selectMyInquiryList(userIdx);
    }

    @Override
    public int getMyInquiryCount(Long userIdx) {
        return myPageMapper.selectMyInquiryCount(userIdx);
    }

    // ===== 신고 =====

    @Override
    public List<MyPageReportDto> getMyReportList(Long userIdx) {
        return myPageMapper.selectMyReportList(userIdx);
    }

    @Override
    public int getMyReportCount(Long userIdx) {
        return myPageMapper.selectMyReportCount(userIdx);
    }

    // ===== 리뷰 =====

    @Override
    public List<MyPageReviewDto> getMyReviewList(Long userIdx) {
        return myPageMapper.selectMyReviewList(userIdx);
    }

    @Override
    public int getMyReviewCount(Long userIdx) {
        return myPageMapper.selectMyReviewCount(userIdx);
    }

    // ===== 여행 일정 =====

    @Override
    public List<MyPagePlanDto> getMyPlanList(Long userIdx) {
        return myPageMapper.selectMyPlanList(userIdx);
    }

    @Override
    public int getMyPlanCount(Long userIdx) {
        return myPageMapper.selectMyPlanCount(userIdx);
    }

    // ===== 알림 =====

    @Override
    public List<FeedNotificationDto> getNotifications(Long userIdx) {
        return myPageMapper.selectNotifications(userIdx);
    }

    @Override
    public int getNotificationCount(Long userIdx) {
        return myPageMapper.selectNotificationCount(userIdx);
    }

    @Override
    public FeedNotificationDto getNotification(Long notificationId) {
        return myPageMapper.selectNotification(notificationId);
    }

    @Override
    public void addNotification(FeedNotificationDto notification) {
        myPageMapper.insertNotification(notification);
    }

    @Override
    public void deleteNotification(Long notificationId) {
        myPageMapper.deleteNotification(notificationId);
    }

    @Override
    public List<FeedNotificationDto> getAllNotifications(Long userIdx) {
        return myPageMapper.selectAllNotifications(userIdx);
    }

    @Override
    public void deleteAllNotifications(Long userIdx) {
        myPageMapper.deleteAllNotifications(userIdx);
    }

}
