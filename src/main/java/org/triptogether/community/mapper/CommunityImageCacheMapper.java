package org.triptogether.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommunityImageCacheMapper {

    /** 지역 캐시 전체 삭제 */
    void deleteCacheByRegion(@Param("region") String region);

    /** 캐시 1건 삽입 */
    void insertCache(@Param("region") String region, @Param("imageUrl") String imageUrl);

    /** 특정 지역에서 랜덤 1장 */
    String selectRandomCacheImage(@Param("region") String region);

    /** 전체 캐시에서 랜덤 1장 (etc 지역용) */
    String selectRandomCacheImageFromAll();
}
