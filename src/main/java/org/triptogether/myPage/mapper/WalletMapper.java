package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.util.List;

@Mapper
public interface WalletMapper {

    UsersVO selectUserByIdx(@Param("userIdx") Long userIdx);

    UsersVO selectUserByIdxForUpdate(@Param("userIdx") Long userIdx);

    void updateWalletBalances(@Param("userIdx") Long userIdx,
                              @Param("cashBalance") long cashBalance,
                              @Param("mileageBalance") long mileageBalance);

    void insertPaymentHistory(WalletPaymentDto payment);

    void insertWalletHistory(WalletHistoryDto history);

    List<WalletPaymentDto> selectRecentPaymentHistory(@Param("userIdx") Long userIdx);

    List<WalletHistoryDto> selectRecentWalletHistory(@Param("userIdx") Long userIdx);
}
