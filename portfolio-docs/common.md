# 공통 · 인프라 · i18n

TripTogether의 횡단 관심사(cross-cutting concern)를 모아 둔 계층입니다. 인증·인가 게이트, 활동/차단 로그, 헤더 알림 데이터 주입, 파일 업로드, JSON 직렬화, 4개 언어 다국어 처리를 모든 도메인이 공유합니다. 핵심 구현은 `org.triptogether.config` 패키지의 설정 클래스와 인터셉터, 그리고 `org.triptogether.common` 패키지의 헬퍼들에 집중되어 있습니다.

설계 기조는 "도메인 코드는 비즈니스 로직에만 집중하고, 인증·로깅·다국어 같은 공통 처리는 진입 단계(인터셉터)에서 일괄 수행한다"입니다. 각 도메인 컨트롤러는 로그인 여부 검사나 활동 로그 적재를 직접 호출하지 않으며, 이 책임은 `WebConfig`에 등록된 인터셉터 체인이 담당합니다.

## 주요 기능

- **경로 기반 인증/인가 게이트**: `LoginInterceptor`, `AdminInterceptor`, `SuperAdminInterceptor`가 URL 패턴별로 접근을 차단합니다.
- **세분화된 관리자 권한 매핑**: `AdminInterceptor`가 `/admin/**` 서브패스별로 필요한 권한(예: `MEMBER_ADMIN`, `FINANCE_OPERATOR`)을 해석해 검증합니다.
- **전역 모델 주입**: `AdminModeInterceptor`(관리자 모드 플래그), `NotificationInterceptor`(헤더 알림 벨 데이터)가 `postHandle`에서 모든 View 모델에 공통 값을 주입합니다.
- **애플리케이션 레벨 차단/감사**: `IpBlockInterceptor`(IP·국가·ASN·계정 차단), `ActivityLogInterceptor`(전 요청 활동 로그)가 보안·운영 흐름을 기록합니다.
- **파일 업로드 인프라**: 로컬 디스크 `/upload/**` 정적 매핑과 외부 CDN(Cloudinary) 업로드 경로를 병행합니다.
- **다국어(i18n)**: `MessageSource` + `spring:message` + `MessageUtil`로 화면과 API 메시지를 `ko/en/ja/zh` 4개 언어로 처리합니다.
- **공통 빈**: `RestTemplate`, `BCryptPasswordEncoder`, `ObjectMapper`, `@LoginUser` 파라미터 리졸버.

## 핵심 구현

### 1. 인터셉터 체인 — `WebConfig#addInterceptors`

모든 인터셉터는 `WebConfig`(`org.triptogether.config.WebConfig`)의 `addInterceptors`에서 등록 순서와 경로 패턴이 결정됩니다. 등록 순서가 곧 실행 순서이므로, 언어 결정이 가장 먼저 와야 이후 인터셉터·컨트롤러·JSP가 동일한 Locale을 보게 됩니다.

등록 순서와 적용 범위:

| 순서 | 인터셉터 | 적용 경로 | 역할 |
| --- | --- | --- | --- |
| 1 | `LocaleChangeInterceptor` | `/**` (정적 제외) | `?lang=` 파라미터로 세션 Locale 갱신 |
| 2 | `IpBlockInterceptor` | `/**` (정적·`/blocked-access`·`/security/appeal/**` 제외) | IP/국가/ASN/계정 차단 |
| 3 | `ActivityLogInterceptor` | `/**` (동일 제외) | 전 요청 활동 로그 적재 |
| 4 | `LoginInterceptor` | `/mypage/**`, `/wallet/**`, `/auth/link/**`, `/inquiry/**` | 비로그인 차단 후 로그인 페이지로 리다이렉트 |
| 5 | `AdminInterceptor` | `/admin/**` | 관리자 권한 + 서브패스별 세부 권한 검증 |
| 6 | `SuperAdminInterceptor` | `/superAdmin/**` | 최고관리자 전용 |
| 7 | `AdminModeInterceptor` | `/**` (정적·`/api/**` 제외) | 관리자 모드 플래그 모델 주입 |
| 8 | `NotificationInterceptor` | `/**` (정적·`/api/**`·`/sse/**` 제외) | 헤더 알림 데이터 모델 주입 |

