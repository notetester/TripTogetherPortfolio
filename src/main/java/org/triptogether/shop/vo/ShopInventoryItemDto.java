package org.triptogether.shop.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getAcquiredAtDate() {
        return fromLocalDateTime(acquiredAt);
    }

    public Date getLastUsedAtDate() {
        return fromLocalDateTime(lastUsedAt);
    }

}
