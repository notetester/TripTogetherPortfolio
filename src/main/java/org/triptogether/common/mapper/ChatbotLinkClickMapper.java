package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.ChatbotLinkClickVO;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * CHATBOT_LINK_CLICK 매퍼.
 *   - P1-1: insertClick (기록)
 *   - P1-2: 관리자 집계 (총계 / 상위 URL / 일별 추이)
 */
@Mapper
public interface ChatbotLinkClickMapper {

    /** 링크 클릭 기록 저장 */
    void insertClick(ChatbotLinkClickVO click);

    /** 지정 기간 총 클릭 수 (from ≤ clicked_at < to) */
    int countClicks(@Param("from") LocalDateTime from,
                    @Param("to") LocalDateTime to);

    /** 지정 기간 URL 별 클릭 수 상위 N */
    List<Map<String, Object>> selectTopUrls(@Param("from") LocalDateTime from,
                                             @Param("to") LocalDateTime to,
                                             @Param("limit") int limit);

    /** 지정 기간 일별 클릭 수 (날짜 오름차순) */
    List<Map<String, Object>> selectDailyTrend(@Param("from") LocalDateTime from,
                                                @Param("to") LocalDateTime to);
}
