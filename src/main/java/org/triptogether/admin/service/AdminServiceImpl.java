package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminMemberVO;
import org.triptogether.admin.vo.AdminSearchVO;
import org.triptogether.admin.vo.AdminStatsVO;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.common.function.Paging;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        List<AdminMemberVO> list  = adminMapper.findMembers(search);
        int                 total = adminMapper.countMembers(search);

        Paging paging = new Paging(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list",   list);
        result.put("paging", paging);
        result.put("total",  total);
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
        List<String> allowed = List.of("ACTIVE", "DORMANT", "DELETED");
        if (!allowed.contains(status)) throw new IllegalArgumentException("유효하지 않은 상태값: " + status);
        adminMapper.updateMemberStatus(userIdx, status);
    }

    @Override
    public void changeMemberRole(Long userIdx, String role) {
        List<String> allowed = List.of("USER", "ADMIN");
        if (!allowed.contains(role)) throw new IllegalArgumentException("유효하지 않은 권한값: " + role);
        adminMapper.updateMemberRole(userIdx, role);
    }
}
