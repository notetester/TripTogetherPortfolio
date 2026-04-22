package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.vo.BusinessAccountApplicationVO;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.myPage.mapper.MyPageMapper;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPageFlightBookingDto;
import org.triptogether.myPage.vo.MyPagePackageBookingDto;
import org.triptogether.myPage.vo.MyPagePlanDto;
import org.triptogether.myPage.vo.MyPageReportDto;
import org.triptogether.myPage.vo.MyPageReviewDto;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {

    private final MyPageMapper myPageMapper;
    private final NotificationSseService notificationSseService;

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

    // ===== 항공권 예매 =====

    @Override
    public List<MyPageFlightBookingDto> getMyFlightBookingList(Long userIdx) {
        return myPageMapper.selectMyFlightBookingList(userIdx);
    }

    @Override
    public int getMyFlightBookingCount(Long userIdx) {
        return myPageMapper.selectMyFlightBookingCount(userIdx);
    }

    @Override
    public List<MyPageFlightBookingDto> getMyFlightBookingAllList(Long userIdx) {
        return myPageMapper.selectMyFlightBookingAllList(userIdx);
    }

    // ===== 패키지 예약 =====

    @Override
    public List<MyPagePackageBookingDto> getMyPackageBookingList(Long userIdx) {
        return myPageMapper.selectMyPackageBookingList(userIdx);
    }

    @Override
    public int getMyPackageBookingCount(Long userIdx) {
        return myPageMapper.selectMyPackageBookingCount(userIdx);
    }

    @Override
    public List<MyPagePackageBookingDto> getMyPackageBookingAllList(Long userIdx) {
        return myPageMapper.selectMyPackageBookingAllList(userIdx);
    }

    // ===== 기업 회원 신청 =====

    @Override
    public BusinessAccountApplicationVO getLatestBusinessApplication(Long userIdx) {
        return myPageMapper.selectLatestBusinessApplication(userIdx);
    }

    @Override
    @Transactional
    public void submitBusinessApplication(BusinessAccountApplicationVO application, String currentUserRole) {
        if (application == null || application.getUserIdx() == null) {
            throw new IllegalArgumentException("신청자 정보를 찾을 수 없습니다.");
        }

        UserRole currentRole = UserRole.from(currentUserRole);
        if (currentRole != UserRole.USER) {
            throw new IllegalStateException("일반 회원만 기업 회원 신청을 할 수 있습니다.");
        }

        UserRole requestedRole = UserRole.parse(application.getRequestedRole())
                .filter(role -> role == UserRole.BUSINESS || role == UserRole.PARTNER)
                .orElseThrow(() -> new IllegalArgumentException("신청 유형은 비즈니스 또는 파트너만 선택할 수 있습니다."));

        if (myPageMapper.countPendingBusinessApplication(application.getUserIdx()) > 0) {
            throw new IllegalStateException("이미 검토 대기 중인 기업 회원 신청이 있습니다.");
        }

        String companyName = normalizeRequired(application.getCompanyName(), "기업명을 입력해주세요.");
        String managerName = normalizeRequired(application.getManagerName(), "담당자명을 입력해주세요.");
        String managerPhone = normalizeRequired(application.getManagerPhone(), "담당자 연락처를 입력해주세요.");

        application.setRequestedRole(requestedRole.code());
        application.setCompanyName(limit(companyName, 100));
        application.setBusinessNumber(limit(normalizeOptional(application.getBusinessNumber()), 50));
        application.setManagerName(limit(managerName, 50));
        application.setManagerPhone(limit(managerPhone, 30));
        application.setDescription(limit(normalizeOptional(application.getDescription()), 1000));
        myPageMapper.insertBusinessApplication(application);
    }

    private String normalizeRequired(String value, String message) {
        String normalized = normalizeOptional(value);
        if (normalized == null) {
            throw new IllegalArgumentException(message);
        }
        return normalized;
    }

    private String normalizeOptional(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String limit(String value, int maxLength) {
        if (value == null || value.length() <= maxLength) {
            return value;
        }
        return value.substring(0, maxLength);
    }

    // ===== 알림 =====

    @Override
    public List<FeedNotificationDto> getNotifications(Long userIdx) {
        return myPageMapper.selectNotifications(userIdx);
    }

    @Override
    public List<FeedNotificationDto> getRecentNotifications(Long userIdx, int limit) {
        return myPageMapper.selectRecentNotifications(userIdx, limit);
    }

    @Override
    public int getNotificationCount(Long userIdx) {
        return myPageMapper.selectNotificationCount(userIdx);
    }

    @Override
    public int getUnreadCount(Long userIdx) {
        return myPageMapper.selectUnreadCount(userIdx);
    }

    @Override
    public FeedNotificationDto getNotification(Long notificationId) {
        return myPageMapper.selectNotification(notificationId);
    }

    @Override
    public void addNotification(FeedNotificationDto notification) {
        myPageMapper.insertNotification(notification);
        try {
            notificationSseService.sendTo(notification.getUserIdx(), notification);
        } catch (Exception e) {
            log.warn("SSE 푸시 실패 (DB 저장은 완료): userIdx={}", notification.getUserIdx(), e);
        }
    }

    @Override
    public void markAsRead(Long notificationId) {
        myPageMapper.updateRead(notificationId);
    }

    @Override
    public void markAllAsRead(Long userIdx) {
        myPageMapper.updateReadAll(userIdx);
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
