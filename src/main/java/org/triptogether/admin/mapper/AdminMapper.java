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

    // ===== 회원 관리 =====
    List<AdminMemberVO> findMembers(AdminSearchVO search);
    int countMembers(AdminSearchVO search);
    AdminMemberVO findMemberDetail(Long userIdx);
    void updateMemberStatus(@Param("userIdx") Long userIdx, @Param("status") String status);
    void updateMemberRole(@Param("userIdx") Long userIdx, @Param("role") String role);

    // ===== 회원 로그인 이력 =====
    List<UserLoginHistoryVO> findLoginHistory(@Param("userIdx") Long userIdx,
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
}
