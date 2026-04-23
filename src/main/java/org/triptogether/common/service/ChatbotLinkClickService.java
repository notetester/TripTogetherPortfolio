package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.common.mapper.ChatbotLinkClickMapper;
import org.triptogether.common.vo.ChatbotLinkClickVO;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 챗봇 링크 클릭 로깅·집계 서비스.
 *
 * 로깅 실패가 사용자 네비게이션을 막지 않도록 insert 예외는 삼키고 경고만 남긴다.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotLinkClickService {

    private final ChatbotLinkClickMapper mapper;

    public void logClick(ChatbotLinkClickVO click) {
        try {
            mapper.insertClick(click);
        } catch (Exception e) {
            log.warn("[Chatbot] link-click 기록 실패 — messageId={}, url={}, 원인={}",
                    click.getMessageId(), click.getUrl(), e.getMessage());
        }
    }

    public int countClicks(LocalDateTime from, LocalDateTime to) {
        return mapper.countClicks(from, to);
    }

    public List<Map<String, Object>> getTopUrls(LocalDateTime from, LocalDateTime to, int limit) {
        return mapper.selectTopUrls(from, to, limit);
    }

    public List<Map<String, Object>> getDailyTrend(LocalDateTime from, LocalDateTime to) {
        return mapper.selectDailyTrend(from, to);
    }
}
