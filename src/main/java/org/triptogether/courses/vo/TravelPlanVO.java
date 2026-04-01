package org.triptogether.courses.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TravelPlanVO {
    private Long plan_id;
    private Long user_idx;
    private String title;
    private String destination;
    private LocalDate start_date;
    private LocalDate end_date;
    private Integer is_public;
    private String share_token;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
}
