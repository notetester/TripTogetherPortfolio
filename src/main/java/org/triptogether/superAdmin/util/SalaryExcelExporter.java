package org.triptogether.superAdmin.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.triptogether.superAdmin.vo.SuperAdminMemberVO;

import java.io.OutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class SalaryExcelExporter {

    private static final String[] HEADERS = {
        "닉네임", "이메일", "부서", "직책", "직급",
        "Seniority", "Tier", "Level", "Band", "Grade", "Step",
        "역할", "계정상태", "최근로그인"
    };

    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public static void export(List<SuperAdminMemberVO> list, OutputStream out) throws Exception {
        try (Workbook wb = new XSSFWorkbook()) {
            Sheet sheet = wb.createSheet("관리자 역량현황");

            CellStyle headerStyle = wb.createCellStyle();
            Font headerFont = wb.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < HEADERS.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(HEADERS[i]);
                cell.setCellStyle(headerStyle);
                sheet.setColumnWidth(i, 4200);
            }

            int rowNum = 1;
            for (SuperAdminMemberVO m : list) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(nullSafe(m.getNickname()));
                row.createCell(1).setCellValue(nullSafe(m.getUserEmail()));
                row.createCell(2).setCellValue(nullSafe(m.getAdminDepartment()));
                row.createCell(3).setCellValue(nullSafe(m.getAdminTitle()));
                row.createCell(4).setCellValue(nullSafe(m.getAdminPosition()));
                row.createCell(5).setCellValue(nullSafe(m.getAdminSeniority()));
                row.createCell(6).setCellValue(nullSafe(m.getAdminTier()));
                row.createCell(7).setCellValue(nullSafe(m.getAdminLevel()));
                row.createCell(8).setCellValue(nullSafe(m.getAdminBand()));
                row.createCell(9).setCellValue(nullSafe(m.getAdminGrade()));
                row.createCell(10).setCellValue(nullSafe(m.getAdminStep()));
                row.createCell(11).setCellValue(nullSafe(m.getAdminRole()));
                row.createCell(12).setCellValue(nullSafe(m.getAccountStatus()));
                row.createCell(13).setCellValue(m.getLastLoginAt() != null ? m.getLastLoginAt().format(FMT) : "-");
            }

            wb.write(out);
        }
    }

    private static String nullSafe(String v) {
        return v != null ? v : "";
    }
}
