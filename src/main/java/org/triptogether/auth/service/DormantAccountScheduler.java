package org.triptogether.auth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.triptogether.admin.service.AdminPolicyService;

@Slf4j
@Component
@RequiredArgsConstructor
public class DormantAccountScheduler {

    private final AdminPolicyService adminPolicyService;

    @Scheduled(fixedDelay = 300000L, initialDelay = 60000L)
    public void processDormantAccounts() {
        try {
            adminPolicyService.processDuePolicies();
        } catch (Exception e) {
            log.error("[DormantAccountScheduler] 운영 정책 배치 오류", e);
        }
    }
}
