# 프로젝트 개요

**TripTogether**는 여행지 탐색에서 시작해 코스 작성, 항공권·패키지 예약, 결제와 보상, 커뮤니티, 그리고 관리자 운영까지 하나의 흐름으로 연결한 통합 여행 플랫폼입니다. 사용자가 "탐색 → 계획 → 예약 → 공유"라는 여행의 전 과정을 한 서비스 안에서 끝낼 수 있도록 설계했습니다.

기술적으로는 **Spring Boot 4.0.5 / Java 21 / MyBatis / MySQL / JSP·JSTL** 기반의 WAR 패키징 모놀리식 애플리케이션입니다. 단일 애플리케이션이지만 내부는 `org.triptogether.{module}` 단위로 기능 도메인을 명확히 분리하고, 각 도메인이 `controller → service → mapper → vo` 계층을 일관되게 따르는 구조로 구성했습니다. 운영 측면에서는 상태값 기반 관리, 이력(history) 중심 추적, 정책 테이블 외부화, 4개 국어 다국어, 다중 AI 모델 연동을 핵심 설계 방향으로 삼았습니다.

## 주요 기능

- **인증·계정·보안** — 자체 로그인/회원가입, 이메일 인증, 비밀번호 재설정, 카카오·네이버·구글 OAuth, 세션 기반 인증과 인터셉터 보호
- **여행지 탐색·상세** — 지역/테마/평점 기반 탐색, AI 추천, 리뷰·좋아요·찜·신고, Google Maps 연동, 번역 캐시
- **여행 코스·AI 일정** — 방문지 순서가 있는 여행 계획 작성과 AI 기반 일정 자동 생성
- **항공권·패키지** — mock 항공권 예매/취소, 판매자 패키지 등록과 관리자 승인 워크플로, 예약/취소
- **지갑·결제·보상** — Toss Payments 캐시 충전, 마일리지·포인트·EXP·레벨·회원등급, 아이템샵
- **커뮤니티·신고·모더레이션** — 게시글·댓글·태그·이미지·좋아요, 신고 상태머신, 신고 누적 기반 BLUR/BLOCKED, Perspective 독성 판정
- **문의·알림·마이페이지** — 1:1 문의와 관리자 답변, SSE 실시간 알림, 프로필·소셜 연동 관리
- **AI 연동** — 멀티턴 여행 도우미·AI 일정 생성(OpenAI GPT), 사이트 안내 챗봇·여행지 추천(Gemini), 문의 답변 초안(Claude Haiku), 독성 판정(Perspective)
- **관리자·최고관리자** — 회원/신고/문의/패키지/번역/차단 운영, 로그인·보안·활동 감사 로그, 권한 그룹·조직 기반 정책 관리

## 핵심 구현

### 모듈 단위 도메인 분리

전체 Java 소스는 `src/main/java/org/triptogether/` 하위에서 기능 도메인별 패키지로 나뉩니다. 현재 약 460여 개 Java 파일이 21개 기능 모듈에 분산되어 있으며(설정 전용 `config` 제외), 각 모듈은 `controller / service / mapper / vo` 계층을 일관되게 따릅니다. Mapper SQL은 `src/main/resources/mapper/*.xml`, 화면은 `src/main/webapp/WEB-INF/views/{module}/`의 JSP로 분리됩니다.

도메인 분리가 잘 드러나는 예로, **항공권**(`flight/`)과 **패키지**(`travelPackage/`)는 둘 다 "예약"이지만 도메인 성격이 다르므로 각각 별도 테이블(`FLIGHT_PURCHASE_SIMULATION` / `TRAVEL_PACKAGE_BOOKING`)과 화면으로 분리했습니다. 항공권은 `FlightOfferProvider` 인터페이스 뒤에 `MockFlightOfferProvider`를 두어, 실제 외부 항공 API로 교체 가능한 구조를 미리 확보했습니다.

### 인터셉터 체인으로 횡단 관심사 처리

인증·권한·로그·다국어 같은 횡단 관심사는 `config` 패키지의 인터셉터 체인으로 처리합니다. `WebConfig`에 `LocaleChangeInterceptor`(언어 변경), `IpBlockInterceptor`(IP 차단), `ActivityLogInterceptor`(활동 로그), `LoginInterceptor`(로그인 보호), `AdminInterceptor`·`SuperAdminInterceptor`(관리자/최고관리자 경로 보호), `AdminModeInterceptor`(관리자 모드 주입), `NotificationInterceptor`(헤더 알림 주입)가 순서대로 등록됩니다. 로그인 성공 시 세션에 `loginUser`(UsersVO)를 저장하고, 보호 경로(`/mypage/**`, `/wallet/**`, `/auth/link/**`, `/inquiry/**`)는 인터셉터가 가로채 미인증 사용자를 로그인으로 리다이렉트합니다.

### 상태값·이력 중심 데이터 운영

