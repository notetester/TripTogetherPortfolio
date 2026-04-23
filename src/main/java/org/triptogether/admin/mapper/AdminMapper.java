package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.report.vo.ReportSearchDto;

import java.util.List;

@Mapper
public interface AdminMapper {

    // ===== 대시보드 통계 =====
    AdminStatsVO getStats();

    // ===== 대시보드 차트 (시계열) =====
    List<java.util.Map<String, Object>> findDailyNewMembers(@Param("days") int days);
    List<java.util.Map<String, Object>> findDailyLoginStats(@Param("days") int days);

    // ===== 회원 관리 =====
    List<AdminMemberVO> findMembers(AdminSearchVO search);
    int countMembers(AdminSearchVO search);
    AdminMemberVO findMemberDetail(Long userIdx);
    void updateMemberProfile(@Param("userIdx") Long userIdx,
                             @Param("nickname") String nickname,
                             @Param("nationality") String nationality,
                             @Param("preferredLang") String preferredLang);
    void updateMemberStatus(@Param("userIdx") Long userIdx, @Param("status") String status);
    void markMemberDormant(@Param("userIdx") Long userIdx);
    void releaseMemberDormant(@Param("userIdx") Long userIdx);
    void markMemberBlocked(@Param("userIdx") Long userIdx,
                           @Param("blockedUntil") java.time.LocalDateTime blockedUntil,
                           @Param("blockedReason") String blockedReason);
    void clearMemberBlockState(@Param("userIdx") Long userIdx);
    void updateMemberMeta(AdminMemberVO member);
    void insertUserBlockHistory(@Param("blockRequestId") String blockRequestId,
                                @Param("blockTargetKey") String blockTargetKey,
                                @Param("userIdx") Long userIdx,
                                @Param("blockType") String blockType,
                                @Param("blockedIp") String blockedIp,
                                @Param("reason") String reason,
                                @Param("blockedByUserIdx") Long blockedByUserIdx,
                                @Param("expiresAt") java.time.LocalDateTime expiresAt,
                                @Param("ipMatchType") String ipMatchType);
    Long findBlockHistoryIdxByRequestId(@Param("blockRequestId") String blockRequestId);
    void upsertUserBlocklist(@Param("sourceHistoryBlockIdx") Long sourceHistoryBlockIdx,
                             @Param("blockRequestId") String blockRequestId,
                             @Param("blockTargetKey") String blockTargetKey,
                             @Param("userIdx") Long userIdx,
                             @Param("blockType") String blockType,
                             @Param("blockedIp") String blockedIp,
                             @Param("reason") String reason,
                             @Param("blockedByUserIdx") Long blockedByUserIdx,
                             @Param("expiresAt") java.time.LocalDateTime expiresAt);
    Long findUserBlocklistIdxByTargetKey(@Param("blockTargetKey") String blockTargetKey);
    java.util.List<String> findActiveBlockedIpsByUser(@Param("userIdx") Long userIdx);
    void deactivateCurrentBlocklistByUser(@Param("userIdx") Long userIdx,
                                          @Param("releasedByUserIdx") Long releasedByUserIdx);
    void deactivateActiveBlocksByUser(@Param("userIdx") Long userIdx,
                                      @Param("releasedByUserIdx") Long releasedByUserIdx);
    String findMemberRoleForUpdate(@Param("userIdx") Long userIdx);
    void updateMemberRole(@Param("userIdx") Long userIdx, @Param("role") String role);
    void insertMemberRoleChangeHistory(@Param("userIdx") Long userIdx,
                                       @Param("previousRole") String previousRole,
                                       @Param("newRole") String newRole,
                                       @Param("reason") String reason,
                                       @Param("changedByUserIdx") Long changedByUserIdx);
    boolean hasEffectivePermission(@Param("userIdx") Long userIdx,
                                   @Param("permissionCode") String permissionCode);

    // ===== 기업 회원 신청 =====
    List<BusinessAccountApplicationVO> findBusinessApplications(@Param("status") String status);
    BusinessAccountApplicationVO findBusinessApplicationForUpdate(@Param("applicationIdx") Long applicationIdx);
    void approveBusinessApplication(@Param("applicationIdx") Long applicationIdx,
                                    @Param("reviewedByUserIdx") Long reviewedByUserIdx);
    void rejectBusinessApplication(@Param("applicationIdx") Long applicationIdx,
                                   @Param("rejectReason") String rejectReason,
                                   @Param("reviewedByUserIdx") Long reviewedByUserIdx);

