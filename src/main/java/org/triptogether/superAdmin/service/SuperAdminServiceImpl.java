package org.triptogether.superAdmin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.superAdmin.mapper.SuperAdminMapper;
import org.triptogether.superAdmin.util.SalaryExcelImporter;
import org.triptogether.superAdmin.vo.*;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

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
        SuperAdminMemberVO member = superAdminMapper.findAdminDetail(userIdx);
        if (member != null && UserRole.from(member.getUserRole()).isSuperAdmin()) {
            if (superAdminMapper.countSuperAdmins() <= 1) {
                throw new IllegalStateException("최소 1명의 SUPERADMIN이 유지되어야 합니다.");
            }
        }
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

    // ── 급여/역량 엑셀 업로드 ──
    private static final Set<String> VALID_SENIORITY = Set.of(
        "어소시에이트", "주니어", "미드레벨", "시니어", "리드", "프린시펄", "스태프", "펠로우");
    private static final Set<String> VALID_TIER  = Set.of("T1", "T2", "T3", "T4", "T5");
    private static final Set<String> VALID_LEVEL = Set.of("L1", "L2", "L3", "L4", "L5", "L6", "L7");
    private static final Set<String> VALID_BAND  = Set.of("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10");
    private static final Set<String> VALID_GRADE = Set.of("G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8", "G9", "G10");
    private static final Set<String> VALID_STEP  = Set.of(
        "1호봉","2호봉","3호봉","4호봉","5호봉","6호봉","7호봉","8호봉",
        "9호봉","10호봉","11호봉","12호봉","13호봉","14호봉","15호봉");

    @Override
    public SalaryUploadPreviewDto previewSalaryUpload(MultipartFile file) throws Exception {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어 있습니다.");
        }
        List<SalaryExcelImporter.ImportedRow> imported;
        try (InputStream in = file.getInputStream()) {
            imported = SalaryExcelImporter.parse(in);
        }

        List<SalaryUploadRowDto> rows = new ArrayList<>();
        for (SalaryExcelImporter.ImportedRow ir : imported) {
            SalaryUploadRowDto dto = new SalaryUploadRowDto();
            dto.setRowNumber(ir.rowNumber);
            dto.setEmail(ir.email);
            dto.setNickname(ir.nickname);

            Map<String, String> newValues = new LinkedHashMap<>();
            newValues.put("Seniority", normalize(ir.seniority));
            newValues.put("Tier",      normalize(ir.tier));
            newValues.put("Level",     normalize(ir.level));
            newValues.put("Band",      normalize(ir.band));
            newValues.put("Grade",     normalize(ir.grade));
            newValues.put("Step",      normalize(ir.step));
            dto.setNewValues(newValues);

            List<String> errors = new ArrayList<>();
            addIfInvalid(errors, "Seniority", newValues.get("Seniority"), VALID_SENIORITY);
            addIfInvalid(errors, "Tier",      newValues.get("Tier"),      VALID_TIER);
            addIfInvalid(errors, "Level",     newValues.get("Level"),     VALID_LEVEL);
            addIfInvalid(errors, "Band",      newValues.get("Band"),      VALID_BAND);
            addIfInvalid(errors, "Grade",     newValues.get("Grade"),     VALID_GRADE);
            addIfInvalid(errors, "Step",      newValues.get("Step"),      VALID_STEP);

            SuperAdminMemberVO cur = superAdminMapper.findMemberByEmailForSalary(ir.email);
            if (cur == null) {
                errors.add("해당 이메일의 사용자를 찾을 수 없습니다.");
            } else if (!UserRole.from(cur.getUserRole()).isAdminLike()) {
                errors.add("관리자 계정이 아닙니다.");
            } else {
                dto.setUserIdx(cur.getUserIdx());
                Map<String, String> oldValues = new LinkedHashMap<>();
                oldValues.put("Seniority", cur.getAdminSeniority());
                oldValues.put("Tier",      cur.getAdminTier());
                oldValues.put("Level",     cur.getAdminLevel());
                oldValues.put("Band",      cur.getAdminBand());
                oldValues.put("Grade",     cur.getAdminGrade());
                oldValues.put("Step",      cur.getAdminStep());
                dto.setOldValues(oldValues);
            }

            if (!errors.isEmpty()) {
                dto.setStatus("ERROR");
                dto.setErrorMessage(String.join(" / ", errors));
            } else {
                boolean changed = false;
                for (Map.Entry<String, String> e : newValues.entrySet()) {
                    if (!Objects.equals(dto.getOldValues().get(e.getKey()), e.getValue())) {
                        changed = true;
                        break;
                    }
                }
                dto.setStatus(changed ? "CHANGE" : "UNCHANGED");
            }
            rows.add(dto);
        }

        SalaryUploadPreviewDto preview = new SalaryUploadPreviewDto();
        preview.setRows(rows);
        preview.setTotalCount(rows.size());
        preview.setChangedCount((int) rows.stream().filter(r -> "CHANGE".equals(r.getStatus())).count());
        preview.setUnchangedCount((int) rows.stream().filter(r -> "UNCHANGED".equals(r.getStatus())).count());
        preview.setErrorCount((int) rows.stream().filter(r -> "ERROR".equals(r.getStatus())).count());
        return preview;
    }

    @Override
    @Transactional
    public int applySalaryUpload(List<SalaryUploadApplyVO.ApplyRow> rows, Long changedBy) {
        if (rows == null || rows.isEmpty()) return 0;
        String batchId = UUID.randomUUID().toString();
        List<SalaryAuditVO> allAudits = new ArrayList<>();
        int applied = 0;

        for (SalaryUploadApplyVO.ApplyRow r : rows) {
            SuperAdminMemberVO cur = superAdminMapper.findMemberByEmailForSalary(r.getEmail());
            if (cur == null) continue;
            if (!UserRole.from(cur.getUserRole()).isAdminLike()) continue;
            if (r.getUserIdx() != null && !cur.getUserIdx().equals(r.getUserIdx())) continue;

            String nSen  = normalize(r.getSeniority());
            String nTier = normalize(r.getTier());
            String nLv   = normalize(r.getLevel());
            String nBand = normalize(r.getBand());
            String nGrd  = normalize(r.getGrade());
            String nStep = normalize(r.getStep());

            List<SalaryAuditVO> rowAudits = new ArrayList<>();
            addAuditIfChanged(rowAudits, batchId, cur, "adminSeniority", cur.getAdminSeniority(), nSen,  changedBy);
            addAuditIfChanged(rowAudits, batchId, cur, "adminTier",      cur.getAdminTier(),      nTier, changedBy);
            addAuditIfChanged(rowAudits, batchId, cur, "adminLevel",     cur.getAdminLevel(),     nLv,   changedBy);
            addAuditIfChanged(rowAudits, batchId, cur, "adminBand",      cur.getAdminBand(),      nBand, changedBy);
            addAuditIfChanged(rowAudits, batchId, cur, "adminGrade",     cur.getAdminGrade(),     nGrd,  changedBy);
            addAuditIfChanged(rowAudits, batchId, cur, "adminStep",      cur.getAdminStep(),      nStep, changedBy);

            if (rowAudits.isEmpty()) continue;

            SuperAdminSalaryEditVO upd = new SuperAdminSalaryEditVO();
            upd.setUserIdx(cur.getUserIdx());
            upd.setAdminSeniority(nSen);
            upd.setAdminTier(nTier);
            upd.setAdminLevel(nLv);
            upd.setAdminBand(nBand);
            upd.setAdminGrade(nGrd);
            upd.setAdminStep(nStep);
            superAdminMapper.updateSalary(upd);

            allAudits.addAll(rowAudits);
            applied++;
        }

        if (!allAudits.isEmpty()) {
            superAdminMapper.insertSalaryAuditBulk(allAudits);
        }
        return applied;
    }

    private static String normalize(String v) {
        return (v == null || v.isBlank()) ? null : v.trim();
    }

    private static void addIfInvalid(List<String> errors, String fieldName, String value, Set<String> allowed) {
        if (value == null) return;
        if (!allowed.contains(value)) {
            errors.add(fieldName + " 허용되지 않는 값: " + value);
        }
    }

    private static void addAuditIfChanged(List<SalaryAuditVO> list, String batchId,
                                          SuperAdminMemberVO cur, String field,
                                          String oldV, String newV, Long changedBy) {
        String o = (oldV == null || oldV.isBlank()) ? null : oldV;
        String n = (newV == null || newV.isBlank()) ? null : newV;
        if (Objects.equals(o, n)) return;
        SalaryAuditVO a = new SalaryAuditVO();
        a.setBatchId(batchId);
        a.setTargetUserIdx(cur.getUserIdx());
        a.setTargetUserEmail(cur.getUserEmail());
        a.setFieldName(field);
        a.setOldValue(o);
        a.setNewValue(n);
        a.setChangedByUserIdx(changedBy);
        list.add(a);
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
        int totalSuperAdmins = superAdminMapper.countSuperAdmins();
        int superAdminsInList = superAdminMapper.countSuperAdminsInList(userIdxList);
        if (superAdminsInList > 0 && superAdminsInList >= totalSuperAdmins) {
            throw new IllegalStateException("최소 1명의 SUPERADMIN이 유지되어야 합니다.");
        }
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
