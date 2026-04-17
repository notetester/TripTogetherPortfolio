package org.triptogether.superAdmin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.superAdmin.mapper.SuperAdminMapper;
import org.triptogether.superAdmin.vo.SuperAdminEditVO;
import org.triptogether.superAdmin.vo.SuperAdminMemberVO;
import org.triptogether.superAdmin.vo.SuperAdminPermissionCodePolicyVO;
import org.triptogether.superAdmin.vo.SuperAdminPermissionVO;
import org.triptogether.superAdmin.vo.SuperAdminPositionPolicyVO;
import org.triptogether.superAdmin.vo.SuperAdminSearchVO;
import org.triptogether.superAdmin.vo.SuperAdminStatsVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SuperAdminServiceImpl implements SuperAdminService {

    private final SuperAdminMapper superAdminMapper;

    @Override
    public Map<String, Object> getAdminList(SuperAdminSearchVO search) {
        List<SuperAdminMemberVO> list  = superAdminMapper.findAdmins(search);
        int total = superAdminMapper.countAdmins(search);
        int totalPage = (int) Math.ceil((double) total / search.getPageSize());

        Map<String, Object> result = new HashMap<>();
        result.put("adminList", list);
        result.put("total", total);
        result.put("totalPage", totalPage);
        result.put("search", search);
        return result;
    }

    @Override
    public SuperAdminMemberVO getAdminDetail(Long userIdx) {
        SuperAdminMemberVO member = superAdminMapper.findAdminDetail(userIdx);
        if (member != null) {
            member.setPermissions(superAdminMapper.findPermissionsByUser(userIdx));
        }
        return member;
    }

    @Override
    public List<SuperAdminMemberVO> searchUsers(SuperAdminSearchVO search) {
        return superAdminMapper.searchUsers(search);
    }

    @Override
    @Transactional
    public void grantAdmin(Long userIdx) {
        superAdminMapper.grantAdmin(userIdx);
    }

    @Override
    @Transactional
    public void revokeAdmin(Long userIdx) {
        superAdminMapper.revokeAllPermissions(userIdx);
        superAdminMapper.revokeAdmin(userIdx);
    }

    @Override
    public List<SuperAdminPermissionVO> getAllPermissionPolicies() {
        return superAdminMapper.findAllPermissionPolicies();
    }

    @Override
    public List<SuperAdminPositionPolicyVO> getAllPositionPolicies() {
        return superAdminMapper.findAllPositionPolicies();
    }

    @Override
    public List<SuperAdminPermissionCodePolicyVO> getAllPermissionCodePolicies() {
        return superAdminMapper.findAllPermissionCodePolicies();
    }

    @Override
    public List<SuperAdminMemberVO> getAllAdmins() {
        return superAdminMapper.findAllAdmins();
    }

    @Override
    @Transactional
    public void updateAdminInfo(SuperAdminEditVO editVO) {
        superAdminMapper.updateAdminInfo(editVO);
    }

    @Override
    public List<SuperAdminMemberVO> getAdminsForOrgChart() {
        return superAdminMapper.findAdminsForOrgChart();
    }

    @Override
    public List<SuperAdminMemberVO> getAllForSalaryTable() {
        return superAdminMapper.findAllForSalaryTable();
    }

    @Override
    public Map<String, Object> getStatsData() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalAdmins",      superAdminMapper.countAllAdmins());
        stats.put("byPosition",       superAdminMapper.getStatsByPosition());
        stats.put("byPermissionCode", superAdminMapper.getStatsByPermissionCode());
        stats.put("byTier",           superAdminMapper.getStatsByTier());
        stats.put("byDepartment",     superAdminMapper.getStatsByDepartment());
        return stats;
    }

    @Override
    @Transactional
    public void updatePermissions(Long userIdx, List<String> permissionCodes, Long grantedBy) {
        // 기존 권한 전체 비활성화 후 선택된 권한만 다시 활성화
        superAdminMapper.revokeAllPermissions(userIdx);
        if (permissionCodes != null) {
            for (String code : permissionCodes) {
                int exists = superAdminMapper.countPermission(userIdx, code);
                if (exists > 0) {
                    superAdminMapper.grantPermission(userIdx, code, grantedBy);
                } else {
                    superAdminMapper.grantPermission(userIdx, code, grantedBy);
                }
            }
        }
    }
}
