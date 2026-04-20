package org.triptogether.shop.service;

import org.triptogether.shop.vo.ShopPurchaseResultDto;
import org.triptogether.shop.vo.ShopInventoryItemDto;

import java.util.List;

public interface ShopService {

    List<String> getOwnedItemCodes(Long userIdx);

    List<ShopInventoryItemDto> getInventoryItems(Long userIdx);

    ShopPurchaseResultDto purchaseItem(Long userIdx, String itemCode);

    void equipItem(Long userIdx, String itemCode);

    void unequipItem(Long userIdx, String equipSlot);
}
