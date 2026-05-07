package org.triptogether.admin.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminSystemPolicyVO;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.SecurityAppealPolicyVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.config.RuntimeSettingService;
import org.triptogether.config.RuntimeSettingVO;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class InitialSettingsService {

    private static final List<String> SECTION_KEYS = List.of(
            "runtimeSettings",
            "providerConfigs",
            "loginRiskPolicies",
            "securityAppealPolicy",
            "systemPolicies"
    );

    private final ObjectMapper objectMapper;
    private final AdminMapper adminMapper;
    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final LoginRiskPolicyService loginRiskPolicyService;
    private final RuntimeSettingService runtimeSettingService;
    private final AdminPolicyService adminPolicyService;

    public Map<String, Object> exportSettings() {
        return exportSettings(SECTION_KEYS);
    }

    public Map<String, Object> exportSettings(Collection<String> sections) {
        Set<String> selected = normalizeSections(sections);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("schemaVersion", 1);
        result.put("exportedAt", LocalDateTime.now().toString());
        result.put("sections", selected);
        if (selected.contains("runtimeSettings")) {
            result.put("runtimeSettings", runtimeSettingService.getRuntimeSettings(null, null, true));
        }
        if (selected.contains("providerConfigs")) {
            result.put("providerConfigs", loginRiskPolicyService.getProviderConfigs());
        }
        if (selected.contains("loginRiskPolicies")) {
            result.put("loginRiskPolicies", loginRiskPolicyService.getPolicies(true));
        }
        if (selected.contains("securityAppealPolicy")) {
            result.put("securityAppealPolicy", loginRiskPolicyService.getSecurityAppealPolicy());
        }
        if (selected.contains("systemPolicies")) {
            result.put("systemPolicies", adminMapper.findSystemPolicies());
        }
        return result;
    }

    public Map<String, Integer> exportSummary() {
        Map<String, Integer> summary = new LinkedHashMap<>();
        summary.put("runtimeSettings", runtimeSettingService.getRuntimeSettings(null, null, true).size());
        summary.put("providerConfigs", loginRiskPolicyService.getProviderConfigs().size());
        summary.put("loginRiskPolicies", loginRiskPolicyService.getPolicies(true).size());
        summary.put("securityAppealPolicy", loginRiskPolicyService.getSecurityAppealPolicy() == null ? 0 : 1);
        summary.put("systemPolicies", adminMapper.findSystemPolicies().size());
        return summary;
    }

    @Transactional
    @SuppressWarnings("unchecked")
    public ImportResult importSettings(Map<String, Object> payload, Long actorUserIdx) {
        ImportResult result = new ImportResult();

        List<Map<String, Object>> runtimeSettings = list(payload.get("runtimeSettings"));
        for (Map<String, Object> item : runtimeSettings) {
            RuntimeSettingVO setting = objectMapper.convertValue(sanitized(item), RuntimeSettingVO.class);
            setting.setSettingIdx(null);
            runtimeSettingService.saveRuntimeSetting(setting, actorUserIdx);
            result.runtimeSettings++;
        }

        List<Map<String, Object>> providerConfigs = list(payload.get("providerConfigs"));
        for (Map<String, Object> item : providerConfigs) {
            SecurityAssessmentProviderConfigVO imported = objectMapper.convertValue(sanitized(item), SecurityAssessmentProviderConfigVO.class);
            SecurityAssessmentProviderConfigVO current = loginRiskPolicyMapper.findProviderConfigByCode(imported.getProviderCode());
            if (current == null) {
                result.skipped++;
                result.skippedMessages.add("providerConfig:" + imported.getProviderCode());
                continue;
            }
            imported.setProviderIdx(current.getProviderIdx());
            loginRiskPolicyService.updateProviderConfig(imported, actorUserIdx);
            result.providerConfigs++;
        }

        List<Map<String, Object>> loginRiskPolicies = list(payload.get("loginRiskPolicies"));
        for (Map<String, Object> item : loginRiskPolicies) {
            LoginRiskPolicyVO imported = objectMapper.convertValue(sanitized(item), LoginRiskPolicyVO.class);
            LoginRiskPolicyVO current = loginRiskPolicyMapper.findPolicyByCode(imported.getPolicyCode());
            if (current == null) {
                result.skipped++;
                result.skippedMessages.add("loginRiskPolicy:" + imported.getPolicyCode());
                continue;
            }
            imported.setPolicyIdx(current.getPolicyIdx());
            loginRiskPolicyService.updatePolicy(imported, actorUserIdx);
            result.loginRiskPolicies++;
        }

        Object appeal = payload.get("securityAppealPolicy");
        if (appeal instanceof Map<?, ?> appealMap) {
            SecurityAppealPolicyVO imported = objectMapper.convertValue(sanitized((Map<String, Object>) appealMap), SecurityAppealPolicyVO.class);
            loginRiskPolicyService.updateSecurityAppealPolicy(imported, actorUserIdx);
            result.securityAppealPolicy = 1;
        }

        List<Map<String, Object>> systemPolicies = list(payload.get("systemPolicies"));
        for (Map<String, Object> item : systemPolicies) {
            AdminSystemPolicyVO imported = objectMapper.convertValue(sanitized(item), AdminSystemPolicyVO.class);
            AdminSystemPolicyVO current = adminMapper.findSystemPolicy(imported.getPolicyCode());
            if (current == null) {
                result.skipped++;
                result.skippedMessages.add("systemPolicy:" + imported.getPolicyCode());
                continue;
            }
            adminPolicyService.updatePolicy(
                    imported.getPolicyCode(),
                    imported.getConfigJson(),
                    imported.getScheduleType(),
                    imported.getScheduleIntervalHours(),
                    imported.getScheduleDayOfMonth(),
                    imported.getScheduleTime(),
                    imported.isActive(),
                    actorUserIdx
            );
            result.systemPolicies++;
        }

        return result;
    }

    public Map<String, Object> parseJson(byte[] bytes) throws Exception {
        return objectMapper.readValue(bytes, new TypeReference<Map<String, Object>>() {});
    }


    private Map<String, Object> sanitized(Map<String, Object> source) {
        Map<String, Object> copy = new LinkedHashMap<>();
        for (Map.Entry<String, Object> entry : source.entrySet()) {
            String key = entry.getKey();
            if (key == null || key.endsWith("Date")) {
                continue;
            }
            copy.put(key, entry.getValue());
        }
        return copy;
    }

    private Set<String> normalizeSections(Collection<String> sections) {
        if (sections == null || sections.isEmpty()) {
            return new LinkedHashSet<>(SECTION_KEYS);
        }
        Set<String> selected = new LinkedHashSet<>();
        for (String section : sections) {
            if (section == null || section.isBlank()) {
                continue;
            }
            String[] parts = section.split(",");
            for (String part : parts) {
                String key = part.trim();
                if (SECTION_KEYS.contains(key)) {
                    selected.add(key);
                }
            }
        }
        if (selected.isEmpty()) {
            return new LinkedHashSet<>(SECTION_KEYS);
        }
        return selected;
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> list(Object value) {
        if (value instanceof List<?> rawList) {
            return rawList.stream()
                    .filter(Map.class::isInstance)
                    .map(item -> (Map<String, Object>) item)
                    .toList();
        }
        return List.of();
    }

    public static class ImportResult {
        public int runtimeSettings;
        public int providerConfigs;
        public int loginRiskPolicies;
        public int securityAppealPolicy;
        public int systemPolicies;
        public int skipped;
        public java.util.List<String> skippedMessages = new java.util.ArrayList<>();

        public int totalApplied() {
            return runtimeSettings + providerConfigs + loginRiskPolicies + securityAppealPolicy + systemPolicies;
        }
    }
}
