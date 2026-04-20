package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminBlockSearchVO;

import java.time.LocalDateTime;
import java.util.Map;

public interface AdminBlockService {
    Map<String, Object> getBlockDashboard(AdminBlockSearchVO search);
    void createIpBlockBatch(String batchCode, String batchName, String sourceType, String sourceName, String description, Long actorUserIdx);
    void toggleIpBlockBatch(Long ipBlockBatchIdx, boolean active, Long actorUserIdx);
    void createGlobalIpRule(String matchType, String ipAddress, String cidrNotation, String rangeStartIp, String rangeEndIp,
                            String countryCode, String asn, String blockCategory, Integer priority, Long ipBlockBatchIdx,
                            String reason, LocalDateTime expiresAt, Long actorUserIdx);
    void toggleIpRule(Long ipBlocklistIdx, boolean active, Long actorUserIdx);
    void releaseUserBlock(String blockTargetKey, Long actorUserIdx);
}
