package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 관리자 대시보드 차트용 시계열 데이터.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminDashboardChartVO {

    /** 일자 라벨 (예: "04/17") */
    private List<String> labels;

    /** 일자별 신규 가입자 수 */
    private List<Long> newMembers;

    /** 일자별 로그인 성공 수 */
    private List<Long> loginSuccess;

    /** 일자별 로그인 실패 수 */
    private List<Long> loginFail;
}
