package org.triptogether.common.service;

import com.google.gson.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.common.vo.ChatbotRequestVO;
import org.triptogether.common.vo.ChatbotResponseVO;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotService {

    private final RestTemplate restTemplate;

    @Value("${claude.api.key}")
    private String claudeApiKey;

    @Value("${app.base-url}")
    private String baseUrl;

    private static final String CLAUDE_API_URL = "https://api.anthropic.com/v1/messages";
    private static final String MODEL = "claude-sonnet-4-20250514";

    // ══════════════════════════════════════════
    // 시스템 프롬프트 — 사이트 구조 정의
    // ══════════════════════════════════════════
    private static final String SYSTEM_PROMPT = """
            당신은 TripTogether 여행 플랫폼의 안내 도우미입니다.
            사용자가 원하는 것을 파악하고, 사이트 내 적절한 페이지로 안내해주세요.
            
            ## 사이트 구조 (내부 링크)
            
            | 페이지 | 경로 | 설명 |
            |--------|------|------|
            | 홈 | / | 메인 페이지 |
            | 여행지 탐색 | /explore | 전 세계 여행지 검색 및 필터링 |
            | 여행 코스 | /courses | 다른 여행자가 공유한 여행 코스 |
            | AI 도우미 | /assistant | AI가 맞춤 여행 계획 생성 |
            | 커뮤니티 | /community/list | 여행 후기, 사진, 정보 공유 |
            | 마이페이지 | /mypage | 내 프로필 및 활동 내역 |
            | 로그인 | /auth/login | 로그인 페이지 |
            | 회원가입 | /auth/register | 회원가입 페이지 |
            | 아이디 찾기 | /auth/find-id | 아이디 찾기 |
            | 비밀번호 찾기 | /auth/find-pw | 비밀번호 재설정 |
            | 회원정보 수정 | /mypage/edit-confirm | 회원정보 수정 |
            
            ## 응답 규칙
            
            반드시 아래 JSON 형식으로만 응답하세요. 다른 텍스트는 절대 포함하지 마세요.
            
            ```json
            {
              "message": "사용자에게 보여줄 안내 메시지 (최대 3문장, 친근하고 간결하게)",
              "links": [
                { "label": "버튼 텍스트", "url": "/경로", "icon": "이모지" }
              ],
              "quickReplies": ["빠른 답변1", "빠른 답변2", "빠른 답변3"]
            }
            ```
            
            - `links`: 관련 페이지 링크 버튼 (0~4개). 직접 관련 있는 것만 포함.
            - `quickReplies`: 다음에 물어볼 법한 질문 예시 (0~3개). 자연스러운 후속 질문.
            - 인사말이나 단순 대화에는 links를 비워도 됩니다.
            - 여행 관련 질문에는 반드시 관련 링크를 제공하세요.
            - 한국어로 응답하세요.
            """;

    // ══════════════════════════════════════════
    // 메인 처리
    // ══════════════════════════════════════════
    public ChatbotResponseVO ask(ChatbotRequestVO request) {
        try {
            // ── API 요청 페이로드 구성 ──
            JsonObject payload = new JsonObject();
            payload.addProperty("model", MODEL);
            payload.addProperty("max_tokens", 1024);
            payload.addProperty("system", buildSystemPrompt(request));

            // 대화 히스토리 + 현재 질문
            JsonArray messages = new JsonArray();
            if (request.getHistory() != null) {
                for (ChatbotRequestVO.HistoryItem h : request.getHistory()) {
                    // assistant 메시지는 JSON 원문이 들어있으므로 텍스트만 추출
                    String content = h.getContent();
                    if ("assistant".equals(h.getRole())) {
                        content = extractTextFromResponse(content);
                    }
                    JsonObject msg = new JsonObject();
                    msg.addProperty("role", h.getRole());
                    msg.addProperty("content", content);
                    messages.add(msg);
                }
            }

            // 현재 사용자 메시지 추가
            JsonObject userMsg = new JsonObject();
            userMsg.addProperty("role", "user");
            userMsg.addProperty("content", request.getMessage());
            messages.add(userMsg);

            payload.add("messages", messages);

            // ── HTTP 요청 ──
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-api-key", claudeApiKey);
            headers.set("anthropic-version", "2023-06-01");

            ResponseEntity<String> response = restTemplate.exchange(
                    CLAUDE_API_URL,
                    HttpMethod.POST,
                    new HttpEntity<>(payload.toString(), headers),
                    String.class
            );

            return parseClaudeResponse(response.getBody(), request.isLoggedIn());

        } catch (Exception e) {
            log.error("[Chatbot] API 호출 실패", e);
            return fallbackResponse();
        }
    }

    // ── 시스템 프롬프트 + 현재 컨텍스트 조합 ──
    private String buildSystemPrompt(ChatbotRequestVO request) {
        StringBuilder sb = new StringBuilder(SYSTEM_PROMPT);

        sb.append("\n\n## 현재 사용자 컨텍스트\n");
        sb.append("- 로그인 상태: ").append(request.isLoggedIn() ? "로그인 중" : "비로그인").append("\n");

        if (request.getCurrentPath() != null && !request.getCurrentPath().isBlank()) {
            sb.append("- 현재 페이지: ").append(getCurrentPageName(request.getCurrentPath())).append("\n");
        }

        if (!request.isLoggedIn()) {
            sb.append("\n비로그인 사용자에게는 로그인/회원가입 링크를 자주 추천하세요.\n");
        }

        return sb.toString();
    }

    // ── Claude 응답 파싱 ──
    private ChatbotResponseVO parseClaudeResponse(String body, boolean loggedIn) {
        try {
            JsonObject root = JsonParser.parseString(body).getAsJsonObject();
            JsonArray content = root.getAsJsonArray("content");
            String text = content.get(0).getAsJsonObject().get("text").getAsString().trim();

            // JSON 코드블록 제거
            text = text.replaceAll("```json\\s*", "").replaceAll("```\\s*", "").trim();

            JsonObject json = JsonParser.parseString(text).getAsJsonObject();

            ChatbotResponseVO vo = new ChatbotResponseVO();
            vo.setMessage(json.get("message").getAsString());

            // links
            List<ChatbotResponseVO.SiteLink> links = new ArrayList<>();
            if (json.has("links") && !json.get("links").isJsonNull()) {
                for (JsonElement el : json.getAsJsonArray("links")) {
                    JsonObject l = el.getAsJsonObject();
                    // 비로그인 시 마이페이지 링크 필터
                    String url = l.get("url").getAsString();
                    if (!loggedIn && url.startsWith("/mypage")) continue;

                    links.add(ChatbotResponseVO.SiteLink.builder()
                            .label(l.get("label").getAsString())
                            .url(url)
                            .icon(l.has("icon") ? l.get("icon").getAsString() : "")
                            .build());
                }
            }
            vo.setLinks(links);

            // quickReplies
            List<String> quickReplies = new ArrayList<>();
            if (json.has("quickReplies") && !json.get("quickReplies").isJsonNull()) {
                for (JsonElement el : json.getAsJsonArray("quickReplies")) {
                    quickReplies.add(el.getAsString());
                }
            }
            vo.setQuickReplies(quickReplies);

            return vo;

        } catch (Exception e) {
            log.error("[Chatbot] 응답 파싱 실패, body={}", body, e);
            return fallbackResponse();
        }
    }

    // ── assistant 히스토리에서 텍스트만 추출 ──
    private String extractTextFromResponse(String jsonContent) {
        try {
            JsonObject obj = JsonParser.parseString(jsonContent).getAsJsonObject();
            return obj.has("message") ? obj.get("message").getAsString() : jsonContent;
        } catch (Exception e) {
            return jsonContent;
        }
    }

    // ── 현재 페이지 이름 반환 ──
    private String getCurrentPageName(String path) {
        if (path.equals("/") || path.isEmpty())           return "홈";
        if (path.startsWith("/explore"))                  return "여행지 탐색";
        if (path.startsWith("/courses"))                  return "여행 코스";
        if (path.startsWith("/assistant"))                return "AI 도우미";
        if (path.startsWith("/community"))                return "커뮤니티";
        if (path.startsWith("/mypage"))                   return "마이페이지";
        if (path.startsWith("/auth"))                     return "인증 페이지";
        if (path.startsWith("/detail"))                   return "여행지 상세";
        return path;
    }

    // ── 폴백 응답 ──
    private ChatbotResponseVO fallbackResponse() {
        return ChatbotResponseVO.builder()
                .message("죄송해요, 잠시 문제가 생겼어요. 아래 링크를 이용해보세요! 🙏")
                .links(List.of(
                        ChatbotResponseVO.SiteLink.builder().label("여행지 탐색").url("/explore").icon("📍").build(),
                        ChatbotResponseVO.SiteLink.builder().label("AI 도우미").url("/assistant").icon("✨").build(),
                        ChatbotResponseVO.SiteLink.builder().label("커뮤니티").url("/community/list").icon("💬").build()
                ))
                .quickReplies(List.of("인기 여행지 추천", "여행 코스 보기"))
                .build();
    }
}
