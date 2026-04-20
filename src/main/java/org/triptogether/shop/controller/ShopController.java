package org.triptogether.shop.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.shop.service.ShopService;
import org.triptogether.shop.vo.ShopItemPreviewDto;
import org.triptogether.shop.vo.ShopPurchaseResultDto;
import org.triptogether.shop.vo.ShopSectionDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/shop")
public class ShopController {

    private final ShopService shopService;

    @GetMapping("")
    public String shopPage(HttpSession session, Model model) {
        // 상품 구매/장착 기능은 ShopService에서 처리하고, 컨트롤러는 화면 데이터만 모델에 담는다.
        // 로그인 사용자가 있으면 보유 상품 목록과 포인트 정보를 함께 보여준다.
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        model.addAttribute("user", loginUser);
        model.addAttribute("shopSections", createPreviewSections());
        model.addAttribute("ownedItemCodeMap", createOwnedItemCodeMap(loginUser));
        return "shop/index";
    }

    @PostMapping("/purchase")
    public String purchaseItem(@RequestParam String itemCode,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("shopError", "로그인 후 구매할 수 있습니다.");
            return "redirect:/auth/login";
        }

        try {
            ShopPurchaseResultDto result = shopService.purchaseItem(loginUser.getUserIdx(), itemCode);
            session.setAttribute("loginUser", result.getUser());
            redirectAttributes.addFlashAttribute(
                    "shopMessage",
                    result.getItem().getItemName() + " 구매가 완료되었습니다."
            );
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("shopError", e.getMessage());
        }

        return "redirect:/shop";
    }

    private Map<String, Boolean> createOwnedItemCodeMap(UsersVO loginUser) {
        Map<String, Boolean> ownedItemCodeMap = new HashMap<>();
        if (loginUser == null) {
            return ownedItemCodeMap;
        }

        for (String itemCode : shopService.getOwnedItemCodes(loginUser.getUserIdx())) {
            ownedItemCodeMap.put(itemCode, true);
        }
        return ownedItemCodeMap;
    }

    private List<ShopSectionDto> createPreviewSections() {
        return List.of(
                new ShopSectionDto(
                        "shop.section.nicknameColor",
                        "shop.section.nicknameColor.desc",
                        "NC",
                        "shop-accent-blue",
                        List.of(
                                item("NICK_COLOR_SKY", "shop.item.nick.sky", "shop.item.nick.sky.desc", "shop.type.nicknameColor", "TRIP", "preview-nick-sky", 150),
                                item("NICK_COLOR_SUNSET", "shop.item.nick.sunset", "shop.item.nick.sunset.desc", "shop.type.nicknameColor", "TRIP", "preview-nick-sunset", 150),
                                item("NICK_COLOR_MINT", "shop.item.nick.mint", "shop.item.nick.mint.desc", "shop.type.nicknameColor", "TRIP", "preview-nick-mint", 150),
                                item("NICK_COLOR_ROSE", "shop.item.nick.rose", "shop.item.nick.rose.desc", "shop.type.nicknameColor", "TRIP", "preview-nick-rose", 150)
                        )
                ),
                new ShopSectionDto(
                        "shop.section.nicknameEffect",
                        "shop.section.nicknameEffect.desc",
                        "NE",
                        "shop-accent-amber",
                        List.of(
                                item("NICK_GLOW_GOLD", "shop.item.glow.gold", "shop.item.glow.gold.desc", "shop.type.nicknameEffect", "TRIP", "preview-glow-gold", 700),
                                item("NICK_BORDER_NEON", "shop.item.border.neon", "shop.item.border.neon.desc", "shop.type.nicknameEffect", "TRIP", "preview-border-neon", 900),
                                item("NICK_GLOW_RAINBOW", "shop.item.glow.rainbow", "shop.item.glow.rainbow.desc", "shop.type.nicknameEffect", "TRIP", "preview-glow-rainbow", 1800)
                        )
                ),
                new ShopSectionDto(
                        "shop.section.badge",
                        "shop.section.badge.desc",
                        "PB",
                        "shop-accent-emerald",
                        List.of(
                                item("BADGE_BEGINNER_TRAVELER", "shop.item.badge.beginner", "shop.item.badge.beginner.desc", "shop.type.profileBadge", "SPROUT", "preview-badge-green", 300),
                                item("BADGE_FOOD_EXPLORER", "shop.item.badge.food", "shop.item.badge.food.desc", "shop.type.profileBadge", "FOOD", "preview-badge-orange", 500),
                                item("BADGE_NIGHT_COLLECTOR", "shop.item.badge.night", "shop.item.badge.night.desc", "shop.type.profileBadge", "NIGHT", "preview-badge-navy", 500),
                                item("BADGE_REVIEW_MASTER", "shop.item.badge.review", "shop.item.badge.review.desc", "shop.type.profileBadge", "REVIEW", "preview-badge-purple", 1000)
                        )
                ),
                new ShopSectionDto(
                        "shop.section.bubble",
                        "shop.section.bubble.desc",
                        "CB",
                        "shop-accent-pink",
                        List.of(
                                item("BUBBLE_PASTEL", "shop.item.bubble.pastel", "shop.item.bubble.pastel.desc", "shop.type.bubble", "Pastel review", "preview-bubble-pastel", 700),
                                item("BUBBLE_MAP_PIN", "shop.item.bubble.map", "shop.item.bubble.map.desc", "shop.type.bubble", "Map pin note", "preview-bubble-map", 900),
                                item("BUBBLE_SKY_CARD", "shop.item.bubble.sky", "shop.item.bubble.sky.desc", "shop.type.bubble", "Sky card", "preview-bubble-sky", 1200)
                        )
                )
        );
    }

    private ShopItemPreviewDto item(String itemCode,
                                    String nameMessageCode,
                                    String descriptionMessageCode,
                                    String itemTypeMessageCode,
                                    String previewText,
                                    String previewClass,
                                    long pointPrice) {
        return new ShopItemPreviewDto(
                itemCode,
                nameMessageCode,
                descriptionMessageCode,
                itemTypeMessageCode,
                previewText,
                previewClass,
                pointPrice
        );
    }
}
