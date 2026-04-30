package org.triptogether.common.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.triptogether.config.IpBlockInterceptor;

/**
 * 보안 정책 차단 안내 화면.
 */
@Controller
public class BlockedAccessController {

    @GetMapping("/blocked-access")
    public String blockedAccess(HttpServletRequest request, Model model) {
        model.addAttribute("requestId", attr(request, IpBlockInterceptor.ATTR_BLOCK_REQUEST_ID));
        model.addAttribute("blockKind", attr(request, IpBlockInterceptor.ATTR_BLOCK_KIND));
        model.addAttribute("matchType", attr(request, IpBlockInterceptor.ATTR_BLOCK_MATCH_TYPE));
        model.addAttribute("targetKey", attr(request, IpBlockInterceptor.ATTR_BLOCK_TARGET_KEY));
        model.addAttribute("reason", attr(request, IpBlockInterceptor.ATTR_BLOCK_REASON));
        model.addAttribute("clientIp", attr(request, IpBlockInterceptor.ATTR_BLOCK_CLIENT_IP));
        model.addAttribute("countryCode", attr(request, IpBlockInterceptor.ATTR_BLOCK_COUNTRY_CODE));
        model.addAttribute("asn", attr(request, IpBlockInterceptor.ATTR_BLOCK_ASN));
        return "error/blockedAccess";
    }

    private Object attr(HttpServletRequest request, String key) {
        Object value = request.getAttribute(key);
        return value == null ? "" : value;
    }
}
