package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.WalletLimitPolicyVO;

import java.util.List;

/**
 * 회원 등급별 충전 한도 정책 매퍼.
 *
 * <p>충전 진입점 AOP({@code WalletChargeLimitAspect}) 와 어드민 정책 화면이 공유한다.</p>
 */
@Mapper
public interface WalletLimitPolicyMapper {

    /**
     * 사용자의 현재 등급에 맞는 활성 정책을 한 건 조회.
     * 정책 행이 없으면 {@code null} (한도 미적용).
     */
    WalletLimitPolicyVO selectActivePolicyForUser(@Param("userIdx") Long userIdx);

    /** 어드민 화면용 — 모든 정책 (등급 우선순위 순) */
    List<WalletLimitPolicyVO> selectAll();

    /** 등급으로 조회 */
    WalletLimitPolicyVO selectByGrade(@Param("memberGrade") String memberGrade);

    /** 등록 또는 갱신 */
    int upsert(WalletLimitPolicyVO vo);

    /** 사용자의 오늘(KST 기준) 충전 합계 — payment_status = COMPLETED, payment_type = CHARGE */
    long sumTodayCharge(@Param("userIdx") Long userIdx);

    /** 사용자의 이번 달(KST 기준) 충전 합계 */
    long sumThisMonthCharge(@Param("userIdx") Long userIdx);
}
