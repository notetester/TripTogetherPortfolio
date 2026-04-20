package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminBlockService;
import org.triptogether.admin.vo.AdminBlockSearchVO;
import org.triptogether.auth.vo.UsersVO;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/blocks")
public class AdminBlockController {

    private final AdminBlockService adminBlockService;

    @GetMapping
    public String blockDashboard(AdminBlockSearchVO search, Model model) {
        model.addAllAttributes(adminBlockService.getBlockDashboard(search));
        model.addAttribute("activeMenu", "blocks");
        model.addAttribute("pageTitle", "차단 관리");
        return "admin/block/list";
    }

    @PostMapping("/ip-rules")
    @ResponseBody
    public Map<String, Object> createIpRule(@RequestParam String matchType,
                                            @RequestParam(required = false) String ipAddress,
                                            @RequestParam(required = false) String cidrNotation,
                                            @RequestParam(required = false) String rangeStartIp,
                                            @RequestParam(required = false) String rangeEndIp,
                                            @RequestParam(required = false) String countryCode,
                                            @RequestParam(required = false) String asn,
                                            @RequestParam(defaultValue = "MANUAL") String blockCategory,
                                            @RequestParam(defaultValue = "1") Integer priority,
                                            @RequestParam(required = false) Long ipBlockBatchIdx,
                                            @RequestParam(required = false) String reason,
                                            @RequestParam(required = false) String expiresAt,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            LocalDateTime parsed = (expiresAt != null && !expiresAt.isBlank()) ? LocalDateTime.parse(expiresAt) : null;
            adminBlockService.createGlobalIpRule(matchType, ipAddress, cidrNotation, rangeStartIp, rangeEndIp,
                    countryCode, asn, blockCategory, priority, ipBlockBatchIdx, reason, parsed,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 차단 규칙이 저장되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/ip-rules/{ipBlocklistIdx}/toggle")
    @ResponseBody
    public Map<String, Object> toggleIpRule(@PathVariable Long ipBlocklistIdx,
                                            @RequestParam boolean active,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.toggleIpRule(ipBlocklistIdx, active, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", active ? "IP 차단 규칙이 재활성화되었습니다." : "IP 차단 규칙이 비활성화되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/user-blocks/release")
    @ResponseBody
    public Map<String, Object> releaseUserBlock(@RequestParam String blockTargetKey,
                                                HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.releaseUserBlock(blockTargetKey, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "회원 차단이 해제되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/batches")
    @ResponseBody
    public Map<String, Object> createBatch(@RequestParam String batchCode,
                                           @RequestParam String batchName,
                                           @RequestParam String sourceType,
                                           @RequestParam(required = false) String sourceName,
                                           @RequestParam(required = false) String description,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.createIpBlockBatch(batchCode, batchName, sourceType, sourceName, description,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 차단 배치가 생성되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/batches/{ipBlockBatchIdx}/toggle")
    @ResponseBody
    public Map<String, Object> toggleBatch(@PathVariable Long ipBlockBatchIdx,
                                           @RequestParam boolean active,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.toggleIpBlockBatch(ipBlockBatchIdx, active, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", active
                    ? "배치가 활성화되었습니다. 연결된 활성 규칙이 다시 차단 판정에 반영됩니다."
                    : "배치가 비활성화되었습니다. 연결된 활성 규칙은 차단 판정에서 제외됩니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}
