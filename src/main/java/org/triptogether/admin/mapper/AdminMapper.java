package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;

import java.util.List;

@Mapper
public interface AdminMapper {

    // 회원 관리
    List<AdminMemberVO> findMembers(AdminSearchVO search);
    int countMembers(AdminSearchVO search);
    AdminMemberVO findMemberDetail(Long userIdx);
    void updateMemberStatus(@Param("userIdx") Long userIdx, @Param("status") String status);
    void updateMemberRole(@Param("userIdx") Long userIdx, @Param("role") String role);

    // 개별 회원 로그인 이력
    List<UserLoginHistoryVO> findLoginHistory(@Param("userIdx") Long userIdx,
                                              @Param("limit") int limit);

    // 대시보드 통계
    AdminStatsVO getStats();

    // 문의 관리
    List<AdminInquiryVO> findInquiries(AdminInquirySearchVO search);
    int countInquiries(AdminInquirySearchVO search);

    // 로그인 감사
    List<AdminLoginAuditVO> findLoginAudits(AdminLoginAuditSearchVO search);
    int countLoginAudits(AdminLoginAuditSearchVO search);

    // 보안 이력 감사
    List<AdminSecurityAuditVO> findSecurityAudits(AdminSecurityAuditSearchVO search);
    int countSecurityAudits(AdminSecurityAuditSearchVO search);

    // 이메일 인증 요청 이력
    List<AdminEmailVerificationRequestVO> findEmailVerificationRequests(AdminEmailVerificationRequestSearchVO search);
    int countEmailVerificationRequests(AdminEmailVerificationRequestSearchVO search);

    // 신고 처리용 - 상태 무관 작성자 조회
    Long findPostAuthorIdx(@Param("postId") Long postId);
    Long findCommentAuthorIdx(@Param("commentId") Long commentId);
}
