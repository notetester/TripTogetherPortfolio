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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class InitialSettingsService {

    private final ObjectMapper objectMapper;
    private final AdminMapper adminMapper;
    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final LoginRiskPolicyService loginRiskPolicyService;
    private final RuntimeSettingService runtimeSettingService;
    private final AdminPolicyService adminPolicyService;

    public Map<String, Object> exportSettings() {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("schemaVersion", 1);
        result.put("exportedAt", LocalDateTime.now().toString());
        result.put("runtimeSettings", runtimeSettingService.getRuntimeSettings(null, null, true));
        result.put("providerConfigs", loginRiskPolicyService.getProviderConfigs());
        result.put("loginRiskPolicies", loginRiskPolicyService.getPolicies(true));
        result.put("securityAppealPolicy", loginRiskPolicyService.getSecurityAppealPolicy());
        result.put("systemPolicies", adminMapper.findSystemPolicies());
        return result;
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
