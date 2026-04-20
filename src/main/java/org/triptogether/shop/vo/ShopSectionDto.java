package org.triptogether.shop.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class ShopSectionDto {

    private String titleMessageCode;
    private String descriptionMessageCode;
    private String iconText;
    private String accentClass;
    private List<ShopItemPreviewDto> items;
}
