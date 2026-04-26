package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminBlockSearchVO;

import java.time.LocalDateTime;
import java.util.Map;

public interface AdminBlockService {
    Map<String, Object> getBlockDashboard(AdminBlockSearchVO search);
    Map<String, Object> getBlockHistoriesPaged(AdminBlockSearchVO search);
    Map<String, Object> getIpBlocksPaged(AdminBlockSearchVO search);
    Map<String, Object> getIpBlockBatchesPaged(AdminBlockSearchVO search);
    Map<String, Object> getUserBlocksPaged(AdminBlockSearchVO search);
    void createIpBlockBatch(String batchCode, String batchName, String sourceType, String sourceName,
                            String batchRuleAction, Integer defaultRulePriority,
                            String defaultDisableStrategy, String defaultEnableStrategy,
                            String description, Long actorUserIdx);
    void updateIpBlockBatch(Long ipBlockBatchIdx, String batchCode, String batchName, String sourceType, String sourceName,
                            String batchRuleAction, Integer defaultRulePriority,
                            String defaultDisableStrategy, String defaultEnableStrategy,
                            String description, Long actorUserIdx);
    void toggleIpBlockBatch(Long ipBlockBatchIdx, boolean active, String operationOption, String description, Long actorUserIdx);
    void createGlobalIpRule(String matchType, String ipAddress, String cidrNotation, String rangeStartIp, String rangeEndIp,
                            String countryCode, String asn, String ruleAction, String controlMode,
                            String blockCategory, Integer priority, Long ipBlockBatchIdx,
                            String reason, String detailMessage, LocalDateTime expiresAt, Long actorUserIdx);
    void updateIpRule(Long ipBlocklistIdx, String ruleAction, String controlMode, String blockCategory,
                      Integer priority, String reason, String detailMessage, LocalDateTime expiresAt, Long actorUserIdx);
    void toggleIpRule(Long ipBlocklistIdx, boolean active, Long actorUserIdx);
    void returnIpRuleToBatchControl(Long ipBlocklistIdx, Long actorUserIdx);
    void updateUserBlock(Long blockIdx, boolean active, String reason, LocalDateTime expiresAt, Long actorUserIdx);
    void releaseUserBlock(String blockTargetKey, Long actorUserIdx);
    void bulkReleaseUserBlocks(java.util.List<String> blockTargetKeys, Long actorUserIdx);
    void bulkToggleIpRules(java.util.List<Long> ipBlocklistIdxList, boolean active, Long actorUserIdx);
    Map<String, Object> findCurrentSettingByHistory(Long historyBlockIdx);
}
