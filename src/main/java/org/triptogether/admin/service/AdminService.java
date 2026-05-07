package org.triptogether.admin.service;

import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.report.vo.ReportSearchDto;

import java.util.List;
import java.util.Map;

public interface AdminService {

    // ===== 대시보드 통계 =====
    AdminStatsVO getStats();
    AdminDashboardChartVO getDashboardChart(int days);
    List<AdminSalesDailyStatVO> getSalesDailyStats(int days);

    // ===== 회원 관리 =====
    Map<String, Object> getMemberList(AdminSearchVO search);
    AdminMemberVO getMemberDetail(Long userIdx);
    void bulkChangeMemberStatus(List<Long> userIdxList, String status);
    List<AdminMemberVO> getMembersForExport(AdminSearchVO search);
    List<AdminMemberVO> getMembersByIds(List<Long> ids);
    List<UserLoginHistoryVO> getLoginHistory(Long userIdx);
    Map<String, Object> getMemberContext(Long userIdx);
    Map<String, Object> getIpContext(String ipAddress);
    List<org.triptogether.common.vo.ChatbotLinkClickVO> getChatbotLinkClicks(Long userIdx, String ip, int mode);
    void updateMemberProfile(Long userIdx, String nickname, String nationality, String preferredLang);
    void updateMemberEmail(Long userIdx, String email);
    void changeMemberStatus(Long userIdx, String status);
    void blockMember(Long userIdx, String blockType, String blockedIp, String reason, java.time.LocalDateTime expiresAt, Long actorUserIdx);
    void updateMemberMeta(AdminMemberVO member);
    void changeMemberRole(Long userIdx, String role, String reason, Long changedByUserIdx);
    boolean hasEffectivePermission(Long userIdx, String permissionCode);
    Long getPostAuthorIdx(Long postId);
    Long getCommentAuthorIdx(Long commentId);

    // ===== 기업 회원 신청 =====
    Map<String, Object> getBusinessApplicationList(BusinessApplicationSearchVO search);
    List<BusinessAccountApplicationVO> getBusinessApplications(String status);
    List<BusinessAccountApplicationVO> getBusinessApplicationsForExport(BusinessApplicationSearchVO search);
    List<BusinessAccountApplicationVO> getBusinessApplicationsByIds(List<Long> ids);
    void approveBusinessApplication(Long applicationIdx, Long reviewerUserIdx);
    void rejectBusinessApplication(Long applicationIdx, String rejectReason, Long reviewerUserIdx);
    void bulkApproveBusinessApplications(List<Long> applicationIdxList, Long reviewerUserIdx);
    void bulkRejectBusinessApplications(List<Long> applicationIdxList, String rejectReason, Long reviewerUserIdx);

    // ===== 문의 관리 =====
    Map<String, Object> getInquiryList(AdminInquirySearchVO search);
    AdminInquiryVO getInquiryDetail(Long inquiryId);
    AdminInquiryStatsVO getInquiryStats();
    void saveInquiryAnswer(Long inquiryId, Long adminUserIdx, String content);
    void deleteInquiryAnswer(Long inquiryId);
    void updateInquiryStatus(Long inquiryId, String status);
    void deleteInquiry(Long inquiryId);

    // ===== 신고 관리 =====
    Map<String, Object> getAdminReportList(ReportSearchDto search);
    AdminReportVO getAdminReport(Long reportId);

    // ===== 로그인 감사 =====
    Map<String, Object> getLoginAuditList(AdminLoginAuditSearchVO search);

    // ===== 보안 이력 감사 =====
    Map<String, Object> getSecurityAuditList(AdminSecurityAuditSearchVO search);

    // ===== 이메일 액션 요청 이력 =====
    Map<String, Object> getEmailVerificationRequestList(AdminEmailVerificationRequestSearchVO search);
    List<AdminEmailVerificationRequestVO> getEmailVerificationRequestsForExport(AdminEmailVerificationRequestSearchVO search);

    // ===== 이메일 액션 토큰 이력 =====
    Map<String, Object> getEmailVerificationList(AdminEmailVerificationSearchVO search);

    // ===== 일반 활동 로그 =====
    Map<String, Object> getActivityLogList(AdminActivityLogSearchVO search);
}
