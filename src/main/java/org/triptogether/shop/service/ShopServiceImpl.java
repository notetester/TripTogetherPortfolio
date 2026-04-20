package org.triptogether.shop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.reward.vo.PointHistoryCreateDto;
import org.triptogether.shop.mapper.ShopMapper;
import org.triptogether.shop.vo.ShopInventoryItemDto;
import org.triptogether.shop.vo.ShopItemDto;
import org.triptogether.shop.vo.ShopPurchaseHistoryCreateDto;
import org.triptogether.shop.vo.ShopPurchaseResultDto;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShopServiceImpl implements ShopService {

    private final ShopMapper shopMapper;

    @Override
    public List<String> getOwnedItemCodes(Long userIdx) {
        if (userIdx == null) {
            return Collections.emptyList();
        }
        return shopMapper.selectOwnedItemCodes(userIdx);
    }

    @Override
    public List<ShopInventoryItemDto> getInventoryItems(Long userIdx) {
        if (userIdx == null) {
            return Collections.emptyList();
        }
        return shopMapper.selectInventoryItems(userIdx);
    }

    @Override
    @Transactional
    public ShopPurchaseResultDto purchaseItem(Long userIdx, String itemCode) {
        validatePurchaseRequest(userIdx, itemCode);

        UsersVO user = shopMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("로그인 정보가 유효하지 않습니다.");
        }

        ShopItemDto item = shopMapper.selectActiveItemForUpdate(itemCode);
        if (item == null) {
            throw new IllegalArgumentException("판매 중인 상품이 아닙니다.");
        }

        int ownedCount = shopMapper.countInventoryItem(userIdx, itemCode);
        if (!item.isRepeatable() && ownedCount > 0) {
            throw new IllegalStateException("이미 보유 중인 상품입니다.");
        }

        if (user.getPointBalance() < item.getPointPrice()) {
            throw new IllegalStateException("포인트가 부족합니다.");
        }

        long balanceAfter = user.getPointBalance() - item.getPointPrice();
        shopMapper.updateUserPointBalance(userIdx, balanceAfter);

        ShopPurchaseHistoryCreateDto purchase = new ShopPurchaseHistoryCreateDto();
        purchase.setUserIdx(userIdx);
        purchase.setItemCode(item.getItemCode());
        purchase.setQuantity(1);
        purchase.setUnitPrice(item.getPointPrice());
        purchase.setTotalPrice(item.getPointPrice());
        purchase.setPurchaseStatus("COMPLETED");
        purchase.setDetailMessage(item.getItemName() + " 구매");
        shopMapper.insertPurchaseHistory(purchase);

        shopMapper.upsertInventoryItem(userIdx, item.getItemCode(), purchase.getPointPurchaseIdx());

        PointHistoryCreateDto pointHistory = new PointHistoryCreateDto();
        pointHistory.setUserIdx(userIdx);
        pointHistory.setChangeType("USE");
        pointHistory.setSourceType("SHOP_PURCHASE");
        pointHistory.setSourceId(purchase.getPointPurchaseIdx());
        pointHistory.setAmount(-item.getPointPrice());
        pointHistory.setBalanceAfter(balanceAfter);
        pointHistory.setDetailMessage(item.getItemName() + " 구매로 포인트 사용");
        pointHistory.setRelatedPurchaseIdx(purchase.getPointPurchaseIdx());
        shopMapper.insertPointHistory(pointHistory);

        UsersVO updatedUser = shopMapper.selectUserByIdx(userIdx);
        return new ShopPurchaseResultDto(updatedUser, item, purchase.getPointPurchaseIdx());
    }

    @Override
    @Transactional
    public void equipItem(Long userIdx, String itemCode) {
        validatePurchaseRequest(userIdx, itemCode);

        ShopInventoryItemDto inventoryItem = shopMapper.selectInventoryItem(userIdx, itemCode);
        if (inventoryItem == null) {
            throw new IllegalStateException("보유하지 않은 상품은 장착할 수 없습니다.");
        }

        String equipSlot = resolveEquipSlot(inventoryItem.getItemType());
        shopMapper.upsertEquipItem(userIdx, equipSlot, itemCode);
        shopMapper.updateInventoryLastUsedAt(userIdx, itemCode);
    }

    @Override
    @Transactional
    public void unequipItem(Long userIdx, String equipSlot) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (!isSupportedEquipSlot(equipSlot)) {
            throw new IllegalArgumentException("해제할 수 없는 장착 슬롯입니다.");
        }
        shopMapper.deleteEquipItem(userIdx, equipSlot);
    }

    private void validatePurchaseRequest(Long userIdx, String itemCode) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (itemCode == null || itemCode.isBlank()) {
            throw new IllegalArgumentException("구매할 상품을 선택해주세요.");
        }
    }

    private String resolveEquipSlot(String itemType) {
        if (!isSupportedEquipSlot(itemType)) {
            throw new IllegalArgumentException("장착할 수 없는 상품 유형입니다.");
        }
        return itemType;
    }

    private boolean isSupportedEquipSlot(String equipSlot) {
        return "NICKNAME_COLOR".equals(equipSlot)
                || "NICKNAME_EFFECT".equals(equipSlot)
                || "PROFILE_BADGE".equals(equipSlot)
                || "BUBBLE_STYLE".equals(equipSlot);
    }
}
