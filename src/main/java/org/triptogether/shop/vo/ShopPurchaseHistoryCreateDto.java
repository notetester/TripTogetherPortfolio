package org.triptogether.shop.vo;

import lombok.Data;

@Data
public class ShopPurchaseHistoryCreateDto {

    private Long pointPurchaseIdx;
    private Long userIdx;
    private String itemCode;
    private int quantity;
    private long unitPrice;
    private long totalPrice;
    private String purchaseStatus;
    private String detailMessage;
}
