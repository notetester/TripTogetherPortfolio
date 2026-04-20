package org.triptogether.reward.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.reward.mapper.RewardMapper;
import org.triptogether.reward.vo.ExpHistoryCreateDto;
import org.triptogether.reward.vo.LevelOverrideDto;
import org.triptogether.reward.vo.LevelPolicyDto;
import org.triptogether.reward.vo.PointHistoryCreateDto;
import org.triptogether.reward.vo.RewardPolicyDto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class RewardServiceImpl implements RewardService {

    private static final int MAX_LEVEL_SCAN = 10_000;

    private final RewardMapper rewardMapper;

    @Override
    @Transactional
    public void awardAction(Long userIdx, String rewardCode, Long sourceId, long amountBasis, String detailMessage) {
        if (userIdx == null || rewardCode == null || rewardCode.isBlank()) {
            return;
        }

        UsersVO user = rewardMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            return;
        }

        RewardPolicyDto pointPolicy = rewardMapper.selectPointRewardPolicy(rewardCode);
        RewardPolicyDto expPolicy = rewardMapper.selectExpRewardPolicy(rewardCode);

        boolean canGrantPoint = pointPolicy != null && !alreadyGrantedPoint(userIdx, rewardCode, sourceId);
        boolean canGrantExp = expPolicy != null && !alreadyGrantedExp(userIdx, rewardCode, sourceId);
        if (!canGrantPoint && !canGrantExp) {
            return;
        }

        long pointAmount = canGrantPoint ? calculateRewardAmount(pointPolicy, amountBasis) : 0L;
        int expAmount = canGrantExp ? (int) calculateRewardAmount(expPolicy, amountBasis) : 0;
        if (pointAmount <= 0 && expAmount <= 0) {
            return;
        }

        long nextPointBalance = user.getPointBalance() + Math.max(pointAmount, 0L);
        long nextExpPoints = user.getExpPoints() + Math.max(expAmount, 0);
        int nextLevel = expAmount > 0 ? resolveLevel(nextExpPoints) : user.getLevelNo();

        rewardMapper.updateUserRewardState(userIdx, nextPointBalance, nextExpPoints, nextLevel);

        if (pointAmount > 0) {
            PointHistoryCreateDto pointHistory = new PointHistoryCreateDto();
            pointHistory.setUserIdx(userIdx);
            pointHistory.setChangeType("EARN");
            pointHistory.setSourceType(rewardCode);
            pointHistory.setSourceId(sourceId);
            pointHistory.setAmount(pointAmount);
            pointHistory.setBalanceAfter(nextPointBalance);
            pointHistory.setDetailMessage(detailMessage);
            pointHistory.setCreatedAt(LocalDateTime.now());
            rewardMapper.insertPointHistory(pointHistory);
        }

        if (expAmount > 0) {
            ExpHistoryCreateDto expHistory = new ExpHistoryCreateDto();
            expHistory.setUserIdx(userIdx);
            expHistory.setSourceType(rewardCode);
            expHistory.setSourceId(sourceId);
            expHistory.setExpAmount(expAmount);
            expHistory.setLevelAfter(nextLevel);
            expHistory.setExpAfter(nextExpPoints);
            expHistory.setDetailMessage(detailMessage);
            expHistory.setCreatedAt(LocalDateTime.now());
            rewardMapper.insertExpHistory(expHistory);
        }
    }

    private boolean alreadyGrantedPoint(Long userIdx, String rewardCode, Long sourceId) {
        return sourceId != null && rewardMapper.countPointHistory(userIdx, rewardCode, sourceId) > 0;
    }

    private boolean alreadyGrantedExp(Long userIdx, String rewardCode, Long sourceId) {
        return sourceId != null && rewardMapper.countExpHistory(userIdx, rewardCode, sourceId) > 0;
    }

    private long calculateRewardAmount(RewardPolicyDto policy, long amountBasis) {
        if (policy == null || policy.getRewardValue() == null || policy.getRewardValue() <= 0) {
            return 0L;
        }

        if ("PER_AMOUNT".equalsIgnoreCase(policy.getRewardType())) {
            if (policy.getUnitAmount() == null || policy.getUnitAmount() <= 0 || amountBasis <= 0) {
                return 0L;
            }
            return (amountBasis / policy.getUnitAmount()) * policy.getRewardValue();
        }

        return policy.getRewardValue();
    }

    private int resolveLevel(long totalExp) {
        LevelPolicyDto levelPolicy = rewardMapper.selectActiveLevelPolicy();
        Map<Integer, Long> overrideMap = toOverrideMap(rewardMapper.selectActiveLevelOverrides());

        int level = 1;
        for (int nextLevel = 2; nextLevel <= MAX_LEVEL_SCAN; nextLevel++) {
            long requiredExp = getRequiredTotalExp(nextLevel, levelPolicy, overrideMap);
            if (requiredExp <= totalExp) {
                level = nextLevel;
                continue;
            }
            break;
        }
        return level;
    }

    private Map<Integer, Long> toOverrideMap(List<LevelOverrideDto> overrides) {
        Map<Integer, Long> result = new HashMap<>();
        if (overrides == null) {
            return result;
        }
        for (LevelOverrideDto override : overrides) {
            if (override.getLevelNo() != null && override.getRequiredTotalExp() != null) {
                result.put(override.getLevelNo(), override.getRequiredTotalExp());
            }
        }
        return result;
    }

    private long getRequiredTotalExp(int levelNo, LevelPolicyDto policy, Map<Integer, Long> overrideMap) {
        if (levelNo <= 1) {
            return 0L;
        }
        if (overrideMap.containsKey(levelNo)) {
            return overrideMap.get(levelNo);
        }
        if (policy == null || policy.getPolicyMode() == null) {
            return 0L;
        }

        int step = levelNo - 1;
        return switch (policy.getPolicyMode()) {
            case "EXPONENTIAL" -> calculateExponential(step, policy);
            case "HYBRID" -> calculateHybrid(step, policy);
            case "QUADRATIC" -> calculateQuadratic(step, policy);
            default -> 0L;
        };
    }

    private long calculateQuadratic(int step, LevelPolicyDto policy) {
        BigDecimal a = safe(policy.getQuadraticA());
        BigDecimal b = safe(policy.getQuadraticB());
        BigDecimal c = safe(policy.getQuadraticC());
        BigDecimal level = BigDecimal.valueOf(step);
        BigDecimal result = a.multiply(level.pow(2))
                .add(b.multiply(level))
                .add(c);
        return Math.max(0L, Math.round(result.doubleValue()));
    }

    private long calculateExponential(int step, LevelPolicyDto policy) {
        double base = safe(policy.getExpBase()).doubleValue();
        double rate = safe(policy.getExpRate()).doubleValue();
        if (base <= 0 || rate <= 0) {
            return 0L;
        }
        return Math.max(0L, Math.round(base * Math.pow(rate, step)));
    }

    private long calculateHybrid(int step, LevelPolicyDto policy) {
        Integer switchLevel = policy.getHybridSwitchLevel();
        if (switchLevel == null || step < switchLevel) {
            return calculateQuadratic(step, policy);
        }
        return calculateExponential(step, policy);
    }

    private BigDecimal safe(BigDecimal value) {
        return value != null ? value : BigDecimal.ZERO;
    }
}
