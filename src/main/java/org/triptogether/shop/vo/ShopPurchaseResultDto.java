package org.triptogether.shop.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.triptogether.auth.vo.UsersVO;

@Getter
@AllArgsConstructor
public class ShopPurchaseResultDto {

    private UsersVO user;
    private ShopItemDto item;
    private Long pointPurchaseIdx;
}
