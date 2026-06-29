# 아키텍처

TripTogether는 Spring Boot 4 / Java 21 기반의 모놀리식 웹 애플리케이션입니다. JSP·JSTL을 뷰로 사용하고 MyBatis로 MySQL에 접근하며, 서버 사이드 렌더링과 부분적 AJAX/SSE를 혼합한 전통적인 MVC 구조를 따릅니다. 모든 기능 모듈이 동일한 4계층(controller / service / mapper / vo) 레이아웃을 공유하도록 강제하여, 모듈이 20개 이상으로 늘어나도 코드의 위치와 책임을 예측 가능하게 유지하는 것을 핵심 설계 목표로 삼았습니다.

인증·인가는 Spring Security의 인증 메커니즘 대신 **자체 세션 + 인터셉터 체인 + AOP 어노테이션** 조합으로 처리합니다. Spring Security는 CSRF 보호 용도로만 부분 도입했습니다. 횡단 관심사(차단, 활동 로그, 다국어, 관리자 모드, 알림 주입)는 각각 독립된 인터셉터로 분리하여 컨트롤러를 비즈니스 로직에 집중시켰습니다.

## 주요 기능

- 기능 모듈마다 `controller / service / mapper / vo` 4계층으로 일관 분리
- 세션 기반 인증 + 경로별 인터셉터 + 어노테이션 AOP의 이중 인가 모델
- 8종 인터셉터 체인으로 다국어·IP 차단·활동 로그·관리자 모드·알림을 횡단 처리
- MyBatis XML 매퍼 + `@Mapper` 인터페이스로 SQL과 Java를 분리
- WAR 패키징 + 외장/내장 Tomcat 양쪽 구동, 컨텍스트 경로 `/TripTogether`
- 전역 예외 처리기(`GlobalExceptionHandler`)로 비즈니스 예외를 표준 응답으로 변환

## 핵심 구현

### 4계층 모듈 구조

각 기능은 `org.triptogether.{module}` 패키지 아래에 동일한 레이어 구조로 배치됩니다.

```
{module}/
  controller/   — @Controller / @RestController (요청 진입점)
  service/      — 인터페이스 + ServiceImpl (트랜잭션·비즈니스 로직)
  mapper/       — @Mapper 인터페이스 (SQL 바인딩)
  vo/           — VO / DTO
```

`org.triptogether` 하위에는 `auth`, `community`, `courses`, `assistant`, `admin`, `superAdmin`, `inquiry`, `myPage`, `report`, `moderation`, `wallet`(reward/shop), `travelPackage`, `flight` 등 20여 개 모듈이 존재하며 모두 같은 골격을 공유합니다. 공통 인프라(인터셉터, AOP, 전역 예외, 리졸버, 어노테이션)는 `config` 패키지와 `common` 패키지에 모았습니다.

### 요청 처리 흐름

표준 페이지 요청은 다음 단계를 거칩니다.

1. 내장/외장 Tomcat이 `/TripTogether` 컨텍스트로 요청 수신 → `DispatcherServlet` 위임
2. **인터셉터 체인의 `preHandle`** 순차 실행 (다국어 → IP 차단 → 활동 로그 → 로그인 → 관리자/최고관리자)
3. `LoginUserArgumentResolver`가 세션의 `loginUser`를 `@LoginUser UsersVO` 파라미터에 주입
4. 컨트롤러 메서드 진입 직전 `AuthorizationAspect`(AOP)가 `@RequireLogin`/`@RequireAdmin` 검증
5. Controller → Service → Mapper → MyBatis → MySQL 순으로 처리, 결과를 Model에 적재
6. **인터셉터 `postHandle`** 에서 `AdminModeInterceptor`·`NotificationInterceptor`가 Model에 공통 데이터(`isAdmin`, 알림 개수 등) 주입
7. `InternalResourceViewResolver`가 `/WEB-INF/views/{view}.jsp`로 포워딩 → JSP 렌더링

```mermaid
flowchart TD
    A[Client 요청<br/>/TripTogether/...] --> B[Tomcat + DispatcherServlet]
    B --> C{인터셉터 preHandle 체인}
    C -->|locale| C1[LocaleChangeInterceptor]
    C1 --> C2[IpBlockInterceptor]
    C2 --> C3[ActivityLogInterceptor]
    C3 --> C4[LoginInterceptor /mypage,/wallet,/inquiry...]
    C4 --> C5[AdminInterceptor /admin/**<br/>SuperAdminInterceptor /superAdmin/**]
    C5 --> D[LoginUserArgumentResolver<br/>@LoginUser 주입]
    D --> E{AOP AuthorizationAspect<br/>@RequireLogin/@RequireAdmin}
    E -->|통과| F[Controller]
    E -->|실패| X[GlobalExceptionHandler<br/>401/403 표준 응답]
    F --> G[Service Impl]
    G --> H[MyBatis Mapper]
    H --> I[(MySQL)]
    I --> H --> G --> F
    F --> J{인터셉터 postHandle}
    J --> J1[AdminModeInterceptor<br/>isAdmin/권한 플래그 주입]
    J1 --> J2[NotificationInterceptor<br/>알림 개수·목록 주입]
    J2 --> K[ViewResolver → JSP<br/>/WEB-INF/views/*.jsp]
    K --> L[HTML 응답]
```

