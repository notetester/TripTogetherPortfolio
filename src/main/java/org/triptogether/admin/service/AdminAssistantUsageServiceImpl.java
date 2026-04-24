package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminAssistantUsageMapper;
import org.triptogether.admin.vo.AdminAssistantUsageVO;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AdminAssistantUsageServiceImpl implements AdminAssistantUsageService {

    private final AdminAssistantUsageMapper usageMapper;

    @Override
    public AdminAssistantUsageVO getUsage(Long userIdx, String ipAddress, LocalDateTime periodStart) {
        return usageMapper.selectUsage(userIdx, ipAddress, periodStart);
    }

    @Override
    @Transactional
    public void incrementMessageCount(Long userIdx, String ipAddress, LocalDateTime periodStart) {
        usageMapper.upsertMessageIncrement(userIdx, ipAddress, periodStart);
    }

    @Override
    @Transactional
    public void incrementSessionCount(Long userIdx, String ipAddress, LocalDateTime periodStart) {
        usageMapper.upsertSessionIncrement(userIdx, ipAddress, periodStart);
    }

    @Override
    @Transactional
    public void decreaseMessageCount(Long userIdx, String ipAddress, LocalDateTime periodStart, int amount) {
        if (amount <= 0) return;
        usageMapper.decreaseMessageCount(userIdx, ipAddress, periodStart, amount);
    }
}
