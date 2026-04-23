package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.common.vo.ChatbotLinkClickVO;

/**
 * CHATBOT_LINK_CLICK 매퍼.
 * P1-1: 기록 전용. 조회·집계 메서드는 P1-2 이후 단계적으로 추가.
 */
@Mapper
public interface ChatbotLinkClickMapper {

    /** 링크 클릭 기록 저장 */
    void insertClick(ChatbotLinkClickVO click);
}
