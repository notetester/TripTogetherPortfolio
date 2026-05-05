package org.triptogether.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class RuntimeSettingService {

    private final RuntimeSettingMapper runtimeSettingMapper;

    public String getValue(String settingKey, String fallbackValue) {
        try {
            RuntimeSettingVO setting = runtimeSettingMapper.findActiveSettingByKey(settingKey);
            if (setting == null) {
                return fallbackValue;
            }
            if (hasText(setting.getSettingValue())) {
                return setting.getSettingValue().trim();
            }
            if (hasText(setting.getFallbackValue())) {
                return setting.getFallbackValue().trim();
            }
            return fallbackValue;
        } catch (Exception e) {
            log.debug("[RuntimeSetting] fallback used for key={}, reason={}", settingKey, e.getMessage());
            return fallbackValue;
        }
    }

    public int getInt(String settingKey, int fallbackValue) {
        String value = getValue(settingKey, String.valueOf(fallbackValue));
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return fallbackValue;
        }
    }

    public boolean getBoolean(String settingKey, boolean fallbackValue) {
        String value = getValue(settingKey, String.valueOf(fallbackValue));
        if (value == null) {
            return fallbackValue;
        }
        return "1".equals(value) || "true".equalsIgnoreCase(value) || "Y".equalsIgnoreCase(value) || "yes".equalsIgnoreCase(value);
    }

    public List<RuntimeSettingVO> getRuntimeSettings(String settingGroup, String keyword, boolean includeInactive) {
        return runtimeSettingMapper.findRuntimeSettings(emptyToNull(settingGroup), emptyToNull(keyword), includeInactive);
    }

    public List<RuntimeSettingHistoryVO> getRuntimeSettingHistories(String settingKey, int limit) {
        int safeLimit = Math.max(1, Math.min(limit, 100));
        return runtimeSettingMapper.findRuntimeSettingHistory(emptyToNull(settingKey), safeLimit);
    }

    public RuntimeSettingVO getRuntimeSettingByIdx(Long settingIdx) {
        return runtimeSettingMapper.findRuntimeSettingByIdx(settingIdx);
    }

    @Transactional
    public void saveRuntimeSetting(RuntimeSettingVO input, Long actorUserIdx) {
        RuntimeSettingVO before = input.getSettingIdx() == null
                ? runtimeSettingMapper.findRuntimeSettingByKey(input.getSettingKey())
                : runtimeSettingMapper.findRuntimeSettingByIdx(input.getSettingIdx());

        RuntimeSettingVO setting = before == null ? new RuntimeSettingVO() : before;
        setting.setSettingKey(required(input.getSettingKey(), "settingKey"));
        setting.setSettingGroup(defaultText(input.getSettingGroup(), "GENERAL"));
        setting.setDisplayName(defaultText(input.getDisplayName(), input.getSettingKey()));
        setting.setSettingValue(emptyToNull(input.getSettingValue()));
        setting.setFallbackValue(emptyToNull(input.getFallbackValue()));
        setting.setValueType(defaultText(input.getValueType(), "STRING"));
        setting.setSecret(input.isSecret());
        setting.setEditable(input.isEditable());
        setting.setActive(input.isActive());
        setting.setDescription(emptyToNull(input.getDescription()));
        setting.setUpdatedByUserIdx(actorUserIdx);

        String beforeSnapshot = snapshot(before);
        if (before == null) {
            runtimeSettingMapper.insertRuntimeSetting(setting);
        } else {
            runtimeSettingMapper.updateRuntimeSetting(setting);
        }
        RuntimeSettingVO after = runtimeSettingMapper.findRuntimeSettingByKey(setting.getSettingKey());
        runtimeSettingMapper.insertRuntimeSettingHistory(
                after == null ? setting.getSettingIdx() : after.getSettingIdx(),
                setting.getSettingKey(),
                before == null ? "CREATE" : "UPDATE",
                actorUserIdx,
                before == null ? null : before.getSettingValue(),
                setting.getSettingValue(),
                before == null ? null : before.getFallbackValue(),
                setting.getFallbackValue(),
                beforeSnapshot,
                snapshot(after == null ? setting : after)
        );
    }

    private String required(String value, String name) {
        if (!hasText(value)) {
            throw new IllegalArgumentException(name);
        }
        return value.trim();
    }

    private String defaultText(String value, String fallback) {
        return hasText(value) ? value.trim() : fallback;
    }

    private String emptyToNull(String value) {
        return hasText(value) ? value.trim() : null;
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private String snapshot(RuntimeSettingVO setting) {
        if (setting == null) {
            return "{}";
        }
        return "{"
                + pair("settingKey", setting.getSettingKey()) + ","
                + pair("settingGroup", setting.getSettingGroup()) + ","
                + pair("displayName", setting.getDisplayName()) + ","
                + pair("settingValue", setting.getSettingValue()) + ","
                + pair("fallbackValue", setting.getFallbackValue()) + ","
                + pair("valueType", setting.getValueType()) + ","
                + pair("secret", setting.isSecret()) + ","
                + pair("editable", setting.isEditable()) + ","
                + pair("active", setting.isActive())
                + "}";
    }

    private String pair(String key, Object value) {
        return "\"" + escapeJson(key) + "\":\"" + escapeJson(value == null ? "" : String.valueOf(value)) + "\"";
    }

    private String escapeJson(String value) {
        return value == null ? "" : value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
