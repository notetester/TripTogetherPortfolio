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

    /**
     * 특정 레벨에 도달하기 위해 필요한 누적 경험치를 반환합니다.
     * (마이페이지 경험치 바 렌더링에 사용)
     *
     * @param levelNo 조회 대상 레벨
     * @return 해당 레벨에 필요한 누적 경험치 (Lv.1이면 0)
     */
    long getRequiredExpForLevel(int levelNo);

    /**
     * 현재 경험치 기준으로 회원 레벨을 일괄 재정산합니다.
     *
     * @param onlyActiveMembers ACTIVE 계정만 대상으로 제한할지 여부
     * @return 실제로 레벨이 변경된 회원 수
     */
    int synchronizeUserLevels(boolean onlyActiveMembers);

    /**
     * 이미 높은 레벨에 도달해 있지만 정책 추가 시점 이후라 아직 받지 못한
     * 레벨업 보상을 현재 레벨 기준으로 소급 정산한다.
     *
     * @param userIdx 보상을 정산할 회원 PK
     * @return 실제로 새로 지급된 보상이 하나라도 있으면 true
     */
    boolean grantMissingLevelUpRewards(Long userIdx);
}
