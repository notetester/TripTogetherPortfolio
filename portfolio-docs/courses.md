# 여행 코스 · AI 일정

여행 코스 모듈은 사용자가 여행 일정을 **직접 작성**하거나 **AI(GPT)로 자동 생성**할 수 있는 일정 관리 도메인입니다. 하나의 여행 계획(`TRAVEL_PLAN`)은 날짜·방문 순서가 매겨진 방문지 목록(`PLAN_SPOT`)을 가지며, 소유자만 수정·삭제할 수 있고 공개로 전환하면 다른 사용자가 둘러볼 수 있는 공개 피드에 노출됩니다.

핵심 가치는 **두 가지 일정 생성 경로를 단일 데이터 모델로 통합**한 데 있습니다. 수동 작성 경로와 AI 생성 경로 모두 최종적으로 동일한 `TRAVEL_PLAN` + `PLAN_SPOT` 구조로 수렴하므로, 상세 조회·수정·공개·삭제 등 후속 기능은 일정의 출처(`plan_source`)와 무관하게 동일하게 동작합니다.

## 주요 기능

- **수동 일정 작성** — 제목·여행지·기간을 입력하고 방문지를 순서대로 추가 (`/courses/write` → `/courses/insert`)
- **AI 자동 일정 생성** — 여행지·기간·동행·스타일·예산·추가요청을 입력하면 GPT가 날짜별 방문지 일정을 생성 (`/courses/ai/form` → `/courses/ai/generate`)
- **순서 있는 방문지 관리** — 날짜(`visit_date`) + 방문 순서(`visit_order`) 기준으로 정렬되는 일정표
- **소유권 기반 CRUD** — 상세·수정·삭제 시 세션 사용자와 일정 소유자 일치 검증
- **공개/비공개 전환과 공개 피드** — `is_public` 플래그로 공개 목록(`/courses/public`)에 노출
- **소프트 삭제** — 물리 삭제 대신 `is_deleted` 플래그 처리
- **다국어(i18n)** — 사용자 메시지를 `MessageSource` 코드로 출력, 방문지명 자동 번역 연동

## 핵심 구현

### 1. 단일 데이터 모델로 수렴하는 두 생성 경로

수동·AI 두 경로는 입력 형태가 다르지만 동일한 영속 계층을 공유합니다.

- **수동 경로**: `TravelPlanController.insertTravelPlan()`이 폼에서 바인딩된 `TravelPlanVO`(내부에 `List<PlanSpotVO> spotList` 포함)를 받아 `plan_source`를 `"MANUAL"`로 세팅한 뒤 `TravelPlanService.insertTravelPlan()` 호출.
- **AI 경로**: `AiPlanController.generatePlan()`이 `AiPlanRequestDTO`를 받아 `AiPlanServiceImpl.generateAndSavePlan()`을 호출. 이 서비스가 GPT 응답을 받아 `TravelPlanVO`를 조립하고 `plan_source`를 `"AI"`로 세팅한 뒤, 동일한 `TravelPlanService.insertTravelPlan()` / `insertPlanSpot()`을 재사용합니다.

즉 AI 서비스는 별도 저장 로직을 만들지 않고 수동 작성용 서비스 메서드를 그대로 호출하므로, 저장 규칙(방문 순서 채번, 빈 방문지 스킵 등)이 두 경로에서 일관됩니다.

### 2. 방문지 순서 보장 (`PLAN_SPOT`)

`TravelPlanServiceImpl.insertTravelPlan()`은 `spotList`를 순회하며 방문 순서를 채번합니다.

- `place_name`이 비어 있으면 해당 방문지를 건너뜀(`continue`)
- `visit_order`가 비어 있으면 루프 인덱스(`order`)로 자동 부여
- `spot_id`가 빈 문자열이면 `null`로 정규화 (마스터 여행지 `SPOT_TRAVEL`과 매칭되지 않는 자유 입력 방문지를 허용)

수정(`editTravelPlan`)은 **전체 삭제 후 재삽입** 전략을 씁니다. `deletePlanSpotsByPlanId()`로 기존 방문지를 모두 지운 뒤 새 목록을 다시 채번해 삽입하므로, 방문지 추가·삭제·순서 변경이 뒤섞인 수정 요청을 단순하게 처리합니다.

조회 시 정렬은 매퍼(`getPlanSpotListByPlanId`)에서 보장합니다.

```sql
ORDER BY
  CASE WHEN visit_date IS NULL THEN 1 ELSE 0 END,
  visit_date ASC,
  visit_order ASC
```