`TripTogetherDB.sql` 기준 약 125개 테이블과 다수의 뷰로 구성된 스키마는 **상태값과 이력 테이블을 적극 사용**합니다. 어드민 차단·삭제는 물리 삭제(DELETE)가 아니라 상태값으로 처리합니다(`post_status='BLOCKED'`, `comment_status='BLOCKED'`, `account_status='BLOCKED'`). 차단 정보는 현재 상태(`USERS.account_status`), 상세 스냅샷(`USER_BLOCKLIST`), 이력(`USER_BLOCK_HISTORY`)으로 분리해 추적성을 확보했습니다. 결제·지갑·포인트·EXP·등급 변동도 각각 이력 테이블(`USER_PAYMENT_HISTORY`, `USER_WALLET_HISTORY`, `USER_POINT_HISTORY`, `USER_EXP_HISTORY`, `USER_GRADE_HISTORY`)로 남겨 자산 변동을 재구성할 수 있게 했습니다.

### 정책 테이블 외부화

보상·등급·모더레이션 같은 운영 규칙은 코드에 하드코딩하지 않고 정책 테이블로 외부화했습니다. 포인트/EXP/레벨/등급/레벨업 보상은 `POINT_REWARD_POLICY`, `EXP_REWARD_POLICY`, `EXP_LEVEL_POLICY`, `MEMBER_GRADE_POLICY`, `LEVEL_UP_REWARD_POLICY` 등으로 정의하고, 모더레이션 임계값은 `CONTENT_MODERATION_POLICY`로 관리합니다. 관리자 권한 또한 코드 상수가 아니라 `ADMIN_PERMISSION` 계열 + 권한 그룹·조직 정책 테이블로 운영합니다.

### 다중 AI 모델 연동

서로 다른 목적에 맞춰 AI 모델을 구분해 사용합니다. **여행 도우미**(`assistant/`)는 멀티턴 상담을 위해 OpenAI GPT를 사용하고 대화 이력을 DB(`CHAT_POST`, `CHAT_COMMENT`)에 저장합니다. **AI 일정 생성**(`ai/`, `courses/` 연계) 역시 OpenAI GPT로 여행 기간·목적지 기반 일정을 생성합니다. **사이트 안내 챗봇**(`common/ChatbotController`)은 Gemini로 구조화 JSON(`message`, `links[]`, `quickReplies[]`)을 받아 사이트 네비게이션을 안내하며, 차단 검사 → 쿼터 검사 → 대화 생성/조회 → 모델 호출 → 메시지 저장 → 사용량 증가 파이프라인으로 동작합니다. **여행지 추천**(`explore/`)은 Gemini 추천에 캐시·폴백을 결합합니다. 그 밖에 **문의 답변 초안**(`inquiry/`)은 Claude Haiku로 관리자 답변 초안을 생성하고, 모더레이션용으로 **Perspective API**(`perspective/`)를 연동합니다. API 키는 키 이름(`openai.api.key`, `gemini.api.key`, `inquiry.claude.api.key`, `perspective.api.key` 등)으로만 설정에 참조되며 값은 외부화 대상입니다.

## 설계 결정과 트레이드오프

- **세션 + 인터셉터 + AOP 권한 체크 / Spring Security 부분 적용** — 전체 인증을 Spring Security에 위임하지 않고, 세션 인증과 인터셉터 보호를 주 흐름으로 두되 일부 모듈(`/community/**`, `/report/**`, `/inquiry/**`)에 CSRF 보호만 부분 도입했습니다. (ADR-0011 인가 AOP·전역 예외 처리, ADR-0012 Spring Security CSRF 부분 도입)
- **소프트 삭제·상태값 모델** — 운영자가 콘텐츠를 되돌리거나 감사할 수 있도록 물리 삭제 대신 상태값을 사용합니다. (ADR-0008)
- **모더레이션 정책 외부화 / 신고 자동 차단 배제** — 신고가 곧바로 사용자 차단으로 이어지지 않게 하고, 임계값을 정책 테이블로 분리했습니다. (ADR-0001, ADR-0003 BLUR vs BLOCKED, ADR-0009)
- **카운터 캐시 컬럼 동기화** — `like_count`, `comment_count`를 캐시 컬럼으로 두되 정합성 동기화·재계산 규칙을 둡니다. (ADR-0006)
- **Cloudinary 이미지 저장** — 로컬 업로드 한계를 고려해 외부 스토리지로 분리했습니다. (ADR-0007)
- **mock 항공권 provider** — 실제 항공 API 도입 전에도 예약 흐름 전체를 검증하기 위해 인터페이스 + mock 구현으로 시작했습니다.
- **i18n 메시지 전면 적용** — 사용자 노출 문자열은 JSP/JS에 하드코딩하지 않고 `ko/en/ja/zh` 언어팩으로만 출력합니다. (ADR-0013)

설계 결정의 전체 목록과 배경은 [설계 결정(ADR 종합)](/decisions) 문서에서 다룹니다.

## 데이터 모델 / 연동

- **데이터베이스** — MySQL 8, `TripTogetherDB.sql` 기준 약 125개 테이블 + 뷰. 도메인별 테이블 + 정책 테이블 + 이력 테이블 구조.
- **외부 API** — Toss Payments(테스트 결제), Google Maps, Cloudinary(이미지), 카카오·네이버·구글 OAuth, OpenAI·Gemini·Claude(AI), Google Translate(번역), Perspective(독성 판정), Pixabay.
- **메시지 번들** — `src/main/resources/messages/*_{locale}.properties`로 모듈별 4개 국어 분리.

