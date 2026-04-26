package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/moderation")
public class AdminModerationController {

    private static final Set<String> VALID_LEVELS = Set.of("STRICT", "NORMAL", "LOOSE");

    private final ModerationPolicyService moderationPolicyService;

    @GetMapping({"", "/"})
    public String page(Model model) {
        model.addAttribute("policy", moderationPolicyService.getPolicy());
        model.addAttribute("activeMenu", "moderation");
        return "admin/moderation/index";
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> update(
            @RequestParam String toxicityLevel,
            @RequestParam int postWindowMinutes,
            @RequestParam int postMaxCount,
            @RequestParam int commentWindowMinutes,
            @RequestParam int commentMaxCount,
            @RequestParam int inquiryWindowMinutes,
            @RequestParam int inquiryMaxCount,
            @RequestParam int reportThreshold,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();

        if (toxicityLevel == null || !VALID_LEVELS.contains(toxicityLevel)) {
            res.put("success", false);
            res.put("message", "민감도 값이 올바르지 않습니다.");
            return ResponseEntity.badRequest().body(res);
        }
        if (postWindowMinutes < 1 || postMaxCount < 1
                || commentWindowMinutes < 1 || commentMaxCount < 1
                || inquiryWindowMinutes < 1 || inquiryMaxCount < 1
                || reportThreshold < 1) {
            res.put("success", false);
            res.put("message", "모든 숫자는 1 이상이어야 합니다.");
            return ResponseEntity.badRequest().body(res);
        }

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long updatedBy = (loginUser != null) ? loginUser.getUserIdx() : null;

        ContentModerationPolicyVO policy = new ContentModerationPolicyVO();
        policy.setToxicityLevel(toxicityLevel);
        policy.setPostWindowMinutes(postWindowMinutes);
        policy.setPostMaxCount(postMaxCount);
        policy.setCommentWindowMinutes(commentWindowMinutes);
        policy.setCommentMaxCount(commentMaxCount);
        policy.setInquiryWindowMinutes(inquiryWindowMinutes);
        policy.setInquiryMaxCount(inquiryMaxCount);
        policy.setReportThreshold(reportThreshold);
        policy.setUpdatedByUserIdx(updatedBy);

        moderationPolicyService.updatePolicy(policy);

        res.put("success", true);
        return ResponseEntity.ok(res);
    }
}
