package org.triptogether.superAdmin.service;

import org.triptogether.superAdmin.vo.SuperAdminEditVO;
import org.triptogether.superAdmin.vo.SuperAdminMemberVO;
import org.triptogether.superAdmin.vo.SuperAdminPermissionCodePolicyVO;
import org.triptogether.superAdmin.vo.SuperAdminPermissionVO;
import org.triptogether.superAdmin.vo.SuperAdminPositionPolicyVO;
import org.triptogether.superAdmin.vo.SuperAdminSearchVO;
import org.triptogether.superAdmin.vo.SuperAdminStatsVO;

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

    List<SuperAdminMemberVO> getAdminsForOrgChart();

    List<SuperAdminMemberVO> getAllForSalaryTable();

    Map<String, Object> getStatsData();
}
