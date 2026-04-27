package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletLimitPolicyMapper;
import org.triptogether.myPage.vo.WalletLimitPolicyVO;

import jakarta.servlet.http.HttpSession;

/**
 * 어드민 — 내지갑 정책 관리.
 *
 * <p>권한: FINANCE_POLICY_ADMIN ({@code AdminInterceptor#resolveFinancePermission}).</p>
 *
 * <ul>
 *     <li>GET  /admin/finance/policy        — 한도 정책 목록 (탭: 한도 / 적립률)</li>
 *     <li>POST /admin/finance/policy/limit  — 한도 정책 등록·갱신 (UPSERT)</li>
 * </ul>
 *
 * <p>적립률 정책 (WALLET_REWARD_POLICY) 은 Phase 13 에서 같은 컨트롤러에 추가될 예정.</p>
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/finance/policy")
public class AdminWalletPolicyController {

    private final WalletLimitPolicyMapper limitPolicyMapper;

    @GetMapping
    public String policyHome(Model model) {
        model.addAttribute("activeMenu", "finance");
        model.addAttribute("section", "policy");
        model.addAttribute("limitPolicies", limitPolicyMapper.selectAll());
        return "admin/finance/policy";
    }

    @PostMapping("/limit")
    public String saveLimitPolicy(@ModelAttribute WalletLimitPolicyVO form,
                                  HttpSession session,
                                  RedirectAttributes ra) {
        UsersVO admin = (UsersVO) session.getAttribute("loginUser");
        if (admin != null) form.setUpdatedByUserIdx(admin.getUserIdx());
        if (form.getIsActive() == null) form.setIsActive(true);

        try {
            limitPolicyMapper.upsert(form);
            ra.addFlashAttribute("policyMessage",
                    "[" + form.getMemberGrade() + "] 한도 정책 저장 완료");
        } catch (Exception e) {
            log.error("[AdminWalletPolicyController] limit upsert 실패", e);
            ra.addFlashAttribute("policyError", "정책 저장 실패: " + e.getMessage());
        }
        return "redirect:/admin/finance/policy";
    }
}
