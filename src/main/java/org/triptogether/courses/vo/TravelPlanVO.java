package org.triptogether.courses.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.time.ZoneId;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TravelPlanVO {

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date start_date;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_date;

    private Long plan_id;
    private Long user_idx;
    private String title;
    private String destination;
    private Integer is_public;
    private String share_token;
    private String plan_source;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    private List<PlanSpotVO> spotList;

    private String nickname;

    public Date getStart_dateDate() {
        return start_date;
    }

    public Date getEnd_dateDate() {
        return end_date;
    }

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreated_atDate() {
        return fromLocalDateTime(created_at);
    }

    public Date getUpdated_atDate() {
        return fromLocalDateTime(updated_at);
    }

}
