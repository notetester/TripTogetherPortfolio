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
    public List<SuperAdminMemberVO> searchAdmins(SuperAdminSearchVO search) {
        return superAdminMapper.searchAdmins(search);
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

    // ── 그룹 소속 관리 ──

    @Override
    public List<SuperAdminAdminGroupVO> getAdminGroups(Long userIdx) {
        return superAdminMapper.findAdminGroups(userIdx);
    }

    @Override
    public List<SuperAdminAdminGroupVO> getGroupAuditLog(Long userIdx) {
        return superAdminMapper.findGroupAuditLog(userIdx);
    }

    @Override
    public List<SuperAdminGroupMemberVO> getGroupMembers(String groupCode) {
        return superAdminMapper.findGroupMembers(groupCode);
    }

    @Override
    @Transactional
    public void assignAdminToGroup(Long userIdx, String groupCode, Long grantedBy) {
        superAdminMapper.insertAdminGroup(userIdx, groupCode, grantedBy);
    }

    @Override
    @Transactional
    public void revokeAdminFromGroup(Long userIdx, String groupCode) {
        superAdminMapper.revokeAdminGroup(userIdx, groupCode);
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

    @Override
    @Transactional
    public void deleteGroup(String groupCode) {
        superAdminMapper.deleteGroupMembers(groupCode);
        superAdminMapper.deleteGroupItems(groupCode);
        superAdminMapper.deleteGroupPolicy(groupCode);
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

    @Override
    public List<SuperAdminPermissionVO> getAllPermissionPoliciesForManage() {
        return superAdminMapper.findAllPermissionPoliciesForManage();
    }

    @Override
    public Map<String, Object> getPermissionPolicyDetail(String permissionCode) {
        Map<String, Object> result = new HashMap<>();
        result.put("groups",  superAdminMapper.findGroupsByPermissionCode(permissionCode));
        result.put("codes",   superAdminMapper.findCodesByPermissionCode(permissionCode));
        result.put("admins",  superAdminMapper.findAdminsByDirectPermission(permissionCode));
        return result;
    }

    @Override
    @Transactional
    public void grantDirectPermission(Long userIdx, String permissionCode, Long grantedBy) {
        superAdminMapper.grantPermission(userIdx, permissionCode, grantedBy);
    }

    @Override
    @Transactional
    public void revokeDirectPermission(Long userIdx, String permissionCode) {
        superAdminMapper.revokePermission(userIdx, permissionCode);
    }

    @Override
    @Transactional
    public void createPermissionPolicy(String permissionCode, String displayName, String description, Long createdBy) {
        superAdminMapper.insertPermissionPolicy(permissionCode, displayName, description, createdBy);
    }

    @Override
    @Transactional
    public void togglePermissionPolicyActive(String permissionCode, boolean active, Long updatedBy) {
        superAdminMapper.togglePermissionPolicyActive(permissionCode, active ? 1 : 0, updatedBy);
    }

    @Override
    @Transactional
    public void deletePermissionPolicy(String permissionCode) {
        superAdminMapper.deletePermissionPolicy(permissionCode);
    }

    @Override
    @Transactional
    public void updatePermissionCode(Long userIdx, String permissionCode) {
        superAdminMapper.updatePermissionCode(userIdx, permissionCode);
    }

    @Override
    public List<SuperAdminPermissionCodePolicyVO> getAllPermissionCodePoliciesWithCount() {
        return superAdminMapper.findAllPermissionCodePoliciesWithCount();
    }

    @Override
    public Map<String, Object> getPermissionCodeDetail(String adminPermissionCode) {
        Map<String, Object> result = new HashMap<>();
        result.put("permissionItems", superAdminMapper.findCodePermissionItems(adminPermissionCode));
        result.put("groupItems",      superAdminMapper.findCodeGroupItems(adminPermissionCode));
        result.put("admins",          superAdminMapper.findAdminsByPermissionCode(adminPermissionCode));
        return result;
    }

    @Override
    @Transactional
    public void createPermissionCode(String adminPermissionCode, String displayName, String description, Long createdBy) {
        superAdminMapper.insertPermissionCode(adminPermissionCode, displayName, description, createdBy);
    }

    @Override
    @Transactional
    public void togglePermissionCodeActive(String adminPermissionCode, boolean active, Long updatedBy) {
        superAdminMapper.togglePermissionCodeActive(adminPermissionCode, active ? 1 : 0, updatedBy);
    }

    @Override
    @Transactional
    public void deletePermissionCode(String adminPermissionCode) {
        superAdminMapper.deletePermissionCode(adminPermissionCode);
    }

    @Override
    @Transactional
    public void addCodePermissionItem(String adminPermissionCode, String permissionCode, Long createdBy) {
        superAdminMapper.addCodePermissionItem(adminPermissionCode, permissionCode, createdBy);
    }

    @Override
    @Transactional
    public void removeCodePermissionItem(String adminPermissionCode, String permissionCode) {
        superAdminMapper.removeCodePermissionItem(adminPermissionCode, permissionCode);
    }

    @Override
    @Transactional
    public void addCodeGroupItem(String adminPermissionCode, String groupCode, Long createdBy) {
        superAdminMapper.addCodeGroupItem(adminPermissionCode, groupCode, createdBy);
    }

    @Override
    @Transactional
    public void removeCodeGroupItem(String adminPermissionCode, String groupCode) {
        superAdminMapper.removeCodeGroupItem(adminPermissionCode, groupCode);
    }
}
