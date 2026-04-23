package org.triptogether.travelPackage.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

/**
 * 패키지 등록/수정 폼에서 넘어오는 입력값 DTO.
 *
 * <p>DB 저장용 VO와 화면 입력 DTO를 분리하면, 화면 전용 필드(action 등)가
 * DB VO에 섞이지 않아 유지보수가 쉬워진다.</p>
 */
@Data
public class TravelPackageForm {

    private Long packageIdx;
    private Long spotIdx;

    private String packageTitle;
    private String packageSummary;
    private String packageContent;
    private Long packagePrice;
    private String currencyCode;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate startDate;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate endDate;

    private Integer minPeople;
    private Integer maxPeople;
    private String mainImagePath;
    private MultipartFile mainImageFile;

    /**
     * DRAFT: 임시저장
     * PENDING: 관리자 승인 요청
     */
    private String action;
}
