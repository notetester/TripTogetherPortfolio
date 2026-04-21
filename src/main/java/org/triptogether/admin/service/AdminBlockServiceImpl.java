package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminBlockMapper;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminBlockHistoryVO;
import org.triptogether.admin.vo.AdminBlockSearchVO;
import org.triptogether.admin.vo.AdminIpBlockBatchOperationRuleVO;
import org.triptogether.admin.vo.AdminIpBlockBatchOperationVO;
import org.triptogether.admin.vo.AdminIpBlockBatchVO;
import org.triptogether.admin.vo.AdminIpBlockVO;
import org.triptogether.admin.vo.AdminUserBlockVO;
import org.triptogether.config.IpBlockMapper;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminBlockServiceImpl implements AdminBlockService {

    private final AdminBlockMapper adminBlockMapper;
    private final AdminMapper adminMapper;
    private final IpBlockMapper ipBlockMapper;

    @Override
    public Map<String, Object> getBlockDashboard(AdminBlockSearchVO search) {
        Map<String, Object> result = new HashMap<>();
        result.put("search", search);
        result.put("activeUserBlockCount", adminBlockMapper.countActiveUserBlocks());
        result.put("activeIpBlockCount", adminBlockMapper.countActiveIpBlocks());
        result.put("blockHistoryCount", adminBlockMapper.countBlockHistories());
        result.put("activeBatchCount", adminBlockMapper.countActiveBatches());
        result.put("userBlocks", adminBlockMapper.findUserBlocks(search));
        result.put("ipBlocks", adminBlockMapper.findIpBlocks(search));
        result.put("histories", adminBlockMapper.findBlockHistories(search));
        result.put("batches", adminBlockMapper.findIpBlockBatches(search));
        result.put("batchOperations", adminBlockMapper.findRecentBatchOperations(search));
        return result;
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
    public void releaseUserBlock(String blockTargetKey, Long actorUserIdx) {
        AdminUserBlockVO current = adminBlockMapper.findUserBlockByTargetKey(blockTargetKey);
        if (current == null) throw new IllegalArgumentException("현재 차단 상태를 찾을 수 없습니다.");

        adminBlockMapper.updateUserBlocklistActiveByTargetKey(blockTargetKey, false, actorUserIdx, "RELEASED");
        adminBlockMapper.deactivateBlockHistoriesByTargetKey(blockTargetKey, actorUserIdx, "RELEASE");

        if (current.getBlockedIp() != null && !current.getBlockedIp().isBlank()) {
            refreshUserActionIpRuleFromHistory(current.getBlockedIp());
        }
        if (current.getUserIdx() != null && ("USER_ONLY".equals(current.getBlockType()) || "USER_IP".equals(current.getBlockType()))) {
            long remain = adminBlockMapper.countOtherActiveUserBlocks(current.getUserIdx(), blockTargetKey);
            if (remain == 0) {
                adminMapper.clearMemberBlockState(current.getUserIdx());
                adminMapper.updateMemberStatus(current.getUserIdx(), "ACTIVE");
            }
        }
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
                latest.getSourceBlocklistIdx()
        );
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

    private AdminIpBlockVO snapshot(AdminIpBlockVO source) {
        AdminIpBlockVO copy = new AdminIpBlockVO();
        BeanUtils.copyProperties(source, copy);
        return copy;
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
        if (!List.of("MANUAL", "BATCH", "MANUAL_OVERRIDE").contains(normalized)) {
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
        if (active && !List.of("BATCH_ONLY", "RESTORE_BATCH_CONTROL", "FORCE_ENABLE_ALL").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 배치 활성화 옵션입니다.");
        }
        if (!active && !List.of("BATCH_ONLY", "CASCADE_ACTIVE_RULES").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 배치 비활성화 옵션입니다.");
        }
        return normalized;
    }

    private String resolveBatchDisableStrategy(String value) {
        String normalized = safeUpper(value, "BATCH_ONLY");
        if (!List.of("BATCH_ONLY", "CASCADE_ACTIVE_RULES").contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 배치 OFF 기본 전략입니다.");
        }
        return normalized;
    }

    private String resolveBatchEnableStrategy(String value) {
        String normalized = safeUpper(value, "BATCH_ONLY");
        if (!List.of("BATCH_ONLY", "RESTORE_BATCH_CONTROL", "FORCE_ENABLE_ALL").contains(normalized)) {
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
