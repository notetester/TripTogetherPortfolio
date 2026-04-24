package org.triptogether.assistant.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.triptogether.assistant.mapper.AssistantMapper;
import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AssistantServiceImpl implements AssistantService {

    private final RestTemplate restTemplate;
    private final AssistantMapper assistantMapper;

    /* ──────────────────────────────────────────────────────────────
     * [다국어] MessageSource를 주입받아서, 에러 메시지도 사용자의
     * 현재 언어에 맞게 출력할 수 있도록 한다.
     * (현재는 프롬프트 언어 전환만 사용하지만, 추후 확장 가능)
     * ────────────────────────────────────────────────────────────── */
    private final MessageSource messageSource;

    @Value("${openai.api.key:}")
    private String openAiApiKey;

    @Value("${openai.model:gpt-4o-mini}")
    private String openAiModel;

    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    private static final int MAX_HISTORY = 20;

    private static final String TEST_API_KEY = "YOUR_OPENAI_API_KEY";

    /* ──────────────────────────────────────────────────────────────
     * [다국어] 기존의 SYSTEM_PROMPT 상수를 제거하고,
     * buildSystemPrompt(lang) 메서드로 대체한다.
     *
     * 핵심 변경점:
     *   - 기존: "항상 한국어로 답변하세요" (하드코딩)
     *   - 변경: lang 파라미터에 따라 응답 언어를 동적으로 지정
     *
     * GPT에게 "어떤 언어로 답변해라" 라고 직접 지시하는 방식이
     * 가장 자연스럽고 품질이 높다.
     * (GPT 응답을 기계번역하는 것보다 훨씬 나은 결과를 얻을 수 있다)
     * ────────────────────────────────────────────────────────────── */

    /**
     * 언어 코드("ko", "en", "ja", "zh")를 GPT가 이해할 수 있는
     * 자연어 언어명으로 변환하는 Map.
     *
     * 예: "en" → "English"
     *     "ja" → "Japanese (日本語)"
     *
     * GPT는 영어로 된 지시를 가장 잘 따르기 때문에,
     * 시스템 프롬프트 자체는 영어로 작성하되
     * "답변 언어"만 해당 언어로 지정하는 전략을 사용한다.
     */
    private static final Map<String, String> LANG_NAME_MAP = Map.of(
            "ko", "Korean (한국어)",
            "en", "English",
            "ja", "Japanese (日本語)",
            "zh", "Chinese (中文)"
    );

    /**
     * 사용자의 현재 언어에 맞는 시스템 프롬프트를 동적으로 생성한다.
     *
     * @param lang 언어 코드 (예: "ko", "en", "ja", "zh")
     * @return GPT에게 전달할 시스템 프롬프트 문자열
     */
    private String buildSystemPrompt(String lang) {

        // lang이 null이거나 지원하지 않는 언어면 한국어를 기본값으로 사용
        String langName = LANG_NAME_MAP.getOrDefault(lang, "Korean (한국어)");

        /*
         * 시스템 프롬프트 구성:
         * - 역할 정의: TripTogether의 AI 여행 도우미
         * - 답변 규칙 1번: 기존 "항상 한국어로" → langName으로 동적 변경
         * - 나머지 규칙은 기존과 동일하게 유지
         */
        return """
                당신은 TripTogether의 AI 여행 도우미입니다.
                
                역할:
                - 여행지 추천
                - 여행 일정 초안 제안
                - 교통, 숙소, 음식, 예산, 준비물 안내
                - 여행 초보자도 이해하기 쉽게 설명
                
                답변 규칙:
                1. 항상 %s 로 답변하세요. (Always respond in %s)
                2. 여행과 관련 없는 질문은 정중하게 거절하세요.
                3. 답변은 실용적으로 작성하세요.
                4. 가능하면 항목별로 정리해서 가독성 있게 답하세요.
                5. 가격, 운영시간, 정책처럼 변동 가능한 정보는 단정하지 말고 유동적일 수 있다고 안내하세요.
                6. 사용자가 여행지, 예산, 기간, 동행 정보를 말하면 최대한 반영하세요.
                7. 너무 장황하지 않되 핵심 정보는 빠뜨리지 마세요.
                """.formatted(langName, langName);
    }

    @Override
    @Transactional
    public Map<String, Object> chat(String userMessage,
                                    List<Map<String, String>> history,
                                    Long userIdx,
                                    Long chatPostIdx,
                                    String lang) {   // ← 다국어 파라미터 추가

        Map<String, Object> result = new HashMap<>();

        try {
            if (userMessage == null || userMessage.trim().isEmpty()) {
                result.put("success", false);
                result.put("answer", "메시지를 입력해주세요.");
                result.put("history", history != null ? history : new ArrayList<>());
                return result;
            }

            if (openAiApiKey == null || openAiApiKey.trim().isEmpty()) {
                result.put("success", false);
                result.put("answer", "OpenAI API 키가 설정되지 않았습니다. application.properties 또는 환경변수를 확인해주세요.");
                result.put("history", history != null ? history : new ArrayList<>());
                return result;
            }

            List<Map<String, String>> messages =
                    history != null ? new ArrayList<>(history) : new ArrayList<>();

            Map<String, String> userMsg = new HashMap<>();
            userMsg.put("role", "user");
            userMsg.put("content", userMessage.trim());
            messages.add(userMsg);

            List<Map<String, String>> requestMessages = new ArrayList<>();

            /* ──────────────────────────────────────────────────────────
             * [다국어] 기존: SYSTEM_PROMPT 상수 사용 (한국어 고정)
             *         변경: buildSystemPrompt(lang) 호출 (동적 언어)
             * ────────────────────────────────────────────────────────── */
            Map<String, String> systemMsg = new HashMap<>();
            systemMsg.put("role", "system");
            systemMsg.put("content", buildSystemPrompt(lang));  // ← 핵심 변경
            requestMessages.add(systemMsg);
            requestMessages.addAll(messages);

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", openAiModel);
            requestBody.put("messages", requestMessages);
            requestBody.put("temperature", 0.7);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            // headers.setBearerAuth(openAiApiKey.trim());
            headers.setBearerAuth(TEST_API_KEY.trim());

            String requestJson = new Gson().toJson(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(requestJson, headers);

            ResponseEntity<String> response = restTemplate.exchange(
                    OPENAI_API_URL,
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            JsonObject responseJson = JsonParser.parseString(response.getBody()).getAsJsonObject();
            JsonArray choices = responseJson.getAsJsonArray("choices");

            if (choices == null || choices.isEmpty()) {
                throw new RuntimeException("OpenAI 응답에 choices가 없습니다.");
            }

            String assistantAnswer = choices.get(0)
                    .getAsJsonObject()
                    .getAsJsonObject("message")
                    .get("content")
                    .getAsString()
                    .trim();

            Map<String, String> assistantMsg = new HashMap<>();
            assistantMsg.put("role", "assistant");
            assistantMsg.put("content", assistantAnswer);
            messages.add(assistantMsg);

            while (messages.size() > MAX_HISTORY) {
                messages.remove(0);
            }

            Long currentChatPostIdx = chatPostIdx;

            if (userIdx != null) {

                if (currentChatPostIdx == null) {
                    ChatPostVO chatPostVO = ChatPostVO.builder()
                            .user_idx(userIdx)
                            .title(makeTitle(userMessage))
                            .build();

                    assistantMapper.insertChatPost(chatPostVO);
                    currentChatPostIdx = chatPostVO.getChat_post_idx();
                }

                Integer maxOrder = assistantMapper.selectMaxCommentOrder(currentChatPostIdx);
                int lastOrder = (maxOrder == null) ? 0 : maxOrder;

                int userOrder = lastOrder + 1;
                int assistantOrder = lastOrder + 2;

                ChatCommentVO userComment = ChatCommentVO.builder()
                        .chat_post_idx(currentChatPostIdx)
                        .user_idx(userIdx)
                        .comment_role("USER")
                        .content(userMessage.trim())
                        .comment_order(userOrder)
                        .build();

                ChatCommentVO assistantComment = ChatCommentVO.builder()
                        .chat_post_idx(currentChatPostIdx)
                        .user_idx(userIdx)
                        .comment_role("ASSISTANT")
                        .content(assistantAnswer)
                        .comment_order(assistantOrder)
                        .build();

                assistantMapper.insertChatComment(userComment);
                assistantMapper.insertChatComment(assistantComment);

                result.put("chatPostIdx", currentChatPostIdx);
            } else {
                // 비로그인 -> 저장 안함
                result.put("chatPostIdx", null);
            }

            result.put("success", true);
            result.put("answer", assistantAnswer);
            result.put("history", messages);

        } catch (HttpStatusCodeException e) {
            String responseBody = e.getResponseBodyAsString();
            log.error("[AssistantService] OpenAI HTTP 오류: status={}, body={}", e.getStatusCode(), responseBody, e);

            result.put("success", false);
            result.put("answer", "OpenAI 호출 중 오류가 발생했습니다. 상태코드=" + e.getStatusCode().value());
            result.put("history", history != null ? history : new ArrayList<>());
        } catch (Exception e) {
            log.error("[AssistantService] OpenAI API 호출 실패: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("answer", "죄송합니다. 일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            result.put("history", history != null ? history : new ArrayList<>());
        }

        return result;
    }

    @Override
    public List<ChatPostVO> getRecentChatPosts(Long userIdx) {
        if (userIdx == null) {
            return new ArrayList<>();
        }

        return assistantMapper.selectRecentChatPosts(userIdx);
    }

    @Override
    public List<ChatCommentVO> getChatComments(Long chatPostIdx, Long userIdx) {
        if (userIdx == null || chatPostIdx == null) {
            return new ArrayList<>();
        }

        return assistantMapper.selectChatComments(chatPostIdx, userIdx);
    }

    @Override
    @Transactional
    public boolean updateChatPostTitle(Long chatPostIdx, Long userIdx, String title) {
        if (userIdx == null || chatPostIdx == null || title == null || title.trim().isEmpty()) {
            return false;
        }

        int result = assistantMapper.updateChatPostTitle(
                chatPostIdx,
                userIdx,
                title.trim()
        );

        return result > 0;
    }

    @Override
    @Transactional
    public boolean deleteChatPost(Long chatPostIdx, Long userIdx) {
        if (userIdx == null || chatPostIdx == null) {
            return false;
        }

        assistantMapper.deleteChatComments(chatPostIdx, userIdx);
        int result = assistantMapper.deleteChatPost(chatPostIdx, userIdx);

        return result > 0;
    }

    private String makeTitle(String userMessage) {
        String msg = userMessage == null ? "" : userMessage.trim();
        if (msg.isEmpty()) return "새 대화";
        return msg.length() > 20 ? msg.substring(0, 20) + "..." : msg;
    }
}
