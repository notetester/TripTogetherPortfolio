package org.triptogether.courses.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SpotTravelVO {
    private Long spot_idx;
    private String spot_id;
    private String name;
    private String region;
    private String address;
    private Double latitude;
    private Double longitude;
    private String description;
    private Float rating_avg;
    private Integer review_count;
}