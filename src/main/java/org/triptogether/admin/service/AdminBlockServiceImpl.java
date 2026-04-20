package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminBlockMapper;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.config.IpBlockMapper;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AdminBlockServiceImpl implements AdminBlockService {

    private final AdminBlockMapper adminBlockMapper;
    private final AdminMapper adminMapper;
    private final IpBlockMapper ipBlockMapper;

    @Override
    public Map<String, Object> getBlockDashboard(AdminBlockSearchVO search) {
        Map<String, Object> result = new HashMap<>();
        result.put("search", search);
        result.put("activeUserBlockCount", adminBlockMapper.countActiveUserBlocks());
        result.put("activeIpBlockCount", adminBlockMapper.countActiveIpBlocks());
        result.put("blockHistoryCount", adminBlockMapper.countBlockHistories());
        result.put("activeBatchCount", adminBlockMapper.countActiveBatches());
        result.put("userBlocks", adminBlockMapper.findUserBlocks(search));
        result.put("ipBlocks", adminBlockMapper.findIpBlocks(search));
        result.put("histories", adminBlockMapper.findBlockHistories(search));
        result.put("batches", adminBlockMapper.findIpBlockBatches(search));
        return result;
    }

    @Override
    public void createIpBlockBatch(String batchCode, String batchName, String sourceType, String sourceName, String description, Long actorUserIdx) {
        if (isBlank(batchCode) || isBlank(batchName) || isBlank(sourceType)) {
            throw new IllegalArgumentException("배치 코드, 배치명, 출처 유형은 필수입니다.");
        }
        adminBlockMapper.insertIpBlockBatch(batchCode.trim().toUpperCase(), batchName.trim(), sourceType.trim().toUpperCase(), trimToNull(sourceName), trimToNull(description), actorUserIdx);
    }

    @Override
    public void toggleIpBlockBatch(Long ipBlockBatchIdx, boolean active, Long actorUserIdx) {
        adminBlockMapper.updateIpBlockBatchActive(ipBlockBatchIdx, active, actorUserIdx);
    }

    @Override
    public void createGlobalIpRule(String matchType, String ipAddress, String cidrNotation, String rangeStartIp, String rangeEndIp,
                                   String countryCode, String asn, String blockCategory, Integer priority, Long ipBlockBatchIdx,
                                   String reason, LocalDateTime expiresAt, Long actorUserIdx) {
        String normalizedType = safeUpper(matchType, "SINGLE_IP");
        String normalizedCategory = safeUpper(blockCategory, "MANUAL");
        String normalizedIp = normalizeIp(ipAddress);
        String normalizedCidr = trimToNull(cidrNotation);
        String normalizedRangeStart = normalizeIp(rangeStartIp);
        String normalizedRangeEnd = normalizeIp(rangeEndIp);
        String normalizedCountry = trimToNull(countryCode) != null ? trimToNull(countryCode).toUpperCase() : null;
        String normalizedAsn = trimToNull(asn) != null ? trimToNull(asn).toUpperCase() : null;

        String representativeIp;
        String targetKey;
        switch (normalizedType) {
            case "SINGLE_IP" -> {
                if (isBlank(normalizedIp)) throw new IllegalArgumentException("단일 IP 차단은 IP 주소가 필요합니다.");
                representativeIp = normalizedIp;
                targetKey = "IP:" + normalizedIp;
            }
            case "CIDR" -> {
                if (isBlank(normalizedCidr) || !normalizedCidr.contains("/")) {
                    throw new IllegalArgumentException("CIDR 차단은 올바른 CIDR 표기가 필요합니다.");
                }
                representativeIp = normalizedCidr.substring(0, normalizedCidr.indexOf('/')).trim();
                targetKey = "CIDR:" + normalizedCidr;
            }
            case "RANGE" -> {
                if (isBlank(normalizedRangeStart) || isBlank(normalizedRangeEnd)) {
                    throw new IllegalArgumentException("범위 차단은 시작 IP와 끝 IP가 필요합니다.");
                }
                representativeIp = normalizedRangeStart;
                targetKey = "RANGE:" + normalizedRangeStart + "~" + normalizedRangeEnd;
            }
            case "COUNTRY" -> {
                if (isBlank(normalizedCountry)) throw new IllegalArgumentException("국가 차단은 국가 코드가 필요합니다.");
                representativeIp = "COUNTRY:" + normalizedCountry;
                targetKey = "COUNTRY:" + normalizedCountry;
            }
            case "ASN" -> {
                if (isBlank(normalizedAsn)) throw new IllegalArgumentException("ASN 차단은 ASN 코드가 필요합니다.");
                representativeIp = normalizedAsn;
                targetKey = "ASN:" + normalizedAsn;
            }
            default -> throw new IllegalArgumentException("지원하지 않는 매칭 방식입니다.");
        }

        String requestId = UUID.randomUUID().toString();
        adminBlockMapper.insertGlobalBlockHistory(
                requestId,
                targetKey,
                "BLOCK",
                "GLOBAL",
                null,
                "IP_ONLY",
                representativeIp,
                normalizedType,
                normalizedCidr,
                normalizedRangeStart,
                normalizedRangeEnd,
                ipBlockBatchIdx,
                trimToNull(reason),
                actorUserIdx,
                expiresAt
        );
        Long historyIdx = adminBlockMapper.findBlockHistoryIdxByRequestId(requestId);
        adminBlockMapper.upsertIpBlockRule(
                representativeIp,
                targetKey,
                requestId,
                historyIdx,
                normalizedType,
                normalizedCidr,
                normalizedRangeStart,
                normalizedRangeEnd,
                normalizedCountry,
                normalizedAsn,
                "GLOBAL",
                normalizedCategory,
                null,
                "IP_ONLY",
                actorUserIdx,
                trimToNull(reason),
                expiresAt,
                priority != null ? priority : 1,
                ipBlockBatchIdx,
                null,
                false,
                null,
                null
        );
    }

    @Override
    public void toggleIpRule(Long ipBlocklistIdx, boolean active, Long actorUserIdx) {
        AdminIpBlockVO rule = adminBlockMapper.findIpBlockById(ipBlocklistIdx);
        if (rule == null) throw new IllegalArgumentException("IP 차단 규칙을 찾을 수 없습니다.");
        if (!active) {
            adminBlockMapper.updateIpBlockRuleActive(ipBlocklistIdx, false, actorUserIdx);
            adminBlockMapper.deactivateBlockHistoriesByTargetKey(rule.getBlockTargetKey(), actorUserIdx, "RELEASE");
            return;
        }
        createGlobalIpRule(rule.getMatchType(), rule.getIpAddress(), rule.getCidrNotation(), rule.getRangeStartIp(), rule.getRangeEndIp(),
                rule.getCountryCode(), rule.getAsn(), rule.getBlockCategory(), rule.getPriority(), rule.getIpBlockBatchIdx(),
                rule.getReason(), rule.getExpiresAt(), actorUserIdx);
    }

    @Override
    public void releaseUserBlock(String blockTargetKey, Long actorUserIdx) {
        AdminUserBlockVO current = adminBlockMapper.findUserBlockByTargetKey(blockTargetKey);
        if (current == null) throw new IllegalArgumentException("현재 차단 상태를 찾을 수 없습니다.");

        adminBlockMapper.updateUserBlocklistActiveByTargetKey(blockTargetKey, false, actorUserIdx, "RELEASED");
        adminBlockMapper.deactivateBlockHistoriesByTargetKey(blockTargetKey, actorUserIdx, "RELEASE");

        if (current.getBlockedIp() != null && !current.getBlockedIp().isBlank()) {
            refreshIpRuleFromHistory(current.getBlockedIp());
        }
        if (current.getUserIdx() != null && ("USER_ONLY".equals(current.getBlockType()) || "USER_IP".equals(current.getBlockType()))) {
            long remain = adminBlockMapper.countOtherActiveUserBlocks(current.getUserIdx(), blockTargetKey);
            if (remain == 0) {
                adminMapper.clearMemberBlockState(current.getUserIdx());
                adminMapper.updateMemberStatus(current.getUserIdx(), "ACTIVE");
            }
        }
    }

    private void refreshIpRuleFromHistory(String ipAddress) {
        if (ipAddress == null || ipAddress.isBlank()) return;
        String normalizedIp = normalizeIp(ipAddress);
        var latest = ipBlockMapper.findLatestActiveHistoryRuleByIp(normalizedIp);
        if (latest == null) {
            ipBlockMapper.deactivateBlockedIpByTargetKey("IP:" + normalizedIp, null);
            return;
        }
        ipBlockMapper.upsertBlockedIpWithHistory(
                normalizedIp,
                "IP:" + normalizedIp,
                latest.getReason(),
                latest.getUserIdx(),
                latest.getBlockType(),
                latest.getBlockedByUserIdx(),
                latest.getExpiresAt(),
                latest.getBlockRequestId(),
                latest.getSourceHistoryBlockIdx(),
                latest.getSourceBlocklistIdx()
        );
    }

    private String normalizeIp(String ip) {
        if (ip == null) return null;
        String trimmed = ip.trim();
        if (trimmed.isBlank()) return null;
        if ("0:0:0:0:0:0:0:1".equals(trimmed) || "::1".equals(trimmed)) return "127.0.0.1";
        if (trimmed.startsWith("::ffff:")) return trimmed.substring(7);
        return trimmed;
    }

    private static String trimToNull(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private static String safeUpper(String value, String fallback) {
        String base = isBlank(value) ? fallback : value.trim();
        return base.toUpperCase();
    }
}
