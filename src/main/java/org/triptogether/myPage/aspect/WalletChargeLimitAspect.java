package org.triptogether.myPage.aspect;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.triptogether.myPage.mapper.WalletLimitPolicyMapper;
import org.triptogether.myPage.vo.WalletLimitPolicyVO;

/**
 * 회원 등급별 충전 한도를 검증하는 AOP.
 *
 * <p>{@link org.triptogether.myPage.service.WalletService#simulateCashCharge}
 * 와 {@link org.triptogether.myPage.service.WalletService#prepareTossCharge} 진입 직전에
 * 1회/일/월 한도를 체크하여 초과 시 {@link IllegalStateException} 을 던진다.</p>
 *
 * <p>WalletService 본 코드는 변경하지 않는다 (코드 수정 자제 원칙).</p>
 *
 * <ul>
 *     <li>정책 행이 등급에 없으면 한도 미적용 (FAIL-OPEN)</li>
 *     <li>{@code single_limit} / {@code daily_limit} / {@code monthly_limit} 중 NULL 컬럼은 무제한</li>
 * </ul>
 */
@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class WalletChargeLimitAspect {

    private final WalletLimitPolicyMapper limitPolicyMapper;
    private final MessageSource messageSource;

    @Before("execution(* org.triptogether.myPage.service.WalletService.simulateCashCharge(..)) " +
            "&& args(userIdx, amount, ..)")
    public void beforeSimulate(JoinPoint jp, Long userIdx, long amount) {
        validate(userIdx, amount);
    }

    @Before("execution(* org.triptogether.myPage.service.WalletService.prepareTossCharge(..)) " +
            "&& args(userIdx, amount, ..)")
    public void beforePrepareToss(JoinPoint jp, Long userIdx, long amount) {
        validate(userIdx, amount);
    }

    private void validate(Long userIdx, long amount) {
        if (userIdx == null || amount <= 0) return;

        WalletLimitPolicyVO policy;
        try {
            policy = limitPolicyMapper.selectActivePolicyForUser(userIdx);
        } catch (Exception e) {
            // 정책 조회 실패는 결제 자체를 막지 않음 (FAIL-OPEN)
            log.warn("[WalletChargeLimitAspect] 정책 조회 실패 - userIdx={} : {}", userIdx, e.getMessage());
            return;
        }
        if (policy == null) return;

        if (policy.getSingleLimit() != null && amount > policy.getSingleLimit()) {
            throw exceeded("wallet.charge.limit.single", policy.getSingleLimit());
        }

        if (policy.getDailyLimit() != null) {
            long todaySum = limitPolicyMapper.sumTodayCharge(userIdx);
            if (todaySum + amount > policy.getDailyLimit()) {
                throw exceeded("wallet.charge.limit.daily",
                        policy.getDailyLimit(), todaySum, policy.getDailyLimit() - todaySum);
            }
        }

        if (policy.getMonthlyLimit() != null) {
            long monthSum = limitPolicyMapper.sumThisMonthCharge(userIdx);
            if (monthSum + amount > policy.getMonthlyLimit()) {
                throw exceeded("wallet.charge.limit.monthly",
                        policy.getMonthlyLimit(), monthSum, policy.getMonthlyLimit() - monthSum);
            }
        }
    }

    private IllegalStateException exceeded(String code, Object... args) {
        String msg = messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
        return new IllegalStateException(msg);
    }
}