## 모듈 지도

| 모듈 | 한 줄 요약 | 대표 테이블 / 연동 |
|---|---|---|
| `auth` | 로그인·회원가입·이메일 인증·OAuth(카카오/네이버/구글) | `USERS`, `USER_SOCIAL`, `EMAIL_VERIFICATION` |
| `explore` | 여행지 탐색·추천·찜·번역 캐시 | `SPOT_TRAVEL`, `SPOT_FAVORITE`, `SPOT_RECOMMEND` |
| `detail` | 여행지 상세·리뷰·리뷰 좋아요·신고·지도 | `SPOT_REVIEW`, `SPOT_REVIEW_LIKE`, Google Maps |
| `courses` | 방문지 순서 기반 여행 코스 작성 | `TRAVEL_PLAN`, `plan_spot` |
| `ai` | AI 여행 일정 생성(OpenAI GPT, 코스 연계) | (`courses` 연계, OpenAI GPT) |
| `flight` | mock 항공권 조회·예매·취소 | `FLIGHT_PURCHASE_SIMULATION` |
| `travelPackage` | 패키지 등록·관리자 승인·예약·수정 요청 | `TRAVEL_PACKAGE`, `TRAVEL_PACKAGE_BOOKING`, `TRAVEL_PACKAGE_REVISION` |
| `myPage` | 마이페이지·지갑·알림·예약 내역 | `USER_PAYMENT_HISTORY`, `USER_WALLET_HISTORY` |
| `reward` | 포인트·EXP·레벨·등급 보상 | `POINT_REWARD_POLICY`, `EXP_LEVEL_POLICY` |
| `shop` | 포인트 기반 아이템샵·장착 | `POINT_SHOP_ITEM`, `USER_POINT_ITEM_EQUIP` |
| `community` | 게시글·댓글·태그·이미지·좋아요·신고 | `COMMUNITY_POST`, `COMMUNITY_COMMENT` |
| `report` | 게시글/댓글/리뷰/유저 신고 게시판 | `REPORT` |
| `moderation` | 모더레이션 정책 | `CONTENT_MODERATION_POLICY` |
| `perspective` | Google Perspective 독성 판정 연동 | Perspective API |
| `inquiry` | 1:1 문의와 관리자 답변(Claude Haiku 답변 초안) | `INQUIRY`, `INQUIRY_ANSWER` |
| `assistant` | 멀티턴 AI 여행 도우미(OpenAI GPT) | `CHAT_POST`, `CHAT_COMMENT` |
| `common` | 공통 컨트롤러·사이트 안내 챗봇(Gemini) | `CHATBOT_CONVERSATION`, `CHATBOT_MESSAGE` |
| `cloudinary` | Cloudinary 이미지 업로드 연동 | Cloudinary API |
| `admin` | 관리자 대시보드·회원/신고/패키지/번역/차단 운영 | `USER_BLOCKLIST`, `AD_CAMPAIGN`, `ADMIN_TRANSLATION` |
| `superAdmin` | 최고관리자 권한·조직·정책·감사 | `ADMIN_PERMISSION`, `USER_ROLE_CHANGE_HISTORY` |
| `home` | 홈 화면 | — |
| `config` | MVC·보안·인터셉터·Bean 설정 | (인터셉터 체인) |

## 데모에서 볼 수 있는 것

[라이브 데모](https://notetester.github.io/TripTogetherPortfolio/)는 백엔드 없이 화면을 둘러볼 수 있는 정적 데모입니다. 여행지 탐색·상세, 커뮤니티, 여행 코스, 마이페이지, 관리자 화면 등 주요 UI 흐름을 확인할 수 있습니다. 실제 로그인·결제·AI 응답은 서버가 필요하므로 데모에서는 화면 구성과 사용자 동선 위주로 제공됩니다.

- **라이브 데모**: <https://notetester.github.io/TripTogetherPortfolio/>
- **소스 코드**(민감정보 전체 이력 제거 공개본): <https://github.com/notetester/TripTogetherPortfolio>

## 사용 기술

| 영역 | 기술 |
|---|---|
| Language | Java 21 |
| Backend | Spring Boot 4.0.5, Spring MVC |
| View | JSP, JSTL, Spring Message Tag |
| Persistence | MyBatis, Mapper XML |
| Database | MySQL 8 |
| Packaging | WAR |
| Auth | 세션 기반 인증, BCrypt, OAuth(카카오/네이버/구글), Spring Security CSRF 부분 적용 |
| Payment | Toss Payments(테스트 결제) |
| AI / 외부 API | OpenAI(GPT), Gemini, Claude, Google Translate, Google Maps, Perspective, Cloudinary, Pixabay |
| i18n | MessageSource, `ko/en/ja/zh` 4개 국어 |
| Utility | Lombok, OkHttp/RestTemplate, Jackson, Apache POI, jsoup |
