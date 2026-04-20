package org.triptogether.shop.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ShopInventoryItemDto {

    private Long pointInventoryIdx;
    private Long userIdx;
    private String itemCode;
    private String itemName;
    private String itemType;
    private long pointPrice;
    private int quantity;
    private boolean active;
    private String itemPayloadJson;
    private String description;
    private LocalDateTime acquiredAt;
    private LocalDateTime lastUsedAt;
    private boolean equipped;
    private String equipSlot;
}
