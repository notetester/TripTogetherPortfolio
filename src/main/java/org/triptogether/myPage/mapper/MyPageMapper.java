package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;

import java.util.List;

@Mapper
public interface MyPageMapper {

    List<MyPageCommunityDto> selectMyCommunityList(@Param("userIdx") Long userIdx);
    int selectMyCommunityCount(@Param("userIdx") Long userIdx);

    List<MyPageInquiryDto> selectMyInquiryList(@Param("userIdx") Long userIdx);
    int selectMyInquiryCount(@Param("userIdx") Long userIdx);

    // ===== 알림 =====
    List<FeedNotificationDto> selectNotifications(@Param("userIdx") Long userIdx);
    List<FeedNotificationDto> selectAllNotifications(@Param("userIdx") Long userIdx);
    int selectNotificationCount(@Param("userIdx") Long userIdx);
    FeedNotificationDto selectNotification(@Param("notificationId") Long notificationId);
    void insertNotification(FeedNotificationDto notification);
    void deleteNotification(@Param("notificationId") Long notificationId);
    void deleteAllNotifications(@Param("userIdx") Long userIdx);
}