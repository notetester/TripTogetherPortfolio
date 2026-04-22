package org.triptogether.superAdmin.vo;

import lombok.Data;

import java.util.List;

@Data
public class SalaryUploadPreviewDto {
    private List<SalaryUploadRowDto> rows;
    private int totalCount;
    private int changedCount;
    private int unchangedCount;
    private int errorCount;
}
