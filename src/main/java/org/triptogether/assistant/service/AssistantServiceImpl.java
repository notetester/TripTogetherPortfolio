package org.triptogether.assistant.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
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

    @Value("${openai.api.key:}")
    private String openAiApiKey;

    @Value("${openai.model:gpt-4o-mini}")
    private String openAiModel;

    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    private static final int MAX_HISTORY = 20;

    private static final String TEST_API_KEY = "YOUR_OPENAI_API_KEY";

    private static final String SYSTEM_PROMPT = """
            당신은 TripTogether의 AI 여행 도우미입니다.

            역할:
            - 여행지 추천
            - 여행 일정 초안 제안
            - 교통, 숙소, 음식, 예산, 준비물 안내
            - 여행 초보자도 이해하기 쉽게 설명

            답변 규칙:
            1. 항상 한국어로 답변하세요.
            2. 여행과 관련 없는 질문은 정중하게 거절하세요.
            3. 답변은 실용적으로 작성하세요.
            4. 가능하면 항목별로 정리해서 가독성 있게 답하세요.
            5. 가격, 운영시간, 정책처럼 변동 가능한 정보는 단정하지 말고 유동적일 수 있다고 안내하세요.
            6. 사용자가 여행지, 예산, 기간, 동행 정보를 말하면 최대한 반영하세요.
            7. 너무 장황하지 않되 핵심 정보는 빠뜨리지 마세요.
            """;

    @Override
    @Transactional
    public Map<String, Object> chat(String userMessage,
                                    List<Map<String, String>> history,
                                    Long userIdx,
                                    Long chatPostIdx) {

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

            Map<String, String> systemMsg = new HashMap<>();
            systemMsg.put("role", "system");
            systemMsg.put("content", SYSTEM_PROMPT);
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
            if (currentChatPostIdx == null) {
                ChatPostVO chatPost = ChatPostVO.builder()
                        .user_idx(userIdx)
                        .title(makeTitle(userMessage))
                        .build();

                assistantMapper.insertChatPost(chatPost);
                currentChatPostIdx = chatPost.getChat_post_idx();
            }

            int historySizeBeforeThisTurn = (history == null) ? 0 : history.size();
            int userOrder = historySizeBeforeThisTurn + 1;
            int assistantOrder = historySizeBeforeThisTurn + 2;

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

            result.put("success", true);
            result.put("answer", assistantAnswer);
            result.put("history", messages);
            result.put("chatPostIdx", currentChatPostIdx);

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

    private String makeTitle(String userMessage) {
        String msg = userMessage == null ? "" : userMessage.trim();
        if (msg.isEmpty()) return "새 대화";
        return msg.length() > 20 ? msg.substring(0, 20) + "..." : msg;
    }
}