날짜가 없는 방문지를 뒤로 보내고, 날짜 → 방문 순서 순으로 정렬합니다. 또한 `PLAN_SPOT` 테이블에는 `UNIQUE KEY uq_plan_spot_order (plan_id, visit_date, visit_order)` 제약이 걸려 있어, 같은 일정·같은 날짜 안에서 방문 순서 중복을 DB 레벨에서도 차단합니다.

### 3. GPT 구조화 출력(Structured Outputs)

`AiPlanGPTServiceImpl.generatePlan()`은 OpenAI Chat Completions API(`/v1/chat/completions`)를 `RestTemplate`로 호출하며, 응답을 자유 텍스트가 아닌 **엄격한 JSON 스키마**로 강제합니다.

- 요청 본문에 `response_format = { type: "json_schema", json_schema: { name, strict: true, schema } }`를 포함 (`buildJsonSchemaResponseFormat()`).
- 스키마는 `title`, `summary`, `days[]`를 요구하고, 각 `day`는 `dayNo`, `date`, `theme`, `spots[]`를, 각 `spot`은 `name`, `description`, `visitOrder`를 `required`로 지정. 모든 객체에 `additionalProperties: false`를 설정해 스키마 외 필드 생성을 막습니다.
- 시스템 프롬프트(`developer` 역할)에서 "JSON 스키마만 따르고, 인사말·코드블록·마크다운을 출력하지 말 것"을 명시해 파싱 안정성을 높입니다.

응답 파싱은 2단계입니다. 먼저 OpenAI 응답 envelope에서 `choices[0].message.content`를 `JsonNode`로 추출한 뒤, 그 문자열을 다시 `objectMapper.readValue(content, AiPlanResponseDTO.class)`로 역직렬화합니다. 구조화 출력 덕분에 `AiPlanResponseDTO` → `AiDayDTO` → `AiSpotDTO` 매핑이 추가 방어 코드 없이 곧바로 성립합니다.

> 참고: 공개 레포에서는 OpenAI 호출에 사용하는 인증 키가 실제 값 대신 플레이스홀더 상수(`TEST_API_KEY = "YOUR_OPENAI_API_KEY"`)로 대체되어 있으며, 운영 환경에서 키를 `openai.api.key` 프로퍼티로 주입하는 코드 경로(`headers.setBearerAuth(apiKey)`)는 주석으로 보존해 두었습니다. 따라서 공개본을 그대로 실행하면 인증에 실패하며, 이는 시크릿 노출을 막기 위한 의도된 처리입니다.

### 4. AI 응답 → PLAN_SPOT 변환과 트랜잭션

`AiPlanServiceImpl.savePlanSpots()`가 `days[]`를 순회하며 각 `day.date`를 `visit_date`로, `spot.visitOrder`를 `visit_order`로 매핑해 `PlanSpotVO`를 만들고 저장합니다.

- AI가 생성한 방문지는 자유 텍스트 장소명이므로 마스터 테이블과 매칭하지 않고 `spot_id`를 `null`로 둡니다(`place_name`만 저장).
- `generateAndSavePlan()`은 `@Transactional`로 묶여 있어, 일정 헤더 저장과 방문지 일괄 저장이 하나의 트랜잭션으로 처리됩니다.
- 저장 전 `validateRequest()`가 여행지·시작일·종료일 필수 여부와 `종료일 >= 시작일`을 검증하며, 위반 시 `IllegalArgumentException`을 던져 컨트롤러가 폼으로 되돌립니다.

### 5. 소유권 기반 CRUD

모든 접근 제어는 세션의 `loginUser`(UsersVO) 기준으로 이뤄집니다.

- **상세 조회**(`/courses/detail`): 비공개 일정은 `isOwner || isPublic` 검사를 통과해야만 열람 가능. 소유자가 아니고 비공개면 목록으로 리다이렉트.
- **수정/삭제**: 매퍼 쿼리 자체에 `WHERE plan_id = #{plan_id} AND user_idx = #{user_idx} AND is_deleted = 0` 조건을 두어, 소유자가 아니면 애초에 대상 row가 잡히지 않도록 이중으로 차단. 수정 폼(`editForm`)에서는 추가로 `getUser_idx().equals(userIdx)` 검사도 수행.
- **삭제**: `deleteTravelPlan` 매퍼가 물리 DELETE가 아니라 `UPDATE ... SET is_deleted = 1`로 소프트 삭제를 수행.

### 6. 공개 피드

