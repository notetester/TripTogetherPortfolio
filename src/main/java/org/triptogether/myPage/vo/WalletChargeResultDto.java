package org.triptogether.myPage.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.triptogether.auth.vo.UsersVO;

/**
 * 충전 시뮬레이션 처리 결과.
 * 컨트롤러가 메시지와 최신 사용자 정보를 함께 받기 위해 사용한다.
 */
@Data
@AllArgsConstructor
public class WalletChargeResultDto {

    private UsersVO user;
    private long chargedCash;
    private long earnedMileage;
}
