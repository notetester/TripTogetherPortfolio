package org.triptogether.ai.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiSpotDTO {
    private String name;
    private String description;
    private int visitOrder;
}
