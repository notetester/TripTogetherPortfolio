package org.triptogether.community.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class CommunityImageCacheDto {
    private Long          cacheId;
    private String        region;
    private String        imageUrl;
    private LocalDateTime fetchedAt;
}