`LoginInterceptor`는 `preHandle`에서 세션 속성 `loginUser`(`UsersVO`)가 없으면 원래 가려던 경로를 `redirect` 파라미터로 URL 인코딩해 `/auth/login?redirect=...`로 보냅니다. 로그인 후 원래 위치로 복귀시키기 위한 설계입니다.

### 2. 관리자 권한의 경로별 해석 — `AdminInterceptor`

`AdminInterceptor`는 단순한 ADMIN 여부 검사를 넘어, `/admin/**` 하위 경로마다 필요한 권한 코드를 매핑해 세션의 `adminPermissions`(`Set<String>`)와 대조합니다.

- `SUPER_ADMIN` 권한 보유 시 모든 검사를 통과합니다.
- 정적 매핑 `URL_PERMISSION_MAP`이 `/admin/members → MEMBER_ADMIN`, `/admin/reports → REPORT_ADMIN` 등 도메인 경로를 권한에 연결합니다.
- 감사 로그 계열(`/admin/logins`, `/admin/security`, `/admin/activity-logs` 등)은 `AUDIT_URLS`로 묶어 `AUDIT_ADMIN`을 요구합니다.
- 동적 분기가 필요한 영역은 별도 메서드로 해석합니다.
  - `resolveAiHelperPermission`: `/admin/ai-helper/chatbot|conversations|blocks|quotas`는 Gemini 챗봇 담당으로 `AI_CHATBOT_ADMIN`, 그 외(`/admin/ai-helper` 루트 등)는 Claude 도우미 담당으로 `ASSISTANT_ADMIN`을 요구합니다.
  - `resolveFinancePermission`: `/admin/finance/refund/**`는 `FINANCE_OPERATOR`, `/admin/finance/policy/**`는 `FINANCE_POLICY_ADMIN`, 그 외 대시보드는 읽기 전용 `FINANCE_ADMIN`을 요구합니다.
  - `/admin/blocks`는 차단 관리 4개 권한(`USER_BLOCK_ADMIN`, `IP_BLOCK_ADMIN`, `BLOCK_POLICY_ADMIN`, `BLOCK_AUDIT_ADMIN`) 중 하나라도 있으면 통과시킵니다.

권한이 부족하면 `/admin`으로 리다이렉트하고 사유를 로그로 남깁니다.

### 3. 전역 모델 주입 인터셉터 — `AdminModeInterceptor` / `NotificationInterceptor`

두 인터셉터는 모두 `postHandle`에서 동작하며 `ModelAndView`가 null(예: AJAX/리다이렉트 응답)이면 즉시 반환해 View가 있는 페이지에만 영향을 줍니다.

- **`AdminModeInterceptor`**: 세션의 `loginUser`에서 리플렉션으로 `getUserRole()`을 호출해(VO를 auth 담당이 관리하므로) `UserRole.isAdminLike()` 여부를 판단합니다. 모델에 `isAdmin`, `isAdminMode`(세션 `viewMode`가 `"user"`면 유저경험모드로 false)와 함께, `hasCommunityAdmin`·`hasFinanceOperator`·`hasAnyBlockAdmin` 등 권한별 boolean 플래그를 일괄 주입합니다. JSP는 `${isAdminMode}`, `${hasReportAdmin}` 형태로 별도 조회 없이 메뉴 노출을 분기합니다.
- **`NotificationInterceptor`**: 로그인 사용자에 한해 `MyPageService.getUnreadCount`와 `getRecentNotifications`(최근 5건)를 조회해 `headerUnreadCount`, `headerRecentNotifications`를 모델에 주입합니다. 헤더 알림 벨이 이 값을 렌더링합니다.

### 4. 애플리케이션 레벨 차단·감사 — `IpBlockInterceptor` / `ActivityLogInterceptor`

대량 트래픽 방어는 앞단(CDN/WAF) 책임으로 두고, 이 두 인터셉터는 애플리케이션 문맥이 필요한 정밀 정책을 담당합니다.

