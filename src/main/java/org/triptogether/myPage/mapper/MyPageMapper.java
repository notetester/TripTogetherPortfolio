package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPageReportDto;

import java.util.List;

@Mapper
public interface MyPageMapper {

    // ===== 커뮤니티 =====

    List<MyPageCommunityDto> selectMyCommunityList(@Param("userIdx") Long userIdx);
    int selectMyCommunityCount(@Param("userIdx") Long userIdx);

    // ===== 문의 =====

    List<MyPageInquiryDto> selectMyInquiryList(@Param("userIdx") Long userIdx);
    int selectMyInquiryCount(@Param("userIdx") Long userIdx);

    // ===== 신고 =====

    List<MyPageReportDto> selectMyReportList(@Param("userIdx") Long userIdx);
    int selectMyReportCount(@Param("userIdx") Long userIdx);

    // ===== 알림 =====

    // 알림 목록 조회 (최신순 10개)
    List<FeedNotificationDto> selectNotifications(@Param("userIdx") Long userIdx);

    // 알림 총 개수 조회
    int selectNotificationCount(@Param("userIdx") Long userIdx);

    // 알림 단건 조회
    FeedNotificationDto selectNotification(@Param("notificationId") Long notificationId);

    // 알림 등록
    void insertNotification(FeedNotificationDto notification);

    // 알림 단건 삭제
    void deleteNotification(@Param("notificationId") Long notificationId);

    // 알림 전체 목록 조회 (무제한)
    List<FeedNotificationDto> selectAllNotifications(@Param("userIdx") Long userIdx);

    // 알림 전체 삭제
    void deleteAllNotifications(@Param("userIdx") Long userIdx);

}
