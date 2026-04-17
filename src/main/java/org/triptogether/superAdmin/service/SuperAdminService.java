package org.triptogether.superAdmin.service;

import org.triptogether.superAdmin.vo.*;

import java.util.List;
import java.util.Map;

public interface SuperAdminService {

    Map<String, Object> getAdminList(SuperAdminSearchVO search);
    SuperAdminMemberVO getAdminDetail(Long userIdx);
    List<SuperAdminMemberVO> searchUsers(SuperAdminSearchVO search);

    void grantAdmin(Long userIdx);
    void revokeAdmin(Long userIdx);

    List<SuperAdminPermissionVO> getAllPermissionPolicies();
    void updatePermissions(Long userIdx, List<String> permissionCodes, Long grantedBy);

    List<SuperAdminPositionPolicyVO> getAllPositionPolicies();
    List<SuperAdminPermissionCodePolicyVO> getAllPermissionCodePolicies();
    List<SuperAdminMemberVO> getAllAdmins();
    void updateAdminInfo(SuperAdminEditVO editVO);
    void updateSalary(SuperAdminSalaryEditVO salaryVO);

    List<SuperAdminMemberVO> getAdminsForOrgChart();
    List<SuperAdminMemberVO> getAllForSalaryTable(SuperAdminSearchVO search);
    int getSalaryTableCount(SuperAdminSearchVO search);

    Map<String, Object> getStatsData();

    // ── 예외 현황 보고 ──
    List<SuperAdminMemberVO> getDormantAdmins();
    List<SuperAdminMemberVO> getAdminsWithoutPermissions();
    List<SuperAdminMemberVO> getAdminsWithoutManager();

    // ── 권한 변경 이력 ──
    List<SuperAdminAuditLogVO> getPermissionAuditLog(Long userIdx);

    // ── 권한 그룹 관리 ──
    List<SuperAdminGroupPolicyVO> getAllGroupPolicies();
    List<SuperAdminGroupItemVO> getGroupItems(String groupCode);
    void createGroup(String groupCode, String displayName, String description, Long createdBy);
    void toggleGroupActive(String groupCode, boolean active, Long updatedBy);
    void addGroupItem(String groupCode, String permissionCode, Long createdBy);
    void removeGroupItem(String groupCode, String permissionCode);

    // ── 권한 요청 워크플로우 ──
    List<SuperAdminPermissionRequestVO> getPendingRequests();
    int getPendingRequestCount();
    void requestPermissions(Long userIdx, List<String> permissionCodes, Long requestedBy, String description);
    void approvePermissionRequest(Long adminPermissionIdx, Long approvedBy);
    void rejectPermissionRequest(Long adminPermissionIdx, Long approvedBy);

    // ── 일괄 처리 ──
    void bulkRevokeAdmin(List<Long> userIdxList);
    void bulkUpdatePermissions(List<Long> userIdxList, List<String> permissionCodes, Long grantedBy);
}