- **`IpBlockInterceptor`**: `BlockRuleCacheService`의 스냅샷(DB 직접 조회를 피하는 캐시)에서 규칙을 받아 IP 차단을 계정 차단보다 우선 평가합니다. 매칭 타입은 `SINGLE_IP`/`CIDR`/`RANGE`/`COUNTRY`/`ASN`을 지원하며, CIDR은 `BigInteger` 비트 마스크로 직접 계산합니다. 차단 시 `SC_FORBIDDEN` 상태로 `/blocked-access`에 forward하고, 차단 안내 페이지 언어는 `lang` 파라미터 → 사용자 `preferredLang` → 국가코드(KR→ko, JP→ja, CN/TW→zh 등) 순으로 결정해 세션 Locale에 반영합니다. 모든 차단 요청은 `BlockAccessLogMapper`로 적재합니다.
- **`ActivityLogInterceptor`**: `preHandle`에서 `requestId`/시작시각을 심고, `afterCompletion`에서 URI·HTTP 메서드·핸들러명·응답 상태·소요시간·활동 도메인/타입/코드를 `ActivityLogMapper`로 적재합니다. 두 인터셉터 모두 쿼리스트링/Referer에서 `token`·`password`·`newPassword`·`currentPassword`·`code`·`state` 등 민감 파라미터를 `***`로 마스킹한 뒤 저장합니다.

### 5. 다국어(i18n) — MessageSource · MessageUtil · spring:message

- **번들 구성**: `MessageSource`는 `WebConfig#messageSource()`에서 `ReloadableResourceBundleMessageSource`로 등록합니다. basename은 `classpath:messages/{도메인}` 형태로 21개를 도메인 단위 분리(`admin`, `assistant`, `auth`, `chatbot`, `community`, `course`/`courses`, `detail`, `explore`, `footer`, `header`, `home`, `inquiry`, `mypage`, `package`, `report`, `recommend`, `superAdmin`, `shop`, `security`, `wallet`)했습니다. 각 basename은 `*_ko/_en/_ja/_zh.properties` 4개 언어 파일을 한 세트로 자동 로딩합니다. 인코딩은 UTF-8입니다.
- **누락 키 폴백**: `setUseCodeAsDefaultMessage(true)`로 번역 누락 시 예외 대신 키 코드 문자열을 그대로 노출합니다. 화면이 죽지 않으면서 QA가 누락 키를 즉시 식별할 수 있게 한 의도적 선택입니다.
- **Locale 결정**: `SessionLocaleResolver`(기본 `Locale.KOREAN`)에 언어를 세션 단위로 보관하고, `LocaleChangeInterceptor`(파라미터명 `lang`)가 `?lang=en` 같은 요청으로 세션 Locale을 갱신합니다. 한 번 전환하면 이후 요청은 `lang` 없이도 세션 언어를 따릅니다.
- **JSP 출력**: `<spring:message code="..."/>`로 직접 출력하거나, `javaScriptEscape="true"`로 이스케이프해 JS 변수로 안전하게 전달합니다.
- **자바/API 레이어**: `MessageUtil`(`common.util`)이 `LocaleContextHolder.getLocale()` 기준으로 같은 `MessageSource`를 조회합니다. `get(code)`와 placeholder용 `get(code, args...)` 오버로드를 제공해, 컨트롤러·서비스가 API 응답 메시지까지 4개 언어로 일관 처리합니다.

## 설계 결정과 트레이드오프

