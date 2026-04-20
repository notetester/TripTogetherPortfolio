package org.triptogether.shop.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.shop.vo.ShopItemPreviewDto;
import org.triptogether.shop.vo.ShopSectionDto;

import java.util.List;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @GetMapping("")
    public String shopPage(HttpSession session, Model model) {
        // 상품 구매 기능은 이후 단계에서 붙일 예정이므로,
        // 현재는 로그인 사용자가 있으면 보유 포인트만 화면에 표시한다.
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        model.addAttribute("user", loginUser);
        model.addAttribute("shopSections", createPreviewSections());
        return "shop/index";
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
                                item("BADGE_BEGINNER_TRAVELER", "shop.item.badge.beginner", "shop.item.badge.beginner.desc", "shop.type.profileBadge", "새싹", "preview-badge-green", 300),
                                item("BADGE_FOOD_EXPLORER", "shop.item.badge.food", "shop.item.badge.food.desc", "shop.type.profileBadge", "미식", "preview-badge-orange", 500),
                                item("BADGE_NIGHT_COLLECTOR", "shop.item.badge.night", "shop.item.badge.night.desc", "shop.type.profileBadge", "야경", "preview-badge-navy", 500),
                                item("BADGE_REVIEW_MASTER", "shop.item.badge.review", "shop.item.badge.review.desc", "shop.type.profileBadge", "리뷰", "preview-badge-purple", 1000)
                        )
                ),
                new ShopSectionDto(
                        "shop.section.bubble",
                        "shop.section.bubble.desc",
                        "CB",
                        "shop-accent-pink",
                        List.of(
                                item("BUBBLE_PASTEL", "shop.item.bubble.pastel", "shop.item.bubble.pastel.desc", "shop.type.bubble", "좋은 여행이었어요!", "preview-bubble-pastel", 700),
                                item("BUBBLE_MAP_PIN", "shop.item.bubble.map", "shop.item.bubble.map.desc", "shop.type.bubble", "여기 추천해요", "preview-bubble-map", 900),
                                item("BUBBLE_SKY_CARD", "shop.item.bubble.sky", "shop.item.bubble.sky.desc", "shop.type.bubble", "다음에도 가고 싶어요", "preview-bubble-sky", 1200)
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
