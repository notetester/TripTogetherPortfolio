package org.triptogether.superAdmin.vo;

import lombok.Data;

import java.util.List;

/**
 * 미리보기에서 확정된 변경 행 목록을 서버로 재전송하는 요청 바디.
 */
@Data
public class SalaryUploadApplyVO {

    private List<ApplyRow> rows;

    @Data
    public static class ApplyRow {
        private Long   userIdx;
        private String email;
        private String seniority;
        private String tier;
        private String level;
        private String band;
        private String grade;
        private String step;
    }
}
