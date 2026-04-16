package org.triptogether.home.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HomePlanVO {
    private Long planId;
    private String title;
    private String destination;
    private String nickname;
    private Integer nights;
    private String imageUrl;
}
