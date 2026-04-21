package org.triptogether.admin.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminSystemPolicyHistoryVO;
import org.triptogether.admin.vo.AdminSystemPolicyVO;
import org.triptogether.auth.service.AuthService;
import org.triptogether.reward.service.RewardService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminPolicyServiceImpl implements AdminPolicyService {

    private static final String POLICY_DORMANT = "DORMANT_ACCOUNT_POLICY";
    private static final String POLICY_LEVEL_SETTLEMENT = "MEMBER_LEVEL_SETTLEMENT_POLICY";

    private final AdminMapper adminMapper;
    private final AuthService authService;
    private final RewardService rewardService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public Map<String, Object> getPolicyDashboard() {
        List<AdminSystemPolicyVO> policies = adminMapper.findSystemPolicies();
        Map<String, List<AdminSystemPolicyVO>> groupedPolicies = new LinkedHashMap<>();
        Map<String, List<AdminSystemPolicyHistoryVO>> historyMap = new HashMap<>();
        for (AdminSystemPolicyVO policy : policies) {
            groupedPolicies.computeIfAbsent(policy.getPolicyGroup(), key -> new java.util.ArrayList<>()).add(policy);
            historyMap.put(policy.getPolicyCode(), adminMapper.findSystemPolicyHistories(policy.getPolicyCode(), 8));
        }

        Map<String, Object> result = new HashMap<>();
        result.put("policies", policies);
        result.put("policyGroups", groupedPolicies);
        result.put("policyHistories", historyMap);
        return result;
    }

    @Override
    public AdminSystemPolicyVO getPolicy(String policyCode) {
        return adminMapper.findSystemPolicy(policyCode);
    }

    @Override
    @Transactional
    public void updatePolicy(String policyCode,
                             String configJson,
                             String scheduleType,
                             Integer scheduleIntervalHours,
                             Integer scheduleDayOfMonth,
                             String scheduleTime,
                             boolean active,
                             Long actorUserIdx) {
        AdminSystemPolicyVO current = requirePolicy(policyCode);
        AdminSystemPolicyVO update = copyPolicy(current);
        update.setConfigJson(normalizeConfigJson(configJson));
        update.setScheduleType(normalizeScheduleType(scheduleType));
        update.setScheduleIntervalHours(normalizeIntervalHours(update.getScheduleType(), scheduleIntervalHours));
        update.setScheduleDayOfMonth(normalizeDayOfMonth(update.getScheduleType(), scheduleDayOfMonth));
        update.setScheduleTime(normalizeScheduleTime(update.getScheduleType(), scheduleTime));
        update.setActive(active);
        update.setNextExecuteAt(resolveNextExecuteAt(update, LocalDateTime.now()));
        update.setUpdatedByUserIdx(actorUserIdx);

        adminMapper.updateSystemPolicy(update);
        adminMapper.insertSystemPolicyHistory(buildChangeHistory(current, update, "UPDATE", null, null, actorUserIdx));
    }

    @Override
    @Transactional
    public void runPolicyNow(String policyCode, Long actorUserIdx) {
        AdminSystemPolicyVO policy = requirePolicy(policyCode);
        runPolicyInternal(policy, actorUserIdx, true);
    }

    @Override
    @Transactional
    public void processDuePolicies() {
        List<AdminSystemPolicyVO> duePolicies = adminMapper.findDueSystemPolicies();
        for (AdminSystemPolicyVO policy : duePolicies) {
            try {
                runPolicyInternal(policy, null, false);
            } catch (Exception e) {
                log.error("[AdminPolicyService] 정책 실행 실패. code={}", policy.getPolicyCode(), e);
            }
        }
    }

    private void runPolicyInternal(AdminSystemPolicyVO policy, Long actorUserIdx, boolean manualRun) {
        AdminSystemPolicyVO before = requirePolicy(policy.getPolicyCode());
        LocalDateTime now = LocalDateTime.now();
        String executionStatus = "SUCCESS";
        String executionMessage = null;
        try {
            executionMessage = executePolicy(policy);
        } catch (Exception e) {
            executionStatus = "FAIL";
            executionMessage = trimMessage(e.getMessage() == null ? e.getClass().getSimpleName() : e.getMessage());
            throw e;
        } finally {
            LocalDateTime nextExecuteAt = manualRun
                    ? resolveNextExecuteAt(before, now)
                    : resolveNextExecuteAt(policy, now);
            adminMapper.updateSystemPolicyExecution(policy.getPolicyCode(), now, nextExecuteAt, executionStatus, executionMessage);
            AdminSystemPolicyVO after = requirePolicy(policy.getPolicyCode());
            adminMapper.insertSystemPolicyHistory(buildChangeHistory(
                    before,
                    after,
                    manualRun ? "MANUAL_RUN" : "EXECUTE",
                    executionStatus,
                    executionMessage,
                    actorUserIdx
            ));
        }
    }

    private String executePolicy(AdminSystemPolicyVO policy) {
        Map<String, Object> config = readConfig(policy.getConfigJson());
        if (POLICY_DORMANT.equals(policy.getPolicyCode())) {
            int inactiveDays = readInt(config, "inactiveDays", 365);
            authService.processDormantAccounts(inactiveDays);
            return "휴면 계정 정책을 실행했습니다. 기준: " + inactiveDays + "일";
        }
        if (POLICY_LEVEL_SETTLEMENT.equals(policy.getPolicyCode())) {
            boolean onlyActiveMembers = readBoolean(config, "onlyActiveMembers", true);
            int changedCount = rewardService.synchronizeUserLevels(onlyActiveMembers);
            return "회원 레벨 정산을 실행했습니다. 변경된 회원: " + changedCount + "명";
        }
        return "정책 실행 대상이 정의되지 않았습니다.";
    }

    private AdminSystemPolicyVO requirePolicy(String policyCode) {
        AdminSystemPolicyVO policy = adminMapper.findSystemPolicy(policyCode);
        if (policy == null) {
            throw new IllegalArgumentException("정책 정보를 찾을 수 없습니다: " + policyCode);
        }
        return policy;
    }

    private AdminSystemPolicyVO copyPolicy(AdminSystemPolicyVO source) {
        AdminSystemPolicyVO copy = new AdminSystemPolicyVO();
        copy.setPolicyCode(source.getPolicyCode());
        copy.setPolicyName(source.getPolicyName());
        copy.setPolicyGroup(source.getPolicyGroup());
        copy.setConfigJson(source.getConfigJson());
        copy.setScheduleType(source.getScheduleType());
        copy.setScheduleIntervalHours(source.getScheduleIntervalHours());
        copy.setScheduleDayOfMonth(source.getScheduleDayOfMonth());
        copy.setScheduleTime(source.getScheduleTime());
        copy.setActive(source.isActive());
        copy.setLastExecutedAt(source.getLastExecutedAt());
        copy.setNextExecuteAt(source.getNextExecuteAt());
        copy.setLastExecutionStatus(source.getLastExecutionStatus());
        copy.setLastExecutionMessage(source.getLastExecutionMessage());
        copy.setCreatedByUserIdx(source.getCreatedByUserIdx());
        copy.setUpdatedByUserIdx(source.getUpdatedByUserIdx());
        copy.setCreatedAt(source.getCreatedAt());
        copy.setUpdatedAt(source.getUpdatedAt());
        return copy;
    }

    private AdminSystemPolicyHistoryVO buildChangeHistory(AdminSystemPolicyVO before,
                                                          AdminSystemPolicyVO after,
                                                          String changeType,
                                                          String executionStatus,
                                                          String executionMessage,
                                                          Long actorUserIdx) {
        AdminSystemPolicyHistoryVO history = new AdminSystemPolicyHistoryVO();
        history.setPolicyCode(after.getPolicyCode());
        history.setChangeType(changeType);
        history.setBeforeConfigJson(before.getConfigJson());
        history.setAfterConfigJson(after.getConfigJson());
        history.setBeforeScheduleType(before.getScheduleType());
        history.setAfterScheduleType(after.getScheduleType());
        history.setBeforeScheduleIntervalHours(before.getScheduleIntervalHours());
        history.setAfterScheduleIntervalHours(after.getScheduleIntervalHours());
        history.setBeforeScheduleDayOfMonth(before.getScheduleDayOfMonth());
        history.setAfterScheduleDayOfMonth(after.getScheduleDayOfMonth());
        history.setBeforeScheduleTime(before.getScheduleTime());
        history.setAfterScheduleTime(after.getScheduleTime());
        history.setBeforeActive(before.isActive());
        history.setAfterActive(after.isActive());
        history.setExecutionStatus(executionStatus);
        history.setExecutionMessage(trimMessage(executionMessage));
        history.setChangedByUserIdx(actorUserIdx);
        return history;
    }

    private String normalizeConfigJson(String configJson) {
        Map<String, Object> parsed = readConfig(configJson);
        try {
            return objectMapper.writeValueAsString(parsed);
        } catch (Exception e) {
            throw new IllegalArgumentException("정책 설정 JSON을 저장할 수 없습니다.");
        }
    }

    private Map<String, Object> readConfig(String configJson) {
        try {
            if (configJson == null || configJson.isBlank()) {
                return new LinkedHashMap<>();
            }
            return objectMapper.readValue(configJson, new TypeReference<>() {});
        } catch (Exception e) {
            throw new IllegalArgumentException("정책 설정 JSON 형식이 올바르지 않습니다.");
        }
    }

    private String normalizeScheduleType(String scheduleType) {
        String value = scheduleType == null ? "MANUAL" : scheduleType.trim().toUpperCase();
        return switch (value) {
            case "DAILY_TIME", "INTERVAL_HOURS", "MONTHLY_DAY_TIME", "MANUAL" -> value;
            default -> throw new IllegalArgumentException("지원하지 않는 실행 방식입니다.");
        };
    }

    private Integer normalizeIntervalHours(String scheduleType, Integer scheduleIntervalHours) {
        if (!"INTERVAL_HOURS".equals(scheduleType)) {
            return null;
        }
        if (scheduleIntervalHours == null || scheduleIntervalHours < 1) {
            throw new IllegalArgumentException("간격 실행 시간은 1시간 이상이어야 합니다.");
        }
        return scheduleIntervalHours;
    }

    private Integer normalizeDayOfMonth(String scheduleType, Integer scheduleDayOfMonth) {
        if (!"MONTHLY_DAY_TIME".equals(scheduleType)) {
            return null;
        }
        if (scheduleDayOfMonth == null || scheduleDayOfMonth < 1 || scheduleDayOfMonth > 28) {
            throw new IllegalArgumentException("월간 실행 일자는 1~28일 사이로 입력해주세요.");
        }
        return scheduleDayOfMonth;
    }

    private String normalizeScheduleTime(String scheduleType, String scheduleTime) {
        if ("MANUAL".equals(scheduleType)) {
            return null;
        }
        if (scheduleTime == null || scheduleTime.isBlank()) {
            throw new IllegalArgumentException("실행 시각을 입력해주세요.");
        }
        try {
            return LocalTime.parse(scheduleTime.trim()).toString().substring(0, 5);
        } catch (Exception e) {
            throw new IllegalArgumentException("실행 시각 형식이 올바르지 않습니다. (HH:mm)");
        }
    }

    private LocalDateTime resolveNextExecuteAt(AdminSystemPolicyVO policy, LocalDateTime baseTime) {
        if (!policy.isActive() || "MANUAL".equals(policy.getScheduleType())) {
            return null;
        }
        return switch (policy.getScheduleType()) {
            case "DAILY_TIME" -> nextDaily(baseTime, policy.getScheduleTime());
            case "INTERVAL_HOURS" -> baseTime.plusHours(policy.getScheduleIntervalHours() == null ? 24 : policy.getScheduleIntervalHours());
            case "MONTHLY_DAY_TIME" -> nextMonthly(baseTime, policy.getScheduleDayOfMonth(), policy.getScheduleTime());
            default -> null;
        };
    }

    private LocalDateTime nextDaily(LocalDateTime baseTime, String scheduleTime) {
        LocalTime time = LocalTime.parse(scheduleTime);
        LocalDateTime candidate = LocalDate.now().atTime(time);
        if (!candidate.isAfter(baseTime)) {
            candidate = candidate.plusDays(1);
        }
        return candidate;
    }

    private LocalDateTime nextMonthly(LocalDateTime baseTime, Integer dayOfMonth, String scheduleTime) {
        int resolvedDay = dayOfMonth == null ? 1 : Math.max(1, Math.min(dayOfMonth, 28));
        LocalTime time = LocalTime.parse(scheduleTime);
        YearMonth currentMonth = YearMonth.from(baseTime);
        LocalDateTime candidate = currentMonth.atDay(Math.min(resolvedDay, currentMonth.lengthOfMonth())).atTime(time);
        if (!candidate.isAfter(baseTime)) {
            YearMonth nextMonth = currentMonth.plusMonths(1);
            candidate = nextMonth.atDay(Math.min(resolvedDay, nextMonth.lengthOfMonth())).atTime(time);
        }
        return candidate;
    }

    private int readInt(Map<String, Object> config, String key, int defaultValue) {
        Object value = config.get(key);
        if (value instanceof Number number) {
            return number.intValue();
        }
        if (value instanceof String text && !text.isBlank()) {
            return Integer.parseInt(text.trim());
        }
        return defaultValue;
    }

    private boolean readBoolean(Map<String, Object> config, String key, boolean defaultValue) {
        Object value = config.get(key);
        if (value instanceof Boolean bool) {
            return bool;
        }
        if (value instanceof String text && !text.isBlank()) {
            return Boolean.parseBoolean(text.trim());
        }
        return defaultValue;
    }

    private String trimMessage(String message) {
        if (message == null) {
            return null;
        }
        String trimmed = message.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        return trimmed.length() > 500 ? trimmed.substring(0, 500) : trimmed;
    }
}
