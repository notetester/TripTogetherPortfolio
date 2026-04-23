package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.common.vo.IpBlockRuleVO;

import java.math.BigInteger;
import java.net.InetAddress;
import java.util.List;

@Component
@RequiredArgsConstructor
public class IpBlockInterceptor implements HandlerInterceptor {

    private final IpBlockMapper ipBlockMapper;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        String ip = normalizeIp(getClientIp(request));
        if (ip != null && isBlockedByRule(ip)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "접근이 차단된 IP입니다.");
            return false;
        }
        return true;
    }

    private boolean isBlockedByRule(String clientIp) {
        List<IpBlockRuleVO> rules = ipBlockMapper.findActiveIpBlockRules();
        if (rules == null || rules.isEmpty()) return false;
        for (IpBlockRuleVO rule : rules) {
            if (rule == null) continue;
            if (matchesRule(clientIp, rule)) {
                return !"ALLOW".equalsIgnoreCase(rule.getRuleAction());
            }
        }
        return false;
    }

    private boolean matchesRule(String clientIp, IpBlockRuleVO rule) {
        String matchType = rule.getMatchType() == null ? "SINGLE_IP" : rule.getMatchType().trim().toUpperCase();
        return switch (matchType) {
            case "SINGLE_IP" -> clientIp.equals(normalizeIp(rule.getIpAddress()));
            case "CIDR" -> matchesCidr(clientIp, rule.getCidrNotation());
            case "RANGE" -> matchesRange(clientIp, rule.getRangeStartIp(), rule.getRangeEndIp());
            default -> false; // COUNTRY / ASN 등은 추후 별도 데이터 소스가 붙을 때 확장
        };
    }

    private boolean matchesCidr(String clientIp, String cidr) {
        if (cidr == null || cidr.isBlank()) return false;
        try {
            String[] parts = cidr.split("/");
            if (parts.length != 2) return false;
            InetAddress client = InetAddress.getByName(clientIp);
            InetAddress subnet = InetAddress.getByName(parts[0].trim());
            int prefix = Integer.parseInt(parts[1].trim());
            byte[] clientBytes = client.getAddress();
            byte[] subnetBytes = subnet.getAddress();
            if (clientBytes.length != subnetBytes.length) return false;

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
        if (startIp == null || endIp == null || startIp.isBlank() || endIp.isBlank()) return false;
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
}
