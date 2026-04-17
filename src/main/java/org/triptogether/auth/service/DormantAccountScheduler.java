package org.triptogether.auth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class DormantAccountScheduler {

    private final AuthService authService;

    @Scheduled(cron = "0 15 3 * * *")
    public void processDormantAccounts() {
        try {
            authService.processDormantAccounts();
        } catch (Exception e) {
            log.error("[DormantAccountScheduler] 휴면 전환 배치 오류", e);
        }
    }
}
