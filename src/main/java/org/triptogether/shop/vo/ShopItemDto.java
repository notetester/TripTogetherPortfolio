package org.triptogether.shop.vo;

import lombok.Data;

@Data
public class ShopItemDto {

    private Long pointShopItemIdx;
    private String itemCode;
    private String itemName;
    private String itemType;
    private long pointPrice;
    private boolean repeatable;
    private boolean active;
    private String itemPayloadJson;
    private String description;
}
