package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.triptogether.admin.service.AdminFinanceService;
import org.triptogether.admin.vo.AdminFinanceUserSearchDto;
import org.triptogether.auth.vo.UsersVO;

/**
 * 어드민 내지갑 관리 (FINANCE_ADMIN 권한, MVP read-only).
 *
 * - GET /admin/finance              대시보드 (자산 집계 통계)
 * - GET /admin/finance/users        사용자 목록 (자산 잔액)
 * - GET /admin/finance/users/{idx}  사용자 상세 (자산 + 변동 이력 + 결제 이력)
 *
 * 자산 조정/환불은 의도적으로 미포함 (신성륜 토스페이먼트 영역 침범 회피).
 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/finance")
public class AdminFinanceController {

    private final AdminFinanceService adminFinanceService;

    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("activeMenu", "finance");
        model.addAttribute("stats", adminFinanceService.getStats());
        return "admin/finance/dashboard";
    }

    @GetMapping("/users")
    public String userList(@ModelAttribute AdminFinanceUserSearchDto search, Model model) {
        model.addAttribute("activeMenu", "finance");
        model.addAttribute("search",     search);
        model.addAttribute("userList",   adminFinanceService.getUserList(search));
        model.addAttribute("totalCount", adminFinanceService.getTotalCount(search));
        model.addAttribute("totalPage",  adminFinanceService.getTotalPage(search));
        return "admin/finance/users";
    }

    @GetMapping("/users/{userIdx}")
    public String userDetail(@PathVariable Long userIdx, Model model) {
        UsersVO user = adminFinanceService.getUser(userIdx);
        if (user == null) {
            return "redirect:/admin/finance/users";
        }
        model.addAttribute("activeMenu",     "finance");
        model.addAttribute("user",           user);
        model.addAttribute("walletHistory",  adminFinanceService.getWalletHistory(userIdx));
        model.addAttribute("paymentHistory", adminFinanceService.getPaymentHistory(userIdx));
        return "admin/finance/user-detail";
    }
}
