package org.triptogether.common.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.triptogether.config.IpBlockInterceptor;

import java.util.Locale;
import java.util.Set;

/**
 * 보안 정책 차단 안내 화면.
 *
 * <p>사용자에게는 우회 단서가 될 수 있는 상세 규칙 키/사유를 노출하지 않고,
 * 요청 ID와 최소 지원 정보만 제공한다. 상세 근거는 BLOCK_ACCESS_LOG에서 확인한다.</p>
 */
@Controller
public class BlockedAccessController {

    private static final Set<String> SUPPORTED_LANGS = Set.of("ko", "en", "ja", "zh");

    @GetMapping("/blocked-access")
    public String blockedAccess(HttpServletRequest request, Locale locale, Model model) {
        model.addAttribute("requestId", attrOrParam(request, IpBlockInterceptor.ATTR_BLOCK_REQUEST_ID, "requestId"));
        model.addAttribute("blockKind", normalizeBlockKind(attrOrParam(request, IpBlockInterceptor.ATTR_BLOCK_KIND, "blockKind")));
        model.addAttribute("clientIp", attrOrParam(request, IpBlockInterceptor.ATTR_BLOCK_CLIENT_IP, "clientIp"));

        String pageLang = normalizeLang(locale == null ? null : locale.getLanguage());
        if (pageLang == null) {
            pageLang = normalizeLang(String.valueOf(attr(request, IpBlockInterceptor.ATTR_BLOCK_LANG)));
        }
        model.addAttribute("pageLang", pageLang == null ? "ko" : pageLang);
        return "error/blockedAccess";
    }

    private Object attr(HttpServletRequest request, String key) {
        Object value = request.getAttribute(key);
        return value == null ? "" : value;
    }

    private String attrOrParam(HttpServletRequest request, String attrKey, String paramKey) {
        Object value = request.getAttribute(attrKey);
        if (value != null && !String.valueOf(value).isBlank()) {
            return String.valueOf(value);
        }
        String param = request.getParameter(paramKey);
        return param == null ? "" : param;
    }

    private String normalizeBlockKind(String value) {
        if (value == null) return "";
        String normalized = value.trim().toUpperCase(Locale.ROOT);
        return "USER".equals(normalized) ? "USER" : "IP";
    }

    private String normalizeLang(String value) {
        if (value == null) return null;
        String lang = value.trim().toLowerCase(Locale.ROOT);
        if (lang.contains("_")) lang = lang.substring(0, lang.indexOf('_'));
        if (lang.contains("-")) lang = lang.substring(0, lang.indexOf('-'));
        return SUPPORTED_LANGS.contains(lang) ? lang : null;
    }
}
