package org.triptogether.shop.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.reward.vo.PointHistoryCreateDto;
import org.triptogether.shop.vo.ShopInventoryItemDto;
import org.triptogether.shop.vo.ShopItemDto;
import org.triptogether.shop.vo.ShopPurchaseHistoryCreateDto;

import java.util.List;

@Mapper
public interface ShopMapper {

    UsersVO selectUserByIdx(@Param("userIdx") Long userIdx);

    UsersVO selectUserByIdxForUpdate(@Param("userIdx") Long userIdx);

    ShopItemDto selectActiveItemForUpdate(@Param("itemCode") String itemCode);

    int countInventoryItem(@Param("userIdx") Long userIdx,
                           @Param("itemCode") String itemCode);

    List<String> selectOwnedItemCodes(@Param("userIdx") Long userIdx);

    List<ShopInventoryItemDto> selectInventoryItems(@Param("userIdx") Long userIdx);

    ShopInventoryItemDto selectInventoryItem(@Param("userIdx") Long userIdx,
                                             @Param("itemCode") String itemCode);

    void updateUserPointBalance(@Param("userIdx") Long userIdx,
                                @Param("pointBalance") long pointBalance);

    void insertPurchaseHistory(ShopPurchaseHistoryCreateDto purchase);

    void upsertInventoryItem(@Param("userIdx") Long userIdx,
                             @Param("itemCode") String itemCode,
                             @Param("relatedPurchaseIdx") Long relatedPurchaseIdx);

    void insertPointHistory(PointHistoryCreateDto history);

    void upsertEquipItem(@Param("userIdx") Long userIdx,
                         @Param("equipSlot") String equipSlot,
                         @Param("itemCode") String itemCode);

    void deleteEquipItem(@Param("userIdx") Long userIdx,
                         @Param("equipSlot") String equipSlot);

    void updateInventoryLastUsedAt(@Param("userIdx") Long userIdx,
                                   @Param("itemCode") String itemCode);
}
