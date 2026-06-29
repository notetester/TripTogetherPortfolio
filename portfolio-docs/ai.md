# AI 통합

TripTogether는 단일 LLM에 의존하지 않고, **용도별로 가장 적합한 모델을 분리 적용한 멀티모델 아키텍처**를 채택했습니다. 사이트 네비게이션·콘텐츠 추천에는 Google Gemini, 여행 일정 자동 생성과 멀티턴 플래닝 상담에는 OpenAI GPT, CS 답변 초안에는 Anthropic Claude, 사용자 작성 글의 독성 감지에는 Google Perspective를 사용합니다.

각 연동은 외부 API의 지연·실패·악용을 전제로 설계되었습니다. 모든 호출 경로에 **fail-safe 폴백**(실패해도 사용자 흐름을 막지 않음), **구조화 JSON 파싱**, **쿼터·차단·독성 검증**을 결합하여, AI 응답을 신뢰할 수 없는 외부 입력으로 다룹니다. 특히 LLM이 생성한 링크·텍스트는 화이트리스트 검증과 모더레이션 파이프라인을 통과한 뒤에야 사용자에게 노출됩니다.

## 주요 기능

- **사이트 네비게이션 챗봇(`common`)** — Gemini 기반 '트립이'. 의도 분류 → 실시간 DB 콘텐츠 주입 → 구조화 응답(메시지·링크·빠른답변) 생성. 등급별 쿼터·차단·다국어 지원.
- **멀티턴 여행 상담 어시스턴트(`assistant`)** — GPT 기반 대화형 여행 도우미. 대화 이력 관리(in-memory 메시지 최대 20개 유지), 사용자 로케일별 응답 언어 전환, 대화 DB 저장.
- **AI 일정 자동 생성(`ai`)** — GPT Structured Outputs(JSON Schema strict)로 날짜·테마·방문 순서가 보장된 여행 일정 객체를 생성.
- **CS 답변 초안 생성(`inquiry`)** — Claude Haiku 싱글턴 호출로 관리자 문의 답변 초안 자동 작성.
- **독성 콘텐츠 자동 모더레이션** — Perspective API로 게시글·댓글·문의·어시스턴트 대화의 독성 점수를 비동기 산출, `ai_flagged` 플래그 + BLUR + 어드민 검토(ADR-0010).

## 핵심 구현

### 1. assistant vs chatbot — 명확히 구분되는 두 챗봇

두 모듈은 이름이 비슷하지만 모델·목적·구조가 완전히 다릅니다.

| 구분 | `assistant` 모듈 | `common`(chatbot) |
|---|---|---|
| 모델 | OpenAI GPT (`gpt-4o-mini`) | Google Gemini (`gemini-2.5-flash`) |
| 목적 | 여행 상담·일정 초안 (자유 대화) | 사이트 네비게이션·콘텐츠 추천 |
| 진입점 | `AssistantController` (`/assistant`) | `ChatbotController` (`/chatbot`) |
| 핵심 서비스 | `AssistantServiceImpl.chat()` | `ChatbotService.ask()` |
| 응답 형식 | 자연어 텍스트 | 구조화 JSON (message/links/quickReplies) |
| 이력 | 메모리 + `CHAT_POST`/`CHAT_COMMENT` 저장 | `CONVERSATION`/`ChatMessage` 다중 대화 |
| 쿼터·차단 | 없음 | 등급별 쿼터·IP/USER 차단 |

`AssistantServiceImpl.chat()`은 요청 시점의 `history`(in-memory 리스트)에 사용자 메시지를 붙여 OpenAI Chat Completions로 보내고, 응답을 다시 history에 추가합니다. 메시지 수가 `MAX_HISTORY = 20`을 초과하면 가장 오래된 메시지부터 제거(`while (messages.size() > MAX_HISTORY) messages.remove(0)`)하여 토큰 폭증을 막습니다. 로그인 사용자는 `assistantMapper.insertChatPost` / `insertChatComment`로 대화를 DB에 영속화하고(`comment_order`로 USER/ASSISTANT 순서 보존), 비로그인은 저장하지 않습니다.