### 인터셉터 체인

`WebConfig.addInterceptors`에서 8종 인터셉터를 경로 패턴별로 등록합니다. 각 인터셉터는 단일 책임을 가지며, 정적 리소스(`/css/**`, `/js/**`, `/upload/**` 등)는 일괄 제외합니다.

| 인터셉터 | 적용 경로 | 역할 |
| --- | --- | --- |
| `LocaleChangeInterceptor` | `/**` | `?lang=` 파라미터로 세션 로케일 변경 |
| `IpBlockInterceptor` | `/**` | 차단 IP 접근 차단 |
| `ActivityLogInterceptor` | `/**` | 활동 로그 기록 |
| `LoginInterceptor` | `/mypage/**`, `/wallet/**`, `/auth/link/**`, `/inquiry/**` | 비로그인 차단, `?redirect=` 보존 후 로그인 페이지로 |
| `AdminInterceptor` | `/admin/**` | 관리자 권한 + 세부 권한(`adminPermissions`) URL별 검사 |
| `SuperAdminInterceptor` | `/superAdmin/**` | 관리자 계열만 진입 허용 |
| `AdminModeInterceptor` | `/**` (postHandle) | `isAdmin`, `isAdminMode`, 권한 플래그를 Model에 주입 |
| `NotificationInterceptor` | `/**` (postHandle) | 헤더 알림 개수·최근 알림을 Model에 주입 |

`AdminInterceptor`는 단순 역할 검사에 그치지 않고, 세션에 적재된 `adminPermissions` 집합을 기준으로 URL 접두사별 필요 권한을 매핑합니다. 예를 들어 `/admin/members`는 `MEMBER_ADMIN`, `/admin/reports`는 `REPORT_ADMIN`을 요구하며, `/admin/finance/refund`(환불)·`/admin/finance/policy`(정책)·나머지(read-only)는 `resolveFinancePermission()`으로, `/admin/ai-helper` 이하는 Gemini 챗봇(`AI_CHATBOT_ADMIN`)과 Claude 도우미(`ASSISTANT_ADMIN`)로 분기 처리합니다. `SUPER_ADMIN` 권한 보유 시 모든 검사를 통과합니다.

### 이중 인가 모델: 인터셉터 + AOP

인터셉터가 "경로 단위" 1차 방어선이라면, AOP는 "메서드 단위" 정밀 인가를 담당합니다.

- `LoginUserArgumentResolver`: `@LoginUser UsersVO user` 파라미터에 세션 `loginUser`를 자동 주입(비로그인 시 null).
- `AuthorizationAspect`: `@RequireLogin` / `@RequireAdmin`이 붙은 컨트롤러 메서드 진입 직전(`@Before`)에 `RequestContextHolder`로 세션을 직접 조회해 권한을 검증하고, 실패 시 `UnauthorizedException`(401)·`ForbiddenException`(403)을 던집니다.

이 둘이 결합되어, 컨트롤러 본문은 "`@RequireLogin`이 붙은 메서드의 `@LoginUser` 파라미터는 항상 non-null"이라고 가정할 수 있어 null 체크 보일러플레이트가 제거됩니다(ADR-0011). 던져진 예외는 `GlobalExceptionHandler`가 표준 응답으로 변환합니다.

### MyBatis 매핑

- `@Mapper` 인터페이스(`org.triptogether.{module}.mapper`)와 XML(`src/main/resources/mapper/*.xml`)을 네임스페이스로 연결합니다. `mybatis.mapper-locations=classpath:mapper/*.xml`로 일괄 로드합니다.
- 컬럼-프로퍼티 매핑은 `<resultMap>`으로 명시합니다. 예: `CommunityMapper.xml`의 `PostResultMap`은 `post_id → postId`, `like_count → likeCount`처럼 스네이크/카멜 매핑을 명시적으로 선언합니다.
- 타입 별칭은 `mybatis.type-aliases-package`에 VO 패키지를 **명시적으로 나열**합니다. 와일드카드 전체 스캔 대신 모듈별 `*.vo`만 열거하여 스텁(`Temp.java`) 별칭 충돌을 방지합니다. 새 VO 패키지 추가 시 이 목록에 함께 등록해야 합니다.

### 설정 패키지 (`org.triptogether.config`)

