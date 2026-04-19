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

## Database Schema
DB 스키마가 필요할 때는 TripTogetherDB.sql 파일을 직접 읽어서 참고.

---

## ⚠️ 작업 방식 (절대 규칙)
- 어떤 코드 변경이든 반드시 구현 계획을 먼저 텍스트로 설명할 것
- 사용자가 명시적으로 "진행" 또는 승인 의사를 밝힌 후에만 코드 작성 시작
- 승인 전 Edit/Write/Bash(코드 수정) 도구 사용 절대 금지
- "계획부터", "코딩하지마" 등의 지시가 없어도 이 규칙은 항상 적용됨
- 단순 오타 수정·주석 수정이라도 계획 설명 후 승인 필요

## ⚠️ 작업 브랜치 규칙 (매우 중요)
- 코드 작업은 반드시 Victor 브랜치에서만 할 것
- dev 브랜치에서 직접 작업 절대 금지

## ⚠️ Git 작업 분담 규칙
- Claude는 `git add` + `git commit`까지만 진행
- `git pull`, `git push origin <branch>`, PR 생성(`gh pr create` 또는 GitHub UI)은 사용자가 직접 수행
- 커밋 여러 개로 나눠야 할 땐 Claude가 단위 제안 → 사용자 승인 후 실행
- **커밋 메시지는 Claude가 후보 제시 → 사용자 승인 후에만 실행**
  (메시지 내용이 중간에 바뀌면 새로 승인 요청)
- 커밋 메시지는 기존 로그 스타일(짧은 한국어 요약) 유지
- `--no-verify`, `--amend`, `git push --force` 등 위험 옵션은 사용자 명시 요청 시에만 사용

## Victor 담당 모듈
- 모든 모듈 수정 가능

## superAdmin 모듈
- 관리자(admin 계정)를 관리하는 페이지
- URL prefix: `/superAdmin/**`
- CSS 프리픽스: `sa-`
- 최고관리자(SUPERADMIN 역할)만 접근 가능

## CSS 프리픽스 규칙
- 커뮤니티: `comm-`
- 문의게시판: `inq-`
- 마이페이지: `mp-`
- 신고게시판: `rpt-`
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

## 커뮤니티 신고/차단 상태 규칙 (중요)
- **신고 3회 이상 누적 (`report_count >= 3`)**:
  - `post_status` / `comment_status`는 `'BLOCKED'`로 전환됨
  - 그러나 일반 사용자 목록에 계속 표시됨 (리스트 쿼리 조건에 포함)
  - 본문 BLUR 처리 + "⚠️ 신고된 콘텐츠입니다. 클릭하여 확인" 오버레이
  - 클릭하면 블러 벗겨져 내용 공개 (점진적 공개 UX)
- **관리자 직접 차단 (`report_count < 3` + `status='BLOCKED'`)**:
  - 일반 사용자 목록에서 **완전 숨김** ("blind")
  - 관리자 모드에서만 표시
- 즉, `BLOCKED` 상태값 자체는 같음. `report_count` 조건으로 렌더링 분기
- "BLOCKED = 안 보임"이라고 단정 금지. 반드시 `report_count`까지 확인할 것
