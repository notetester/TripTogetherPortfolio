package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.*;

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
    List<AdminIpBlockBatchOperationVO> findRecentBatchOperations(AdminBlockSearchVO search);

    void insertIpBlockBatch(AdminIpBlockBatchVO batch);

    void updateIpBlockBatchActive(@Param("ipBlockBatchIdx") Long ipBlockBatchIdx,
                                  @Param("active") boolean active,
                                  @Param("updatedByUserIdx") Long updatedByUserIdx);

    AdminIpBlockBatchVO findIpBlockBatchById(@Param("ipBlockBatchIdx") Long ipBlockBatchIdx);
    List<AdminIpBlockVO> findIpRulesByBatchId(@Param("ipBlockBatchIdx") Long ipBlockBatchIdx);
    AdminIpBlockVO findIpBlockById(@Param("ipBlocklistIdx") Long ipBlocklistIdx);

    void insertGlobalBlockHistory(AdminBlockHistoryVO history);

    Long findBlockHistoryIdxByRequestId(@Param("blockRequestId") String blockRequestId);

    void insertIpBlockRule(AdminIpBlockVO rule);
    void updateIpBlockRule(AdminIpBlockVO rule);

    void insertIpBlockBatchOperation(AdminIpBlockBatchOperationVO operation);
    void updateIpBlockBatchOperationAffectedCount(@Param("ipBlockBatchOperationIdx") Long ipBlockBatchOperationIdx,
                                                  @Param("affectedRuleCount") int affectedRuleCount);
    AdminIpBlockBatchOperationVO findLatestBatchDisableOperation(@Param("ipBlockBatchIdx") Long ipBlockBatchIdx);
    List<AdminIpBlockBatchOperationRuleVO> findOperationRules(@Param("ipBlockBatchOperationIdx") Long ipBlockBatchOperationIdx);
    void insertIpBlockBatchOperationRule(AdminIpBlockBatchOperationRuleVO operationRule);

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
