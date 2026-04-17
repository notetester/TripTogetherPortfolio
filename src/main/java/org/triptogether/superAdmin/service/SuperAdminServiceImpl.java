package org.triptogether.superAdmin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.superAdmin.mapper.SuperAdminMapper;
import org.triptogether.superAdmin.vo.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SuperAdminServiceImpl implements SuperAdminService {

    private final SuperAdminMapper superAdminMapper;

    @Override
    public Map<String, Object> getAdminList(SuperAdminSearchVO search) {
        List<SuperAdminMemberVO> list = superAdminMapper.findAdmins(search);
        int total     = superAdminMapper.countAdmins(search);
        int totalPage = (int) Math.ceil((double) total / search.getPageSize());

        Map<String, Object> result = new HashMap<>();
        result.put("adminList",  list);
        result.put("total",      total);
        result.put("totalPage",  totalPage);
        result.put("search",     search);
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
    @Transactional
    public void updateSalary(SuperAdminSalaryEditVO salaryVO) {
        superAdminMapper.updateSalary(salaryVO);
    }

    @Override
    public List<SuperAdminMemberVO> getAdminsForOrgChart() {
        return superAdminMapper.findAdminsForOrgChart();
    }

    @Override
    public List<SuperAdminMemberVO> getAllForSalaryTable(SuperAdminSearchVO search) {
        return superAdminMapper.findAllForSalaryTable(search);
    }

    @Override
    public int getSalaryTableCount(SuperAdminSearchVO search) {
        return superAdminMapper.countForSalaryTable(search);
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
        superAdminMapper.revokeAllPermissions(userIdx);
        if (permissionCodes != null) {
            for (String code : permissionCodes) {
                superAdminMapper.grantPermission(userIdx, code, grantedBy);
            }
        }
    }

    // ── 예외 현황 보고 ──

    @Override
    public List<SuperAdminMemberVO> getDormantAdmins() {
        return superAdminMapper.findDormantAdmins();
    }

    @Override
    public List<SuperAdminMemberVO> getAdminsWithoutPermissions() {
        return superAdminMapper.findAdminsWithoutPermissions();
    }

    @Override
    public List<SuperAdminMemberVO> getAdminsWithoutManager() {
        return superAdminMapper.findAdminsWithoutManager();
    }

    // ── 권한 변경 이력 ──

    @Override
    public List<SuperAdminAuditLogVO> getPermissionAuditLog(Long userIdx) {
        return superAdminMapper.findPermissionAuditLog(userIdx);
    }

    // ── 권한 그룹 관리 ──

    @Override
    public List<SuperAdminGroupPolicyVO> getAllGroupPolicies() {
        return superAdminMapper.findAllGroupPolicies();
    }

    @Override
    public List<SuperAdminGroupItemVO> getGroupItems(String groupCode) {
        return superAdminMapper.findGroupItems(groupCode);
    }

    @Override
    @Transactional
    public void createGroup(String groupCode, String displayName, String description, Long createdBy) {
        superAdminMapper.insertGroup(groupCode, displayName, description, createdBy);
    }

    @Override
    @Transactional
    public void toggleGroupActive(String groupCode, boolean active, Long updatedBy) {
        superAdminMapper.toggleGroupActive(groupCode, active ? 1 : 0, updatedBy);
    }

    @Override
    @Transactional
    public void addGroupItem(String groupCode, String permissionCode, Long createdBy) {
        superAdminMapper.addGroupItem(groupCode, permissionCode, createdBy);
    }

    @Override
    @Transactional
    public void removeGroupItem(String groupCode, String permissionCode) {
        superAdminMapper.removeGroupItem(groupCode, permissionCode);
    }

    // ── 권한 요청 워크플로우 ──

    @Override
    public List<SuperAdminPermissionRequestVO> getPendingRequests() {
        return superAdminMapper.findPendingRequests();
    }

    @Override
    public int getPendingRequestCount() {
        return superAdminMapper.countPendingRequests();
    }

    @Override
    @Transactional
    public void requestPermissions(Long userIdx, List<String> permissionCodes, Long requestedBy, String description) {
        if (permissionCodes == null) return;
        for (String code : permissionCodes) {
            if (superAdminMapper.countActivePermission(userIdx, code) == 0) {
                superAdminMapper.createPermissionRequest(userIdx, code, requestedBy, description);
            }
        }
    }

    @Override
    @Transactional
    public void approvePermissionRequest(Long adminPermissionIdx, Long approvedBy) {
        superAdminMapper.approvePermissionRequest(adminPermissionIdx, approvedBy);
    }

    @Override
    @Transactional
    public void rejectPermissionRequest(Long adminPermissionIdx, Long approvedBy) {
        superAdminMapper.rejectPermissionRequest(adminPermissionIdx, approvedBy);
    }

    // ── 일괄 처리 ──

    @Override
    @Transactional
    public void bulkRevokeAdmin(List<Long> userIdxList) {
        if (userIdxList == null || userIdxList.isEmpty()) return;
        superAdminMapper.bulkRevokeAllPermissions(userIdxList);
        superAdminMapper.bulkRevokeAdmin(userIdxList);
    }

    @Override
    @Transactional
    public void bulkUpdatePermissions(List<Long> userIdxList, List<String> permissionCodes, Long grantedBy) {
        if (userIdxList == null || userIdxList.isEmpty()) return;
        superAdminMapper.bulkRevokeAllPermissions(userIdxList);
        if (permissionCodes != null) {
            for (Long userIdx : userIdxList) {
                for (String code : permissionCodes) {
                    superAdminMapper.grantPermission(userIdx, code, grantedBy);
                }
            }
        }
    }
}
