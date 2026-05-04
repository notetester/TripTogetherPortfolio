package org.triptogether.admin.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.admin.mapper.AdminBlockMapper;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminBlockHistoryVO;
import org.triptogether.admin.vo.AdminBlockSearchVO;
import org.triptogether.admin.vo.AdminIpBlockBatchOperationRuleVO;
import org.triptogether.admin.vo.AdminIpBlockBatchOperationVO;
import org.triptogether.admin.vo.AdminIpBlockBatchVO;
import org.triptogether.admin.vo.AdminIpBlockVO;
import org.triptogether.admin.vo.AdminPolicyFeedRuleVO;
import org.triptogether.admin.vo.AdminPolicyFeedImportRequest;
import org.triptogether.admin.vo.AdminUserBlockVO;
import org.triptogether.config.IpBlockMapper;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminBlockServiceImpl implements AdminBlockService {

    private static final DateTimeFormatter DISPLAY_DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");

    private final AdminBlockMapper adminBlockMapper;
    private final AdminMapper adminMapper;
    private final IpBlockMapper ipBlockMapper;
    private final ObjectMapper objectMapper;

    @Override
    public Map<String, Object> getBlockHistoriesPaged(AdminBlockSearchVO search) {
        int page = Math.max(1, search.getPage());
        int size = Math.max(1, Math.min(200, search.getSize()));
        int offset = (page - 1) * size;

        java.util.Map<String, Object> params = new HashMap<>();
        params.put("status", search.getStatus());
        params.put("scope", search.getScope());
        params.put("matchType", search.getMatchType());
        params.put("blockType", search.getBlockType());
        params.put("ruleAction", search.getRuleAction());
        params.put("controlMode", search.getControlMode());
        params.put("batchId", search.getBatchId());
        params.put("keyword", search.getKeyword());
        params.put("field", search.getField());
        params.put("sortBy", search.getSortBy());
        params.put("sortDir", "ASC".equalsIgnoreCase(search.getSortDir()) ? "ASC" : "DESC");
        params.put("size", size);
        params.put("offset", offset);

        java.util.List<AdminBlockHistoryVO> rows = adminBlockMapper.findBlockHistoriesPaged(params);
        long total = adminBlockMapper.countBlockHistoriesFiltered(params);

        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("totalPages", (int) Math.max(1, Math.ceil(total / (double) size)));
        return result;
    }

    @Override
    public Map<String, Object> getIpBlocksPaged(AdminBlockSearchVO search) {
        int page = Math.max(1, search.getPage());
        int size = Math.max(1, Math.min(200, search.getSize()));
        int offset = (page - 1) * size;

        java.util.Map<String, Object> params = new HashMap<>();
        params.put("status", search.getStatus());
        params.put("scope", search.getScope());
        params.put("matchType", search.getMatchType());
        params.put("blockType", search.getBlockType());
        params.put("ruleAction", search.getRuleAction());
        params.put("controlMode", search.getControlMode());
        params.put("category", search.getCategory());
        params.put("effectiveStatus", search.getEffectiveStatus());
        params.put("batchId", search.getBatchId());
        params.put("keyword", search.getKeyword());
        params.put("field", search.getField());
        params.put("sortBy", search.getSortBy());
        params.put("sortDir", "ASC".equalsIgnoreCase(search.getSortDir()) ? "ASC" : "DESC");
        params.put("size", size);
        params.put("offset", offset);

        java.util.List<AdminIpBlockVO> rows = adminBlockMapper.findIpBlocksPaged(params);
        long total = adminBlockMapper.countIpBlocksFiltered(params);

        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("totalPages", (int) Math.max(1, Math.ceil(total / (double) size)));
        return result;
    }

    @Override
    public Map<String, Object> getIpBlockBatchesPaged(AdminBlockSearchVO search) {
        int page = Math.max(1, search.getPage());
        int size = Math.max(1, Math.min(200, search.getSize()));
        int offset = (page - 1) * size;

        java.util.Map<String, Object> params = new HashMap<>();
        params.put("status", search.getStatus());
        params.put("keyword", search.getKeyword());
        params.put("field", search.getField());
        params.put("sortBy", search.getSortBy());
        params.put("sortDir", "ASC".equalsIgnoreCase(search.getSortDir()) ? "ASC" : "DESC");
        params.put("size", size);
        params.put("offset", offset);

        java.util.List<AdminIpBlockBatchVO> rows = adminBlockMapper.findIpBlockBatchesPaged(params);
        long total = adminBlockMapper.countIpBlockBatchesFiltered(params);

        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("totalPages", (int) Math.max(1, Math.ceil(total / (double) size)));
        return result;
    }

    @Override
    public Map<String, Object> getUserBlocksPaged(AdminBlockSearchVO search) {
        int page = Math.max(1, search.getPage());
        int size = Math.max(1, Math.min(200, search.getSize()));
        int offset = (page - 1) * size;

        java.util.Map<String, Object> params = new HashMap<>();
        params.put("status", search.getStatus());
        params.put("scope", search.getScope());
        params.put("blockType", search.getBlockType());
        params.put("controlMode", search.getControlMode());
        params.put("category", search.getCategory());
        params.put("effectiveStatus", search.getEffectiveStatus());
        params.put("batchId", search.getBatchId());
        params.put("keyword", search.getKeyword());
        params.put("field", search.getField());
        params.put("sortBy", search.getSortBy());
        params.put("sortDir", "ASC".equalsIgnoreCase(search.getSortDir()) ? "ASC" : "DESC");
        params.put("size", size);
        params.put("offset", offset);

        java.util.List<AdminUserBlockVO> rows = adminBlockMapper.findUserBlocksPaged(params);
        long total = adminBlockMapper.countUserBlocksFiltered(params);

        Map<String, Object> result = new HashMap<>();
        result.put("rows", rows);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("totalPages", (int) Math.max(1, Math.ceil(total / (double) size)));
        return result;
    }


    @Override
    public AdminUserBlockVO getUserBlockDetail(Long blockIdx) {
        if (blockIdx == null) {
            return null;
        }
        return adminBlockMapper.findUserBlockById(blockIdx);
    }

    @Override
    public AdminIpBlockVO getIpRuleDetail(Long ipBlocklistIdx) {
        if (ipBlocklistIdx == null) {
            return null;
        }
        return adminBlockMapper.findIpBlockById(ipBlocklistIdx);
    }

    @Override
    public Map<String, Object> getIpRuleDetailData(Long ipBlocklistIdx) {
        Map<String, Object> result = new HashMap<>();
        AdminIpBlockVO rule = getIpRuleDetail(ipBlocklistIdx);
        result.put("rule", rule);
        if (rule == null || rule.getBlockTargetKey() == null || rule.getBlockTargetKey().isBlank()) {
            result.put("histories", java.util.Collections.emptyList());
            return result;
        }
        AdminBlockSearchVO historySearch = new AdminBlockSearchVO();
        historySearch.setField("target");
        historySearch.setKeyword(rule.getBlockTargetKey());
        historySearch.setLimit(20);
        result.put("histories", adminBlockMapper.findBlockHistories(historySearch));
        return result;
    }

    @Override
    public AdminIpBlockBatchVO getBatchDetail(Long ipBlockBatchIdx) {
        if (ipBlockBatchIdx == null) {
            return null;
        }
        return adminBlockMapper.findIpBlockBatchById(ipBlockBatchIdx);
    }

    @Override
    public Map<String, Object> getBatchDetailData(Long ipBlockBatchIdx) {
        Map<String, Object> result = new HashMap<>();
        AdminIpBlockBatchVO batch = getBatchDetail(ipBlockBatchIdx);
        result.put("batch", batch);
        if (ipBlockBatchIdx == null || batch == null) {
            result.put("rules", java.util.Collections.emptyList());
            result.put("operations", java.util.Collections.emptyList());
            return result;
        }
        result.put("rules", adminBlockMapper.findIpRulesByBatchId(ipBlockBatchIdx));
        AdminBlockSearchVO operationSearch = new AdminBlockSearchVO();
        operationSearch.setBatchId(ipBlockBatchIdx);
        operationSearch.setLimit(10);
        result.put("operations", adminBlockMapper.findRecentBatchOperations(operationSearch));
        return result;
    }

    @Override
    public AdminBlockHistoryVO getHistoryDetail(Long historyBlockIdx) {
        if (historyBlockIdx == null) {
            return null;
        }
        return adminBlockMapper.findBlockHistoryById(historyBlockIdx);
    }

    @Override
    public Map<String, Object> getBlockDashboard(AdminBlockSearchVO search) {
        return getBlockDashboard(search, true, true, true, true);
    }

    @Override
    public Map<String, Object> getBlockDashboard(AdminBlockSearchVO search, boolean loadUserBlocks, boolean loadIpBlocks, boolean loadBatches, boolean loadHistories) {
        Map<String, Object> result = new HashMap<>();
        result.put("search", search);
        result.put("activeUserBlockCount", adminBlockMapper.countActiveUserBlocks());
        result.put("activeIpBlockCount", adminBlockMapper.countActiveIpBlocks());
        result.put("blockHistoryCount", adminBlockMapper.countBlockHistories());
        result.put("activeBatchCount", adminBlockMapper.countActiveBatches());
        result.put("totalUserCount", adminBlockMapper.countTotalUsers());
        result.put("totalIpRuleCount", adminBlockMapper.countTotalIpRules());
        result.put("todayBlockCount", adminBlockMapper.countTodayBlockHistories());
        result.put("totalBatchCount", adminBlockMapper.countTotalBatches());

        result.put("userBlocks", loadUserBlocks ? adminBlockMapper.findUserBlocks(search) : java.util.Collections.emptyList());
        result.put("ipBlocks", loadIpBlocks ? adminBlockMapper.findIpBlocks(search) : java.util.Collections.emptyList());
        result.put("histories", loadHistories ? adminBlockMapper.findBlockHistories(search) : java.util.Collections.emptyList());
        result.put("batches", loadBatches ? adminBlockMapper.findIpBlockBatches(search) : java.util.Collections.emptyList());

        AdminBlockSearchVO recentSearch = copySearchWithLimit(search, 5);
        result.put("dashboardUserBlocks", adminBlockMapper.findUserBlocks(recentSearch));
        result.put("dashboardIpBlocks", adminBlockMapper.findIpBlocks(recentSearch));
        result.put("dashboardHistories", adminBlockMapper.findBlockHistories(recentSearch));

        AdminBlockSearchVO batchFilterSearch = new AdminBlockSearchVO();
        batchFilterSearch.setLimit(1000);
        result.put("batchFilterOptions", adminBlockMapper.findIpBlockBatches(batchFilterSearch));
        result.put("batchOperations", adminBlockMapper.findRecentBatchOperations(search));
        return result;
    }

    private AdminBlockSearchVO copySearchWithLimit(AdminBlockSearchVO source, int limit) {
        AdminBlockSearchVO copied = new AdminBlockSearchVO();
        if (source != null) {
            BeanUtils.copyProperties(source, copied);
        }
        copied.setLimit(limit);
        return copied;
    }

    @Override
    public void createIpBlockBatch(String batchCode, String batchName, String sourceType, String sourceName,
                                   String batchRuleAction, Integer defaultRulePriority,
                                   String defaultDisableStrategy, String defaultEnableStrategy,
                                   String description, Long actorUserIdx) {
        if (isBlank(batchCode) || isBlank(batchName) || isBlank(sourceType)) {
            throw new IllegalArgumentException("배치 코드, 배치명, 출처 유형은 필수입니다.");
        }

        AdminIpBlockBatchVO batch = new AdminIpBlockBatchVO();
        batch.setBatchCode(batchCode.trim().toUpperCase());
        batch.setBatchName(batchName.trim());
        batch.setSourceType(sourceType.trim().toUpperCase());
        batch.setSourceName(trimToNull(sourceName));
        batch.setBatchRuleAction(safeUpper(batchRuleAction, "BLOCK"));
        batch.setDefaultRulePriority(defaultRulePriority != null && defaultRulePriority > 0 ? defaultRulePriority : 1);
        batch.setDefaultDisableStrategy(resolveBatchDisableStrategy(defaultDisableStrategy));
        batch.setDefaultEnableStrategy(resolveBatchEnableStrategy(defaultEnableStrategy));
        batch.setDescription(trimToNull(description));
        batch.setCreatedByUserIdx(actorUserIdx);
        batch.setUpdatedByUserIdx(actorUserIdx);
        adminBlockMapper.insertIpBlockBatch(batch);
    }

    @Override
    public void updateIpBlockBatch(Long ipBlockBatchIdx, String batchCode, String batchName, String sourceType, String sourceName,
                                   String batchRuleAction, Integer defaultRulePriority,
                                   String defaultDisableStrategy, String defaultEnableStrategy,
                                   String description, Long actorUserIdx) {
        AdminIpBlockBatchVO batch = requireBatch(ipBlockBatchIdx);
        if (isBlank(batchCode) || isBlank(batchName) || isBlank(sourceType)) {
            throw new IllegalArgumentException("배치 코드, 배치명, 출처 유형은 필수입니다.");
        }

        batch.setBatchCode(batchCode.trim().toUpperCase());
        batch.setBatchName(batchName.trim());
        batch.setSourceType(sourceType.trim().toUpperCase());
        batch.setSourceName(trimToNull(sourceName));
        batch.setBatchRuleAction(safeUpper(batchRuleAction, batch.getBatchRuleAction() != null ? batch.getBatchRuleAction() : "BLOCK"));
        batch.setDefaultRulePriority(defaultRulePriority != null && defaultRulePriority > 0 ? defaultRulePriority : 1);
        batch.setDefaultDisableStrategy(resolveBatchDisableStrategy(defaultDisableStrategy));
        batch.setDefaultEnableStrategy(resolveBatchEnableStrategy(defaultEnableStrategy));
        batch.setDescription(trimToNull(description));
        batch.setUpdatedByUserIdx(actorUserIdx);
        adminBlockMapper.updateIpBlockBatch(batch);
    }

    @Override
    public void toggleIpBlockBatch(Long ipBlockBatchIdx, boolean active, String operationOption, String description, Long actorUserIdx) {
        AdminIpBlockBatchVO batch = requireBatch(ipBlockBatchIdx);
        if (batch.isActive() == active) {
            throw new IllegalArgumentException(active ? "이미 활성화된 배치입니다." : "이미 비활성화된 배치입니다.");
        }

        String resolvedOption = resolveBatchOperationOption(batch, active, operationOption);
        LocalDateTime now = LocalDateTime.now();
        List<AdminIpBlockVO> rules = adminBlockMapper.findIpRulesByBatchId(ipBlockBatchIdx);

        AdminIpBlockBatchOperationVO operation = new AdminIpBlockBatchOperationVO();
        operation.setIpBlockBatchIdx(ipBlockBatchIdx);
        operation.setOperationType(active ? "BATCH_ACTIVATE" : "BATCH_DEACTIVATE");
        operation.setOperationOption(resolvedOption);
        operation.setRequestedRuleCount(rules.size());
        operation.setAffectedRuleCount(0);
        operation.setDescription(trimToNull(description));
        operation.setRequestedByUserIdx(actorUserIdx);
        operation.setRequestedAt(now);
        adminBlockMapper.insertIpBlockBatchOperation(operation);

        Map<Long, AdminIpBlockBatchOperationRuleVO> lastDisabledRuleMap = Map.of();
        if (active && "RESTORE_BATCH_CONTROL".equals(resolvedOption)) {
            AdminIpBlockBatchOperationVO latestDisable = adminBlockMapper.findLatestBatchDisableOperation(ipBlockBatchIdx);
            if (latestDisable != null) {
                lastDisabledRuleMap = adminBlockMapper.findOperationRules(latestDisable.getIpBlockBatchOperationIdx()).stream()
                        .filter(detail -> "RULE_DISABLED".equals(detail.getOperationEffect()))
                        .collect(Collectors.toMap(AdminIpBlockBatchOperationRuleVO::getIpBlocklistIdx, Function.identity(), (left, right) -> left));
            }
        }

        adminBlockMapper.updateIpBlockBatchActive(ipBlockBatchIdx, active, actorUserIdx);

        int affectedRuleCount = 0;
        for (AdminIpBlockVO rule : rules) {
            AdminIpBlockVO before = snapshot(rule);
            boolean beforeBatchActive = batch.isActive();
            String effect = "NO_CHANGE";
            String memo = null;

            rule.setBatchActive(active);

            if (!active) {
                if ("CASCADE_ACTIVE_RULES".equals(resolvedOption)) {
                    if ("MANUAL_OVERRIDE".equalsIgnoreCase(before.getControlMode())) {
                        effect = "SKIPPED_MANUAL_OVERRIDE";
                        memo = "관리자가 개별 예외로 전환한 규칙은 유지했습니다.";
                    } else if ("BATCH".equalsIgnoreCase(before.getControlMode()) && before.isActive()) {
                        rule.setActive(false);
                        rule.setReleasedAt(now);
                        rule.setReleasedByUserIdx(actorUserIdx);
                        rule.setLastControlAction("BATCH_CASCADE_DISABLE");
                        rule.setLastControlByUserIdx(actorUserIdx);
                        rule.setLastControlAt(now);
                        rule.setLastControlReason("배치 비활성화와 함께 개별 규칙도 비활성화");
                        rule.setBlockRequestId(UUID.randomUUID().toString());
                        effect = "RULE_DISABLED";
                        affectedRuleCount++;
                    } else {
                        effect = "NO_CHANGE";
                    }
                } else {
                    effect = "BATCH_ONLY";
                    memo = "배치 상태만 비활성화하고 개별 규칙 상태는 유지했습니다.";
                }
            } else {
                if ("RESTORE_BATCH_CONTROL".equals(resolvedOption)) {
                    AdminIpBlockBatchOperationRuleVO disabledRule = lastDisabledRuleMap.get(rule.getIpBlocklistIdx());
                    if ("MANUAL_OVERRIDE".equalsIgnoreCase(before.getControlMode())) {
                        effect = "SKIPPED_MANUAL_OVERRIDE";
                        memo = "관리자 수동 예외 규칙은 자동 복구하지 않았습니다.";
                    } else if (disabledRule != null
                            && "BATCH".equalsIgnoreCase(before.getControlMode())
                            && !before.isActive()
                            && !hasBeenChangedAfter(before, operation.getRequestedAt())) {
                        rule.setActive(true);
                        rule.setReleasedAt(null);
                        rule.setReleasedByUserIdx(null);
                        rule.setLastControlAction("BATCH_CASCADE_RESTORE");
                        rule.setLastControlByUserIdx(actorUserIdx);
                        rule.setLastControlAt(now);
                        rule.setLastControlReason("이전 배치 비활성화로 꺼진 규칙 복구");
                        rule.setBlockRequestId(UUID.randomUUID().toString());
                        effect = "RULE_ENABLED";
                        affectedRuleCount++;
                    } else {
                        effect = "NO_CHANGE";
                    }
                } else if ("FORCE_ENABLE_ALL".equals(resolvedOption)) {
                    if (!before.isActive() || "MANUAL_OVERRIDE".equalsIgnoreCase(before.getControlMode())) {
                        rule.setActive(true);
                        rule.setControlMode("BATCH");
                        rule.setManualOverrideByUserIdx(null);
                        rule.setManualOverrideByNickname(null);
                        rule.setManualOverrideAt(null);
                        rule.setManualOverrideReason(null);
                        rule.setReleasedAt(null);
                        rule.setReleasedByUserIdx(null);
                        rule.setLastControlAction("FORCE_ENABLE");
                        rule.setLastControlByUserIdx(actorUserIdx);
                        rule.setLastControlAt(now);
                        rule.setLastControlReason("배치 활성화 시 모든 규칙 강제 ON");
                        rule.setBlockRequestId(UUID.randomUUID().toString());
                        effect = "RULE_ENABLED";
                        affectedRuleCount++;
                    } else {
                        effect = "NO_CHANGE";
                    }
                } else {
                    effect = "BATCH_ONLY";
                    memo = "배치 상태만 활성화하고 개별 규칙 상태는 유지했습니다.";
                }
            }

            applyEffectiveState(rule, evaluateRule(rule, active), "BATCH", now);
            adminBlockMapper.updateIpBlockRule(rule);

            AdminIpBlockBatchOperationRuleVO operationRule = new AdminIpBlockBatchOperationRuleVO();
            operationRule.setIpBlockBatchOperationIdx(operation.getIpBlockBatchOperationIdx());
            operationRule.setIpBlocklistIdx(rule.getIpBlocklistIdx());
            operationRule.setOperationEffect(effect);
            operationRule.setBeforeIsActive(before.isActive());
            operationRule.setAfterIsActive(rule.isActive());
            operationRule.setBeforeControlMode(before.getControlMode());
            operationRule.setAfterControlMode(rule.getControlMode());
            operationRule.setMemo(memo);
            adminBlockMapper.insertIpBlockBatchOperationRule(operationRule);

            if ("RULE_DISABLED".equals(effect) || "RULE_ENABLED".equals(effect) || "FORCE_ENABLE_ALL".equals(resolvedOption)) {
                recordRuleHistory(
                        before,
                        rule,
                        beforeBatchActive,
                        active,
                        "RULE_DISABLED".equals(effect) ? "BATCH_RULE_DISABLED" : "BATCH_RULE_ENABLED",
                        "BATCH",
                        operation.getIpBlockBatchOperationIdx(),
                        rule.getLastControlReason(),
                        actorUserIdx
                );
            }
        }

        adminBlockMapper.updateIpBlockBatchOperationAffectedCount(operation.getIpBlockBatchOperationIdx(), affectedRuleCount);
    }

    @Override
    public void createGlobalIpRule(String matchType, String ipAddress, String cidrNotation, String rangeStartIp, String rangeEndIp,
                                   String countryCode, String asn, String ruleAction, String controlMode,
                                   String blockCategory, Integer priority, Long ipBlockBatchIdx,
                                   String reason, String detailMessage, LocalDateTime expiresAt, Long actorUserIdx) {
        AdminIpBlockBatchVO batch = ipBlockBatchIdx != null ? requireBatch(ipBlockBatchIdx) : null;
        String normalizedType = safeUpper(matchType, "SINGLE_IP");
        String normalizedAction = safeUpper(isBlank(ruleAction) && batch != null ? batch.getBatchRuleAction() : ruleAction, "BLOCK");
        String normalizedControlMode = resolveControlMode(controlMode, ipBlockBatchIdx);
        String normalizedCategory = safeUpper(blockCategory, "MANUAL");
        int resolvedPriority = priority != null && priority > 0
                ? priority
                : batch != null && batch.getDefaultRulePriority() != null ? batch.getDefaultRulePriority() : 1;

        String normalizedIp = normalizeIp(ipAddress);
        String normalizedCidr = trimToNull(cidrNotation);
        String normalizedRangeStart = normalizeIp(rangeStartIp);
        String normalizedRangeEnd = normalizeIp(rangeEndIp);
        String normalizedCountry = trimToNull(countryCode) != null ? trimToNull(countryCode).toUpperCase() : null;
        String normalizedAsn = trimToNull(asn) != null ? trimToNull(asn).toUpperCase() : null;

        String representativeIp;
        String targetKey;
        switch (normalizedType) {
            case "SINGLE_IP" -> {
                if (isBlank(normalizedIp)) throw new IllegalArgumentException("단일 IP 규칙은 IP 주소가 필요합니다.");
                representativeIp = normalizedIp;
                targetKey = "IP:" + normalizedIp;
            }
            case "CIDR" -> {
                if (isBlank(normalizedCidr) || !normalizedCidr.contains("/")) {
                    throw new IllegalArgumentException("CIDR 규칙은 올바른 CIDR 표기가 필요합니다.");
                }
                representativeIp = normalizedCidr.substring(0, normalizedCidr.indexOf('/')).trim();
                targetKey = "CIDR:" + normalizedCidr;
            }
            case "RANGE" -> {
                if (isBlank(normalizedRangeStart) || isBlank(normalizedRangeEnd)) {
                    throw new IllegalArgumentException("범위 규칙은 시작 IP와 끝 IP가 필요합니다.");
                }
                representativeIp = normalizedRangeStart;
                targetKey = "RANGE:" + normalizedRangeStart + "~" + normalizedRangeEnd;
            }
            case "COUNTRY" -> {
                if (isBlank(normalizedCountry)) throw new IllegalArgumentException("국가 규칙은 국가 코드가 필요합니다.");
                representativeIp = "COUNTRY:" + normalizedCountry;
                targetKey = "COUNTRY:" + normalizedCountry;
            }
            case "ASN" -> {
                if (isBlank(normalizedAsn)) throw new IllegalArgumentException("ASN 규칙은 ASN 코드가 필요합니다.");
                representativeIp = normalizedAsn;
                targetKey = "ASN:" + normalizedAsn;
            }
            default -> throw new IllegalArgumentException("지원하지 않는 매칭 방식입니다.");
        }

        LocalDateTime now = LocalDateTime.now();
        AdminIpBlockVO rule = new AdminIpBlockVO();
        rule.setBlockRequestId(UUID.randomUUID().toString());
        rule.setIpAddress(representativeIp);
        rule.setBlockTargetKey(targetKey);
        rule.setRuleAction(normalizedAction);
        rule.setControlMode(normalizedControlMode);
        rule.setRuleOriginType(batch != null ? "POLICY" : "MANUAL");
        rule.setIpBlockBatchIdx(ipBlockBatchIdx);
        rule.setMatchType(normalizedType);
        rule.setCidrNotation(normalizedCidr);
        rule.setRangeStartIp(normalizedRangeStart);
        rule.setRangeEndIp(normalizedRangeEnd);
        rule.setCountryCode(normalizedCountry);
        rule.setAsn(normalizedAsn);
        rule.setSourceScope("GLOBAL");
        rule.setBlockCategory(normalizedCategory);
        rule.setBlockType("IP_ONLY");
        rule.setBlockedByUserIdx(actorUserIdx);
        rule.setBlockedAt(now);
        rule.setReason(trimToNull(reason));
        rule.setActive(true);
        rule.setExpiresAt(expiresAt);
        rule.setDetailMessage(trimToNull(detailMessage));
        rule.setPriority(resolvedPriority);
        rule.setBatchActive(batch == null || batch.isActive());
        rule.setBatchCode(batch != null ? batch.getBatchCode() : null);
        rule.setBatchName(batch != null ? batch.getBatchName() : null);
        rule.setBatchSourceType(batch != null ? batch.getSourceType() : null);
        rule.setBatchSourceName(batch != null ? batch.getSourceName() : null);
        rule.setLastControlAction("CREATE");
        rule.setLastControlByUserIdx(actorUserIdx);
        rule.setLastControlAt(now);
        rule.setLastControlReason(trimToNull(reason));
        if (ipBlockBatchIdx != null) {
            rule.setBatchBoundAt(now);
            rule.setBatchBoundByUserIdx(actorUserIdx);
        }
        if ("MANUAL_OVERRIDE".equals(normalizedControlMode)) {
            rule.setManualOverrideByUserIdx(actorUserIdx);
            rule.setManualOverrideAt(now);
            rule.setManualOverrideReason(trimToNull(reason));
        }

        applyEffectiveState(rule, evaluateRule(rule, batch == null || batch.isActive()), "ADMIN", now);
        adminBlockMapper.insertIpBlockRule(rule);
        recordRuleHistory(null, rule, true, batch == null || batch.isActive(), "CREATE_RULE", "ADMIN", null, trimToNull(reason), actorUserIdx);
    }


    @Override
    public Map<String, Object> importPolicyFeed(MultipartFile file, String sourceName, String defaultRuleAction, Long actorUserIdx) {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("admin.blocks.policyFeed.error.fileRequired");
        }

        List<PolicyFeedRow> rows = parsePolicyFeedRows(file);
        if (rows.isEmpty()) {
            throw new IllegalArgumentException("admin.blocks.policyFeed.error.noRows");
        }

        return importPolicyFeedRows(
                rows,
                sourceName,
                defaultRuleAction,
                "FILE",
                file.getOriginalFilename(),
                actorUserIdx
        );
    }

    @Override
    public Map<String, Object> importPolicyFeed(AdminPolicyFeedImportRequest request, Long actorUserIdx) {
        if (request == null || request.getRules() == null || request.getRules().isEmpty()) {
            throw new IllegalArgumentException("admin.blocks.policyFeed.error.noRows");
        }
        List<PolicyFeedRow> rows = request.getRules().stream()
                .map(this::toPolicyFeedRow)
                .filter(row -> !isBlank(row.targetValue()))
                .collect(Collectors.toList());
        if (rows.isEmpty()) {
            throw new IllegalArgumentException("admin.blocks.policyFeed.error.noRows");
        }
        return importPolicyFeedRows(
                rows,
                request.getSourceName(),
                request.getDefaultRuleAction(),
                "API",
                "JSON_API",
                actorUserIdx
        );
    }

    private Map<String, Object> importPolicyFeedRows(List<PolicyFeedRow> rows,
                                                     String sourceName,
                                                     String defaultRuleAction,
                                                     String importMethod,
                                                     String sourceDetail,
                                                     Long actorUserIdx) {
        LocalDateTime now = LocalDateTime.now();
        AdminIpBlockBatchVO batch = new AdminIpBlockBatchVO();
        batch.setBatchCode("MANUAL_FEED_" + now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        batch.setBatchName("Manual Upload Feed " + now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        batch.setSourceType("POLICY_AUTHORITY");
        batch.setSourceName(firstNonBlank(trimToNull(sourceName), "MANUAL_UPLOAD_FEED"));
        batch.setBatchRuleAction(safeUpper(defaultRuleAction, "BLOCK"));
        batch.setDefaultRulePriority(50);
        batch.setDescription("MANUAL_UPLOAD_FEED importMethod=" + firstNonBlank(importMethod, "-") + ", source=" + firstNonBlank(sourceDetail, "-"));
        batch.setDefaultDisableStrategy("BATCH_ONLY");
        batch.setDefaultEnableStrategy("RESTORE_BATCH_CONTROL");
        batch.setCreatedByUserIdx(actorUserIdx);
        batch.setUpdatedByUserIdx(actorUserIdx);
        adminBlockMapper.insertIpBlockBatch(batch);

        int successCount = 0;
        List<String> skipped = new ArrayList<>();
        for (int i = 0; i < rows.size(); i++) {
            PolicyFeedRow row = rows.get(i);
            try {
                createGlobalIpRule(
                        row.matchType(),
                        "SINGLE_IP".equals(row.matchType()) ? row.targetValue() : null,
                        "CIDR".equals(row.matchType()) ? row.targetValue() : null,
                        null,
                        null,
                        "COUNTRY".equals(row.matchType()) ? row.targetValue() : null,
                        "ASN".equals(row.matchType()) ? row.targetValue() : null,
                        firstNonBlank(row.ruleAction(), batch.getBatchRuleAction()),
                        "BATCH",
                        "SECURITY",
                        row.priority() == null ? 50 : row.priority(),
                        batch.getIpBlockBatchIdx(),
                        firstNonBlank(row.reason(), "MANUAL_UPLOAD_FEED"),
                        firstNonBlank(row.detailMessage(), "Imported by MANUAL_UPLOAD_FEED"),
                        null,
                        actorUserIdx
                );
                successCount++;
            } catch (Exception e) {
                skipped.add("line=" + (i + 1) + ", target=" + row.targetValue() + ", reason=" + e.getMessage());
            }
        }

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("batchId", batch.getIpBlockBatchIdx());
        result.put("batchCode", batch.getBatchCode());
        result.put("importMethod", importMethod);
        result.put("totalCount", rows.size());
        result.put("successCount", successCount);
        result.put("failedCount", skipped.size());
        result.put("skipped", skipped);
        return result;
    }

    private List<PolicyFeedRow> parsePolicyFeedRows(MultipartFile file) {
        String filename = file.getOriginalFilename() == null ? "" : file.getOriginalFilename().toLowerCase();
        try {
            String content = new String(file.getBytes(), StandardCharsets.UTF_8);
            if (filename.endsWith(".json") || content.trim().startsWith("[")) {
                List<Map<String, Object>> values = objectMapper.readValue(content, new TypeReference<List<Map<String, Object>>>() {});
                List<PolicyFeedRow> rows = new ArrayList<>();
                for (Map<String, Object> value : values) {
                    rows.add(toPolicyFeedRow(value));
                }
                return rows.stream().filter(row -> !isBlank(row.targetValue())).collect(Collectors.toList());
            }
            return parseCsvPolicyFeedRows(content);
        } catch (Exception e) {
            throw new IllegalArgumentException("admin.blocks.policyFeed.error.parseFailed");
        }
    }

    private List<PolicyFeedRow> parseCsvPolicyFeedRows(String content) {
        List<PolicyFeedRow> rows = new ArrayList<>();
        String[] lines = content.split("\\r?\\n");
        if (lines.length == 0) {
            return rows;
        }

        String[] header = splitCsvLine(lines[0]);
        Map<String, Integer> headerIndex = new HashMap<>();
        for (int i = 0; i < header.length; i++) {
            headerIndex.put(header[i].trim().toLowerCase(), i);
        }
        boolean hasHeader = headerIndex.containsKey("targetvalue") || headerIndex.containsKey("target_value")
                || headerIndex.containsKey("value") || headerIndex.containsKey("ip") || headerIndex.containsKey("country");

        for (int i = hasHeader ? 1 : 0; i < lines.length; i++) {
            String line = lines[i];
            if (isBlank(line) || line.trim().startsWith("#")) {
                continue;
            }
            String[] cols = splitCsvLine(line);
            Map<String, Object> value = new HashMap<>();
            if (hasHeader) {
                value.put("matchType", csvValue(cols, headerIndex, "matchtype", "match_type", "type"));
                value.put("targetValue", csvValue(cols, headerIndex, "targetvalue", "target_value", "value", "ip", "cidr", "country", "asn"));
                value.put("ruleAction", csvValue(cols, headerIndex, "ruleaction", "rule_action", "action"));
                value.put("reason", csvValue(cols, headerIndex, "reason"));
                value.put("detailMessage", csvValue(cols, headerIndex, "detailmessage", "detail_message", "memo"));
                value.put("priority", csvValue(cols, headerIndex, "priority"));
            } else {
                value.put("matchType", cols.length > 0 ? cols[0] : null);
                value.put("targetValue", cols.length > 1 ? cols[1] : null);
                value.put("reason", cols.length > 2 ? cols[2] : null);
            }
            rows.add(toPolicyFeedRow(value));
        }
        return rows.stream().filter(row -> !isBlank(row.targetValue())).collect(Collectors.toList());
    }

    private String[] splitCsvLine(String line) {
        return line.split("\\s*,\\s*", -1);
    }

    private String csvValue(String[] cols, Map<String, Integer> index, String... keys) {
        for (String key : keys) {
            Integer i = index.get(key);
            if (i != null && i >= 0 && i < cols.length) {
                return trimToNull(cols[i]);
            }
        }
        return null;
    }

    private PolicyFeedRow toPolicyFeedRow(AdminPolicyFeedRuleVO value) {
        if (value == null) {
            return new PolicyFeedRow(null, null, null, null, null, null);
        }
        return new PolicyFeedRow(
                normalizeFeedMatchType(value.getMatchType(), value.getTargetValue()),
                trimToNull(value.getTargetValue()),
                safeUpper(value.getRuleAction(), "BLOCK"),
                firstNonBlank(value.getReason(), "MANUAL_UPLOAD_FEED"),
                value.getDetailMessage(),
                value.getPriority()
        );
    }

    private PolicyFeedRow toPolicyFeedRow(Map<String, Object> value) {
        String targetValue = firstNonBlank(
                stringValue(value.get("targetValue")),
                stringValue(value.get("target_value")),
                stringValue(value.get("value")),
                stringValue(value.get("ip")),
                stringValue(value.get("cidr")),
                stringValue(value.get("country")),
                stringValue(value.get("countryCode")),
                stringValue(value.get("asn"))
        );
        String matchType = firstNonBlank(stringValue(value.get("matchType")), stringValue(value.get("match_type")), stringValue(value.get("type")));
        matchType = normalizeFeedMatchType(matchType, targetValue);
        return new PolicyFeedRow(
                matchType,
                targetValue == null ? null : targetValue.trim(),
                safeUpper(stringValue(value.get("ruleAction")), "BLOCK"),
                firstNonBlank(stringValue(value.get("reason")), "MANUAL_UPLOAD_FEED"),
                stringValue(value.get("detailMessage")),
                parseInteger(value.get("priority"))
        );
    }

    private String normalizeFeedMatchType(String matchType, String targetValue) {
        String normalized = trimToNull(matchType);
        normalized = normalized == null ? null : normalized.toUpperCase();
        if (!isBlank(normalized)) {
            if ("IP".equals(normalized)) return "SINGLE_IP";
            return normalized;
        }
        if (targetValue != null && targetValue.contains("/")) return "CIDR";
        if (targetValue != null && targetValue.matches("(?i)^[A-Z]{2}$")) return "COUNTRY";
        if (targetValue != null && targetValue.matches("(?i)^AS?\\d+$")) return "ASN";
        return "SINGLE_IP";
    }

    private Integer parseInteger(Object value) {
        if (value == null) return null;
        try {
            return Integer.parseInt(String.valueOf(value).trim());
        } catch (Exception e) {
            return null;
        }
    }

    private String stringValue(Object value) {
        return value == null ? null : trimToNull(String.valueOf(value));
    }

    private record PolicyFeedRow(String matchType,
                                 String targetValue,
                                 String ruleAction,
                                 String reason,
                                 String detailMessage,
                                 Integer priority) {
    }

    @Override
    public void updateIpRule(Long ipBlocklistIdx, String ruleAction, String controlMode, String blockCategory,
                             Integer priority, String reason, String detailMessage, LocalDateTime expiresAt, Long actorUserIdx) {
        AdminIpBlockVO rule = requireRule(ipBlocklistIdx);
        AdminIpBlockVO before = snapshot(rule);
        AdminIpBlockBatchVO batch = rule.getIpBlockBatchIdx() != null ? requireBatch(rule.getIpBlockBatchIdx()) : null;
        LocalDateTime now = LocalDateTime.now();

        if (expiresAt != null && !expiresAt.isAfter(now)) {
            throw new IllegalArgumentException("만료 시각은 현재 시각 이후로 설정해주세요.");
        }

        rule.setBlockRequestId(UUID.randomUUID().toString());
        rule.setRuleAction(safeUpper(ruleAction, before.getRuleAction() != null ? before.getRuleAction() : "BLOCK"));
        rule.setControlMode(resolveEditableControlMode(controlMode, batch, before.getControlMode()));
        rule.setBlockCategory(safeUpper(blockCategory, before.getBlockCategory() != null ? before.getBlockCategory() : "MANUAL"));
        rule.setPriority(priority != null && priority > 0 ? priority : before.getPriority());
        rule.setReason(trimToNull(reason));
        rule.setDetailMessage(trimToNull(detailMessage));
        rule.setExpiresAt(expiresAt);
        rule.setLastControlAction("RULE_UPDATED");
        rule.setLastControlByUserIdx(actorUserIdx);
        rule.setLastControlAt(now);

        if ("MANUAL_OVERRIDE".equalsIgnoreCase(rule.getControlMode())) {
            rule.setManualOverrideByUserIdx(actorUserIdx);
            rule.setManualOverrideAt(now);
            rule.setManualOverrideReason("관리자가 정책 규칙을 수동 예외로 조정함");
            rule.setLastControlReason(rule.getManualOverrideReason());
        } else {
            rule.setManualOverrideByUserIdx(null);
            rule.setManualOverrideByNickname(null);
            rule.setManualOverrideAt(null);
            rule.setManualOverrideReason(null);
            rule.setLastControlReason("관리자가 정책 규칙 상세 설정을 수정함");
        }

        boolean beforeBatchActive = before.getIpBlockBatchIdx() == null || Boolean.TRUE.equals(before.getBatchActive());
        boolean afterBatchActive = batch == null || batch.isActive();
        rule.setBatchActive(afterBatchActive);

        applyEffectiveState(rule, evaluateRule(rule, afterBatchActive), "ADMIN", now);
        adminBlockMapper.updateIpBlockRule(rule);
        recordRuleHistory(before, rule, beforeBatchActive, afterBatchActive, "RULE_UPDATED", "ADMIN", null,
                buildIpRuleUpdateReason(before, rule), actorUserIdx);
    }

    @Override
    public void toggleIpRule(Long ipBlocklistIdx, boolean active, Long actorUserIdx) {
        AdminIpBlockVO rule = requireRule(ipBlocklistIdx);
        AdminIpBlockVO before = snapshot(rule);
        LocalDateTime now = LocalDateTime.now();
        boolean batchActive = rule.getIpBlockBatchIdx() == null || Boolean.TRUE.equals(rule.getBatchActive());

        rule.setBlockRequestId(UUID.randomUUID().toString());
        rule.setActive(active);
        rule.setReleasedAt(active ? null : now);
        rule.setReleasedByUserIdx(active ? null : actorUserIdx);
        rule.setLastControlAction(active ? "MANUAL_ENABLE" : "MANUAL_DISABLE");
        rule.setLastControlByUserIdx(actorUserIdx);
        rule.setLastControlAt(now);

        if (rule.getIpBlockBatchIdx() != null) {
            rule.setControlMode("MANUAL_OVERRIDE");
            rule.setManualOverrideByUserIdx(actorUserIdx);
            rule.setManualOverrideAt(now);
            rule.setManualOverrideReason(active ? "관리자가 개별 규칙을 재활성화함" : "관리자가 개별 규칙을 비활성화함");
            rule.setLastControlReason(rule.getManualOverrideReason());
        } else {
            rule.setControlMode("MANUAL");
            rule.setLastControlReason(active ? "관리자가 개별 규칙을 재활성화함" : "관리자가 개별 규칙을 비활성화함");
        }

        applyEffectiveState(rule, evaluateRule(rule, batchActive), "ADMIN", now);
        adminBlockMapper.updateIpBlockRule(rule);

        String historyKind = rule.getIpBlockBatchIdx() != null
                ? (active ? "MANUAL_OVERRIDE_ENABLE" : "MANUAL_OVERRIDE_DISABLE")
                : (active ? "MANUAL_ENABLE" : "MANUAL_DISABLE");
        recordRuleHistory(before, rule, batchActive, batchActive, historyKind, "ADMIN", null, rule.getLastControlReason(), actorUserIdx);
    }

    @Override
    public void returnIpRuleToBatchControl(Long ipBlocklistIdx, Long actorUserIdx) {
        AdminIpBlockVO rule = requireRule(ipBlocklistIdx);
        if (rule.getIpBlockBatchIdx() == null) {
            throw new IllegalArgumentException("배치에 속한 규칙만 배치 제어로 되돌릴 수 있습니다.");
        }

        AdminIpBlockVO before = snapshot(rule);
        AdminIpBlockBatchVO batch = requireBatch(rule.getIpBlockBatchIdx());
        LocalDateTime now = LocalDateTime.now();

        rule.setBlockRequestId(UUID.randomUUID().toString());
        rule.setControlMode("BATCH");
        rule.setActive(true);
        rule.setBatchActive(batch.isActive());
        rule.setManualOverrideByUserIdx(null);
        rule.setManualOverrideByNickname(null);
        rule.setManualOverrideAt(null);
        rule.setManualOverrideReason(null);
        rule.setReleasedAt(null);
        rule.setReleasedByUserIdx(null);
        rule.setLastControlAction("RETURN_TO_BATCH");
        rule.setLastControlByUserIdx(actorUserIdx);
        rule.setLastControlAt(now);
        rule.setLastControlReason("관리자가 규칙을 배치 제어 상태로 복귀");

        applyEffectiveState(rule, evaluateRule(rule, batch.isActive()), "ADMIN", now);
        adminBlockMapper.updateIpBlockRule(rule);
        recordRuleHistory(before, rule, before.getIpBlockBatchIdx() == null || Boolean.TRUE.equals(before.getBatchActive()),
                batch.isActive(), "RETURN_TO_BATCH", "ADMIN", null, rule.getLastControlReason(), actorUserIdx);
    }

    @Override
    public void updateUserBlock(Long blockIdx, boolean active, String reason, LocalDateTime expiresAt, Long actorUserIdx) {
        AdminUserBlockVO current = requireUserBlock(blockIdx);
        AdminUserBlockVO before = snapshot(current);
        LocalDateTime now = LocalDateTime.now();

        if (active && expiresAt != null && !expiresAt.isAfter(now)) {
            throw new IllegalArgumentException("차단 만료 시각은 현재 시각 이후로 설정해주세요.");
        }

        String normalizedReason = trimToNull(reason);
        String controlReason = buildUserBlockControlReason(before, active, normalizedReason, expiresAt);
        String requestId = UUID.randomUUID().toString();

        adminBlockMapper.archiveUserBlockHistoriesByTargetKey(current.getBlockTargetKey(), actorUserIdx);

        AdminBlockHistoryVO history = new AdminBlockHistoryVO();
        history.setBlockRequestId(requestId);
        history.setBlockTargetKey(current.getBlockTargetKey());
        history.setUserBlocklistIdx(current.getBlockIdx());
        history.setRuleAction("BLOCK");
        history.setControlMode("MANUAL");
        history.setOperationSource("ADMIN");
        history.setHistoryKind(active ? "USER_BLOCK_EDIT" : "RELEASE");
        history.setBlockScope("USER_ACTION");
        history.setUserIdx(current.getUserIdx());
        history.setBlockType(current.getBlockType());
        history.setBlockedIp(current.getBlockedIp());
        history.setIpMatchType(current.getBlockedIp() != null && !current.getBlockedIp().isBlank() ? "SINGLE_IP" : null);
        history.setActive(active);
        history.setBeforeRuleIsActive(before.isActive());
        history.setAfterRuleIsActive(active);
        history.setBeforeEffectiveActive(before.isActive());
        history.setAfterEffectiveActive(active);
        history.setBeforeEffectiveStatus(resolveUserBlockEffectiveStatus(before));
        history.setAfterEffectiveStatus(resolveUserBlockEffectiveStatus(active, before.getSnapshotStatus()));
        history.setReason(normalizedReason);
        history.setBlockedByUserIdx(actorUserIdx);
        history.setBlockedAt(now);
        history.setReleasedByUserIdx(active ? null : actorUserIdx);
        history.setReleasedAt(active ? null : now);
        history.setExpiresAt(expiresAt);
        history.setListSyncedAt(now);
        history.setEffectiveResult(active ? "APPLIED" : "SKIPPED_RULE_INACTIVE");
        history.setControlReason(controlReason);
        adminBlockMapper.insertGlobalBlockHistory(history);

        Long historyIdx = adminBlockMapper.findBlockHistoryIdxByRequestId(requestId);
        current.setSourceHistoryBlockIdx(historyIdx);
        current.setBlockRequestId(requestId);
        current.setReason(normalizedReason);
        current.setActive(active);
        current.setExpiresAt(expiresAt);
        current.setLastHistoryAt(now);
        current.setSyncedAt(now);
        current.setUpdatedByUserIdx(actorUserIdx);
        current.setEffectiveActive(active);
        current.setEffectiveStatus(active ? "EFFECTIVE" : "MANUAL_RELEASED");
        current.setEffectiveStatusReason(active ? "관리자 수동 활성화" : "관리자 수동 해제");
        current.setEffectiveSyncedAt(now);
        current.setLastControlAction(active ? "MANUAL_ENABLE" : "RELEASE");
        current.setLastControlByUserIdx(actorUserIdx);
        current.setLastControlAt(now);
        current.setLastControlReason(controlReason);
        current.setControlMode("MANUAL");

        if (active) {
            current.setSnapshotStatus("ACTIVE");
            current.setReleasedAt(null);
            current.setReleasedByUserIdx(null);
            if (!before.isActive()) {
                current.setBlockedAt(now);
                current.setBlockedByUserIdx(actorUserIdx);
            }
        } else {
            current.setSnapshotStatus(resolveInactiveSnapshotStatus(before, now));
            current.setReleasedAt(now);
            current.setReleasedByUserIdx(actorUserIdx);
        }

        adminBlockMapper.updateUserBlockSnapshot(current);

        if (current.getBlockedIp() != null && !current.getBlockedIp().isBlank()) {
            refreshUserActionIpRuleFromHistory(current.getBlockedIp());
        }
        syncMemberBlockState(current.getUserIdx());
    }

    @Override
    public void releaseUserBlock(String blockTargetKey, Long actorUserIdx) {
        AdminUserBlockVO current = adminBlockMapper.findUserBlockByTargetKey(blockTargetKey);
        if (current == null) throw new IllegalArgumentException("현재 차단 상태를 찾을 수 없습니다.");

        adminBlockMapper.updateUserBlocklistActiveByTargetKey(blockTargetKey, false, actorUserIdx, "RELEASED");
        adminBlockMapper.deactivateBlockHistoriesByTargetKey(blockTargetKey, actorUserIdx, "RELEASE");

        if (current.getBlockedIp() != null && !current.getBlockedIp().isBlank()) {
            refreshUserActionIpRuleFromHistory(current.getBlockedIp());
        }
        if (current.getUserIdx() != null && ("USER_ONLY".equals(current.getBlockType()) || "USER_IP".equals(current.getBlockType()))) {
            syncMemberBlockState(current.getUserIdx());
        }
    }

    @Override
    public void bulkReleaseUserBlocks(List<String> blockTargetKeys, Long actorUserIdx) {
        if (blockTargetKeys == null || blockTargetKeys.isEmpty()) return;
        List<String> targetKeys = blockTargetKeys.stream()
                .filter(key -> key != null && !key.isBlank())
                .map(String::trim)
                .distinct()
                .collect(Collectors.toList());
        for (String targetKey : targetKeys) {
            releaseUserBlock(targetKey, actorUserIdx);
        }
    }

    @Override
    public void bulkToggleIpRules(List<Long> ipBlocklistIdxList, boolean active, Long actorUserIdx) {
        if (ipBlocklistIdxList == null || ipBlocklistIdxList.isEmpty()) return;
        List<Long> ids = ipBlocklistIdxList.stream()
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        for (Long id : ids) {
            toggleIpRule(id, active, actorUserIdx);
        }
    }

    @Override
    public Map<String, Object> findCurrentSettingByHistory(Long historyBlockIdx) {
        if (historyBlockIdx == null) {
            throw new IllegalArgumentException("차단 이력 식별자가 필요합니다.");
        }

        AdminBlockHistoryVO history = adminBlockMapper.findBlockHistoryById(historyBlockIdx);
        if (history == null) {
            throw new IllegalArgumentException("차단 이력을 찾을 수 없습니다.");
        }

        String resolvedType = resolveCurrentType(history);
        Map<String, Object> result = new HashMap<>();
        result.put("found", false);
        result.put("currentType", resolvedType);

        if ("BATCH".equals(resolvedType)) {
            if (history.getIpBlockBatchIdx() == null) {
                return result;
            }
            AdminIpBlockBatchVO batch = adminBlockMapper.findIpBlockBatchById(history.getIpBlockBatchIdx());
            if (batch == null) {
                return result;
            }
            result.put("found", true);
            result.put("data", toBatchEditorData(batch));
            return result;
        }

        if ("USER_BLOCK".equals(resolvedType)) {
            AdminUserBlockVO block = history.getUserBlocklistIdx() != null
                    ? adminBlockMapper.findUserBlockById(history.getUserBlocklistIdx())
                    : null;
            if (block == null) {
                block = adminBlockMapper.findCurrentUserBlockByHistoryLink(
                        historyBlockIdx,
                        history.getBlockRequestId(),
                        history.getBlockTargetKey()
                );
            }
            if (block == null) {
                return result;
            }
            result.put("found", true);
            result.put("data", toUserBlockEditorData(block));
            return result;
        }

        AdminIpBlockVO rule = history.getIpBlocklistIdx() != null
                ? adminBlockMapper.findIpBlockById(history.getIpBlocklistIdx())
                : null;
        if (rule == null) {
            rule = adminBlockMapper.findCurrentIpRuleByHistoryLink(
                    historyBlockIdx,
                    history.getBlockRequestId(),
                    history.getBlockTargetKey(),
                    history.getRuleAction(),
                    history.getIpBlockBatchIdx(),
                    history.getBlockScope()
            );
        }
        if (rule == null) {
            return result;
        }
        result.put("found", true);
        result.put("currentType", "IP_RULE");
        result.put("data", toIpRuleEditorData(rule));
        return result;
    }

    private void refreshUserActionIpRuleFromHistory(String ipAddress) {
        if (ipAddress == null || ipAddress.isBlank()) return;
        String normalizedIp = normalizeIp(ipAddress);
        var latest = ipBlockMapper.findLatestActiveHistoryRuleByIp(normalizedIp);
        if (latest == null) {
            ipBlockMapper.deactivateUserActionBlockedIpByTargetKey("IP:" + normalizedIp, null);
            return;
        }
        ipBlockMapper.deactivateUserActionBlockedIpByTargetKey("IP:" + normalizedIp, null);
        ipBlockMapper.upsertBlockedIpWithHistory(
                normalizedIp,
                "IP:" + normalizedIp,
                latest.getReason(),
                latest.getUserIdx(),
                latest.getBlockType(),
                latest.getBlockedByUserIdx(),
                latest.getExpiresAt(),
                latest.getBlockRequestId(),
                latest.getSourceHistoryBlockIdx(),
                latest.getSourceBlocklistIdx(),
                latest.getSourceActionType(),
                latest.getSourceActionGroupId(),
                latest.getSourceUserIdx(),
                latest.getSourceIpAddress()
        );
    }

    private void syncMemberBlockState(Long userIdx) {
        if (userIdx == null) return;
        AdminUserBlockVO latest = adminBlockMapper.findLatestActiveUserBlockByUserIdx(userIdx);
        if (latest == null) {
            adminMapper.clearMemberBlockState(userIdx);
            adminMapper.updateMemberStatus(userIdx, "ACTIVE");
            return;
        }
        adminMapper.markMemberBlocked(userIdx, latest.getExpiresAt(), latest.getReason());
    }

    private void recordRuleHistory(AdminIpBlockVO before,
                                   AdminIpBlockVO after,
                                   boolean beforeBatchActive,
                                   boolean afterBatchActive,
                                   String historyKind,
                                   String operationSource,
                                   Long batchOperationIdx,
                                   String controlReason,
                                   Long actorUserIdx) {
        AdminBlockHistoryVO history = new AdminBlockHistoryVO();
        history.setBlockRequestId(after.getBlockRequestId());
        history.setBlockTargetKey(after.getBlockTargetKey());
        history.setIpBlocklistIdx(after.getIpBlocklistIdx());
        history.setRuleAction(after.getRuleAction());
        history.setControlMode(after.getControlMode());
        history.setOperationSource(operationSource);
        history.setHistoryKind(historyKind);
        history.setBlockScope(after.getSourceScope());
        history.setUserIdx(after.getUserIdx());
        history.setBlockType(after.getBlockType() != null ? after.getBlockType() : "IP_ONLY");
        history.setBlockedIp(after.getIpAddress());
        history.setIpMatchType(after.getMatchType());
        history.setCidrNotation(after.getCidrNotation());
        history.setRangeStartIp(after.getRangeStartIp());
        history.setRangeEndIp(after.getRangeEndIp());
        history.setIpBlockBatchIdx(after.getIpBlockBatchIdx());
        history.setBatchOperationIdx(batchOperationIdx);
        history.setActive(after.isActive());
        history.setBeforeRuleIsActive(before != null ? before.isActive() : null);
        history.setAfterRuleIsActive(after.isActive());
        history.setBeforeBatchIsActive(before != null && before.getIpBlockBatchIdx() != null ? beforeBatchActive : null);
        history.setAfterBatchIsActive(after.getIpBlockBatchIdx() != null ? afterBatchActive : null);
        history.setBeforeEffectiveActive(before != null ? before.isEffectiveActive() : null);
        history.setAfterEffectiveActive(after.isEffectiveActive());
        history.setBeforeEffectiveStatus(before != null ? before.getEffectiveStatus() : null);
        history.setAfterEffectiveStatus(after.getEffectiveStatus());
        history.setReason(after.getReason());
        history.setBlockedByUserIdx(actorUserIdx);
        history.setBlockedAt(LocalDateTime.now());
        history.setReleasedByUserIdx(after.isActive() ? null : actorUserIdx);
        history.setReleasedAt(after.isActive() ? null : LocalDateTime.now());
        history.setExpiresAt(after.getExpiresAt());
        history.setListSyncedAt(LocalDateTime.now());
        history.setEffectiveResult(toEffectiveResult(after));
        history.setControlReason(trimToNull(controlReason));
        adminBlockMapper.insertGlobalBlockHistory(history);
    }

    private String buildIpRuleUpdateReason(AdminIpBlockVO before, AdminIpBlockVO after) {
        List<String> changes = new ArrayList<>();
        if (!Objects.equals(before.getRuleAction(), after.getRuleAction())) {
            changes.add("동작 " + before.getRuleActionLabel() + "→" + after.getRuleActionLabel());
        }
        if (!Objects.equals(before.getControlMode(), after.getControlMode())) {
            changes.add("제어 " + before.getControlModeLabel() + "→" + after.getControlModeLabel());
        }
        if (!Objects.equals(before.getBlockCategory(), after.getBlockCategory())) {
            changes.add("분류 변경");
        }
        if (!Objects.equals(before.getPriority(), after.getPriority())) {
            changes.add("우선순위 " + before.getPriority() + "→" + after.getPriority());
        }
        if (!Objects.equals(trimToNull(before.getReason()), trimToNull(after.getReason()))) {
            changes.add("사유 수정");
        }
        if (!Objects.equals(trimToNull(before.getDetailMessage()), trimToNull(after.getDetailMessage()))) {
            changes.add("상세 메모 수정");
        }
        if (!Objects.equals(before.getExpiresAt(), after.getExpiresAt())) {
            changes.add("만료 시각 변경");
        }
        return changes.isEmpty() ? "관리자가 정책 규칙 상세 설정을 수정함" : String.join(" / ", changes);
    }

    private String buildUserBlockControlReason(AdminUserBlockVO before, boolean active, String reason, LocalDateTime expiresAt) {
        List<String> changes = new ArrayList<>();
        if (before.isActive() != active) {
            changes.add(active ? "차단 재적용" : "차단 해제");
        }
        if (!Objects.equals(trimToNull(before.getReason()), trimToNull(reason))) {
            changes.add("사유 수정");
        }
        if (!Objects.equals(before.getExpiresAt(), expiresAt)) {
            changes.add("만료 시각 변경");
        }
        return changes.isEmpty() ? "관리자가 회원 차단 설정을 수정함" : String.join(" / ", changes);
    }

    private String resolveEditableControlMode(String rawControlMode, AdminIpBlockBatchVO batch, String currentControlMode) {
        if (batch == null) {
            return "MANUAL";
        }
        String fallback = "MANUAL_OVERRIDE".equalsIgnoreCase(currentControlMode) ? "MANUAL_OVERRIDE" : "BATCH";
        String normalized = safeUpper(rawControlMode, fallback);
        if ("MANUAL".equals(normalized)) {
            return "BATCH";
        }
        if (normalized == null || !List.of("BATCH", "MANUAL_OVERRIDE").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 규칙 제어 방식입니다.");
        }
        return normalized;
    }

    private String resolveUserBlockEffectiveStatus(AdminUserBlockVO block) {
        return resolveUserBlockEffectiveStatus(block.isActive(), block.getSnapshotStatus());
    }

    private String resolveUserBlockEffectiveStatus(boolean active, String snapshotStatus) {
        if (active) return "EFFECTIVE";
        if ("EXPIRED".equalsIgnoreCase(snapshotStatus)) return "EXPIRED";
        return "RULE_INACTIVE";
    }

    private String resolveInactiveSnapshotStatus(AdminUserBlockVO before, LocalDateTime now) {
        if ("EXPIRED".equalsIgnoreCase(before.getSnapshotStatus())) {
            return "EXPIRED";
        }
        if (before.getExpiresAt() != null && !before.getExpiresAt().isAfter(now)) {
            return "EXPIRED";
        }
        return "RELEASED";
    }

    private EffectiveState evaluateRule(AdminIpBlockVO rule, boolean batchActive) {
        if (!rule.isActive()) {
            return new EffectiveState(false, "RULE_INACTIVE", "관리자가 개별 규칙을 비활성화했습니다.");
        }
        if (rule.getExpiresAt() != null && !rule.getExpiresAt().isAfter(LocalDateTime.now())) {
            return new EffectiveState(false, "EXPIRED", "규칙 만료 시각이 지나 현재 평가 대상이 아닙니다.");
        }
        boolean controlledByBatch = rule.getIpBlockBatchIdx() != null && "BATCH".equalsIgnoreCase(rule.getControlMode());
        if (controlledByBatch && !batchActive) {
            return new EffectiveState(false, "BATCH_INACTIVE", "배치가 비활성화되어 현재 평가 대상이 아닙니다.");
        }
        return new EffectiveState(true, "EFFECTIVE", "현재 평가 대상입니다.");
    }

    private void applyEffectiveState(AdminIpBlockVO rule, EffectiveState state, String syncedBySource, LocalDateTime syncedAt) {
        rule.setEffectiveActive(state.effectiveActive());
        rule.setEffectiveStatus(state.effectiveStatus());
        rule.setEffectiveStatusReason(state.effectiveStatusReason());
        rule.setEffectiveSyncedAt(syncedAt);
        rule.setEffectiveSyncedBySource(syncedBySource);
    }

    private String toEffectiveResult(AdminIpBlockVO rule) {
        if (rule.isEffectiveActive()) return "APPLIED";
        if ("BATCH_INACTIVE".equals(rule.getEffectiveStatus())) return "SKIPPED_BATCH_OFF";
        if ("EXPIRED".equals(rule.getEffectiveStatus())) return "SKIPPED_EXPIRED";
        if ("MANUAL_OVERRIDE".equalsIgnoreCase(rule.getControlMode())) return "OVERRIDDEN";
        return "SKIPPED_RULE_INACTIVE";
    }

    private boolean hasBeenChangedAfter(AdminIpBlockVO rule, LocalDateTime referenceTime) {
        return referenceTime != null && rule.getLastControlAt() != null && rule.getLastControlAt().isAfter(referenceTime);
    }

    private AdminIpBlockVO requireRule(Long ipBlocklistIdx) {
        AdminIpBlockVO rule = adminBlockMapper.findIpBlockById(ipBlocklistIdx);
        if (rule == null) throw new IllegalArgumentException("IP 정책 규칙을 찾을 수 없습니다.");
        return rule;
    }

    private AdminIpBlockBatchVO requireBatch(Long ipBlockBatchIdx) {
        AdminIpBlockBatchVO batch = adminBlockMapper.findIpBlockBatchById(ipBlockBatchIdx);
        if (batch == null) throw new IllegalArgumentException("IP 배치를 찾을 수 없습니다.");
        return batch;
    }

    private AdminUserBlockVO requireUserBlock(Long blockIdx) {
        AdminUserBlockVO block = adminBlockMapper.findUserBlockById(blockIdx);
        if (block == null) throw new IllegalArgumentException("회원 차단 상태를 찾을 수 없습니다.");
        return block;
    }

    private AdminIpBlockVO snapshot(AdminIpBlockVO source) {
        AdminIpBlockVO copy = new AdminIpBlockVO();
        BeanUtils.copyProperties(source, copy);
        return copy;
    }

    private AdminUserBlockVO snapshot(AdminUserBlockVO source) {
        AdminUserBlockVO copy = new AdminUserBlockVO();
        BeanUtils.copyProperties(source, copy);
        return copy;
    }

    private String resolveCurrentType(AdminBlockHistoryVO history) {
        if (history == null) return "IP_RULE";
        if ("USER_ACTION".equalsIgnoreCase(history.getBlockScope())) return "USER_BLOCK";
        if (history.getBatchOperationIdx() != null && history.getIpBlockBatchIdx() != null) return "BATCH";
        return "IP_RULE";
    }

    private Map<String, Object> toUserBlockEditorData(AdminUserBlockVO block) {
        Map<String, Object> data = new HashMap<>();
        data.put("blockIdx", toStringValue(block.getBlockIdx()));
        data.put("userIdx", toStringValue(block.getUserIdx()));
        data.put("displayName", emptyFallback(firstNonBlank(block.getNickname(), block.getUserId()), "-"));
        data.put("userId", emptyFallback(block.getUserId(), ""));
        data.put("userEmail", emptyFallback(block.getUserEmail(), ""));
        data.put("blockType", emptyFallback(block.getBlockType(), "-"));
        data.put("blockedIp", emptyFallback(block.getBlockedIp(), ""));
        data.put("targetKey", emptyFallback(block.getBlockTargetKey(), ""));
        data.put("active", Boolean.toString(block.isActive()));
        data.put("snapshotStatus", emptyFallback(block.getSnapshotStatus(), "-"));
        data.put("reason", emptyFallback(block.getReason(), ""));
        data.put("expiresAt", block.getExpiresAtInputValue());
        data.put("blockedAt", formatDisplayDateTime(block.getBlockedAt(), "-"));
        data.put("lastHistoryAt", formatDisplayDateTime(block.getLastHistoryAt(), "-"));
        data.put("syncAt", formatDisplayDateTime(block.getSyncedAt(), "-"));
        return data;
    }

    private Map<String, Object> toIpRuleEditorData(AdminIpBlockVO rule) {
        Map<String, Object> data = new HashMap<>();
        data.put("id", toStringValue(rule.getIpBlocklistIdx()));
        data.put("targetDisplay", emptyFallback(firstNonBlank(rule.getTargetDisplayValue(), rule.getBlockTargetKey()), "-"));
        data.put("targetKey", emptyFallback(rule.getBlockTargetKey(), ""));
        data.put("ruleAction", emptyFallback(rule.getRuleAction(), "BLOCK"));
        data.put("controlMode", emptyFallback(rule.getControlMode(), "MANUAL"));
        data.put("blockCategory", emptyFallback(rule.getBlockCategory(), "MANUAL"));
        data.put("priority", Integer.toString(rule.getPriority()));
        data.put("reason", emptyFallback(rule.getReason(), ""));
        data.put("detailMessage", emptyFallback(rule.getDetailMessage(), ""));
        data.put("expiresAt", rule.getExpiresAtInputValue());
        data.put("effectiveStatusLabel", emptyFallback(rule.getEffectiveStatusLabel(), "-"));
        data.put("finalStateLabel", emptyFallback(rule.getFinalStateLabel(), "-"));
        data.put("ruleStateLabel", emptyFallback(rule.getRuleStateLabel(), "-"));
        data.put("batchStatusLabel", emptyFallback(rule.getBatchStatusLabel(), "-"));
        data.put("batchName", emptyFallback(rule.getBatchName(), "개별 규칙"));
        data.put("batchCode", emptyFallback(rule.getBatchCode(), ""));
        data.put("batchId", toStringValue(rule.getIpBlockBatchIdx()));
        data.put("blockedAt", formatDisplayDateTime(rule.getBlockedAt(), "-"));
        data.put("expiresDisplay", formatDisplayDateTime(rule.getExpiresAt(), "없음"));
        data.put("active", Boolean.toString(rule.isActive()));
        return data;
    }

    private Map<String, Object> toBatchEditorData(AdminIpBlockBatchVO batch) {
        Map<String, Object> data = new HashMap<>();
        data.put("batchId", toStringValue(batch.getIpBlockBatchIdx()));
        data.put("batchCode", emptyFallback(batch.getBatchCode(), ""));
        data.put("batchName", emptyFallback(batch.getBatchName(), ""));
        data.put("sourceType", emptyFallback(batch.getSourceType(), "MANUAL"));
        data.put("sourceName", emptyFallback(batch.getSourceName(), ""));
        data.put("batchRuleAction", emptyFallback(batch.getBatchRuleAction(), "BLOCK"));
        data.put("defaultPriority", Integer.toString(batch.getDefaultRulePriority() != null ? batch.getDefaultRulePriority() : 1));
        data.put("defaultDisableStrategy", emptyFallback(batch.getDefaultDisableStrategy(), "BATCH_ONLY"));
        data.put("defaultEnableStrategy", emptyFallback(batch.getDefaultEnableStrategy(), "BATCH_ONLY"));
        data.put("description", emptyFallback(batch.getDescription(), ""));
        data.put("statusLabel", emptyFallback(batch.getActiveLabel(), "-"));
        data.put("createdAt", formatDisplayDateTime(batch.getCreatedAt(), "-"));
        data.put("updatedAt", formatDisplayDateTime(batch.getUpdatedAt(), "-"));
        data.put("totalRules", Long.toString(batch.getTotalRuleCount()));
        data.put("activeRules", Long.toString(batch.getActiveRuleCount()));
        data.put("effectiveRules", Long.toString(batch.getEffectiveRuleCount()));
        data.put("expiredRules", Long.toString(batch.getExpiredRuleCount()));
        return data;
    }

    private String formatDisplayDateTime(LocalDateTime value, String fallback) {
        return value == null ? fallback : value.format(DISPLAY_DATE_TIME_FORMATTER);
    }

    private String toStringValue(Object value) {
        return value == null ? "" : String.valueOf(value);
    }

    private String firstNonBlank(String... values) {
        if (values == null) return null;
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value;
            }
        }
        return null;
    }

    private String emptyFallback(String value, String fallback) {
        return value == null || value.isBlank() ? fallback : value;
    }

    private String normalizeIp(String ip) {
        if (ip == null) return null;
        String trimmed = ip.trim();
        if (trimmed.isBlank()) return null;
        if ("0:0:0:0:0:0:0:1".equals(trimmed) || "::1".equals(trimmed)) return "127.0.0.1";
        if (trimmed.startsWith("::ffff:")) return trimmed.substring(7);
        return trimmed;
    }

    private String resolveControlMode(String rawControlMode, Long ipBlockBatchIdx) {
        if (ipBlockBatchIdx == null) {
            return "MANUAL";
        }
        String normalized = safeUpper(rawControlMode, "BATCH");
        if (normalized == null || !List.of("MANUAL", "BATCH", "MANUAL_OVERRIDE").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 제어 모드입니다.");
        }
        if ("MANUAL_OVERRIDE".equals(normalized) && ipBlockBatchIdx == null) {
            throw new IllegalArgumentException("수동 예외는 배치 규칙에서만 사용할 수 있습니다.");
        }
        return normalized;
    }

    private String resolveBatchOperationOption(AdminIpBlockBatchVO batch, boolean active, String requested) {
        String defaultValue = active ? batch.getDefaultEnableStrategy() : batch.getDefaultDisableStrategy();
        String normalized = safeUpper(requested, defaultValue);
        if (active && (normalized == null || !List.of("BATCH_ONLY", "RESTORE_BATCH_CONTROL", "FORCE_ENABLE_ALL").contains(normalized))) {
            throw new IllegalArgumentException("지원하지 않는 배치 활성화 옵션입니다.");
        }
        if (!active && (normalized == null || !List.of("BATCH_ONLY", "CASCADE_ACTIVE_RULES").contains(normalized))) {
            throw new IllegalArgumentException("지원하지 않는 배치 비활성화 옵션입니다.");
        }
        return normalized;
    }

    private String resolveBatchDisableStrategy(String value) {
        String normalized = safeUpper(value, "BATCH_ONLY");
        if (normalized == null || !List.of("BATCH_ONLY", "CASCADE_ACTIVE_RULES").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 배치 OFF 기본 전략입니다.");
        }
        return normalized;
    }

    private String resolveBatchEnableStrategy(String value) {
        String normalized = safeUpper(value, "BATCH_ONLY");
        if (normalized == null || !List.of("BATCH_ONLY", "RESTORE_BATCH_CONTROL", "FORCE_ENABLE_ALL").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 배치 ON 기본 전략입니다.");
        }
        return normalized;
    }

    private static String trimToNull(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private static String safeUpper(String value, String fallback) {
        String base = isBlank(value) ? fallback : value.trim();
        return base.toUpperCase();
    }

    private record EffectiveState(boolean effectiveActive, String effectiveStatus, String effectiveStatusReason) {
    }
}
