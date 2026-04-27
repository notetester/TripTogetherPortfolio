package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.WalletRewardPolicyVO;

import java.util.List;

/**
 * 적립률/고정 적립량 정책 매퍼.
 */
@Mapper
public interface WalletRewardPolicyMapper {

    /** 어드민 화면용 — 모든 정책 (event_type → member_grade 순) */
    List<WalletRewardPolicyVO> selectAll();

    /**
     * 이벤트 + 등급에 매칭되는 활성 정책 조회.
     * 등급 정확매칭 정책 우선, 없으면 ALL 정책 fallback.
     */
    WalletRewardPolicyVO selectActiveForEvent(@Param("eventType") String eventType,
                                              @Param("memberGrade") String memberGrade);

    int upsert(WalletRewardPolicyVO vo);

    /** 정책 1건 비활성화 (단순 토글) */
    int updateActive(@Param("policyIdx") Long policyIdx,
                     @Param("isActive") Boolean isActive);
}
