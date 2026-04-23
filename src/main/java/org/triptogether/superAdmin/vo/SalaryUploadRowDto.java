package org.triptogether.superAdmin.vo;

import lombok.Data;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 급여/역량 엑셀 업로드 미리보기 한 행.
 * status: CHANGE / UNCHANGED / ERROR
 */
@Data
public class SalaryUploadRowDto {
    private int    rowNumber;
    private String email;
    private Long   userIdx;
    private String nickname;
    private Map<String, String> oldValues = new LinkedHashMap<>();
    private Map<String, String> newValues = new LinkedHashMap<>();
    private String status;
    private String errorMessage;
}
