package org.triptogether.superAdmin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.superAdmin.vo.*;

import java.util.List;

@Mapper
public interface SuperAdminMapper {

    // ── 관리자 목록 ──
    List<SuperAdminMemberVO> findAdmins(SuperAdminSearchVO search);
    int countAdmins(SuperAdminSearchVO search);

    // ── 관리자 상세 ──
    SuperAdminMemberVO findAdminDetail(@Param("userIdx") Long userIdx);

    // ── 일반 유저 검색 (관리자 등록용) ──
    List<SuperAdminMemberVO> searchUsers(SuperAdminSearchVO search);

    // ── 관리자 검색 (권한/그룹/템플릿 배정용) ──
    List<SuperAdminMemberVO> searchAdmins(SuperAdminSearchVO search);

    // ── 관리자 등록/해제 ──
    void grantAdmin(@Param("userIdx") Long userIdx);
    void revokeAdmin(@Param("userIdx") Long userIdx);

    // ── 권한 정책 목록 (ADMIN_PERMISSION_POLICY) ──
    List<SuperAdminPermissionVO> findAllPermissionPolicies();

    // ── 보유 권한 목록 (ADMIN_PERMISSION) ──
    List<SuperAdminPermissionVO> findPermissionsByUser(@Param("userIdx") Long userIdx);

    // ── 권한 부여 ──
    void grantPermission(@Param("userIdx") Long userIdx,
                         @Param("permissionCode") String permissionCode,
                         @Param("grantedBy") Long grantedBy);

    // ── 권한 회수 (is_active = 0) ──
    void revokePermission(@Param("userIdx") Long userIdx,
                          @Param("permissionCode") String permissionCode);

    // ── 권한 존재 여부 확인 ──
    int countPermission(@Param("userIdx") Long userIdx,
                        @Param("permissionCode") String permissionCode);

    // ── 활성 권한 존재 여부 확인 ──
    int countActivePermission(@Param("userIdx") Long userIdx,
                              @Param("permissionCode") String permissionCode);

    // ── 관리자 해제 시 모든 권한 비활성화 ──
    void revokeAllPermissions(@Param("userIdx") Long userIdx);

    // ── 직책 정책 목록 ──
    List<SuperAdminPositionPolicyVO> findAllPositionPolicies();

    // ── 실효 권한 코드 목록 ──
    List<SuperAdminPermissionCodePolicyVO> findAllPermissionCodePolicies();

    // ── 관리자 목록 (상급자 선택용) ──
    List<SuperAdminMemberVO> findAllAdmins();

    // ── 조직/직무 정보 수정 ──
    void updateAdminInfo(SuperAdminEditVO editVO);

    // ── 계층 구조용 전체 관리자 조회 ──
    List<SuperAdminMemberVO> findAdminsForOrgChart();

    // ── 급여/역량 현황 일람표 ──
    List<SuperAdminMemberVO> findAllForSalaryTable(SuperAdminSearchVO search);
    int countForSalaryTable(SuperAdminSearchVO search);

    // ── 예외 현황 보고 ──
    List<SuperAdminMemberVO> findDormantAdmins();
    List<SuperAdminMemberVO> findAdminsWithoutPermissions();
    List<SuperAdminMemberVO> findAdminsWithoutManager();

    // ── 급여/역량 수정 ──
    void updateSalary(SuperAdminSalaryEditVO salaryVO);

    // ── 통계: 직책 분포 ──
    List<SuperAdminStatsVO> getStatsByPosition();

    // ── 통계: 실효권한 분포 ──
    List<SuperAdminStatsVO> getStatsByPermissionCode();

    // ── 통계: 티어 분포 ──
    List<SuperAdminStatsVO> getStatsByTier();

    // ── 통계: 부서 분포 ──
    List<SuperAdminStatsVO> getStatsByDepartment();

    // ── 통계: 총 관리자 수 ──
    int countAllAdmins();

    // ── SUPERADMIN 수 ──
    int countSuperAdmins();
    int countSuperAdminsInList(@Param("list") List<Long> userIdxList);

    // ── 권한 변경 이력 ──
    List<SuperAdminAuditLogVO> findPermissionAuditLog(@Param("userIdx") Long userIdx);

    // ── 그룹 소속 관리 ──
    List<SuperAdminAdminGroupVO> findAdminGroups(@Param("userIdx") Long userIdx);
    List<SuperAdminAdminGroupVO> findGroupAuditLog(@Param("userIdx") Long userIdx);
    List<SuperAdminGroupMemberVO> findGroupMembers(@Param("groupCode") String groupCode);
    void insertAdminGroup(@Param("userIdx") Long userIdx,
                          @Param("groupCode") String groupCode,
                          @Param("grantedBy") Long grantedBy);
    void revokeAdminGroup(@Param("userIdx") Long userIdx,
                          @Param("groupCode") String groupCode);

    // ── 권한 그룹 정책 목록 ──
    List<SuperAdminGroupPolicyVO> findAllGroupPolicies();

    // ── 그룹 구성 권한 목록 ──
    List<SuperAdminGroupItemVO> findGroupItems(@Param("groupCode") String groupCode);

    // ── 그룹 생성 ──
    void insertGroup(@Param("groupCode") String groupCode,
                     @Param("displayName") String displayName,
                     @Param("description") String description,
                     @Param("createdBy") Long createdBy);

