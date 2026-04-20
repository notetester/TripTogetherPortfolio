package org.triptogether.reward.service;

/**
 * 행동/결제에 따른 포인트, 경험치, 레벨 반영을 담당하는 공통 서비스입니다.
 */
public interface RewardService {

    /**
     * 정책 코드(rewardCode)를 기준으로 포인트/경험치를 지급합니다.
     *
     * @param userIdx       보상 대상 회원
     * @param rewardCode    정책 코드 (예: COMMUNITY_POST, PAYMENT)
     * @param sourceId      원천 객체 ID (게시글 ID, 댓글 ID, 결제 ID 등)
     * @param amountBasis   PER_AMOUNT 정책 계산 기준값. FIXED면 0 또는 무시 가능
     * @param detailMessage 이력에 저장할 상세 메시지
     */
    void awardAction(Long userIdx, String rewardCode, Long sourceId, long amountBasis, String detailMessage);
}
