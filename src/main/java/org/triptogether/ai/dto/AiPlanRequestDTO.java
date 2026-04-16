package org.triptogether.ai.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiPlanRequestDTO {
    private String destination;
    private String startDate;
    private String endDate;
    private String companion;
    private String style;
    private String budget;
    private String requestText;
}