| 클래스 | 역할 |
| --- | --- |
| `WebConfig` | `WebMvcConfigurer` 구현 — 인터셉터 등록, `/upload/**` 정적 매핑, `MessageSource`/`LocaleResolver`, 인자 리졸버 등록 |
| `SecurityConfig` | Spring Security를 **CSRF 보호 전용**으로 구성. 인증/폼로그인/HTTP Basic 비활성, `/community/`·`/report/`·`/inquiry/`의 POST/PUT/DELETE만 CSRF 검증(ADR-0012) |
| `BCryptConfig` | `BCryptPasswordEncoder` 빈 (비밀번호 해싱) |
| `JacksonConfig` | `ObjectMapper` 빈 — `JavaTimeModule` 등록, 날짜를 타임스탬프 대신 ISO 문자열로 직렬화 |
| `RestTemplateConfig` | 외부 API 호출용 `RestTemplate` 빈 |

이 패키지에는 인터셉터 구현(`IpBlockInterceptor`, `ActivityLogInterceptor` 등)과 런타임 설정 캐시(`BlockRuleCacheService`, `RuntimeSettingService`)도 함께 위치합니다.

### 정적 리소스와 파일 업로드

`WebConfig.addResourceHandlers`가 `/upload/**`를 파일 시스템 디렉터리(`${file.upload.path}`, 기본 `src/main/resources/upload/`)로 매핑합니다. `System.getProperty("user.dir")`에 경로를 결합한 뒤 구분자를 정규화하여 Windows/Linux/macOS에서 동일하게 동작하도록 처리했습니다. (커뮤니티 이미지 등 외부 저장은 Cloudinary로 처리 — ADR-0007.)

## 설계 결정과 트레이드오프

- **자체 세션 인증 vs Spring Security 전면 도입**: 팀 다수가 익숙한 세션+인터셉터 모델을 채택해 학습 비용을 낮추고, 보안상 가치가 큰 CSRF만 Spring Security로 부분 도입했습니다. 전면 적용 대신 담당 모듈(`/community`, `/report`, `/inquiry`)의 변경 요청부터 점진적으로 확장하는 전략입니다(ADR-0012). 트레이드오프로 표준 보안 필터 체인의 이점은 일부 포기했습니다.
- **인터셉터 + AOP 이중화**: 경로 단위 차단(인터셉터)과 메서드 단위 차단(AOP)을 분리해, 컨트롤러에서 인가 보일러플레이트를 제거하고 `@LoginUser` 파라미터의 non-null을 보장합니다(ADR-0011).
- **MyBatis XML + 명시적 type-alias 나열**: ORM의 자동 매핑 대신 SQL을 직접 제어하는 방식을 선택하고, 별칭 패키지를 좁게 열거하여 스텁 클래스와의 충돌을 차단했습니다.
- **WAR 패키징**: 내장 Tomcat으로 개발 편의(`spring-boot:run`)를 누리면서, `ServletInitializer`를 통해 외장 WAS 배포도 가능하도록 양립시켰습니다. `spring-boot-starter-tomcat`을 `provided` 스코프로 두어 WAR 내부에 Tomcat이 중복 포함되지 않게 했습니다.

## 데이터 모델 / 연동

- **DB**: MySQL (`team1_db`), MyBatis로 접근. 매퍼 SQL은 `src/main/resources/mapper/*.xml`에 모듈별로 분리.
- **외부 연동**: 이메일(`spring-boot-starter-mail`), 이미지 저장(Cloudinary), AI(Claude 기반 assistant 모듈 / Gemini 기반 footer 챗봇), AWS WAFv2 등. HTTP 호출은 `RestTemplate`과 OkHttp를 병용.
- **빌드/패키징**: Maven, WAR. `mvnw clean package -DskipTests`로 빌드, `mvnw spring-boot:run`으로 개발 구동. 앱은 `http://localhost:8080/TripTogether`에서 서비스(컨텍스트 경로 `server.servlet.context-path=/TripTogether`).
- **부트스트랩**: `TripTogetherApplication`(`@SpringBootApplication` + `@EnableScheduling` + `@EnableAsync`)이 진입점이며, 외장 WAS용으로 `ServletInitializer extends SpringBootServletInitializer`를 제공.

## 사용 기술

- **언어/런타임**: Java 21
- **프레임워크**: Spring Boot 4.0.6, Spring MVC(webmvc), Spring AOP(aspectjweaver), Spring Security(CSRF만)
- **영속성**: MyBatis(`mybatis-spring-boot-starter` 4.0.1), MySQL Connector/J
- **뷰**: JSP + JSTL(Jakarta), Tomcat Jasper
- **빌드/패키징**: Maven, WAR (내장/외장 Tomcat 양립)
- **부가**: Lombok, Jackson(+jsr310), Gson, OkHttp, Cloudinary, Apache POI, Jsoup, AWS SDK v2(WAFv2)
- **국제화**: `ReloadableResourceBundleMessageSource` 기반 ko/en/ja/zh 4개 언어팩, `SessionLocaleResolver`
