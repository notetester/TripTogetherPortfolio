package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.myPage.mapper.WalletRewardPolicyMapper;
import org.triptogether.myPage.vo.WalletRewardPolicyVO;

import java.math.BigDecimal;

@Slf4j
@Service
@RequiredArgsConstructor
public class RewardPolicyServiceImpl implements RewardPolicyService {

    private final WalletRewardPolicyMapper rewardPolicyMapper;

    @Override
    public BigDecimal getRate(String eventType, String memberGrade, BigDecimal fallback) {
        WalletRewardPolicyVO p = findActive(eventType, memberGrade);
        if (p == null || p.getRewardRate() == null) return fallback;
        return p.getRewardRate();
    }

    @Override
    public long getFixedAmount(String eventType, String memberGrade, long fallback) {
        WalletRewardPolicyVO p = findActive(eventType, memberGrade);
        if (p == null || p.getRewardFixed() == null) return fallback;
        return p.getRewardFixed();
    }

    @Override
    public WalletRewardPolicyVO findActive(String eventType, String memberGrade) {
        if (eventType == null || eventType.isBlank()) return null;
        String grade = (memberGrade == null || memberGrade.isBlank()) ? "ALL" : memberGrade;
        try {
            return rewardPolicyMapper.selectActiveForEvent(eventType, grade);
        } catch (Exception e) {
            log.warn("[RewardPolicyService] 정책 조회 실패 - event={}, grade={} : {}",
                    eventType, grade, e.getMessage());
            return null;
        }
    }
}
