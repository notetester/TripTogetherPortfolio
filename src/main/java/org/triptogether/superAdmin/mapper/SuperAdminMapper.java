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

    // ── 권한 변경 이력 ──
    List<SuperAdminAuditLogVO> findPermissionAuditLog(@Param("userIdx") Long userIdx);

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
}
