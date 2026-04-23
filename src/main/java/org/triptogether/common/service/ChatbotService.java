package org.triptogether.common.service;

import com.google.gson.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ChatbotQuotaVO;
import org.triptogether.common.vo.ChatbotRequestVO;
import org.triptogether.common.vo.ChatbotResponseVO;
import org.triptogether.common.vo.ConversationVO;

import java.util.*;
import java.util.regex.Pattern;

/**
 * TripTogether 챗봇 서비스 (Gemini 기반).
 *
 * 처리 흐름:
 *  1. 차단 체크 (IP + USER)
 *  2. 등급별 한도 조회
 *  3. 일일 메시지 한도 체크
 *  4. 대화 조회/생성 (신규면 한도 체크 후 생성)
 *  5. 유저 메시지 저장
 *  6. 최근 N개 히스토리 로드
 *  7. Gemini 호출
 *  8. 응답 파싱 및 저장 (inappropriate 플래그 포함)
 *  9. 사용량 +1, last_active 갱신
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotService {

    private final RestTemplate restTemplate;
    private final ChatbotBlockService blockService;
    private final ChatbotQuotaService quotaService;
    private final ConversationService conversationService;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    // ══════════════════════════════════════════════════════════
    // 허용 내부 경로 화이트리스트 (Gemini 응답의 링크 검증용)
    //   - 신규 라우트 추가 시 이 배열에 추가할 것
    //   - 외부 URL / 위험 스킴 / 경로 순회는 별도 검사로 차단
    // ══════════════════════════════════════════════════════════
    private static final List<Pattern> ALLOWED_URL_PATTERNS = List.of(
            Pattern.compile("^/$"),
            Pattern.compile("^/explore(/\\d+)?(\\?.*)?$"),
            Pattern.compile("^/courses(/\\d+)?(\\?.*)?$"),
            Pattern.compile("^/community/list(\\?.*)?$"),
            Pattern.compile("^/community/detail/\\d+(\\?.*)?$"),
            Pattern.compile("^/community/write(\\?.*)?$"),
            Pattern.compile("^/assistant(\\?.*)?$"),
            Pattern.compile("^/packages(/\\d+)?(\\?.*)?$"),
            Pattern.compile("^/packages/manage(/.*)?(\\?.*)?$"),
            Pattern.compile("^/wallet(/.*)?(\\?.*)?$"),
            Pattern.compile("^/shop(/.*)?(\\?.*)?$"),
            Pattern.compile("^/mypage(/.*)?(\\?.*)?$"),
            Pattern.compile("^/inquiry/list(\\?.*)?$"),
            Pattern.compile("^/inquiry/detail/\\d+(\\?.*)?$"),
            Pattern.compile("^/inquiry/write(\\?.*)?$"),
            Pattern.compile("^/auth/(login|register|find-password)(\\?.*)?$")
    );

    private static final Pattern DANGEROUS_SCHEME_PATTERN =
            Pattern.compile("^\\s*(?:javascript|data|file|vbscript):", Pattern.CASE_INSENSITIVE);

    // ══════════════════════════════════════════════════════════
    // 시스템 프롬프트
    // ══════════════════════════════════════════════════════════
    private static final String SYSTEM_PROMPT = """
            당신은 'TripTogether' 여행 플랫폼의 공식 챗봇 '트립이'입니다.
            친근하고 활기찬 톤으로 한국어로 대화합니다.

            ## 사이트 구조 및 기능

            | 기능 | 경로 | 설명 |
            |------|------|------|
            | 홈 | / | 메인 페이지 |
            | 여행지 탐색 | /explore | 국가·태그 필터로 여행지 검색, 리뷰 확인 |
            | 여행 코스 | /courses | 다른 여행자의 코스 탐색 및 공유 |
            | AI 도우미 | /assistant | AI가 여행 일정 자동 생성 |
            | 커뮤니티 | /community/list | 여행 후기·팁 공유 게시판 |
            | 지갑·포인트 | /wallet | 포인트 잔액·충전·사용 내역 |
            | 쇼핑몰 | /shop | 여행 용품 쇼핑 |
            | 여행 패키지 | /packages | 전문 가이드 패키지 상품 |
            | 마이페이지 | /mypage | 내 활동·예약·포인트 |
            | 문의하기 | /inquiry/list | 고객센터 문의 |
            | 로그인 | /auth/login | 일반·소셜 로그인 |
            | 회원가입 | /auth/register | 신규 가입 |

            ## 응답 규칙

            반드시 아래 JSON 형식으로만 응답하세요. 다른 텍스트는 절대 포함하지 마세요.

            ```json
            {
              "message": "최대 3문장, 친근하고 간결. 줄바꿈은 \\\\n 사용",
              "links": [
                { "label": "버튼 텍스트", "url": "/경로", "icon": "이모지" }
              ],
              "quickReplies": ["빠른 답변1", "빠른 답변2"],
              "inappropriate": false
            }
            ```

            ### 응답 지침
            - `links`: 직접 관련 있는 페이지만 0~4개. 실제 존재하는 경로만.
            - `quickReplies`: 자연스러운 후속 질문 0~3개.
            - `inappropriate`: 아래 기준에 해당하면 true.
            - 여행·사이트 관련 질문에만 답하세요.
            - 쇼핑·결제 관련 질문은 /shop, /packages, /wallet 중 해당하는 링크 제공.
            - 비로그인 사용자에게는 로그인·회원가입 링크를 적극 추천.

            ### 부적절 채팅 기준 (inappropriate: true)
            - 욕설, 비방, 혐오 표현
            - 사이트와 무관한 질문 (날씨, 주식, 정치, 연예인 등 순수 잡담)
            - 개인정보 요구 또는 제공
            - 스팸성 반복 메시지
            """;

    // ══════════════════════════════════════════════════════════
    // 메인 처리
    // 주의: @Transactional 을 걸면 외부 Gemini 호출 동안 DB 커넥션이 점유되므로 의도적으로 제외.
    //       대신 conversation create 등 각 내부 서비스에서 자체 트랜잭션 관리.
    // ══════════════════════════════════════════════════════════
    public ChatbotResponseVO ask(ChatbotRequestVO request,
                                 UsersVO loginUser,
                                 String anonSessionId,
                                 String ipAddress) {

        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        boolean loggedIn = loginUser != null;

        // 1. 차단 체크
        if (blockService.isBlocked(ipAddress, userIdx)) {
            return blockedResponse();
        }

        // 2. 등급별 한도 조회
        String grade = quotaService.resolveGrade(loginUser);
        ChatbotQuotaVO quota = quotaService.getQuotaByGrade(grade);
        boolean quotaExempt = quotaService.isQuotaExempt(loginUser);

        // 3. 일일 메시지 한도 체크
        if (!quotaExempt && quota != null) {
            int usage = quotaService.getTodayUsage(userIdx, userIdx == null ? anonSessionId : null);
            if (usage >= quota.getMaxMessagesPerDay()) {
                return quotaExceededResponse(quota.getMaxMessagesPerDay());
            }
        }

        // 4. 대화 조회 또는 신규 생성
        ConversationVO conversation = resolveOrCreateConversation(
                request, userIdx, anonSessionId, ipAddress, quota, quotaExempt);
        if (conversation == null) {
            return conversationLimitResponse(quota != null ? quota.getMaxConversations() : 0);
        }

        // 5. 유저 메시지 저장
        ChatMessageVO userMsg = new ChatMessageVO();
        userMsg.setConversationId(conversation.getConversationId());
        userMsg.setRole("user");
        userMsg.setContent(request.getMessage());
        userMsg.setIsInappropriate(false);
        conversationService.saveMessage(userMsg);

        // 6. 최근 N개 히스토리 로드 (현재 저장한 메시지 제외)
        int contextLimit = quota != null ? quota.getMaxContextMessages() : 10;
        List<ChatMessageVO> history = conversationService.getRecentMessages(
                conversation.getConversationId(), contextLimit + 1);
        if (!history.isEmpty() && Objects.equals(history.get(history.size() - 1).getMessageId(),
                userMsg.getMessageId())) {
            history = history.subList(0, history.size() - 1);
        }

        // 7. Gemini 호출
        ChatbotResponseVO response = callGemini(request, history, loggedIn);

        // 8. 부적절 플래그 처리
        if (response.isInappropriate()) {
            conversationService.markInappropriate(userMsg.getMessageId());
            log.warn("[Chatbot] 부적절 메시지 - conversationId={}, messageId={}, ip={}",
                    conversation.getConversationId(), userMsg.getMessageId(), ipAddress);
        }

        // 9. assistant 메시지 저장
        ChatMessageVO botMsg = new ChatMessageVO();
        botMsg.setConversationId(conversation.getConversationId());
        botMsg.setRole("assistant");
        botMsg.setContent(response.getMessage());
        botMsg.setIsInappropriate(false);
        conversationService.saveMessage(botMsg);

        // 10. 대화 활동 시각 갱신
        conversationService.touch(conversation.getConversationId());

        // 11. 일일 사용량 +1 (면제자 제외)
        if (!quotaExempt) {
            quotaService.incrementTodayUsage(userIdx, userIdx == null ? anonSessionId : null);
        }

        // 12. 응답에 conversationId 포함
        response.setConversationId(conversation.getConversationId());
        return response;
    }

    // 대화 조회 or 신규 생성 + 소유권/한도 체크
    private ConversationVO resolveOrCreateConversation(ChatbotRequestVO request,
                                                        Long userIdx,
                                                        String anonSessionId,
                                                        String ipAddress,
                                                        ChatbotQuotaVO quota,
                                                        boolean quotaExempt) {
        // 기존 대화 이어하기
        if (request.getConversationId() != null) {
            ConversationVO conv = conversationService.getConversation(request.getConversationId());
            if (conv == null || Boolean.TRUE.equals(conv.getIsDeleted())) return null;
            if (!conversationService.isOwner(conv, userIdx, anonSessionId)) return null;
            return conv;
        }

        // 신규 대화 — 대화 수 한도 체크 (면제자 제외)
        if (!quotaExempt && quota != null) {
            int active = conversationService.countActiveConversations(userIdx,
                    userIdx == null ? anonSessionId : null);
            if (active >= quota.getMaxConversations()) {
                return null;
            }
        }

        return conversationService.createConversation(userIdx, anonSessionId, ipAddress, request.getMessage());
    }

    // ══════════════════════════════════════════════════════════
    // Gemini 호출
    // ══════════════════════════════════════════════════════════
    private ChatbotResponseVO callGemini(ChatbotRequestVO request,
                                          List<ChatMessageVO> history,
                                          boolean loggedIn) {
        try {
            JsonObject systemInstruction = new JsonObject();
            JsonArray systemParts = new JsonArray();
            JsonObject systemPart = new JsonObject();
            systemPart.addProperty("text", buildSystemPrompt(request, loggedIn));
            systemParts.add(systemPart);
            systemInstruction.add("parts", systemParts);

            JsonArray contents = new JsonArray();
            for (ChatMessageVO h : history) {
                JsonObject msgObj = new JsonObject();
                msgObj.addProperty("role", "user".equals(h.getRole()) ? "user" : "model");
                JsonArray parts = new JsonArray();
                JsonObject part = new JsonObject();
                String content = "assistant".equals(h.getRole())
                        ? extractMessageText(h.getContent())
                        : h.getContent();
                part.addProperty("text", content);
                parts.add(part);
                msgObj.add("parts", parts);
                contents.add(msgObj);
            }

            JsonObject curMsg = new JsonObject();
            curMsg.addProperty("role", "user");
            JsonArray curParts = new JsonArray();
            JsonObject curPart = new JsonObject();
            curPart.addProperty("text", request.getMessage());
            curParts.add(curPart);
            curMsg.add("parts", curParts);
            contents.add(curMsg);

            JsonObject generationConfig = new JsonObject();
            generationConfig.addProperty("responseMimeType", "application/json");
            generationConfig.addProperty("maxOutputTokens", 1024);
            generationConfig.addProperty("temperature", 0.7);

            JsonObject payload = new JsonObject();
            payload.add("systemInstruction", systemInstruction);
            payload.add("contents", contents);
            payload.add("generationConfig", generationConfig);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            ResponseEntity<String> response = restTemplate.exchange(
                    GEMINI_URL + geminiApiKey,
                    HttpMethod.POST,
                    new HttpEntity<>(payload.toString(), headers),
                    String.class
            );

            return parseGeminiResponse(response.getBody(), loggedIn);

        } catch (HttpClientErrorException e) {
            log.error("[Chatbot] Gemini HTTP 오류 status={}, body={}",
                    e.getStatusCode(), e.getResponseBodyAsString());
            return fallbackResponse();
        } catch (Exception e) {
            log.error("[Chatbot] Gemini API 호출 실패", e);
            return fallbackResponse();
        }
    }

    private ChatbotResponseVO parseGeminiResponse(String body, boolean loggedIn) {
        try {
            JsonObject root = JsonParser.parseString(body).getAsJsonObject();

            // API 오류 응답 처리
            if (root.has("error")) {
                log.error("[Chatbot] Gemini API error 응답: {}", root.get("error"));
                return fallbackResponse();
            }

            // candidates 누락 또는 빈 배열
            if (!root.has("candidates") || root.getAsJsonArray("candidates").isEmpty()) {
                log.error("[Chatbot] Gemini 응답에 candidates 없음. body={}", body);
                return fallbackResponse();
            }

            JsonObject candidate = root.getAsJsonArray("candidates").get(0).getAsJsonObject();

            // 안전 필터로 차단된 경우 content 필드가 없음
            if (!candidate.has("content")) {
                String finishReason = candidate.has("finishReason") ? candidate.get("finishReason").getAsString() : "UNKNOWN";
                log.warn("[Chatbot] Gemini 응답 content 없음. finishReason={}", finishReason);
                return safetyBlockedResponse();
            }

            JsonObject content = candidate.getAsJsonObject("content");
            if (!content.has("parts") || content.getAsJsonArray("parts").isEmpty()) {
                log.error("[Chatbot] Gemini 응답 parts 없음. body={}", body);
                return fallbackResponse();
            }

            String text = content.getAsJsonArray("parts").get(0).getAsJsonObject()
                    .get("text").getAsString().trim();

            text = text.replaceAll("(?s)```json\\s*", "").replaceAll("```\\s*", "").trim();

            JsonObject json = JsonParser.parseString(text).getAsJsonObject();

            ChatbotResponseVO vo = new ChatbotResponseVO();
            vo.setMessage(json.get("message").getAsString());
            vo.setInappropriate(json.has("inappropriate") && json.get("inappropriate").getAsBoolean());

            List<ChatbotResponseVO.SiteLink> links = new ArrayList<>();
            if (json.has("links") && !json.get("links").isJsonNull()) {
                for (JsonElement el : json.getAsJsonArray("links")) {
                    JsonObject l = el.getAsJsonObject();
                    String url = l.get("url").getAsString();
                    if (!isAllowedInternalUrl(url)) {
                        log.warn("[Chatbot] 허용되지 않은 URL drop: {}", url);
                        continue;
                    }
                    if (!loggedIn && url.startsWith("/mypage")) continue;
                    links.add(ChatbotResponseVO.SiteLink.builder()
                            .label(l.get("label").getAsString())
                            .url(url)
                            .icon(l.has("icon") ? l.get("icon").getAsString() : "→")
                            .build());
                }
            }
            vo.setLinks(links);

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

    private String buildSystemPrompt(ChatbotRequestVO request, boolean loggedIn) {
        StringBuilder sb = new StringBuilder(SYSTEM_PROMPT);
        sb.append("\n\n## 현재 사용자 컨텍스트\n");
        sb.append("- 로그인 상태: ").append(loggedIn ? "로그인 중" : "비로그인").append("\n");
        if (request.getCurrentPath() != null && !request.getCurrentPath().isBlank()) {
            sb.append("- 현재 페이지: ").append(getCurrentPageName(request.getCurrentPath())).append("\n");
        }
        return sb.toString();
    }

    private String extractMessageText(String content) {
        try {
            JsonObject obj = JsonParser.parseString(content).getAsJsonObject();
            return obj.has("message") ? obj.get("message").getAsString() : content;
        } catch (Exception e) {
            return content;
        }
    }

    // Gemini가 생성한 내부 URL 검증 — 화이트리스트 + 위험 스킴/경로 차단
    private boolean isAllowedInternalUrl(String url) {
        if (url == null) return false;
        String trimmed = url.trim();
        if (trimmed.isEmpty()) return false;
        if (DANGEROUS_SCHEME_PATTERN.matcher(trimmed).find()) return false;
        if (!trimmed.startsWith("/")) return false;
        if (trimmed.startsWith("//")) return false;          // protocol-relative 차단
        if (trimmed.contains("..")) return false;            // 경로 순회 차단
        for (Pattern p : ALLOWED_URL_PATTERNS) {
            if (p.matcher(trimmed).matches()) return true;
        }
        return false;
    }

    private String getCurrentPageName(String path) {
        if (path.equals("/") || path.isEmpty())    return "홈";
        if (path.startsWith("/explore"))           return "여행지 탐색";
        if (path.startsWith("/courses"))           return "여행 코스";
        if (path.startsWith("/assistant"))         return "AI 도우미";
        if (path.startsWith("/community"))         return "커뮤니티";
        if (path.startsWith("/mypage"))            return "마이페이지";
        if (path.startsWith("/auth"))              return "인증 페이지";
        if (path.startsWith("/wallet"))            return "지갑·포인트";
        if (path.startsWith("/shop"))              return "쇼핑몰";
        if (path.startsWith("/packages"))          return "여행 패키지";
        if (path.startsWith("/inquiry"))           return "문의하기";
        return path;
    }

    // ══════════════════════════════════════════════════════════
    // 특수 응답
    // ══════════════════════════════════════════════════════════
    private ChatbotResponseVO safetyBlockedResponse() {
        return ChatbotResponseVO.builder()
                .message("해당 질문에는 답변하기 어려워요. 여행 관련 질문으로 다시 물어봐 주세요.")
                .links(List.of())
                .quickReplies(List.of("인기 여행지 추천", "여행 코스 보기"))
                .inappropriate(true)
                .build();
    }

    private ChatbotResponseVO blockedResponse() {
        return ChatbotResponseVO.builder()
                .message("죄송합니다. 현재 챗봇 이용이 제한된 상태입니다. 문의사항은 고객센터로 연락해 주세요.")
                .links(List.of(
                        ChatbotResponseVO.SiteLink.builder()
                                .label("문의하기").url("/inquiry/list").icon("📩").build()
                ))
                .quickReplies(List.of())
                .inappropriate(false)
                .build();
    }

    private ChatbotResponseVO quotaExceededResponse(int limit) {
        return ChatbotResponseVO.builder()
                .message("오늘의 채팅 한도(" + limit + "건)를 모두 사용했어요. 내일 다시 만나요!")
                .links(List.of())
                .quickReplies(List.of())
                .inappropriate(false)
                .build();
    }

    private ChatbotResponseVO conversationLimitResponse(int limit) {
        return ChatbotResponseVO.builder()
                .message("대화 수 한도(" + limit + "개)에 도달했어요. 기존 대화를 삭제하거나 이어서 진행해 주세요.")
                .links(List.of())
                .quickReplies(List.of())
                .inappropriate(false)
                .build();
    }

    private ChatbotResponseVO fallbackResponse() {
        return ChatbotResponseVO.builder()
                .message("죄송해요, 잠시 문제가 생겼어요. 아래 링크를 이용해보세요! 🙏")
                .links(List.of(
                        ChatbotResponseVO.SiteLink.builder().label("여행지 탐색").url("/explore").icon("📍").build(),
                        ChatbotResponseVO.SiteLink.builder().label("AI 도우미").url("/assistant").icon("✨").build(),
                        ChatbotResponseVO.SiteLink.builder().label("커뮤니티").url("/community/list").icon("💬").build()
                ))
                .quickReplies(List.of("인기 여행지 추천", "여행 코스 보기"))
                .inappropriate(false)
                .build();
    }
}
