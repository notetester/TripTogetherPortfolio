package org.triptogether.myPage.service;

import org.triptogether.myPage.vo.WalletRewardPolicyVO;

import java.math.BigDecimal;

/**
 * 적립률/고정 적립량 정책 조회 API.
 *
 * <p>Phase 13 즉시 단계 — 정책 정의·조회만 제공한다. 실제 기존 적립 호출부(커뮤니티 글 보상,
 * 일정 완료 보상, 캐시 충전 보너스 등)는 다음 phase 에서 점진적으로 이 서비스를 사용하도록
 * 마이그레이션할 예정.</p>
 *
 * <p>설계 의도: 호출부에서 fallback 값을 같이 넘겨, 정책 행이 없거나 비활성일 때
 * 기존 동작을 유지(하드코딩 디폴트)할 수 있게 한다 → 기존 코드 무중단 마이그레이션 가능.</p>
 */
public interface RewardPolicyService {

    /**
     * 비율형 적립률(%) 조회. 정책이 없으면 {@code fallback}.
     */
    BigDecimal getRate(String eventType, String memberGrade, BigDecimal fallback);

    /**
     * 고정 적립량 조회. 정책이 없으면 {@code fallback}.
     */
    long getFixedAmount(String eventType, String memberGrade, long fallback);

    /**
     * 활성 정책 한 건 조회 (raw VO).
     */
    WalletRewardPolicyVO findActive(String eventType, String memberGrade);
}