- **인증/인가를 자체 인터셉터+AOP로 처리, Spring Security는 CSRF 전용**: `SecurityConfig`는 `authorizeHttpRequests().anyRequest().permitAll()`로 Security의 인증 메커니즘을 비활성화하고, 폼 로그인·HTTP Basic·로그아웃을 모두 끕니다. CSRF 보호만 활용하되, 그마저도 `requireCsrfProtectionMatcher`로 `/community/`·`/report/`·`/inquiry/`의 변경 요청(POST/PUT/DELETE)에만 부분 적용 후 점진 확장하는 전략입니다(ADR-0012). 자체 세션 인증과의 일관성을 위해 의도적으로 Security를 얇게 사용합니다.
- **i18n 번들의 도메인별 분리**: 단일 거대 번들 대신 도메인 basename으로 쪼개 4인 협업의 머지 충돌과 키 충돌을 줄였습니다. 대가는 새 도메인 추가 시 `setBasenames` 등록 누락 위험입니다. 실제로 `common_*.properties` 파일은 디스크에 존재하나 `setBasenames` 목록에는 등록되어 있지 않아 로딩되지 않으며, `course`/`courses` 두 번들이 공존해 네이밍 혼동 소지가 있습니다(정직하게 남아 있는 약점).
- **API 메시지까지 i18n 일관 적용**: 화면(JSP)만이 아니라 API 응답 메시지도 동일 번들로 4개 언어 처리하기로 했고(ADR-0013), 이를 위해 자바 레이어 헬퍼 `MessageUtil`을 두었습니다.
- **`@LoginUser` 파라미터 자동 주입**: 컨트롤러가 세션에서 직접 `loginUser`를 꺼내는 보일러플레이트를 없애기 위해 `LoginUserArgumentResolver`를 등록했습니다(ADR-0011). `@RequireLogin`/`@RequireAdmin` AOP가 먼저 차단하므로 컨트롤러 본문은 user를 non-null로 가정할 수 있습니다.
- **파일 업로드 이원화(Cloudinary 우선)**: 사용자 이미지의 정식 저장소는 Cloudinary CDN이고, 본문에는 `secure_url`만 저장합니다. 로컬 디스크 기반 `/upload/**` 정적 서빙은 초기 방식의 잔재로 설정에만 일부 남아 있습니다(ADR-0007). 외부 의존성·벤더 락인을 떠안는 대신 포트폴리오 단계에서 운영 부담 0·자동 변환·글로벌 CDN을 얻는 선택입니다.
- **JSON 직렬화**: `JacksonConfig`가 `JsonMapper`에 `JavaTimeModule`을 추가하고 `WRITE_DATES_AS_TIMESTAMPS`를 비활성화해 날짜를 ISO-8601 문자열로 직렬화합니다. 본 포트폴리오 리포지토리의 `pom.xml`은 `com.fasterxml.jackson` 계열(Jackson 2.x)을 사용합니다.

## 데이터 모델 / 연동

- **차단 로그**: `IpBlockInterceptor`는 `BlockAccessLogMapper#insertBlockAccessLog`로 차단 요청을 적재하며, 규칙은 `BlockRuleCacheService` 스냅샷(파일 캐시 `security.block.cache.file`)에서 읽습니다.
- **활동 로그**: `ActivityLogInterceptor`는 `ActivityLogMapper#insertActivityLog`로 `UserActivityLogVO`(requestId, flowTraceId, userIdx, requestUri, activityDomain/type/code, responseStatus, responseTimeMs 등)를 적재합니다.
- **알림**: `NotificationInterceptor`는 `MyPageService`를 통해 알림 미읽음 수와 최근 목록(`FeedNotificationDto`)을 조회합니다.
- **MyBatis 타입 별칭**: 매퍼 XML은 `classpath:mapper/*.xml`이며, `mybatis.type-aliases-package`에 VO 패키지를 도메인별로 **명시 나열**합니다(와일드카드·`Temp.java` 별칭 충돌 회피 목적). 새 VO 패키지 추가 시 이 속성에 등록이 필요합니다.
- **외부 연동**: Cloudinary(이미지 CDN), 메일(`spring.mail` SMTP), OAuth(Kakao/Naver/Google), 지도·번역·AI 키 등은 `application.properties`에서 `@Value`로 주입합니다. 공개본에는 모든 비밀 값이 자리표시자로 치환되어 있습니다.

## 사용 기술

- **프레임워크/언어**: Spring Boot 4 / Java 21 / Spring MVC (WAR, JSP·JSTL)
- **인증/인가**: 세션 기반 자체 인증 + `HandlerInterceptor` 체인 + AOP, Spring Security(CSRF 부분 적용)
- **i18n**: `ReloadableResourceBundleMessageSource`, `SessionLocaleResolver`, `LocaleChangeInterceptor`, `spring:message`, `MessageUtil`(`LocaleContextHolder`)
- **영속성**: MyBatis(`@Mapper` + XML), 도메인별 타입 별칭
- **파일/미디어**: Cloudinary CDN 업로드 + 로컬 `/upload/**` 정적 매핑, 멀티파트(10MB/요청 100MB)
- **직렬화/HTTP**: Jackson(`JavaTimeModule`, ISO-8601 날짜), `RestTemplate`
- **공통 빈**: `BCryptPasswordEncoder`, `ObjectMapper`, `LoginUserArgumentResolver`
- **관련 ADR**: 0007(이미지 CDN), 0011(`@LoginUser` 주입), 0012(Security CSRF 부분 도입), 0013(API 메시지 i18n)
