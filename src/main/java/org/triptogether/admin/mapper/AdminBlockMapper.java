package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.*;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface AdminBlockMapper {
    long countActiveUserBlocks();
    long countActiveIpBlocks();
    long countBlockHistories();
    long countActiveBatches();

    List<AdminUserBlockVO> findUserBlocks(AdminBlockSearchVO search);
    List<AdminIpBlockVO> findIpBlocks(AdminBlockSearchVO search);
    List<AdminBlockHistoryVO> findBlockHistories(AdminBlockSearchVO search);
    List<AdminIpBlockBatchVO> findIpBlockBatches(AdminBlockSearchVO search);

    void insertIpBlockBatch(@Param("batchCode") String batchCode,
                            @Param("batchName") String batchName,
                            @Param("sourceType") String sourceType,
                            @Param("sourceName") String sourceName,
                            @Param("description") String description,
                            @Param("createdByUserIdx") Long createdByUserIdx);

    void updateIpBlockBatchActive(@Param("ipBlockBatchIdx") Long ipBlockBatchIdx,
                                  @Param("active") boolean active,
                                  @Param("updatedByUserIdx") Long updatedByUserIdx);

    AdminIpBlockVO findIpBlockById(@Param("ipBlocklistIdx") Long ipBlocklistIdx);

    void insertGlobalBlockHistory(@Param("blockRequestId") String blockRequestId,
                                  @Param("blockTargetKey") String blockTargetKey,
                                  @Param("historyKind") String historyKind,
                                  @Param("blockScope") String blockScope,
                                  @Param("userIdx") Long userIdx,
                                  @Param("blockType") String blockType,
                                  @Param("blockedIp") String blockedIp,
                                  @Param("ipMatchType") String ipMatchType,
                                  @Param("cidrNotation") String cidrNotation,
                                  @Param("rangeStartIp") String rangeStartIp,
                                  @Param("rangeEndIp") String rangeEndIp,
                                  @Param("ipBlockBatchIdx") Long ipBlockBatchIdx,
                                  @Param("reason") String reason,
                                  @Param("blockedByUserIdx") Long blockedByUserIdx,
                                  @Param("expiresAt") LocalDateTime expiresAt);

    Long findBlockHistoryIdxByRequestId(@Param("blockRequestId") String blockRequestId);

    void upsertIpBlockRule(@Param("ipAddress") String ipAddress,
                           @Param("blockTargetKey") String blockTargetKey,
                           @Param("blockRequestId") String blockRequestId,
                           @Param("sourceHistoryBlockIdx") Long sourceHistoryBlockIdx,
                           @Param("matchType") String matchType,
                           @Param("cidrNotation") String cidrNotation,
                           @Param("rangeStartIp") String rangeStartIp,
                           @Param("rangeEndIp") String rangeEndIp,
                           @Param("countryCode") String countryCode,
                           @Param("asn") String asn,
                           @Param("sourceScope") String sourceScope,
                           @Param("blockCategory") String blockCategory,
                           @Param("userIdx") Long userIdx,
                           @Param("blockType") String blockType,
                           @Param("blockedByUserIdx") Long blockedByUserIdx,
                           @Param("reason") String reason,
                           @Param("expiresAt") LocalDateTime expiresAt,
                           @Param("priority") Integer priority,
                           @Param("ipBlockBatchIdx") Long ipBlockBatchIdx,
                           @Param("detailMessage") String detailMessage,
                           @Param("isAutoBlock") boolean isAutoBlock,
                           @Param("autoBlockSource") String autoBlockSource,
                           @Param("riskScore") Integer riskScore);

    void updateIpBlockRuleActive(@Param("ipBlocklistIdx") Long ipBlocklistIdx,
                                 @Param("active") boolean active,
                                 @Param("releasedByUserIdx") Long releasedByUserIdx);

    void deactivateBlockHistoriesByTargetKey(@Param("blockTargetKey") String blockTargetKey,
                                             @Param("releasedByUserIdx") Long releasedByUserIdx,
                                             @Param("historyKind") String historyKind);

    AdminUserBlockVO findUserBlockByTargetKey(@Param("blockTargetKey") String blockTargetKey);

    void updateUserBlocklistActiveByTargetKey(@Param("blockTargetKey") String blockTargetKey,
                                              @Param("active") boolean active,
                                              @Param("releasedByUserIdx") Long releasedByUserIdx,
                                              @Param("snapshotStatus") String snapshotStatus);

    long countOtherActiveUserBlocks(@Param("userIdx") Long userIdx,
                                    @Param("excludeTargetKey") String excludeTargetKey);
}