다국어는 GPT에 직접 응답 언어를 지시하는 전략을 씁니다. `buildSystemPrompt(lang)`이 `LANG_NAME_MAP`(ko/en/ja/zh → 자연어 언어명)으로 "Always respond in {언어}" 지시를 동적으로 주입합니다. 사후 기계번역보다 품질이 높다는 판단입니다.

### 2. Gemini 챗봇 파이프라인 — 12단계 처리와 토큰 절감

`ChatbotService.ask()`는 외부 LLM 호출 전후로 다단계 검증을 수행합니다. (외부 호출 동안 DB 커넥션 점유를 막기 위해 의도적으로 `@Transactional`을 제외하고, 내부 서비스가 각자 트랜잭션을 관리합니다.)

1. **차단 체크** — `ChatbotBlockService.isBlocked(ip, userIdx)` (IP/USER 별 챗봇 전용 차단, `USER_BLOCKLIST`와 독립)
2. **등급 쿼터 조회** — `ChatbotQuotaService.resolveGrade()` → `getQuotaByGrade()`
3. **주기별 사용량 한도 체크**
4. **대화 조회/생성** — 소유권(`user_idx` 또는 `anon_session_id`) 및 대화 수 한도 검증
5. **유저 메시지 저장**
6. **Fast-path** — `ChatbotFastPathService.resolveOrNull()`로 단순 네비게이션 요청은 LLM 호출 없이 즉답
7. **1차 의도 분류** — `IntentContextService.classify()`
8. **본 호출** — `callGemini()` (분류 의도 주입)
9. 부적절 플래그 처리 → 10. assistant 메시지 저장 → 11. `last_active` 갱신 → 12. 쿼터 +1

**토큰 절감을 위한 2-스테이지 게이트**가 특징입니다. fast-path와 사전 분류(`intent.isInappropriate()`)에서 걸러지면 비싼 본 호출(`callGemini`)을 생략합니다. 부적절 판정 시에도 본 호출 없이 `safetyBlockedResponse()`를 저장·반환하므로(`finalizeAndRespond`), 욕설·스팸·잡담에 토큰을 소모하지 않습니다.

### 3. 2단계 LLM — 의도 분류 → 실시간 콘텐츠 주입(RAG 유사 패턴)

챗봇이 "실제로 존재하는" 여행지·코스·패키지·게시글을 추천하도록, `IntentContextService`가 본 호출 전에 별도의 짧은 Gemini 호출로 의도를 분류합니다.

- **분류 호출**: `temperature=0`, `maxOutputTokens=256`, `responseMimeType=application/json`으로 결정적 JSON(`intent`/`keywords`/`relatedTerms`)을 얻습니다. 핵심은 **다국어 키워드를 한국어로 정규화**하는 프롬프트 제약입니다(예: `Paris`→`파리`, `東京`→`도쿄`). 사이트 DB 원본이 한국어이므로 LIKE 매칭을 가능하게 합니다.
- **컨텍스트 주입**: 정규화된 키워드로 `ExploreMapper.searchSpotsByKeywords` / `TravelPlanMapper.searchPlansByKeywords` / `TravelPackageMapper.searchPackagesByKeywords` / `CommunityMapper.searchPostsByKeywords`를 조회해, 실제 id·제목·평점이 담긴 "실시간 후보 데이터" 섹션을 시스템 프롬프트에 덧붙입니다. 본 호출은 이 후보의 실제 id로만 링크를 만들도록 제약받습니다(`/detail/{spotIdx}` 등).
- **성능·안정성**: 동일 메시지는 `ConcurrentHashMap` 캐시(TTL 60초, 상한 500건)로 재분류를 방지합니다. 분류 호출 실패 시 불용어 사전 기반 규칙 토큰화(`extractKeywordsByRule`)로 폴백하여 챗봇이 멈추지 않습니다.

### 4. 구조화 JSON 파싱과 LLM 생성 링크의 보안 검증

