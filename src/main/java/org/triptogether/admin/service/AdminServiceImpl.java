package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 서비스 구현체.
 *
 * <p>컨트롤러는 화면 흐름만 담당하고,</p>
 * <p>조회 조건 보정 / 허용값 검증 / 페이징 계산은 이 서비스에서 맡는다.</p>
 */
@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper adminMapper;

    @Override
    public AdminStatsVO getStats() {
        return adminMapper.getStats();
    }

    @Override
    public Map<String, Object> getMemberList(AdminSearchVO search) {
        List<AdminMemberVO> list = adminMapper.findMembers(search);
        int total = adminMapper.countMembers(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public AdminMemberVO getMemberDetail(Long userIdx) {
        return adminMapper.findMemberDetail(userIdx);
    }

    @Override
    public List<UserLoginHistoryVO> getLoginHistory(Long userIdx) {
        return adminMapper.findLoginHistory(userIdx, 50);
    }

    @Override
    public void changeMemberStatus(Long userIdx, String status) {
        List<String> allowed = List.of("ACTIVE", "DORMANT", "DELETED", "BLOCKED");
        if (!allowed.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값: " + status);
        }
        adminMapper.updateMemberStatus(userIdx, status);
    }

    @Override
    public void changeMemberRole(Long userIdx, String role) {
        List<String> allowed = List.of("USER", "ADMIN");
        if (!allowed.contains(role)) {
            throw new IllegalArgumentException("유효하지 않은 권한값: " + role);
        }
        adminMapper.updateMemberRole(userIdx, role);
    }

    @Override
    public Long getPostAuthorIdx(Long postId) {
        return adminMapper.findPostAuthorIdx(postId);
    }

    @Override
    public Long getCommentAuthorIdx(Long commentId) {
        return adminMapper.findCommentAuthorIdx(commentId);
    }

    @Override
    public Map<String, Object> getInquiryList(AdminInquirySearchVO search) {
        List<AdminInquiryVO> list = adminMapper.findInquiries(search);
        int total = adminMapper.countInquiries(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getLoginAuditList(AdminLoginAuditSearchVO search) {
        List<AdminLoginAuditVO> list = adminMapper.findLoginAudits(search);
        int total = adminMapper.countLoginAudits(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getSecurityAuditList(AdminSecurityAuditSearchVO search) {
        List<AdminSecurityAuditVO> list = adminMapper.findSecurityAudits(search);
        int total = adminMapper.countSecurityAudits(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getEmailVerificationRequestList(AdminEmailVerificationRequestSearchVO search) {
        List<AdminEmailVerificationRequestVO> list = adminMapper.findEmailVerificationRequests(search);
        int total = adminMapper.countEmailVerificationRequests(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }
}
