package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.mapper.AdminMapper;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/policy-history")
public class AdminPolicyHistoryController {

    private final AdminMapper adminMapper;

    @GetMapping
    public String list(@RequestParam(value = "sourceType", required = false) String sourceType,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "limit", required = false, defaultValue = "100") int limit,
                       Model model) {
        int safeLimit = Math.max(20, Math.min(limit, 500));
        model.addAttribute("histories", adminMapper.findUnifiedPolicyHistories(emptyToNull(sourceType), emptyToNull(keyword), safeLimit));
        model.addAttribute("sourceType", sourceType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("limit", safeLimit);
        model.addAttribute("activeMenu", "policyHistory");
        model.addAttribute("pageTitleCode", "admin.policyHistory.title");
        return "admin/policy-history";
    }

    private String emptyToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}