`/courses/public`은 `getPublicTravelList()`로 `is_public = 1 AND is_deleted = 0`인 일정만 최신순으로 조회하며, `TRAVEL_PLAN`에 `USERS`를 INNER JOIN해 작성자 `nickname`을 함께 가져와 목록에 표시합니다. 별도로 챗봇 컨텍스트 제공을 위해 `searchPlansByKeywords()`가 공개 일정을 제목·여행지 다중 키워드 OR LIKE로 검색합니다.

## 설계 결정과 트레이드오프

- **수정 시 방문지 전체 삭제 후 재삽입**: 개별 diff(추가/삭제/순서변경)를 추적하는 대신 통째로 갈아끼우는 단순 전략을 택했습니다. 구현이 단순하고 순서 꼬임 버그가 원천 차단되는 대신, 방문지 수가 많을 때 불필요한 DELETE/INSERT가 발생합니다. 한 일정당 방문지 규모가 작은 도메인 특성상 합리적인 트레이드오프로 판단했습니다.
- **AI 방문지를 마스터(`SPOT_TRAVEL`)와 매칭하지 않음**: GPT가 생성하는 장소명은 자유 텍스트이고 마스터 데이터에 없을 수 있으므로 `spot_id`를 비우고 `place_name`만 저장합니다. 매칭 정합성 부담을 없애는 대신, AI 일정의 방문지는 좌표·평점 등 마스터 메타데이터와 직접 연결되지 않습니다.
- **구조화 출력(strict JSON schema) 채택**: 프롬프트로만 JSON을 요청하면 마크다운 코드펜스·설명 문구가 섞여 파싱이 불안정합니다. `strict: true` + `additionalProperties: false`로 스키마를 강제해 역직렬화 실패 위험을 크게 낮췄습니다.
- **소프트 삭제(`is_deleted`)**: 물리 삭제 대신 플래그 처리로 복구 가능성과 참조 무결성을 확보했습니다(소프트 삭제 패턴은 ADR 0008 참조). 단, 모든 조회 쿼리에 `is_deleted = 0` 조건을 빠짐없이 넣어야 하는 책임이 따릅니다.
- **소유권 검사를 쿼리 조건으로 내림**: 애플리케이션 레벨 검사뿐 아니라 매퍼 `WHERE`에 `user_idx`를 함께 넣어, 권한 누락 시에도 타인의 일정이 수정/삭제되지 않도록 방어선을 이중화했습니다.

## 데이터 모델 / 연동

**`TRAVEL_PLAN`** — 일정 헤더
- `plan_id`(PK), `user_idx`(FK → USERS), `title`, `destination`, `start_date`, `end_date`
- `is_public`(공개 여부), `share_token`(UNIQUE), `plan_source`(`MANUAL`/`AI`, 기본 `MANUAL`), `is_deleted`
- `created_at`, `updated_at`

**`PLAN_SPOT`** — 일정에 속한 순서 있는 방문지
- `plan_spot_id`(PK), `plan_id`(FK → TRAVEL_PLAN, ON DELETE CASCADE), `spot_id`(FK → SPOT_TRAVEL, NULL 허용)
- `place_name`, `visit_date`, `visit_order`, `created_at`
- `UNIQUE KEY uq_plan_spot_order (plan_id, visit_date, visit_order)`

**`SPOT_TRAVEL`** — 여행지 마스터 (수동 작성 시 방문지 선택 후보)
- `spot_id`, `name`, `region`, `address`, `latitude`, `longitude`, `rating_avg`, `review_count` 등

**외부 연동**
- OpenAI Chat Completions API(`/v1/chat/completions`) — 모델은 `openai.model`, 인증 키는 `openai.api.key` 프로퍼티로 주입하도록 설계(공개 레포에서는 키를 플레이스홀더로 대체, 위 핵심 구현 참고)
- `SpotTextTranslationService` — 목록·상세 조회 시 방문지 텍스트 다국어 번역
- `ViewHistoryService` — 상세 조회 시 열람 이력 기록(`record(userIdx, TYPE_PLAN, planId)`)

## 사용 기술

- **백엔드**: Spring Boot 4 / Java 21, Spring MVC `@Controller`, 서비스 계층 인터페이스+Impl 분리
- **영속성**: MyBatis (`TravelPlanMapper` + `TravelPlanMapper.xml`), MySQL, `useGeneratedKeys`로 생성 PK 회수
- **트랜잭션**: `@Transactional`(AI 일정 생성 일괄 저장)
- **AI**: OpenAI Chat Completions + Structured Outputs(JSON Schema, `strict`), `RestTemplate`, Jackson `ObjectMapper`
- **뷰**: JSP/JSTL (`courses/*`, `ai/planForm`)
- **i18n**: `MessageSource` 기반 메시지 코드 출력
