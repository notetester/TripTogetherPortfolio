package org.triptogether.home.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HomeSpotVO {
    private Long spotIdx;
    private String name;
    private String region;
    private String description;
    private String imageUrl;
    private Float ratingAvg;
}
