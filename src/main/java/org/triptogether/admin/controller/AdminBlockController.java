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
import java.util.List;
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


    @GetMapping("/api/histories")
    @ResponseBody
    public Map<String, Object> apiBlockHistories(AdminBlockSearchVO search) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.putAll(adminBlockService.getBlockHistoriesPaged(search));
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @GetMapping("/api/histories/fragment")
    public String apiBlockHistoriesFragment(AdminBlockSearchVO search, Model model) {
        Map<String, Object> data = adminBlockService.getBlockHistoriesPaged(search);
        model.addAttribute("histories", data.get("rows"));
        model.addAttribute("totalCount", data.get("total"));
        model.addAttribute("currentPage", data.get("page"));
        model.addAttribute("pageSize", data.get("size"));
        model.addAttribute("totalPages", data.get("totalPages"));
        return "admin/block/_historyRowsFragment";
    }

    @GetMapping("/histories/{historyBlockIdx}/current-setting")
    @ResponseBody
    public Map<String, Object> findCurrentSettingByHistory(@PathVariable Long historyBlockIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.putAll(adminBlockService.findCurrentSettingByHistory(historyBlockIdx));
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
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
                                            @RequestParam(defaultValue = "BLOCK") String ruleAction,
                                            @RequestParam(required = false) String controlMode,
                                            @RequestParam(defaultValue = "MANUAL") String blockCategory,
                                            @RequestParam(defaultValue = "1") Integer priority,
                                            @RequestParam(required = false) Long ipBlockBatchIdx,
                                            @RequestParam(required = false) String reason,
                                            @RequestParam(required = false) String detailMessage,
                                            @RequestParam(required = false) String expiresAt,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            LocalDateTime parsed = (expiresAt != null && !expiresAt.isBlank()) ? LocalDateTime.parse(expiresAt) : null;
            adminBlockService.createGlobalIpRule(matchType, ipAddress, cidrNotation, rangeStartIp, rangeEndIp,
                    countryCode, asn, ruleAction, controlMode, blockCategory, priority, ipBlockBatchIdx, reason, detailMessage, parsed,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 정책 규칙이 저장되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/ip-rules/{ipBlocklistIdx}/update")
    @ResponseBody
    public Map<String, Object> updateIpRule(@PathVariable Long ipBlocklistIdx,
                                            @RequestParam(defaultValue = "BLOCK") String ruleAction,
                                            @RequestParam(required = false) String controlMode,
                                            @RequestParam(defaultValue = "MANUAL") String blockCategory,
                                            @RequestParam(defaultValue = "1") Integer priority,
                                            @RequestParam(required = false) String reason,
                                            @RequestParam(required = false) String detailMessage,
                                            @RequestParam(required = false) String expiresAt,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            LocalDateTime parsed = (expiresAt != null && !expiresAt.isBlank()) ? LocalDateTime.parse(expiresAt) : null;
            adminBlockService.updateIpRule(ipBlocklistIdx, ruleAction, controlMode, blockCategory, priority,
                    reason, detailMessage, parsed, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 정책 규칙 설정이 저장되었습니다.");
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

    @PostMapping("/ip-rules/bulk-toggle")
    @ResponseBody
    public Map<String, Object> bulkToggleIpRules(@RequestParam List<Long> ipBlocklistIdxList,
                                                 @RequestParam boolean active,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.bulkToggleIpRules(ipBlocklistIdxList, active, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", ipBlocklistIdxList.size() + "개의 IP 규칙이 " + (active ? "활성화" : "비활성화") + "되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/ip-rules/{ipBlocklistIdx}/return-to-batch")
    @ResponseBody
    public Map<String, Object> returnIpRuleToBatch(@PathVariable Long ipBlocklistIdx,
                                                   HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.returnIpRuleToBatchControl(ipBlocklistIdx, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "규칙을 배치 제어 상태로 되돌렸습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/user-blocks/{blockIdx}/update")
    @ResponseBody
    public Map<String, Object> updateUserBlock(@PathVariable Long blockIdx,
                                               @RequestParam boolean active,
                                               @RequestParam(required = false) String reason,
                                               @RequestParam(required = false) String expiresAt,
                                               HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            LocalDateTime parsed = (expiresAt != null && !expiresAt.isBlank()) ? LocalDateTime.parse(expiresAt) : null;
            adminBlockService.updateUserBlock(blockIdx, active, reason, parsed,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", active ? "회원 차단 설정이 저장되었습니다." : "회원 차단이 해제되었습니다.");
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

    @PostMapping("/user-blocks/bulk-release")
    @ResponseBody
    public Map<String, Object> bulkReleaseUserBlocks(@RequestParam List<String> blockTargetKeys,
                                                     HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.bulkReleaseUserBlocks(blockTargetKeys, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", blockTargetKeys.size() + "개의 회원 차단이 해제되었습니다.");
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
                                           @RequestParam(defaultValue = "BLOCK") String batchRuleAction,
                                           @RequestParam(defaultValue = "1") Integer defaultRulePriority,
                                           @RequestParam(defaultValue = "BATCH_ONLY") String defaultDisableStrategy,
                                           @RequestParam(defaultValue = "BATCH_ONLY") String defaultEnableStrategy,
                                           @RequestParam(required = false) String description,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.createIpBlockBatch(batchCode, batchName, sourceType, sourceName,
                    batchRuleAction, defaultRulePriority, defaultDisableStrategy, defaultEnableStrategy, description,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 차단 배치가 생성되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/batches/{ipBlockBatchIdx}/update")
    @ResponseBody
    public Map<String, Object> updateBatch(@PathVariable Long ipBlockBatchIdx,
                                           @RequestParam String batchCode,
                                           @RequestParam String batchName,
                                           @RequestParam String sourceType,
                                           @RequestParam(required = false) String sourceName,
                                           @RequestParam(defaultValue = "BLOCK") String batchRuleAction,
                                           @RequestParam(defaultValue = "1") Integer defaultRulePriority,
                                           @RequestParam(defaultValue = "BATCH_ONLY") String defaultDisableStrategy,
                                           @RequestParam(defaultValue = "BATCH_ONLY") String defaultEnableStrategy,
                                           @RequestParam(required = false) String description,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.updateIpBlockBatch(ipBlockBatchIdx, batchCode, batchName, sourceType, sourceName,
                    batchRuleAction, defaultRulePriority, defaultDisableStrategy, defaultEnableStrategy, description,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "IP 정책 배치 설정이 저장되었습니다.");
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
                                           @RequestParam(required = false) String operationOption,
                                           @RequestParam(required = false) String description,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            adminBlockService.toggleIpBlockBatch(ipBlockBatchIdx, active, operationOption, description,
                    loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", active
                    ? "배치 상태가 활성으로 변경되었습니다."
                    : "배치 상태가 비활성으로 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}
