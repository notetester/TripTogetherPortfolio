package org.triptogether.reward.service;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.util.MessageUtil;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.reward.mapper.RewardMapper;
import org.triptogether.reward.vo.ExpHistoryCreateDto;
import org.triptogether.reward.vo.LevelOverrideDto;
import org.triptogether.reward.vo.LevelPolicyDto;
import org.triptogether.reward.vo.LevelUpRewardPolicyDto;
import org.triptogether.reward.vo.PointHistoryCreateDto;
import org.triptogether.reward.vo.RewardPolicyDto;
import org.triptogether.reward.vo.UserLevelUpRewardHistoryCreateDto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RewardServiceImpl implements RewardService {

    /**
     * 레벨 계산 시 무한 루프를 막기 위한 안전 상한선이다.
     * 정책 데이터가 잘못 들어가더라도 여기서 계산을 멈추게 만든다.
     */
    private static final int MAX_LEVEL_SCAN = 10_000;

    private final RewardMapper rewardMapper;
    private final MyPageService myPageService;
    private final MessageUtil msg;

    /**
     * MyPageService는 알림 저장에 필요하다.
     * reward -> mypage 방향 참조가 생기므로 @Lazy로 순환 참조 위험을 낮춘다.
     */
    public RewardServiceImpl(RewardMapper rewardMapper,
                             @Lazy MyPageService myPageService,
                             MessageUtil msg) {
        this.rewardMapper = rewardMapper;
        this.myPageService = myPageService;
        this.msg = msg;
    }

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
        long nextCashBalance = user.getCashBalance();
        long nextMileageBalance = user.getMileageBalance();

        int prevLevel = user.getLevelNo();
        int nextLevel = expAmount > 0 ? resolveLevel(nextExpPoints) : prevLevel;

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

        LevelRewardGrantResult rewardResult = new LevelRewardGrantResult(
                nextPointBalance,
                nextCashBalance,
                nextMileageBalance
        );

        if (nextLevel > prevLevel) {
            rewardResult = grantLevelUpRewards(userIdx, prevLevel, nextLevel, rewardResult);
        }

        rewardMapper.updateUserRewardState(
                userIdx,
                rewardResult.pointBalance(),
                nextExpPoints,
                nextLevel,
                rewardResult.cashBalance(),
                rewardResult.mileageBalance()
        );

        if (nextLevel > prevLevel) {
            FeedNotificationDto levelUpNoti = new FeedNotificationDto();
            levelUpNoti.setUserIdx(userIdx);
            levelUpNoti.setSourceType("levelup");
            levelUpNoti.setSourceId((long) nextLevel);
            levelUpNoti.setMessage(msg.get("mypage.levelup.notification", nextLevel));
            levelUpNoti.setTargetUrl(NotificationUrlBuilder.levelup());
            myPageService.addNotification(levelUpNoti);
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

    /**
     * 레벨업 보상 지급의 핵심 메서드다.
     * 이전 레벨과 현재 레벨 사이에 해당하는 정책을 모두 조회한 뒤,
     * 이미 지급된 적 없는 보상만 포인트/마일리지/캐시/아이템으로 분기 처리한다.
     *
     * 주의:
     * - 9 -> 12처럼 한 번에 여러 레벨이 오를 수 있으므로 구간 전체를 확인한다.
     * - USER_LEVEL_UP_REWARD_HISTORY를 먼저 확인해서 중복 지급을 막는다.
     * - 실제 잔액 반영과 이력 저장은 같은 트랜잭션 안에서 처리된다.
     */
    private LevelRewardGrantResult grantLevelUpRewards(Long userIdx,
                                                       int prevLevel,
                                                       int nextLevel,
                                                       LevelRewardGrantResult baseState) {
        List<LevelUpRewardPolicyDto> policies =
                rewardMapper.selectActiveLevelUpRewardPoliciesBetween(prevLevel, nextLevel);

        if (policies == null || policies.isEmpty()) {
            return baseState;
        }

        long pointBalance = baseState.pointBalance();
        long cashBalance = baseState.cashBalance();
        long mileageBalance = baseState.mileageBalance();

        for (LevelUpRewardPolicyDto policy : policies) {
            if (policy == null || policy.getLevelUpRewardPolicyIdx() == null) {
                continue;
            }

            boolean alreadyGranted = rewardMapper.countLevelUpRewardHistory(
                    userIdx,
                    policy.getLevelUpRewardPolicyIdx()
            ) > 0;
            if (alreadyGranted) {
                continue;
            }

            String rewardType = policy.getRewardType();
            String note = buildLevelRewardNote(policy);

            if ("POINT".equalsIgnoreCase(rewardType)) {
                long rewardAmount = positive(policy.getRewardAmount());
                if (rewardAmount <= 0) {
                    continue;
                }

                pointBalance += rewardAmount;

                PointHistoryCreateDto pointHistory = new PointHistoryCreateDto();
                pointHistory.setUserIdx(userIdx);
                pointHistory.setChangeType("EARN");
                pointHistory.setSourceType("LEVEL_UP_REWARD");
                pointHistory.setSourceId(policy.getLevelUpRewardPolicyIdx());
                pointHistory.setAmount(rewardAmount);
                pointHistory.setBalanceAfter(pointBalance);
                pointHistory.setDetailMessage(note);
                pointHistory.setCreatedAt(LocalDateTime.now());
                rewardMapper.insertPointHistory(pointHistory);

                insertLevelRewardHistory(userIdx, policy, rewardAmount, null, note);
                continue;
            }

            if ("MILEAGE".equalsIgnoreCase(rewardType)) {
                long rewardAmount = positive(policy.getRewardAmount());
                if (rewardAmount <= 0) {
                    continue;
                }

                mileageBalance += rewardAmount;

                WalletHistoryDto history = new WalletHistoryDto();
                history.setUserIdx(userIdx);
                history.setAssetType("MILEAGE");
                history.setChangeType("EARN");
                history.setAmount(rewardAmount);
                history.setBalanceAfter(mileageBalance);
                history.setDetailMessage(note);
                rewardMapper.insertWalletHistory(history);

                insertLevelRewardHistory(userIdx, policy, rewardAmount, null, note);
                continue;
            }

            if ("CASH".equalsIgnoreCase(rewardType)) {
                long rewardAmount = positive(policy.getRewardAmount());
                if (rewardAmount <= 0) {
                    continue;
                }

                cashBalance += rewardAmount;

                WalletHistoryDto history = new WalletHistoryDto();
                history.setUserIdx(userIdx);
                history.setAssetType("CASH");
                history.setChangeType("EARN");
                history.setAmount(rewardAmount);
                history.setBalanceAfter(cashBalance);
                history.setDetailMessage(note);
                rewardMapper.insertWalletHistory(history);

                insertLevelRewardHistory(userIdx, policy, rewardAmount, null, note);
                continue;
            }

            if ("ITEM".equalsIgnoreCase(rewardType)) {
                if (policy.getItemCode() == null || policy.getItemCode().isBlank()) {
                    continue;
                }

                rewardMapper.upsertLevelRewardInventoryItem(userIdx, policy.getItemCode());
                insertLevelRewardHistory(userIdx, policy, null, policy.getItemCode(), note);
            }
        }

        return new LevelRewardGrantResult(pointBalance, cashBalance, mileageBalance);
    }

    private void insertLevelRewardHistory(Long userIdx,
                                          LevelUpRewardPolicyDto policy,
                                          Long rewardAmount,
                                          String itemCode,
                                          String note) {
        UserLevelUpRewardHistoryCreateDto history = new UserLevelUpRewardHistoryCreateDto();
        history.setUserIdx(userIdx);
        history.setLevelUpRewardPolicyIdx(policy.getLevelUpRewardPolicyIdx());
        history.setLevelNo(policy.getLevelNo());
        history.setRewardType(policy.getRewardType());
        history.setRewardAmount(rewardAmount);
        history.setItemCode(itemCode);
        history.setGrantStatus("GRANTED");
        history.setGrantedAt(LocalDateTime.now());
        history.setNote(note);
        history.setCreatedAt(LocalDateTime.now());
        rewardMapper.insertLevelUpRewardHistory(history);
    }

    /**
     * 포인트/지갑 이력에 저장할 공통 메모를 만든다.
     * 사용자 언어 기준으로 생성하므로, 나중에 이력을 봤을 때도 어떤 레벨 보상인지
     * 비교적 자연스럽게 읽을 수 있다.
     */
    private String buildLevelRewardNote(LevelUpRewardPolicyDto policy) {
        String levelLabel = policy.getLevelNo() == null ? "Lv.?" : "Lv." + policy.getLevelNo();
        String rewardLabel = resolveRewardLabel(policy);
        return msg.get("mypage.levelup.reward.history", levelLabel, rewardLabel);
    }

    /**
     * 정책명은 DB에 고정 언어로 저장될 수 있으므로,
     * 이력 문구에는 정책명 대신 보상 유형명을 언어별 메시지로 사용한다.
     */
    private String resolveRewardLabel(LevelUpRewardPolicyDto policy) {
        if (policy == null || policy.getRewardType() == null) {
            return msg.get("mypage.levelup.reward.default");
        }

        return switch (policy.getRewardType().toUpperCase()) {
            case "POINT" -> msg.get("mypage.levelup.reward.type.point");
            case "MILEAGE" -> msg.get("mypage.levelup.reward.type.mileage");
            case "CASH" -> msg.get("mypage.levelup.reward.type.cash");
            case "ITEM" -> msg.get("mypage.levelup.reward.type.item");
            default -> msg.get("mypage.levelup.reward.default");
        };
    }

    private long positive(Long amount) {
        return amount == null ? 0L : Math.max(amount, 0L);
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

    @Override
    public long getRequiredExpForLevel(int levelNo) {
        LevelPolicyDto levelPolicy = rewardMapper.selectActiveLevelPolicy();
        Map<Integer, Long> overrideMap = toOverrideMap(rewardMapper.selectActiveLevelOverrides());
        return getRequiredTotalExp(levelNo, levelPolicy, overrideMap);
    }

    /**
     * 운영 중 정책을 바꾼 뒤 전체 회원의 레벨을 다시 맞춰야 할 때 사용하는 동기화 메서드다.
     * 레벨이 올라가는 경우에는 단순 숫자만 바꾸지 않고 레벨업 보상도 같이 처리한다.
     */
    @Override
    @Transactional
    public int synchronizeUserLevels(boolean onlyActiveMembers) {
        List<UsersVO> users = rewardMapper.selectUsersForLevelSync(onlyActiveMembers);
        int changedCount = 0;
        if (users == null || users.isEmpty()) {
            return 0;
        }

        for (UsersVO user : users) {
            if (user == null || user.getUserIdx() == null) {
                continue;
            }

            int resolvedLevel = resolveLevel(user.getExpPoints());
            if (resolvedLevel != user.getLevelNo()) {
                if (resolvedLevel > user.getLevelNo()) {
                    LevelRewardGrantResult rewardResult = grantLevelUpRewards(
                            user.getUserIdx(),
                            user.getLevelNo(),
                            resolvedLevel,
                            new LevelRewardGrantResult(
                                    user.getPointBalance(),
                                    user.getCashBalance(),
                                    user.getMileageBalance()
                            )
                    );
                    rewardMapper.updateUserRewardState(
                            user.getUserIdx(),
                            rewardResult.pointBalance(),
                            user.getExpPoints(),
                            resolvedLevel,
                            rewardResult.cashBalance(),
                            rewardResult.mileageBalance()
                    );
                } else {
                    rewardMapper.updateUserLevelOnly(user.getUserIdx(), resolvedLevel);
                }
                changedCount++;
            }
        }
        return changedCount;
    }

    /**
     * 레벨업 보상 처리 중간 결과를 담는 작은 값 객체다.
     * 여러 보상을 한 번에 지급한 뒤 최종 잔액을 한 번에 update 하기 위해 사용한다.
     */
    /**
     * 기존 유저 소급 지급용 메서드.
     *
     * <p>레벨업 보상 정책이 뒤늦게 추가된 경우, 이미 높은 레벨에 도달해 있던 유저는
     * 새로 레벨이 오르지 않는 한 자동 지급 엔진을 타지 못한다.
     * 이 메서드는 현재 레벨까지의 정책을 다시 훑으면서 지급 이력이 없는 보상만
     * 한 번 더 정산해, 기존 유저도 신규 유저와 같은 보상을 받도록 맞춰 준다.</p>
     */
    @Override
    @Transactional
    public boolean grantMissingLevelUpRewards(Long userIdx) {
        if (userIdx == null) {
            return false;
        }

        UsersVO user = rewardMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null || user.getLevelNo() <= 1) {
            return false;
        }

        LevelRewardGrantResult before = new LevelRewardGrantResult(
                user.getPointBalance(),
                user.getCashBalance(),
                user.getMileageBalance()
        );

        LevelRewardGrantResult after = grantLevelUpRewards(
                userIdx,
                0,
                user.getLevelNo(),
                before
        );

        boolean changed = before.pointBalance() != after.pointBalance()
                || before.cashBalance() != after.cashBalance()
                || before.mileageBalance() != after.mileageBalance();

        if (!changed) {
            return false;
        }

        rewardMapper.updateUserRewardState(
                userIdx,
                after.pointBalance(),
                user.getExpPoints(),
                user.getLevelNo(),
                after.cashBalance(),
                after.mileageBalance()
        );

        return true;
    }

    private record LevelRewardGrantResult(long pointBalance, long cashBalance, long mileageBalance) {
    }
}
