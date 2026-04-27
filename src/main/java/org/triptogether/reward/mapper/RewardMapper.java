package org.triptogether.reward.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.reward.vo.ExpHistoryCreateDto;
import org.triptogether.reward.vo.LevelOverrideDto;
import org.triptogether.reward.vo.LevelPolicyDto;
import org.triptogether.reward.vo.LevelUpRewardPolicyDto;
import org.triptogether.reward.vo.PointHistoryCreateDto;
import org.triptogether.reward.vo.RewardPolicyDto;
import org.triptogether.reward.vo.UserLevelUpRewardHistoryCreateDto;

import java.util.List;

@Mapper
public interface RewardMapper {

    UsersVO selectUserByIdxForUpdate(@Param("userIdx") Long userIdx);

    RewardPolicyDto selectPointRewardPolicy(@Param("rewardCode") String rewardCode);

    RewardPolicyDto selectExpRewardPolicy(@Param("rewardCode") String rewardCode);

    int countPointHistory(@Param("userIdx") Long userIdx,
                          @Param("sourceType") String sourceType,
                          @Param("sourceId") Long sourceId);

    int countExpHistory(@Param("userIdx") Long userIdx,
                        @Param("sourceType") String sourceType,
                        @Param("sourceId") Long sourceId);

    void updateUserRewardState(@Param("userIdx") Long userIdx,
                               @Param("pointBalance") long pointBalance,
                               @Param("expPoints") long expPoints,
                               @Param("levelNo") int levelNo,
                               @Param("cashBalance") long cashBalance,
                               @Param("mileageBalance") long mileageBalance);

    List<UsersVO> selectUsersForLevelSync(@Param("onlyActiveMembers") boolean onlyActiveMembers);

    void updateUserLevelOnly(@Param("userIdx") Long userIdx,
                             @Param("levelNo") int levelNo);

    void insertPointHistory(PointHistoryCreateDto history);

    void insertExpHistory(ExpHistoryCreateDto history);

    LevelPolicyDto selectActiveLevelPolicy();

    List<LevelOverrideDto> selectActiveLevelOverrides();

    List<LevelUpRewardPolicyDto> selectActiveLevelUpRewardPoliciesBetween(@Param("fromLevelExclusive") int fromLevelExclusive,
                                                                          @Param("toLevelInclusive") int toLevelInclusive);

    int countLevelUpRewardHistory(@Param("userIdx") Long userIdx,
                                  @Param("levelUpRewardPolicyIdx") Long levelUpRewardPolicyIdx);

    void insertLevelUpRewardHistory(UserLevelUpRewardHistoryCreateDto history);

    void upsertLevelRewardInventoryItem(@Param("userIdx") Long userIdx,
                                        @Param("itemCode") String itemCode);

    void insertWalletHistory(WalletHistoryDto history);
}
