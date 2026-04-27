package org.triptogether.myPage.vo;

import lombok.Data;

@Data
public class MyPageLevelRewardDto {

    private Long levelUpRewardPolicyIdx;
    private Integer levelNo;
    private String rewardType;
    private Long rewardAmount;
    private String itemCode;
    private String itemName;
    private boolean claimed;

    /**
     * 컨트롤러에서 현재 로그인 유저 레벨과 비교해서 계산해 넣는 값이다.
     * JSP에서 단순 비교 로직을 반복하지 않기 위해 별도 필드로 둔다.
     */
    private boolean achieved;

    /**
     * 현재 언어 기준으로 사람이 읽기 쉬운 보상 표시 문자열이다.
     * 예: "포인트 100", "브론즈 성장 뱃지"
     */
    private String rewardDisplayText;
    private String rewardImagePath;

    /**
     * 화면에서 상태 칩을 그릴 때 사용하는 코드다.
     * claimed / pending / locked 3가지로 내려준다.
     */
    private String rewardStatusCode;
}
