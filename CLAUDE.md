# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the application (dev mode with hot reload)
./mvnw spring-boot:run

# Build WAR for deployment
./mvnw clean package -DskipTests

# Run all tests
./mvnw test

# Run a single test class
./mvnw test -Dtest=TripTogetherApplicationTests

# Run a single test method
./mvnw test -Dtest=ClassName#methodName
```

The app is served at `http://localhost:8080/TripTogether` (context path is `/TripTogether`).

## Architecture

Spring Boot 4.0.5 / Java 21 / MyBatis / MySQL / JSP (WAR packaging).

### Module layout

Each feature lives under `org.triptogether.{module}/` with a consistent layered structure:

```
{module}/
  controller/   — Spring @Controller or @RestController
  service/      — Service interface + ServiceImpl
  mapper/       — MyBatis @Mapper interface
  vo/           — VOs and DTOs
  function/     — Helper utilities (many still stubbed as Temp.java)
```

Mapper SQL is in `src/main/resources/mapper/*.xml`. Views are JSPs in `src/main/webapp/WEB-INF/views/{module}/`.

**Active modules:**
- `auth` — Login/register, email verification, password reset, OAuth (Kakao/Naver/Google). Session key: `loginUser` (UsersVO).
- `community` — Community posts (types: `tip`, `question`, general), tags, images, comments, replies, likes, reports. Soft-deletes: status set to `'DELETED'`.
- `courses` — Travel plans with ordered spot lists (PLAN_SPOT table).
- `assistant` — Multi-turn AI travel assistant via Claude API (`claude-3-5-haiku-20241022`). Conversation history managed in-memory per request.
- `common` — `MainController` (home/index routing) and `ChatbotController` (site navigation chatbot via `claude-sonnet-4-20250514` that returns structured JSON with links and quick replies).
- `admin` — Admin dashboard: member management, inquiry management, login audit logs, security audit logs, stats.
- `inquiry` — 1:1 user inquiry system with admin answers.
- `myPage` — Profile editing, social account linking/unlinking, notification feed.
- `detail`, `explore`, `home` — Currently stubbed (only `Temp.java` placeholder files).

### Configuration (`org.triptogether.config`)

- `WebConfig` — Registers interceptors and maps `/upload/**` to the filesystem upload directory.
- `LoginInterceptor` — Blocks unauthenticated access to `/mypage/**`, `/auth/link/**`, `/inquiry/**`; redirects to login with `?redirect=` param.
- `AdminInterceptor` — Blocks non-`ADMIN` role users from `/admin/**`.
- `AdminModeInterceptor` — Runs on all pages (`/**`) to inject admin-mode context into the model.
- `BCryptConfig` — `BCryptPasswordEncoder` bean for password hashing.
- `RestTemplateConfig` — `RestTemplate` bean used by AI service calls.

### MyBatis type aliases

`mybatis.type-aliases-package` must explicitly list every VO package. When adding a new VO package, add it to this property in `application.properties`.

### File uploads

Files are stored at `${file.upload.path}` (default: `src/main/resources/upload/`) and served over `/upload/**`. Community images go to `upload/community/`; only `.jpg/.jpeg/.png/.gif/.webp` are accepted.

### Authentication flow

1. Session attribute `loginUser` (UsersVO) is set on login; checked by interceptors.
2. OAuth callbacks complete via `handleSocialCallback()` in `AuthController` — returns either `UsersVO` (existing user) or `SocialTempVO` (new user needing profile completion).
3. Social logins store the current provider in `currentSocialProvider` session attribute; logout routes through provider-specific logout if set.
4. All login/security events (IP, user agent) are recorded via `LoginRequestContext`.

### AI integrations

- **AssistantServiceImpl**: Multi-turn chat with `claude-3-5-haiku-20241022`. Keeps up to 20 history messages. Requires `claude.api.key` in properties.
- **ChatbotService**: Site-navigation chatbot with `claude-sonnet-4-20250514`. Returns structured JSON (`message`, `links[]`, `quickReplies[]`). Parses JSON from Claude's response and strips code fences before parsing.

### Notification system

`MyPageService.addNotification(FeedNotificationDto)` is called cross-module (e.g., from `CommunityServiceImpl`) when events occur on a user's content.

---

## 작업 방식
- 코드 작성 전 항상 구현 계획을 먼저 설명하고 승인받을 것
- 승인 없이 바로 코드 작성 금지

## ⚠️ 작업 브랜치 규칙 (매우 중요)
- 코드 작업은 반드시 Victor 브랜치에서만 할 것
- dev 브랜치에서 직접 작업 절대 금지

## Victor 담당 모듈
- community, inquiry, myPage, report, home만 수정 가능
- auth, admin, courses, assistant, explore, detail, common 건드리지 말 것

## CSS 프리픽스 규칙
- 커뮤니티: `comm-`
- 문의게시판: `inq-`
- 마이페이지: `mp-`
- 모듈 간 프리픽스 절대 섞지 말 것

## JSP/EL 작성 규칙
- `onclick` 안에 `${}` 직접 쓰지 말 것 → `data-id` 속성으로 분리 후 JS에서 처리
- JS 정규식 안의 `{}` → 유니코드 `\u007B\u007D` 로 이스케이프 (JSP EL 충돌 방지)
- EL 삼항연산자 안에 EL 중첩 금지 → `<c:if>` 태그로 분리
- 이미지 경로: `${pageContext.request.contextPath}/upload/community/UUID.jpg`

## DB/MyBatis 추가 규칙
- 어드민 블로킹은 DELETE 아닌 status 값으로 처리
  (`post_status='DORMANT'`, `comment_status='BLOCKED'`, `account_status='BLOCKED'`)
- `like_count`, `comment_count` 캐시 컬럼 항상 동기화 필수
- MySQL `LIMIT`은 서브쿼리 안에 쓸 수 없음 → 서브쿼리 밖으로 빼기
- `mybatis.type-aliases-package` 좁게 스캔 (`Temp.java` 별칭 충돌 주의)

## 권한 체크 패턴
- 소유자 OR 어드민만 수정/삭제 가능
- 블로킹된 유저 → 글쓰기 시 403 반환