    // ===== 회원 로그인 이력 =====
    List<UserLoginHistoryVO> findLoginHistory(@Param("userIdx") Long userIdx,
                                              @Param("limit") int limit);
    List<AdminLoginAuditVO> findLoginAuditsByUser(@Param("userIdx") Long userIdx,
                                                  @Param("limit") int limit);
    List<AdminSecurityAuditVO> findSecurityAuditsByUser(@Param("userIdx") Long userIdx,
                                                        @Param("limit") int limit);
    List<AdminEmailVerificationRequestVO> findEmailVerificationRequestsByUser(@Param("userIdx") Long userIdx,
                                                                              @Param("limit") int limit);
    List<AdminEmailVerificationVO> findEmailVerificationsByUser(@Param("userIdx") Long userIdx,
                                                                @Param("limit") int limit);
    List<AdminActivityLogVO> findActivityLogsByUser(@Param("userIdx") Long userIdx,
                                                    @Param("limit") int limit);
    List<AdminUserBlockVO> findRecentUserBlocksByUser(@Param("userIdx") Long userIdx,
                                                      @Param("limit") int limit);
    List<AdminLoginAuditVO> findLoginAuditsByIp(@Param("ipAddress") String ipAddress,
                                                @Param("limit") int limit);
    List<AdminSecurityAuditVO> findSecurityAuditsByIp(@Param("ipAddress") String ipAddress,
                                                      @Param("limit") int limit);
    List<AdminEmailVerificationRequestVO> findEmailVerificationRequestsByIp(@Param("ipAddress") String ipAddress,
                                                                            @Param("limit") int limit);
    List<AdminEmailVerificationVO> findEmailVerificationsByIp(@Param("ipAddress") String ipAddress,
                                                              @Param("limit") int limit);
    List<AdminActivityLogVO> findActivityLogsByIp(@Param("ipAddress") String ipAddress,
                                                  @Param("limit") int limit);
    List<AdminBlockHistoryVO> findBlockHistoriesByIp(@Param("ipAddress") String ipAddress,
                                                     @Param("limit") int limit);
    List<AdminIpBlockVO> findExactIpRules(@Param("ipAddress") String ipAddress,
                                          @Param("limit") int limit);

    // ===== 문의 관리 =====
    List<AdminInquiryVO> findInquiries(AdminInquirySearchVO search);
    int countInquiries(AdminInquirySearchVO search);
    AdminInquiryVO findInquiryDetail(Long inquiryId);
    AdminInquiryStatsVO getInquiryStats();
    void insertInquiryAnswer(@Param("inquiryId") Long inquiryId,
                             @Param("adminUserIdx") Long adminUserIdx,
                             @Param("content") String content);
    void updateInquiryAnswer(@Param("answerId") Long answerId, @Param("content") String content);
    void deleteInquiryAnswer(Long inquiryId);
    void updateInquiryStatus(@Param("inquiryId") Long inquiryId, @Param("status") String status);
    void deleteInquiry(Long inquiryId);

    // ===== 신고 관리 =====
    List<AdminReportVO> findReports(ReportSearchDto search);
    int countReports(ReportSearchDto search);
    AdminReportVO findReport(Long reportId);

    // ===== 신고 처리 보조 - 작성자 조회 =====
    Long findPostAuthorIdx(@Param("postId") Long postId);
    Long findCommentAuthorIdx(@Param("commentId") Long commentId);

    // ===== 로그인 감사 =====
    List<AdminLoginAuditVO> findLoginAudits(AdminLoginAuditSearchVO search);
    int countLoginAudits(AdminLoginAuditSearchVO search);

    // ===== 보안 이력 감사 =====
    List<AdminSecurityAuditVO> findSecurityAudits(AdminSecurityAuditSearchVO search);
    int countSecurityAudits(AdminSecurityAuditSearchVO search);

    // ===== 이메일 액션 요청 이력 =====
    List<AdminEmailVerificationRequestVO> findEmailVerificationRequests(AdminEmailVerificationRequestSearchVO search);
    int countEmailVerificationRequests(AdminEmailVerificationRequestSearchVO search);

    // ===== 이메일 액션 토큰 이력 =====
    List<AdminEmailVerificationVO> findEmailVerifications(AdminEmailVerificationSearchVO search);
    int countEmailVerifications(AdminEmailVerificationSearchVO search);

    // ===== 일반 활동 로그 =====
    List<AdminActivityLogVO> findActivityLogs(AdminActivityLogSearchVO search);
    int countActivityLogs(AdminActivityLogSearchVO search);

    // ===== 운영 정책 =====
    List<AdminSystemPolicyVO> findSystemPolicies();
    AdminSystemPolicyVO findSystemPolicy(@Param("policyCode") String policyCode);
    List<AdminSystemPolicyHistoryVO> findSystemPolicyHistories(@Param("policyCode") String policyCode,
                                                               @Param("limit") int limit);
    List<AdminSystemPolicyVO> findDueSystemPolicies();
    int insertSystemPolicy(AdminSystemPolicyVO policy);
    int updateSystemPolicy(AdminSystemPolicyVO policy);
    int updateSystemPolicyExecution(@Param("policyCode") String policyCode,
                                    @Param("lastExecutedAt") java.time.LocalDateTime lastExecutedAt,
                                    @Param("nextExecuteAt") java.time.LocalDateTime nextExecuteAt,
                                    @Param("status") String status,
                                    @Param("message") String message);
    void insertSystemPolicyHistory(AdminSystemPolicyHistoryVO history);
}
