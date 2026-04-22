package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.BusinessAccountApplicationVO;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPageFlightBookingDto;
import org.triptogether.myPage.vo.MyPagePlanDto;
import org.triptogether.myPage.vo.MyPageReportDto;
import org.triptogether.myPage.vo.MyPageReviewDto;

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

    // ===== 리뷰 =====

    List<MyPageReviewDto> selectMyReviewList(@Param("userIdx") Long userIdx);
    int selectMyReviewCount(@Param("userIdx") Long userIdx);

    // ===== 여행 일정 =====

    List<MyPagePlanDto> selectMyPlanList(@Param("userIdx") Long userIdx);
    int selectMyPlanCount(@Param("userIdx") Long userIdx);

    // ===== 항공권 예매 =====

    List<MyPageFlightBookingDto> selectMyFlightBookingList(@Param("userIdx") Long userIdx);
    int selectMyFlightBookingCount(@Param("userIdx") Long userIdx);

    // ===== 기업 회원 신청 =====

    BusinessAccountApplicationVO selectLatestBusinessApplication(@Param("userIdx") Long userIdx);
    int countPendingBusinessApplication(@Param("userIdx") Long userIdx);
    void insertBusinessApplication(BusinessAccountApplicationVO application);

    // ===== 알림 =====

    // 알림 목록 조회 (최신순 10개)
    List<FeedNotificationDto> selectNotifications(@Param("userIdx") Long userIdx);

    // 헤더 드롭다운용 최근 N개 조회
    List<FeedNotificationDto> selectRecentNotifications(@Param("userIdx") Long userIdx, @Param("limit") int limit);

    // 알림 총 개수 조회
    int selectNotificationCount(@Param("userIdx") Long userIdx);

    // 안읽은 알림 개수 조회 (배지용)
    int selectUnreadCount(@Param("userIdx") Long userIdx);

    // 알림 단건 조회
    FeedNotificationDto selectNotification(@Param("notificationId") Long notificationId);

    // 알림 등록
    void insertNotification(FeedNotificationDto notification);

    // 알림 단건 읽음 처리
    void updateRead(@Param("notificationId") Long notificationId);

    // 알림 전체 읽음 처리
    void updateReadAll(@Param("userIdx") Long userIdx);

    // 알림 단건 삭제
    void deleteNotification(@Param("notificationId") Long notificationId);

    // 알림 전체 목록 조회 (무제한)
    List<FeedNotificationDto> selectAllNotifications(@Param("userIdx") Long userIdx);

    // 알림 전체 삭제
    void deleteAllNotifications(@Param("userIdx") Long userIdx);

}
