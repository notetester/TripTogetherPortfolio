package org.triptogether.superAdmin.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class SalaryExcelImporter {

    /**
     * SalaryExcelExporter와 동일한 헤더 순서.
     * 업로드 시에도 같은 순서를 강제한다.
     */
    private static final String[] EXPECTED_HEADERS = {
        "닉네임", "이메일", "부서", "직책", "직급",
        "Seniority", "Tier", "Level", "Band", "Grade", "Step",
        "역할", "계정상태", "최근로그인"
    };

    public static List<ImportedRow> parse(InputStream in) throws Exception {
        List<ImportedRow> result = new ArrayList<>();
        try (Workbook wb = WorkbookFactory.create(in)) {
            Sheet sheet = wb.getSheetAt(0);

            Row headerRow = sheet.getRow(0);
            if (headerRow == null) {
                throw new IllegalArgumentException("빈 파일입니다.");
            }
            for (int i = 0; i < EXPECTED_HEADERS.length; i++) {
                String actual = cellToString(headerRow.getCell(i));
                if (!EXPECTED_HEADERS[i].equals(actual)) {
                    throw new IllegalArgumentException(
                        "헤더가 일치하지 않습니다. " + (i + 1) + "번째 컬럼: 기대=" + EXPECTED_HEADERS[i] + ", 실제=" + actual);
                }
            }

            int last = sheet.getLastRowNum();
            for (int r = 1; r <= last; r++) {
                Row row = sheet.getRow(r);
                if (row == null) continue;

                String email = cellToString(row.getCell(1));
                if (email == null || email.isBlank()) continue;

                ImportedRow ir = new ImportedRow();
                ir.rowNumber = r + 1;
                ir.nickname  = cellToString(row.getCell(0));
                ir.email     = email;
                ir.seniority = cellToString(row.getCell(5));
                ir.tier      = cellToString(row.getCell(6));
                ir.level     = cellToString(row.getCell(7));
                ir.band      = cellToString(row.getCell(8));
                ir.grade     = cellToString(row.getCell(9));
                ir.step      = cellToString(row.getCell(10));
                result.add(ir);
            }
        }
        return result;
    }

    private static String cellToString(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:  return cell.getStringCellValue().trim();
            case NUMERIC: return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try { return cell.getStringCellValue().trim(); }
                catch (Exception e) { return String.valueOf(cell.getNumericCellValue()); }
            case BLANK:
            default:
                return "";
        }
    }

    public static class ImportedRow {
        public int    rowNumber;
        public String nickname;
        public String email;
        public String seniority;
        public String tier;
        public String level;
        public String band;
        public String grade;
        public String step;
    }
}
