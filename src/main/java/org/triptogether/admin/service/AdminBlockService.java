package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminBlockSearchVO;

import java.time.LocalDateTime;
import java.util.Map;

public interface AdminBlockService {
    Map<String, Object> getBlockDashboard(AdminBlockSearchVO search);
    void createIpBlockBatch(String batchCode, String batchName, String sourceType, String sourceName,
                            String batchRuleAction, Integer defaultRulePriority,
                            String defaultDisableStrategy, String defaultEnableStrategy,
                            String description, Long actorUserIdx);
    void toggleIpBlockBatch(Long ipBlockBatchIdx, boolean active, String operationOption, String description, Long actorUserIdx);
    void createGlobalIpRule(String matchType, String ipAddress, String cidrNotation, String rangeStartIp, String rangeEndIp,
                            String countryCode, String asn, String ruleAction, String controlMode,
                            String blockCategory, Integer priority, Long ipBlockBatchIdx,
                            String reason, String detailMessage, LocalDateTime expiresAt, Long actorUserIdx);
    void toggleIpRule(Long ipBlocklistIdx, boolean active, Long actorUserIdx);
    void returnIpRuleToBatchControl(Long ipBlocklistIdx, Long actorUserIdx);
    void releaseUserBlock(String blockTargetKey, Long actorUserIdx);
}
