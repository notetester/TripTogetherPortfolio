package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.myPage.mapper.MyPageMapper;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {

    private final MyPageMapper myPageMapper;

    @Override
    public List<MyPageCommunityDto> getMyCommunityList(Long userIdx) {
        return myPageMapper.selectMyCommunityList(userIdx);
    }

    @Override
    public int getMyCommunityCount(Long userIdx) {
        return myPageMapper.selectMyCommunityCount(userIdx);
    }

    @Override
    public List<MyPageInquiryDto> getMyInquiryList(Long userIdx) {
        return myPageMapper.selectMyInquiryList(userIdx);
    }

    @Override
    public int getMyInquiryCount(Long userIdx) {
        return myPageMapper.selectMyInquiryCount(userIdx);
    }

    @Override
    public List<FeedNotificationDto> getNotifications(Long userIdx) {
        return myPageMapper.selectNotifications(userIdx);
    }

    @Override
    public void addNotification(FeedNotificationDto notification) {
        myPageMapper.insertNotification(notification);
    }

    @Override
    public void readNotification(Long notificationId) {
        myPageMapper.updateNotificationRead(notificationId);
    }


}