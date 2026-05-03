package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class HttpWafSyncProvider implements WafSyncProvider {

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final List<WafSyncAdapter> wafSyncAdapters;

    @Override
    public boolean supports(SecurityWafSyncQueueVO item) {
        return loginRiskPolicyMapper.findEnabledWafProviderConfigs().stream()
                .anyMatch(provider -> wafSyncAdapters.stream().anyMatch(adapter -> adapter.supports(provider, item)));
    }

    @Override
    public WafSyncResult sync(SecurityWafSyncQueueVO item) {
        List<WafSyncResult> results = new ArrayList<>();

        for (SecurityAssessmentProviderConfigVO provider : loginRiskPolicyMapper.findEnabledWafProviderConfigs()) {
            for (WafSyncAdapter adapter : wafSyncAdapters) {
                if (adapter.supports(provider, item)) {
                    results.add(adapter.sync(provider, item));
                    break;
                }
            }
        }

        if (results.isEmpty()) {
            return WafSyncResult.builder()
                    .handled(false)
                    .success(false)
                    .status("EXTERNAL_PROVIDER_PENDING")
                    .message("No enabled WAF provider configuration")
                    .build();
        }

        boolean hasFailed = results.stream().anyMatch(result -> "FAILED".equals(result.getStatus()));
        boolean hasPending = results.stream().anyMatch(result -> "EXTERNAL_PROVIDER_PENDING".equals(result.getStatus()));
        boolean allSynced = results.stream().allMatch(result -> "SYNCED".equals(result.getStatus()));

        String finalStatus;
        boolean success;
        if (hasFailed) {
            finalStatus = "FAILED";
            success = false;
        } else if (hasPending) {
            finalStatus = "EXTERNAL_PROVIDER_PENDING";
            success = false;
        } else if (allSynced) {
            finalStatus = "SYNCED";
            success = true;
        } else {
            finalStatus = "EXTERNAL_PROVIDER_PENDING";
            success = false;
        }

        return WafSyncResult.builder()
                .handled(true)
                .success(success)
                .status(finalStatus)
                .message(joinMessages(results))
                .build();
    }

    private String joinMessages(List<WafSyncResult> results) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < results.size(); i++) {
            WafSyncResult result = results.get(i);
            if (i > 0) {
                builder.append(System.lineSeparator()).append("---").append(System.lineSeparator());
            }
            builder.append("status=").append(result.getStatus())
                    .append("; success=").append(result.isSuccess())
                    .append("; message=").append(result.getMessage());
        }
        return builder.toString();
    }
}
