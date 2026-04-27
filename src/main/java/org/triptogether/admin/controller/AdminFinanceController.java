package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.triptogether.admin.service.AdminFinanceService;
import org.triptogether.admin.service.AdminRefundService;
import org.triptogether.admin.vo.AdminFinanceUserSearchDto;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletLimitPolicyMapper;
import org.triptogether.myPage.mapper.WalletRewardPolicyMapper;

import java.util.Set;

/**
 * 어드민 내지갑 관리 (FINANCE_ADMIN/FINANCE_OPERATOR/FINANCE_POLICY_ADMIN).
 *
 * <ul>
 *   <li>GET /admin/finance              통합 대시보드 (자산 집계 + 사용자 목록 + 권한별 위젯)</li>
 *   <li>GET /admin/finance/users        대시보드로 redirect (외부 링크 호환)</li>
 *   <li>GET /admin/finance/users/{idx}  사용자 상세</li>
 * </ul>
 *
 * 자산 조정/환불/정책은 별도 컨트롤러:
 *  - AdminRefundController        /admin/finance/refund
 *  - AdminWalletPolicyController  /admin/finance/policy
 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/finance")
public class AdminFinanceController {

    private final AdminFinanceService adminFinanceService;
    private final AdminRefundService adminRefundService;
    private final WalletLimitPolicyMapper walletLimitPolicyMapper;
    private final WalletRewardPolicyMapper walletRewardPolicyMapper;

    @GetMapping
    public String dashboard(@ModelAttribute AdminFinanceUserSearchDto search,
                            Model model,
                            HttpSession session) {

        @SuppressWarnings("unchecked")
        Set<String> perms = (Set<String>) session.getAttribute("adminPermissions");
        if (perms == null) perms = Set.of();
        boolean isSuper   = perms.contains("SUPER_ADMIN");
        boolean canRefund = isSuper || perms.contains("FINANCE_OPERATOR");
        boolean canPolicy = isSuper || perms.contains("FINANCE_POLICY_ADMIN");

        model.addAttribute("activeMenu", "finance");
        model.addAttribute("subTab",     "dashboard");

        // 집계 카드
        model.addAttribute("stats", adminFinanceService.getStats());

        // 사용자 목록 (검색·페이지네이션 통합)
        model.addAttribute("search",     search);
        model.addAttribute("userList",   adminFinanceService.getUserList(search));
        model.addAttribute("totalCount", adminFinanceService.getTotalCount(search));
        model.addAttribute("totalPage",  adminFinanceService.getTotalPage(search));

        // 권한별 위젯
        if (canRefund) {
            model.addAttribute("recentRefunds", adminRefundService.getRecentRefundLogs(3));
        }
        if (canPolicy) {
            model.addAttribute("limitPolicies",  walletLimitPolicyMapper.selectAll());
            model.addAttribute("rewardPolicies", walletRewardPolicyMapper.selectAll());
        }

        return "admin/finance/dashboard";
    }

    /** 외부 링크/책갈피 호환을 위해 /admin/finance/users 는 대시보드로 redirect (query string 보존). */
    @GetMapping("/users")
    public String userListRedirect() {
        String qs = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .build()
                .getQuery();
        if (qs != null && !qs.isBlank()) {
            return "redirect:/admin/finance?" + qs;
        }
        return "redirect:/admin/finance";
    }

    @GetMapping("/users/{userIdx}")
    public String userDetail(@PathVariable Long userIdx, Model model) {
        UsersVO user = adminFinanceService.getUser(userIdx);
        if (user == null) {
            return "redirect:/admin/finance";
        }
        model.addAttribute("activeMenu",     "finance");
        model.addAttribute("subTab",         "dashboard");
        model.addAttribute("user",           user);
        model.addAttribute("walletHistory",  adminFinanceService.getWalletHistory(userIdx));
        model.addAttribute("paymentHistory", adminFinanceService.getPaymentHistory(userIdx));
        return "admin/finance/user-detail";
    }
}
