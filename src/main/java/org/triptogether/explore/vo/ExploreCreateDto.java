package org.triptogether.explore.vo;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

/**
 * 여행지 등록 폼 데이터를 담는 DTO
 * - name, region, address, latitude, longitude, description: 기본 정보
 * - image: 여행지 대표 이미지 파일 (MultipartFile)
 */
@Data
public class ExploreCreateDto {
    private String name;           // 여행지 이름
    private String region;         // 지역 (예: 서울, 오사카)
    private String address;        // 상세 주소
    private Double latitude;       // 위도
    private Double longitude;      // 경도
    private String description;    // 여행지 설명

    /**
     * 여행지 대표 이미지 파일
     * - form의 enctype="multipart/form-data"로 전송됨
     * - 허용 형식: JPG, PNG, GIF, WEBP (최대 10MB)
     */
    private List<String> tags;
    private MultipartFile image;
}
