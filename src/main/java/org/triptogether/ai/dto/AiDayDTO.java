package org.triptogether.ai.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiDayDTO {
    private int dayNo;
    private String date;
    private String theme;
    private List<AiSpotDTO> spots;
}
