package org.triptogether.explore.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.explore.vo.SpotTextTranslationVO;

@Mapper
public interface SpotTextTranslationMapper {

    SpotTextTranslationVO selectCache(@Param("sourceType") String sourceType,
                                      @Param("sourcePk") Long sourcePk,
                                      @Param("fieldName") String fieldName,
                                      @Param("sourceTextHash") String sourceTextHash,
                                      @Param("targetLang") String targetLang);

    void upsertCache(SpotTextTranslationVO cache);
}