Gemini는 `{ message, links[], quickReplies[], inappropriate }` JSON으로만 응답하도록 지시받습니다. `parseGeminiResponse()`는 다음 방어를 거칩니다.

- **응답 단계별 가드** — `error` 응답, `candidates` 누락, `content` 누락(safety block), `parts` 누락을 각각 구분 처리하고, 코드펜스(```` ```json ````)를 정규식으로 제거한 뒤 파싱.
- **링크 화이트리스트 검증** — `isAllowedInternalUrl()`이 `ALLOWED_URL_PATTERNS`(정규식 화이트리스트)와 대조하고, 위험 스킴(`javascript:`/`data:`/`file:`/`vbscript:`), protocol-relative(`//`), 경로 순회(`..`)를 차단합니다. 비로그인 사용자에게는 `/mypage` 링크를 제거합니다. **LLM이 환각으로 만든 경로나 주입된 악성 URL이 사용자에게 노출되지 않습니다.**

GPT 일정 생성(`AiPlanGPTServiceImpl`)은 더 강한 보장을 위해 **OpenAI Structured Outputs**를 씁니다. `response_format`에 `json_schema`(`strict: true`, `additionalProperties: false`)를 직접 구성하여 `title`/`summary`/`days[].spots[].visitOrder` 같은 필드와 타입을 모델 레벨에서 강제하고, 응답을 `AiPlanResponseDTO`로 직접 역직렬화합니다. 파싱 실패 가능성을 구조적으로 제거하는 선택입니다.

### 5. 독성 모더레이션 — Perspective + 비동기 + Human-in-the-Loop (ADR-0010)

`PerspectiveService`는 Google Perspective API(`commentanalyzer`)로 텍스트의 `TOXICITY` 점수(0.0~1.0)를 산출합니다. 임계값은 `ModerationPolicyService.getPolicy().getToxicityThreshold()`로 외부화되어 있습니다(ADR-0009).

설계 철학은 **AI 신호를 자동 차단이 아닌 "약한 시그널"로 다루는 것**입니다(ADR-0010, Option C).

- **비동기 호출** — `@Async`로 `checkAndFlagPostAsync` / `checkAndFlagCommentAsync` / `checkAndFlagInquiryAsync`를 돌려, 1~5초가 걸릴 수 있는 API 지연이 글 등록 응답을 막지 않게 합니다.
- **약한 시그널** — 독성 감지 시 삭제·차단이 아니라 `ai_flagged=1`만 세팅합니다. JSP에서 일반 사용자에게는 BLUR 오버레이로 가리고, 어드민에게는 원본 + 해제 버튼을 노출합니다. false positive를 인간 검토로 흡수합니다.
- **fail-safe** — API 실패 시 `isToxic()`은 `false`를 반환해 필터링을 건너뜁니다. 모더레이션 장애가 정상 작성을 막지 않습니다.

어시스턴트 모듈은 다른 팀원 담당으로 수정 불가였기에, `ask()`에 직접 검사를 삽입하는 대신 **스케줄러 기반 사후 스캔**을 채택했습니다. `AdminAssistantModerationScheduler`가 기동 1분 후 시작·5분 간격(`fixedDelay`)으로 미판정 USER 메시지를 최대 50건씩 스캔하고, 호출 간 200ms를 두어 Perspective 쿼터를 보호하며 `ADMIN_ASSISTANT_MODERATION` 테이블에 점수를 적재합니다.

## 설계 결정과 트레이드오프

- **멀티모델 분리** — 단일 벤더 종속 대신 용도별 강점을 취했습니다. Gemini(저비용·빠른 분류/추천), GPT(자유 대화·Structured Outputs 일정 생성), Claude(CS 톤의 답변 초안), Perspective(전용 독성 스코어링). API 키도 용도별로 분리(`gemini.api.key`, `openai.api.key`, `inquiry.claude.api.key`, `perspective.api.key`)하여 비용·권한·장애 영향을 격리했습니다.
- **AI 응답 = 신뢰할 수 없는 입력** — 챗봇이 생성한 링크는 화이트리스트로, 일정 JSON은 스키마로, 사용자 작성 글은 독성 점수로 각각 검증한 뒤에야 사용합니다. LLM 환각·프롬프트 인젝션을 출력 단계에서 차단합니다.
- **토큰·비용 최적화** — fast-path와 사전 분류로 본 호출을 줄이고, 분류 결과를 캐시하며, 어시스턴트는 in-memory 히스토리를 20개 메시지로 절단합니다. 부적절 메시지는 본 호출 없이 안전 응답으로 종료합니다.
- **비동기 + Human-in-the-Loop 모더레이션 (ADR-0010)** — 동기 자동 차단(응답 지연 + false positive 비용)을 피하고, 비동기 플래그 + 점진적 공개(BLUR) + 어드민 해제 권한을 선택했습니다. 트레이드오프로 풀 스택(DB→서비스→JSP→JS)을 봐야 흐름이 이해되며, 비동기 실패 시 재시도 정책이 별도로 필요합니다.
- **폴백 일관성** — 외부 LLM/API 호출은 항상 폴백을 갖습니다. Gemini 실패 → `fallbackResponse()`(기본 링크 제시), 분류 실패 → 규칙 기반 토큰화, Perspective 실패 → `false`, Claude/일정 생성 실패 → 빈 결과 또는 예외 후 안전 응답.

## 데이터 모델 / 연동

| 영역 | 테이블 / 컬럼 | 비고 |
|---|---|---|
| 어시스턴트 대화 | `CHAT_POST`, `CHAT_COMMENT`(`comment_role`, `comment_order`) | 로그인 사용자만 저장 |
| 챗봇 대화 | `CONVERSATION`, ChatMessage | `user_idx` 또는 `anon_session_id` 소유 |
| 챗봇 쿼터 | `CHATBOT_GRADE_QUOTA`(등급별 한도), 일일/주기 사용량 | ADMIN/SUPERADMIN 면제 |
| 챗봇 차단 | `CHATBOT_BLOCK`(IP/USER) | `USER_BLOCKLIST`와 독립 |
| 독성 플래그 | `community_post.ai_flagged`, `community_comment.ai_flagged`, `inquiry_post.ai_flagged` | BLUR/어드민 해제 |
| 어시스턴트 모더레이션 | `ADMIN_ASSISTANT_MODERATION`(점수·부적절 여부) | 스케줄러 사후 적재 |

| 외부 API | 엔드포인트 | 모델/속성 |
|---|---|---|
| Google Gemini | `generativelanguage.googleapis.com/.../gemini-2.5-flash` | 챗봇 본 호출 + 의도 분류 |
| OpenAI | `api.openai.com/v1/chat/completions` | `gpt-4o-mini`, Structured Outputs |
| Anthropic | `api.anthropic.com/v1/messages` | `claude-haiku-4-5-20251001`, 문의 답변 초안 |
| Google Perspective | `commentanalyzer.googleapis.com/.../comments:analyze` | `TOXICITY` 점수 |

## 사용 기술

- **LLM/AI**: Google Gemini 2.5 Flash, OpenAI GPT-4o-mini (Chat Completions + Structured Outputs), Anthropic Claude Haiku (Messages API), Google Perspective API
- **백엔드**: Spring Boot 4 / Java 21, `RestTemplate` 기반 외부 호출, `@Async` 비동기, `@Scheduled` 배치
- **JSON 처리**: Gson(챗봇/어시스턴트 파싱·직렬화), Jackson(GPT 일정 DTO 역직렬화)
- **데이터**: MyBatis Mapper(콘텐츠 후보 검색·대화/쿼터/모더레이션 영속화), MySQL
- **안정성/보안**: URL 화이트리스트 검증, JSON Schema strict, fail-safe 폴백, 의도 분류 캐시(ConcurrentHashMap, TTL), 등급 쿼터·차단, i18n(MessageSource)
