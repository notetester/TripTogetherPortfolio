package org.triptogether.courses.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlanSpotVO {

    private Long plan_spot_id;
    private Long plan_id;
    private String spot_id;
    private String place_name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date visit_date;

    private Integer visit_order;
    private Date created_at;

    // 상세조회용
    private String name;
    private String region;
    private String address;

    public Date getVisit_dateDate() {
        return visit_date;
    }

    public Date getCreated_atDate() {
        return created_at;
    }

}