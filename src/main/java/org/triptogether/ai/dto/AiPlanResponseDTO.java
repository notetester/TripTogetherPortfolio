package org.triptogether.ai.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiPlanResponseDTO {
    private String title;
    private String summary;
    private List<AiDayDTO> days;
}
