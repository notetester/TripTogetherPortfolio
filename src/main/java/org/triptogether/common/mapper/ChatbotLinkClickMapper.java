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

    /** Filter 1: 특정 유저의 최근 클릭 이력 (user_idx = X) */
    List<ChatbotLinkClickVO> selectClicksByUser(@Param("userIdx") Long userIdx,
                                                 @Param("limit") int limit);

    /** Filter 2: 특정 IP의 전체 클릭 이력 (모든 유저 + 익명) */
    List<ChatbotLinkClickVO> selectClicksByIp(@Param("ip") String ip,
                                               @Param("limit") int limit);

    /** Filter 3: 특정 유저 AND 특정 IP (교집합) */
    List<ChatbotLinkClickVO> selectClicksByUserAndIp(@Param("userIdx") Long userIdx,
                                                      @Param("ip") String ip,
                                                      @Param("limit") int limit);

    /** Filter 4: 특정 유저 OR 특정 IP (합집합 — 중복계정 추적용) */
    List<ChatbotLinkClickVO> selectClicksByUserOrIp(@Param("userIdx") Long userIdx,
                                                     @Param("ip") String ip,
                                                     @Param("limit") int limit);

    /** Filter 5: 특정 IP에서 특정 유저 로그인 + 익명 (다른 로그인 유저 제외) */
    List<ChatbotLinkClickVO> selectClicksByIpExcludeOtherUsers(@Param("userIdx") Long userIdx,
                                                                @Param("ip") String ip,
                                                                @Param("limit") int limit);

    /** 특정 대화의 전체 클릭 이력 (오름차순) */
    List<ChatbotLinkClickVO> selectClicksByConversation(@Param("conversationId") Long conversationId);

    /** 특정 URL 을 클릭한 사용자/IP 이력 (최신순) */
    List<Map<String, Object>> selectClickersByUrl(@Param("url") String url,
                                                    @Param("limit") int limit);
}
