package org.triptogether.shop.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ShopItemPreviewDto {

    private String itemCode;
    private String nameMessageCode;
    private String descriptionMessageCode;
    private String itemTypeMessageCode;
    private String previewText;
    private String previewClass;
    private long pointPrice;
}
