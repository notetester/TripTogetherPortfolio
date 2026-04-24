package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.ViewHistoryItemDto;

import java.util.List;

@Mapper
public interface ViewHistoryMapper {

    /** 조회 이력 업서트: 같은 (user, type, id) 재조회 시 viewed_at 만 갱신 */
    void upsertView(@Param("userIdx")      Long   userIdx,
                    @Param("contentType")  String contentType,
                    @Param("contentId")    Long   contentId);

    /** 유저당 최근 keep 개만 남기고 초과분 삭제 */
    int pruneOld(@Param("userIdx") Long userIdx,
                 @Param("keep")    int  keep);

    /** 최근 조회 목록 (타입별 LEFT JOIN 으로 title/thumbnail 까지) */
    List<ViewHistoryItemDto> selectRecent(@Param("userIdx") Long userIdx,
                                          @Param("limit")   int  limit);

    /** 전체 개수 */
    int countRecent(@Param("userIdx") Long userIdx);

    /** 개별 삭제 (본인 기록만) */
    int deleteOne(@Param("userIdx")    Long userIdx,
                  @Param("historyIdx") Long historyIdx);

    /** 전체 삭제 */
    int deleteAll(@Param("userIdx") Long userIdx);
}