    // ── 그룹 활성/비활성 토글 ──
    void toggleGroupActive(@Param("groupCode") String groupCode,
                           @Param("active") int active,
                           @Param("updatedBy") Long updatedBy);

    // ── 그룹 구성 권한 추가 ──
    void addGroupItem(@Param("groupCode") String groupCode,
                      @Param("permissionCode") String permissionCode,
                      @Param("createdBy") Long createdBy);

    // ── 그룹 구성 권한 삭제 ──
    void removeGroupItem(@Param("groupCode") String groupCode,
                         @Param("permissionCode") String permissionCode);

    // ── 그룹 삭제 (소속원 해제 → 아이템 삭제 → 정책 삭제) ──
    void deleteGroupMembers(@Param("groupCode") String groupCode);
    void deleteGroupItems(@Param("groupCode") String groupCode);
    void deleteGroupPolicy(@Param("groupCode") String groupCode);

    // ── 대기 중 권한 요청 목록 ──
    List<SuperAdminPermissionRequestVO> findPendingRequests();

    // ── 대기 중 권한 요청 수 ──
    int countPendingRequests();

    // ── 권한 요청 생성 ──
    void createPermissionRequest(@Param("userIdx") Long userIdx,
                                 @Param("permissionCode") String permissionCode,
                                 @Param("requestedBy") Long requestedBy,
                                 @Param("description") String description);

    // ── 권한 요청 승인 ──
    void approvePermissionRequest(@Param("adminPermissionIdx") Long adminPermissionIdx,
                                  @Param("approvedBy") Long approvedBy);

    // ── 권한 요청 거절 ──
    void rejectPermissionRequest(@Param("adminPermissionIdx") Long adminPermissionIdx,
                                 @Param("approvedBy") Long approvedBy);

    // ── 일괄 관리자 해제 ──
    void bulkRevokeAdmin(@Param("list") List<Long> userIdxList);

    // ── 일괄 모든 권한 비활성화 ──
    void bulkRevokeAllPermissions(@Param("list") List<Long> userIdxList);

    // ── 실효 권한 코드 변경 ──
    void updatePermissionCode(@Param("userIdx") Long userIdx,
                              @Param("permissionCode") String permissionCode);

    // ── 실효 권한 코드 정책 CRUD ──
    List<SuperAdminPermissionCodePolicyVO> findAllPermissionCodePoliciesWithCount();
    void insertPermissionCode(@Param("adminPermissionCode") String adminPermissionCode,
                              @Param("displayName") String displayName,
                              @Param("description") String description,
                              @Param("createdBy") Long createdBy);
    void togglePermissionCodeActive(@Param("adminPermissionCode") String adminPermissionCode,
                                    @Param("active") int active,
                                    @Param("updatedBy") Long updatedBy);
    void deletePermissionCode(@Param("adminPermissionCode") String adminPermissionCode);
    int countAdminsByPermissionCode(@Param("adminPermissionCode") String adminPermissionCode);

    // ── 코드 번들 구성 항목 조회 ──
    List<SuperAdminGroupItemVO> findCodePermissionItems(@Param("adminPermissionCode") String adminPermissionCode);
    List<SuperAdminGroupPolicyVO> findCodeGroupItems(@Param("adminPermissionCode") String adminPermissionCode);

    // ── 코드 번들 개별 권한 추가/제거 ──
    void addCodePermissionItem(@Param("adminPermissionCode") String adminPermissionCode,
                               @Param("permissionCode") String permissionCode,
                               @Param("createdBy") Long createdBy);
    void removeCodePermissionItem(@Param("adminPermissionCode") String adminPermissionCode,
                                  @Param("permissionCode") String permissionCode);

    // ── 코드 번들 그룹 추가/제거 ──
    void addCodeGroupItem(@Param("adminPermissionCode") String adminPermissionCode,
                          @Param("groupCode") String groupCode,
                          @Param("createdBy") Long createdBy);
    void removeCodeGroupItem(@Param("adminPermissionCode") String adminPermissionCode,
                             @Param("groupCode") String groupCode);

    // ── 코드 번들 배정 관리자 목록 ──
    List<SuperAdminMemberVO> findAdminsByPermissionCode(@Param("adminPermissionCode") String adminPermissionCode);

    // ── 개별 권한 정책 관리 ──
    List<SuperAdminPermissionVO> findAllPermissionPoliciesForManage();
    void insertPermissionPolicy(@Param("permissionCode") String permissionCode,
                                @Param("displayName") String displayName,
                                @Param("description") String description,
                                @Param("createdBy") Long createdBy);
    void togglePermissionPolicyActive(@Param("permissionCode") String permissionCode,
                                      @Param("active") int active,
                                      @Param("updatedBy") Long updatedBy);
    void deletePermissionPolicy(@Param("permissionCode") String permissionCode);

    // ── 권한 항목 상세 ──
    List<SuperAdminGroupPolicyVO> findGroupsByPermissionCode(@Param("permissionCode") String permissionCode);
    List<SuperAdminPermissionCodePolicyVO> findCodesByPermissionCode(@Param("permissionCode") String permissionCode);
    List<SuperAdminMemberVO> findAdminsByDirectPermission(@Param("permissionCode") String permissionCode);
}
