package org.triptogether.admin.service;

import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;

import java.util.List;
import java.util.Map;

public interface AdminService {

    AdminStatsVO getStats();

    Map<String, Object> getMemberList(AdminSearchVO search);
    AdminMemberVO getMemberDetail(Long userIdx);
    List<UserLoginHistoryVO> getLoginHistory(Long userIdx);
    void changeMemberStatus(Long userIdx, String status);
    void changeMemberRole(Long userIdx, String role);
    Long getPostAuthorIdx(Long postId);
    Long getCommentAuthorIdx(Long commentId);

    Map<String, Object> getInquiryList(AdminInquirySearchVO search);
    AdminInquiryVO getInquiryDetail(Long inquiryId);
    AdminInquiryStatsVO getInquiryStats();
    void saveInquiryAnswer(Long inquiryId, Long adminUserIdx, String content);
    void deleteInquiryAnswer(Long inquiryId);
    void updateInquiryStatus(Long inquiryId, String status);
    void deleteInquiry(Long inquiryId);
    Map<String, Object> getLoginAuditList(AdminLoginAuditSearchVO search);
    Map<String, Object> getSecurityAuditList(AdminSecurityAuditSearchVO search);
    Map<String, Object> getEmailVerificationRequestList(AdminEmailVerificationRequestSearchVO search);
    Map<String, Object> getEmailVerificationList(AdminEmailVerificationSearchVO search);
    Map<String, Object> getActivityLogList(AdminActivityLogSearchVO search);
}
