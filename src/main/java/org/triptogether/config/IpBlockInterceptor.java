package org.triptogether.config;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.mapper.BlockAccessLogMapper;
import org.triptogether.common.vo.BlockAccessLogVO;
import org.triptogether.common.vo.BlockDecisionVO;
import org.triptogether.common.vo.IpBlockRuleVO;
import org.triptogether.common.vo.UserBlockRuleVO;

import java.math.BigInteger;
import java.net.InetAddress;
import java.util.List;
import java.util.UUID;

/**
 * 애플리케이션 레벨 IP/회원 차단 인터셉터.
 *
 * <p>대량 DDoS 방어는 CDN/WAF/Nginx 같은 앞단 계층에서 처리하고,
 * 이 인터셉터는 로그인 실패, 악성 회원, 챗봇/API 남용처럼 애플리케이션 문맥이 필요한
 * 정밀 차단 정책을 빠르게 적용하는 역할을 맡는다.</p>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class IpBlockInterceptor implements HandlerInterceptor {

    public static final String ATTR_BLOCK_REQUEST_ID = "block.requestId";
    public static final String ATTR_BLOCK_KIND = "block.kind";
    public static final String ATTR_BLOCK_MATCH_TYPE = "block.matchType";
    public static final String ATTR_BLOCK_TARGET_KEY = "block.targetKey";
    public static final String ATTR_BLOCK_REASON = "block.reason";
    public static final String ATTR_BLOCK_CLIENT_IP = "block.clientIp";
    public static final String ATTR_BLOCK_COUNTRY_CODE = "block.countryCode";
    public static final String ATTR_BLOCK_ASN = "block.asn";

    private final BlockRuleCacheService blockRuleCacheService;
    private final BlockAccessLogMapper blockAccessLogMapper;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        String clientIp = normalizeIp(getClientIp(request));
        String countryCode = resolveCountryCode(request);
        String asn = resolveAsn(request);
        HttpSession session = request.getSession(false);
        UsersVO loginUser = session == null ? null : (UsersVO) session.getAttribute("loginUser");

        BlockRuleCacheService.BlockRuleCacheSnapshot snapshot = blockRuleCacheService.getSnapshot();
        BlockDecisionVO userDecision = evaluateUserBlock(loginUser, clientIp, snapshot.getUserRules());
        if (userDecision.isBlocked()) {
            handleBlockedRequest(request, response, handler, userDecision, clientIp, countryCode, asn, snapshot.getSource());
            return false;
        }

        BlockDecisionVO ipDecision = evaluateIpBlock(clientIp, countryCode, asn, snapshot.getIpRules());
        if (ipDecision.isBlocked()) {
            handleBlockedRequest(request, response, handler, ipDecision, clientIp, countryCode, asn, snapshot.getSource());
            return false;
        }
        return true;
    }

    private BlockDecisionVO evaluateUserBlock(UsersVO loginUser, String clientIp, List<UserBlockRuleVO> rules) {
        if (loginUser == null || loginUser.getUserIdx() == null) {
            return BlockDecisionVO.allow();
        }
        if ("BLOCKED".equalsIgnoreCase(loginUser.getAccountStatus())) {
            UserBlockRuleVO accountRule = new UserBlockRuleVO();
            accountRule.setUserIdx(loginUser.getUserIdx());
            accountRule.setBlockTargetKey("USER:" + loginUser.getUserIdx());
            accountRule.setBlockType("ACCOUNT_STATUS");
            accountRule.setReason(loginUser.getBlockedReason() == null ? "계정 상태가 BLOCKED 입니다." : loginUser.getBlockedReason());
            return BlockDecisionVO.blockUser(accountRule);
        }
        if (rules == null || rules.isEmpty()) {
            return BlockDecisionVO.allow();
        }
        for (UserBlockRuleVO rule : rules) {
            if (rule == null || rule.getUserIdx() == null) continue;
            if (!rule.getUserIdx().equals(loginUser.getUserIdx())) continue;
            String blockType = rule.getBlockType() == null ? "USER_ONLY" : rule.getBlockType().trim().toUpperCase();
            if ("USER_ONLY".equals(blockType)) {
                return BlockDecisionVO.blockUser(rule);
            }
            if ("USER_IP".equals(blockType) && clientIp != null && clientIp.equals(normalizeIp(rule.getBlockedIp()))) {
                return BlockDecisionVO.blockUser(rule);
            }
        }
        return BlockDecisionVO.allow();
    }

    private BlockDecisionVO evaluateIpBlock(String clientIp, String countryCode, String asn, List<IpBlockRuleVO> rules) {
        if (rules == null || rules.isEmpty()) return BlockDecisionVO.allow();
        for (IpBlockRuleVO rule : rules) {
            if (rule == null) continue;
            String matchedType = matchedType(clientIp, countryCode, asn, rule);
            if (matchedType == null) continue;
            if ("ALLOW".equalsIgnoreCase(rule.getRuleAction())) {
                return BlockDecisionVO.allow();
            }
            return BlockDecisionVO.blockIp(rule, matchedType);
        }
        return BlockDecisionVO.allow();
    }

    private String matchedType(String clientIp, String countryCode, String asn, IpBlockRuleVO rule) {
        String matchType = rule.getMatchType() == null ? "SINGLE_IP" : rule.getMatchType().trim().toUpperCase();
        return switch (matchType) {
            case "SINGLE_IP" -> clientIp != null && clientIp.equals(normalizeIp(rule.getIpAddress())) ? "SINGLE_IP" : null;
            case "CIDR" -> matchesCidr(clientIp, rule.getCidrNotation()) ? "CIDR" : null;
            case "RANGE" -> matchesRange(clientIp, rule.getRangeStartIp(), rule.getRangeEndIp()) ? "RANGE" : null;
            case "COUNTRY" -> matchesCountry(countryCode, rule) ? "COUNTRY" : null;
            case "ASN" -> matchesAsn(asn, rule) ? "ASN" : null;
            default -> null;
        };
    }

    private boolean matchesCountry(String requestCountryCode, IpBlockRuleVO rule) {
        String requestCountry = normalizeCountry(requestCountryCode);
        if (requestCountry == null) return false;
        String ruleCountry = normalizeCountry(rule.getCountryCode());
        if (ruleCountry == null && rule.getBlockTargetKey() != null && rule.getBlockTargetKey().toUpperCase().startsWith("COUNTRY:")) {
            ruleCountry = normalizeCountry(rule.getBlockTargetKey().substring("COUNTRY:".length()));
        }
        return requestCountry.equals(ruleCountry);
    }

    private boolean matchesAsn(String requestAsn, IpBlockRuleVO rule) {
        String normalizedRequestAsn = normalizeAsn(requestAsn);
        if (normalizedRequestAsn == null) return false;
        String ruleAsn = normalizeAsn(rule.getAsn());
        if (ruleAsn == null && rule.getBlockTargetKey() != null && rule.getBlockTargetKey().toUpperCase().startsWith("ASN:")) {
            ruleAsn = normalizeAsn(rule.getBlockTargetKey().substring("ASN:".length()));
        }
        return normalizedRequestAsn.equals(ruleAsn);
    }

    private void handleBlockedRequest(HttpServletRequest request,
                                      HttpServletResponse response,
                                      Object handler,
                                      BlockDecisionVO decision,
                                      String clientIp,
                                      String countryCode,
                                      String asn,
                                      String cacheSource) throws Exception {
        String requestId = UUID.randomUUID().toString();
        request.setAttribute(ATTR_BLOCK_REQUEST_ID, requestId);
        request.setAttribute(ATTR_BLOCK_KIND, decision.getBlockKind());
        request.setAttribute(ATTR_BLOCK_MATCH_TYPE, decision.getMatchType());
        request.setAttribute(ATTR_BLOCK_TARGET_KEY, decision.getTargetKey());
        request.setAttribute(ATTR_BLOCK_REASON, firstNonBlank(decision.getReason(), decision.getDetailMessage(), "보안 정책에 의해 접근이 제한되었습니다."));
        request.setAttribute(ATTR_BLOCK_CLIENT_IP, clientIp);
        request.setAttribute(ATTR_BLOCK_COUNTRY_CODE, countryCode);
        request.setAttribute(ATTR_BLOCK_ASN, asn);

        logBlockedRequest(request, handler, decision, requestId, clientIp, countryCode, asn, cacheSource);

        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/blocked-access");
        dispatcher.forward(request, response);
    }

    private void logBlockedRequest(HttpServletRequest request,
                                   Object handler,
                                   BlockDecisionVO decision,
                                   String requestId,
                                   String clientIp,
                                   String countryCode,
                                   String asn,
                                   String cacheSource) {
        try {
            HttpSession session = request.getSession(false);
            UsersVO loginUser = session == null ? null : (UsersVO) session.getAttribute("loginUser");
            String handlerName = null;
            if (handler instanceof HandlerMethod hm) {
                handlerName = hm.getBeanType().getSimpleName() + "#" + hm.getMethod().getName();
            }
            Long userIdx = decision.getUserIdx() != null ? decision.getUserIdx() : (loginUser == null ? null : loginUser.getUserIdx());
            blockAccessLogMapper.insertBlockAccessLog(BlockAccessLogVO.builder()
                    .requestId(requestId)
                    .flowTraceId(requestId)
                    .userIdx(userIdx)
                    .sessionId(session == null ? null : session.getId())
                    .requestUri(request.getRequestURI())
                    .httpMethod(request.getMethod())
                    .activityDomain(resolveActivityDomain(request.getRequestURI()))
                    .activityType(resolveActivityType(request))
                    .activityCode("BLOCKED_ACCESS")
                    .activityProvider(resolveActivityProvider(request.getRequestURI()))
                    .authEventType(request.getRequestURI() != null && request.getRequestURI().contains("/auth/") ? "BLOCKED" : null)
                    .handlerName(handlerName)
                    .queryString(sanitizeQueryString(request.getQueryString()))
                    .referer(sanitizeReferer(request.getHeader("Referer")))
                    .ipAddress(clientIp)
                    .userAgent(request.getHeader("User-Agent"))
                    .responseStatus(HttpServletResponse.SC_FORBIDDEN)
                    .responseTimeMs(0)
                    .success(false)
                    .detailSummary("차단된 요청: kind=" + decision.getBlockKind() + ", matchType=" + decision.getMatchType() + ", target=" + decision.getTargetKey())
                    .blockKind(decision.getBlockKind())
                    .blockMatchType(decision.getMatchType())
                    .blockTargetKey(decision.getTargetKey())
                    .blockRequestId(decision.getRequestId())
                    .blockRuleIdx(decision.getRuleIdx())
                    .blockReason(firstNonBlank(decision.getReason(), decision.getDetailMessage(), "보안 정책 차단"))
                    .countryCode(countryCode)
                    .asn(asn)
                    .cacheSource(cacheSource)
                    .build());
        } catch (Exception e) {
            log.warn("[BlockAccessLog] 차단 요청 로그 저장 실패: {}", e.getMessage());
        }
    }

    private String resolveActivityDomain(String uri) {
        if (uri == null) return "GENERAL";
        if (uri.contains("/auth/")) return "AUTH";
        if (uri.contains("/admin/")) return "ADMIN";
        if (uri.contains("/community/")) return "COMMUNITY";
        if (uri.contains("/mypage/")) return "MYPAGE";
        if (uri.contains("/inquiry/")) return "INQUIRY";
        if (uri.contains("/assistant") || uri.contains("/chatbot")) return "AI";
        return "GENERAL";
    }

    private String resolveActivityType(HttpServletRequest request) {
        String xrw = request.getHeader("X-Requested-With");
        String uri = request.getRequestURI();
        if (uri != null && uri.contains("/api/")) return "API";
        if ("XMLHttpRequest".equalsIgnoreCase(xrw)) return "AJAX";
        if ("GET".equalsIgnoreCase(request.getMethod())) return "PAGE_VIEW";
        return "ACTION";
    }

    private String resolveActivityProvider(String uri) {
        if (uri == null) return null;
        if (uri.contains("/auth/kakao")) return "KAKAO";
        if (uri.contains("/auth/naver")) return "NAVER";
        if (uri.contains("/auth/google")) return "GOOGLE";
        if (uri.contains("/auth/")) return "LOCAL";
        return null;
    }

    private boolean matchesCidr(String clientIp, String cidr) {
        if (clientIp == null || cidr == null || cidr.isBlank()) return false;
        try {
            String[] parts = cidr.split("/");
            if (parts.length != 2) return false;
            InetAddress client = InetAddress.getByName(clientIp);
            InetAddress subnet = InetAddress.getByName(parts[0].trim());
            int prefix = Integer.parseInt(parts[1].trim());
            byte[] clientBytes = client.getAddress();
            byte[] subnetBytes = subnet.getAddress();
            if (clientBytes.length != subnetBytes.length) return false;
            if (prefix < 0 || prefix > clientBytes.length * 8) return false;

            BigInteger clientInt = new BigInteger(1, clientBytes);
            BigInteger subnetInt = new BigInteger(1, subnetBytes);
            int totalBits = clientBytes.length * 8;
            BigInteger mask = prefix == 0
                    ? BigInteger.ZERO
                    : BigInteger.ONE.shiftLeft(totalBits).subtract(BigInteger.ONE)
                    .shiftRight(totalBits - prefix)
                    .shiftLeft(totalBits - prefix);
            return clientInt.and(mask).equals(subnetInt.and(mask));
        } catch (Exception e) {
            return false;
        }
    }

    private boolean matchesRange(String clientIp, String startIp, String endIp) {
        if (clientIp == null || startIp == null || endIp == null || startIp.isBlank() || endIp.isBlank()) return false;
        try {
            BigInteger client = ipToBigInteger(clientIp);
            BigInteger start = ipToBigInteger(startIp);
            BigInteger end = ipToBigInteger(endIp);
            if (client == null || start == null || end == null) return false;
            return client.compareTo(start) >= 0 && client.compareTo(end) <= 0;
        } catch (Exception e) {
            return false;
        }
    }

    private BigInteger ipToBigInteger(String ip) {
        try {
            return new BigInteger(1, InetAddress.getByName(normalizeIp(ip)).getAddress());
        } catch (Exception e) {
            return null;
        }
    }

    private String getClientIp(HttpServletRequest request) {
        String[] headers = {
                "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP",
                "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR"
        };
        for (String h : headers) {
            String ip = request.getHeader(h);
            if (ip != null && !ip.isBlank() && !"unknown".equalsIgnoreCase(ip)) {
                return ip.split(",")[0].trim();
            }
        }
        return request.getRemoteAddr();
    }

    private String resolveCountryCode(HttpServletRequest request) {
        return normalizeCountry(firstNonBlank(
                request.getHeader("CF-IPCountry"),
                request.getHeader("CloudFront-Viewer-Country"),
                request.getHeader("X-Country-Code"),
                request.getHeader("X-App-Country-Code")
        ));
    }

    private String resolveAsn(HttpServletRequest request) {
        return normalizeAsn(firstNonBlank(
                request.getHeader("CF-ASN"),
                request.getHeader("X-ASN"),
                request.getHeader("X-App-ASN")
        ));
    }

    private String normalizeIp(String ip) {
        if (ip == null) return null;
        String trimmed = ip.trim();
        if ("0:0:0:0:0:0:0:1".equals(trimmed) || "::1".equals(trimmed)) {
            return "127.0.0.1";
        }
        if (trimmed.startsWith("::ffff:")) {
            return trimmed.substring(7);
        }
        return trimmed;
    }

    private String normalizeCountry(String countryCode) {
        if (countryCode == null || countryCode.isBlank()) return null;
        String normalized = countryCode.trim().toUpperCase();
        if ("XX".equals(normalized) || "UNKNOWN".equals(normalized)) return null;
        return normalized.length() > 2 ? normalized.substring(0, 2) : normalized;
    }

    private String normalizeAsn(String asn) {
        if (asn == null || asn.isBlank()) return null;
        String normalized = asn.trim().toUpperCase();
        if (normalized.startsWith("AS")) normalized = normalized.substring(2);
        normalized = normalized.replaceAll("[^0-9]", "");
        return normalized.isBlank() ? null : normalized;
    }

    private String firstNonBlank(String... values) {
        if (values == null) return null;
        for (String value : values) {
            if (value != null && !value.isBlank()) return value;
        }
        return null;
    }

    private String sanitizeQueryString(String queryString) {
        if (queryString == null || queryString.isBlank()) return queryString;
        return queryString.replaceAll("(?i)(password|token|code|state)=([^&]*)", "$1=***");
    }

    private String sanitizeReferer(String referer) {
        if (referer == null || referer.isBlank()) return referer;
        int q = referer.indexOf('?');
        return q < 0 ? referer : referer.substring(0, q) + "?***";
    }
}
