package org.triptogether.travelPackage.vo;

import lombok.Data;

/**
 * 패키지 상품을 연결할 여행지 선택 옵션.
 */
@Data
public class PackageSpotOptionVO {
    private Long spotIdx;
    private String name;
    private String region;
    private String address;
}
