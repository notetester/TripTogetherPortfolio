# TripTogether

TripTogether는 여행지 탐색, AI 추천, 여행 코스 작성, 커뮤니티, 항공권 예매, 여행 패키지 예약, 포인트 상점, 지갑/보상 시스템, 관리자 운영 기능을 하나로 묶은 Spring Boot 기반 통합 여행 플랫폼입니다.

사용자는 여행지를 탐색하고 상세 페이지에서 리뷰, 좋아요, 신고, 지도, 항공권, 패키지 정보를 함께 확인할 수 있습니다. 이후 캐시와 마일리지를 사용해 예약을 진행하고, 활동 보상으로 포인트와 경험치를 획득하며, 아이템샵에서 꾸미기 아이템을 구매하고 장착할 수 있습니다.

관리자는 회원, 신고, 커뮤니티, 여행지, 패키지, 예약/결제, 차단, 번역, AI 사용량 등을 운영 화면에서 관리할 수 있습니다. 최고관리자는 일반 관리자 권한과 조직/직책 기반 권한 정책을 관리합니다.

---

## 목차

- [기술 스택](#기술-스택)
- [실행 방법](#실행-방법)
- [프로젝트 구조](#프로젝트-구조)
- [주요 기능](#주요-기능)
- [인증과 권한 구조](#인증과-권한-구조)
- [여행지 탐색과 상세 페이지](#여행지-탐색과-상세-페이지)
- [항공권 예매](#항공권-예매)
- [여행 패키지](#여행-패키지)
- [내 지갑과 Toss Payments](#내-지갑과-toss-payments)
- [포인트, 경험치, 레벨, 등급](#포인트-경험치-레벨-등급)
- [아이템샵](#아이템샵)
- [다국어와 번역 구조](#다국어와-번역-구조)
- [관리자와 최고관리자](#관리자와-최고관리자)
- [차단, 신고, 모더레이션](#차단-신고-모더레이션)
- [AI 연동](#ai-연동)
- [DB 구조 요약](#db-구조-요약)
- [개발 규칙과 주의사항](#개발-규칙과-주의사항)
- [테스트와 빌드](#테스트와-빌드)

---

## 기술 스택

| 영역 | 기술 |
|---|---|
| Language | Java 21 |
| Backend | Spring Boot 4.0.5, Spring MVC |
| View | JSP, JSTL, Spring Message Tag |
| Persistence | MyBatis 4.0.1, Mapper XML |
| Database | MySQL 8 |
| Packaging | WAR |
| Auth/Security | Session 기반 인증, BCrypt, Spring Security CSRF 부분 적용 |
| HTTP Client | OkHttp, RestTemplate |
| JSON | Jackson, Gson |
| Mail | Spring Boot Mail, Naver SMTP |
| File/Image | Multipart Upload, Cloudinary |
| Payment | Toss Payments 테스트 결제 |
| AI/External API | Gemini, Claude, OpenAI, Google Translate, Google Maps, Perspective API, Pixabay |
| Utility | Lombok, Apache POI, jsoup |

---

## 실행 방법

### 1. 사전 요구사항

- Java 21
- MySQL 8
- Maven Wrapper 사용 가능 환경
- `TripTogetherDB.sql` 스키마 반영
- 외부 API 키 설정

### 2. DB 생성 및 스키마 반영

프로젝트 루트의 `TripTogetherDB.sql`에 전체 DB 스키마와 샘플 데이터가 포함되어 있습니다.

```sql
SOURCE TripTogetherDB.sql;
```

실제 DB명, 계정, 비밀번호는 로컬 환경에 맞게 조정해야 합니다.

### 3. 설정 파일

주요 설정 파일은 다음 위치에 있습니다.

```text
src/main/resources/application.properties
```

중요 설정 항목:

```properties
server.servlet.context-path=/TripTogether
spring.datasource.url=...
spring.datasource.username=...
spring.datasource.password=...
mybatis.mapper-locations=classpath:mapper/*.xml
mybatis.type-aliases-package=...
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
file.upload.path=src/main/resources/upload/
app.base-url=http://localhost:8080/TripTogether
```

외부 연동에 필요한 키:

```properties
oauth.kakao.client-id=...
oauth.kakao.client-secret=...
oauth.naver.client-id=...
oauth.naver.client-secret=...
oauth.google.client-id=...
oauth.google.client-secret=...
google.maps.api-key=...
gemini.api.key=...
claude.api.key=...
openai.api.key=...
gcp.translate.api.key=...
toss.payments.client-key=...
toss.payments.secret-key=...
pixabay.api.key=...
perspective.api.key=...
cloudinary.cloud-name=...
cloudinary.api-key=...
cloudinary.api-secret=...
```

주의: API 키, DB 비밀번호, OAuth secret은 README나 커밋 로그에 직접 노출하지 않는 것이 좋습니다. 운영 또는 협업 환경에서는 환경변수, 별도 secret 파일, Vault, Secrets Manager 같은 방식으로 분리하는 것을 권장합니다.

### 4. 실행

```bash
./mvnw spring-boot:run
```

Windows PowerShell:

```powershell
.\mvnw.cmd spring-boot:run
```

접속 URL:

```text
http://localhost:8080/TripTogether
```

### 5. WAR 빌드

```bash
./mvnw clean package -DskipTests
```

Windows PowerShell:

```powershell
.\mvnw.cmd clean package -DskipTests
```

---

## 프로젝트 구조

전체 Java 소스는 `org.triptogether` 하위에 기능 단위 모듈로 분리되어 있습니다. 현재 확인 기준 Java 파일은 약 399개이며, 각 도메인은 대체로 `controller`, `service`, `mapper`, `vo` 계층을 가집니다.

```text
src/main/java/org/triptogether/
  admin/          관리자 기능
  ai/             AI 여행 일정 생성
  assistant/      AI 여행 도우미
  auth/           로그인, 회원가입, OAuth, 이메일 인증
  cloudinary/     Cloudinary 연동
  common/         공통 컨트롤러, 챗봇, 공통 VO/유틸
  community/      커뮤니티 게시글, 댓글, 좋아요, 신고 연동
  config/         MVC, 보안, 인터셉터, Bean 설정
  courses/        여행 코스 작성, AI 코스 생성
  detail/         여행지 상세 페이지
  explore/        여행지 탐색, 추천, 번역 캐시
  flight/         항공권 mock 조회/예매/취소
  home/           홈 화면
  inquiry/        1:1 문의
  moderation/     모더레이션 정책
  myPage/         마이페이지, 지갑, 알림, 예약 내역
  perspective/    Google Perspective API 연동
  report/         신고 게시판
  reward/         포인트/EXP/레벨 보상
  shop/           아이템샵
  superAdmin/     최고관리자
  travelPackage/  여행 패키지 등록/승인/예약
```

주요 리소스 구조:

```text
src/main/resources/
  mapper/         MyBatis XML Mapper
  messages/       다국어 메시지 번들
  application.properties

src/main/webapp/
  WEB-INF/views/  JSP 화면
  resources/css/  CSS
  resources/js/   JavaScript
  resources/data/ SVG, 정적 데이터
```

현재 주요 JSP 디렉터리:

```text
admin, ai, assistant, auth, common, community, courses, detail,
explore, home, inquiry, mypage, packages, report, shop,
superAdmin, wallet
```

---

## 주요 기능

### 사용자 기능

- 회원가입, 로그인, 로그아웃
- 이메일 인증, 아이디 찾기, 비밀번호 재설정
- Kakao, Naver, Google OAuth 로그인 및 계정 연동
- 여행지 탐색, 좋아요, 찜하기, AI 추천
- 여행지 상세 정보, 지도, 리뷰, 리뷰 좋아요, 리뷰 신고, 유저 신고
- 여행 코스 작성, 공개/내 코스 조회, AI 일정 생성
- 커뮤니티 게시글, 댓글, 답글, 좋아요, 신고, 질문 채택
- AI 여행 도우미, 사이트 안내 챗봇
- 항공권 mock 조회, 예매, 취소
- 여행 패키지 조회, 예약, 취소
- 캐시 충전, 마일리지, 포인트, 자산 변동 이력
- 레벨, 경험치, 회원등급, 레벨업 보상
- 아이템샵 구매, 보유 아이템 조회, 장착/해제
- 마이페이지 통합 조회
- SSE 기반 알림

### 운영자 기능

- 관리자 대시보드
- 회원 관리, 회원 상태/권한/역할 변경
- 기업회원 신청 승인/반려
- 커뮤니티 게시글/댓글 관리
- 여행지/리뷰 관리
- 패키지 승인/반려, 수정 요청 승인/반려
- 신고 관리
- 문의 답변
- 로그인/보안/활동 로그 조회
- 차단 관리, IP 차단, 배치 차단
- 지갑 정책, 충전 한도, 보상 정책 관리
- 광고 캠페인 관리
- 관리자 AI 도우미/챗봇 사용량 및 차단 관리
- 번역 관리
- 최고관리자 권한/그룹/정책/조직/급여 관리

---

## 인증과 권한 구조

### 세션 인증

로그인 성공 시 세션에 `loginUser`가 저장됩니다.

```text
session.loginUser = UsersVO
```

주요 인증 흐름:

- 일반 로그인
- 이메일 기반 인증
- OAuth 로그인
- 소셜 계정 연동/해제
- 휴면 계정 해제
- 로그인 이력 저장

### OAuth

지원 제공자:

- Kakao
- Naver
- Google

OAuth 신규 사용자는 임시 소셜 정보(`SocialTempVO`)를 기반으로 추가 가입 정보를 입력한 뒤 최종 회원으로 등록됩니다.

### 인터셉터

`WebConfig`에서 다음 인터셉터가 등록됩니다.

| 인터셉터 | 역할 |
|---|---|
| `LocaleChangeInterceptor` | `lang` 파라미터 기반 언어 변경 |
| `IpBlockInterceptor` | IP 차단 검사 |
| `ActivityLogInterceptor` | 사용자 활동 로그 기록 |
| `LoginInterceptor` | 로그인 필요 경로 보호 |
| `AdminInterceptor` | 관리자 경로 보호 |
| `SuperAdminInterceptor` | 최고관리자 경로 보호 |
| `AdminModeInterceptor` | 관리자 모드 컨텍스트 주입 |
| `NotificationInterceptor` | 헤더 알림 데이터 주입 |

로그인 필요 경로 예:

```text
/mypage/**
/wallet/**
/auth/link/**
/inquiry/**
```

관리자 경로:

```text
/admin/**
```

최고관리자 경로:

```text
/superAdmin/**
```

### Spring Security

현재 Spring Security는 전체 인증을 담당하기보다, 일부 모듈의 CSRF 보호를 위해 부분 적용되어 있습니다. 실제 인증/권한 흐름은 세션, 인터셉터, AOP 기반 권한 체크와 함께 동작합니다.

CSRF 적용 대상:

```text
/community/**
/report/**
/inquiry/**
```

---

## 여행지 탐색과 상세 페이지

관련 모듈:

```text
explore/
detail/
recommend/
```

주요 URL:

```text
GET  /explore
POST /explore/write
GET  /explore/suggest
POST /explore/favorite/{spotIdx}
POST /explore/like/{spotIdx}
POST /recommend/view-log
GET  /recommend/spots
GET  /detail/{spotIdx}
POST /detail/{spotIdx}/review
DELETE /detail/{spotIdx}/review/{reviewIdx}
POST /detail/{spotIdx}/review/{reviewIdx}/like
```

주요 기능:

- 여행지 목록 조회
- 여행지 등록
- 지역/테마/평점/좋아요/찜/AI 추천 기반 탐색
- 여행지 좋아요
- 여행지 찜하기
- 체류 로그 기반 추천
- Google Maps 지도 표시
- 여행지 리뷰 작성/삭제
- 리뷰 좋아요
- 리뷰 신고
- 유저 신고
- 승인된 패키지 노출
- 항공권 예매 진입
- 다국어 번역 캐시 적용

추천 구조:

1. 사용자가 여행지 목록 또는 상세 페이지를 조회합니다.
2. 조회/체류 로그가 기록됩니다.
3. 추천 탭 진입 시 캐시를 우선 확인합니다.
4. 캐시가 없거나 만료되면 Gemini 기반 추천을 요청합니다.
5. AI 실패 시 기본 추천 목록으로 폴백합니다.

관련 테이블:

```text
SPOT_TRAVEL
SPOT_IMAGE
SPOT_TAG
SPOT_TAG_LIST
SPOT_LIKE
SPOT_FAVORITE
SPOT_REVIEW
SPOT_REVIEW_LIKE
SPOT_VIEW_LOG
SPOT_TEXT_TRANSLATION_CACHE
SPOT_TRANSLATION
SPOT_RECOMMEND
```

---

## 항공권 예매

관련 모듈:

```text
flight/
```

주요 URL:

```text
GET  /flight/offers
POST /flight/purchase
POST /flight/purchases/{flightPurchaseIdx}/cancel
```

구성 파일:

```text
FlightController
FlightService / FlightServiceImpl
FlightMapper
FlightOfferProvider
MockFlightOfferProvider
FlightMapper.xml
```

주요 기능:

- 여행지 기준 항공권 mock 조회
- 출발일/귀국일 기반 왕복 예매
- 대한민국 출발지 고정 흐름
- 캐시/마일리지 혼합 결제
- 회원등급 기반 할인 적용
- 예매 정보 저장
- 취소 시 캐시/마일리지 환불
- 마이페이지 예매 내역 조회

설계 포인트:

- 실제 항공 API 도입 전에도 사용자 예약 흐름을 검증할 수 있도록 mock provider 사용
- `FlightOfferProvider` 인터페이스를 통해 향후 외부 항공 API로 교체 가능
- 항공권 예매와 패키지 예약은 도메인이 다르므로 각각 별도 테이블과 화면으로 관리

관련 테이블:

```text
FLIGHT_PURCHASE_SIMULATION
USER_PAYMENT_HISTORY
USER_WALLET_HISTORY
MEMBER_GRADE_POLICY
USERS
```

---

## 여행 패키지

관련 모듈:

```text
travelPackage/
```

주요 URL:

```text
GET  /packages
GET  /packages/manage
GET  /packages/manage/write
POST /packages/manage/write
GET  /packages/manage/{packageIdx}/edit
POST /packages/manage/{packageIdx}/edit
POST /packages/manage/{packageIdx}/submit
POST /packages/{packageIdx}/book
POST /packages/bookings/{packageBookingIdx}/cancel
```

주요 기능:

- 사용자용 여행 패키지 목록
- 통합 키워드 검색
- 일반 페이지네이션
- 판매자용 패키지 관리
- 패키지 등록
- 이미지 업로드
- 관리자 승인 요청
- 승인된 패키지만 사용자 노출
- 승인된 패키지 수정 시 수정 요청 생성
- 관리자 수정 요청 승인/반려
- 패키지 예약
- 패키지 취소
- 마이페이지 패키지 예약 내역 조회

상태 흐름:

```text
DRAFT -> PENDING -> APPROVED
                  -> REJECTED
```

수정 요청 흐름:

```text
기존 APPROVED 패키지 유지
판매자 수정 요청
TRAVEL_PACKAGE_REVISION 저장
관리자 검토
승인 시 TRAVEL_PACKAGE 원본 반영
반려 시 기존 원본 유지
```

관련 테이블:

```text
TRAVEL_PACKAGE
TRAVEL_PACKAGE_IMAGE
TRAVEL_PACKAGE_REVISION
TRAVEL_PACKAGE_BOOKING
TRAVEL_PACKAGE_REVIEW_HISTORY
USERS
SPOT_TRAVEL
USER_WALLET_HISTORY
USER_PAYMENT_HISTORY
```

---

## 내 지갑과 Toss Payments

관련 모듈:

```text
myPage/
wallet/
```

주요 URL:

```text
GET  /wallet
POST /wallet/charge
POST /wallet/charge/prepare
GET  /wallet/charge/success
GET  /wallet/charge/fail
```

주요 기능:

- 캐시 잔액 조회
- 마일리지 잔액 조회
- 포인트 잔액 조회
- 캐시 충전
- Toss Payments 테스트 결제
- 충전 성공 시 캐시 반영
- 충전 금액 기반 마일리지 적립
- 충전 한도 정책 적용
- 결제 준비 상태 저장
- 결제 성공/실패 상태 관리
- 중복 성공 콜백 방지
- 결제/충전 이력 조회
- 자산 변동 이력 조회

Toss Payments 충전 흐름:

```text
1. 사용자가 충전 금액 입력
2. /wallet/charge/prepare 요청
3. USER_PAYMENT_HISTORY에 READY 주문 생성
4. Toss 결제창 호출
5. 성공 콜백에서 paymentKey, orderId, amount 수신
6. 서버에서 Toss confirm API 호출
7. 승인 성공 시 USER_PAYMENT_HISTORY COMPLETED 처리
8. USERS.cash_balance 증가
9. 마일리지 적립
10. USER_WALLET_HISTORY 기록
```

관련 테이블:

```text
USERS
USER_PAYMENT_HISTORY
USER_WALLET_HISTORY
MEMBER_GRADE_POLICY
Wallet 정책 관련 테이블
```

설계 포인트:

- 클라이언트 결제 성공만 믿지 않고 서버에서 Toss 승인 API를 호출합니다.
- 결제 전 `READY` 상태를 DB에 저장해 중복 승인과 재호출을 방어합니다.
- 캐시, 마일리지, 결제 이력을 분리해 추적 가능성을 확보합니다.

---

## 포인트, 경험치, 레벨, 등급

관련 모듈:

```text
reward/
myPage/
```

주요 기능:

- 행동 기반 포인트 지급
- 행동 기반 EXP 지급
- 중복 보상 방지
- 누적 EXP 기반 레벨 산정
- 레벨업 알림
- 레벨업 보상 지급
- 기존 유저 레벨 보상 소급 지급
- 회원등급 정책 기반 등급 산정
- 마이페이지 레벨/EXP/보상 표 표시

핵심 정책 테이블:

```text
POINT_REWARD_POLICY
EXP_REWARD_POLICY
EXP_LEVEL_POLICY
EXP_LEVEL_OVERRIDE
MEMBER_GRADE_POLICY
LEVEL_UP_REWARD_POLICY
```

핵심 이력 테이블:

```text
USER_POINT_HISTORY
USER_EXP_HISTORY
USER_GRADE_HISTORY
USER_LEVEL_UP_REWARD_HISTORY
USER_WALLET_HISTORY
```

보상 지급 흐름:

```text
사용자 행동 발생
정책 조회
중복 지급 여부 확인
포인트/EXP 지급
레벨 재계산
레벨 상승 감지
레벨업 보상 정책 조회
미지급 보상 지급
보상 이력 저장
마이페이지에 반영
```

역할 구분:

| 항목 | 역할 |
|---|---|
| 캐시 | 충전 기반 결제 자산 |
| 마일리지 | 예약 시 할인성 자산 |
| 포인트 | 활동 보상 및 아이템샵 소비 자산 |
| EXP | 레벨 성장을 위한 누적 값 |
| 회원등급 | 결제 실적 기반 혜택 |
| 레벨 | 활동 기반 성장 지표 |

---

## 아이템샵

관련 모듈:

```text
shop/
myPage/
```

주요 URL:

```text
GET  /shop
POST /shop/purchase
POST /mypage/items/equip
POST /mypage/items/unequip
```

주요 기능:

- 포인트 기반 아이템 구매
- 보유 아이템 인벤토리 조회
- 아이템 장착
- 아이템 장착 해제
- 닉네임 색상 적용
- 닉네임 테두리/글로우 적용
- 프로필 뱃지 적용
- 댓글/리뷰 말풍선 스타일 적용
- 레벨업 전용 성장 뱃지 지급 및 장착

관련 테이블:

```text
POINT_SHOP_ITEM
USER_POINT_PURCHASE_HISTORY
USER_POINT_ITEM_INVENTORY
USER_POINT_ITEM_EQUIP
USER_POINT_HISTORY
USERS
```

설계 포인트:

- 판매 상품 정의와 사용자 보유 상태를 분리합니다.
- 보유 상태와 장착 상태도 분리합니다.
- 레벨업 전용 뱃지는 상점 노출 상품과 분리하되, 기존 인벤토리/장착 구조를 재사용합니다.

---

## 다국어와 번역 구조

지원 언어:

```text
ko, en, ja, zh
```

정적 문구:

```text
src/main/resources/messages/*_{locale}.properties
```

현재 메시지 번들 예:

```text
admin, assistant, auth, chatbot, common, community, course, courses,
detail, explore, footer, header, home, inquiry, mypage, package,
recommend, report, shop, superAdmin, wallet
```

동작 구조:

- `SessionLocaleResolver`로 사용자 언어를 세션에 저장합니다.
- `LocaleChangeInterceptor`가 `?lang=en` 같은 요청 파라미터를 감지합니다.
- JSP에서는 Spring Message Tag를 사용해 정적 문구를 렌더링합니다.
- 여행지/패키지 등 DB 기반 동적 텍스트는 번역 캐시 테이블을 통해 관리합니다.

관련 테이블:

```text
SPOT_TEXT_TRANSLATION_CACHE
SPOT_TRANSLATION
ADMIN_TRANSLATION
ADMIN_TRANSLATION_REVISION
ADMIN_TRANSLATION_SOURCE_SNAPSHOT
```

설계 포인트:

- 고정 UI 문구와 DB 동적 문구의 번역 전략을 분리합니다.
- 외부 번역 API 호출을 매번 수행하지 않고 캐시를 사용합니다.
- 관리자 번역 관리 화면을 통해 번역 데이터의 운영 관리를 지원합니다.

---

## 관리자와 최고관리자

### 관리자

관련 경로:

```text
/admin/**
```

주요 기능:

- 대시보드
- 최근 매출 통계
- 회원 관리
- 기업회원 신청 관리
- 커뮤니티 관리
- 여행지/리뷰 관리
- 패키지 승인/반려
- 패키지 수정 요청 승인/반려
- 문의 관리
- 신고 관리
- 로그인 이력 조회
- 보안 이력 조회
- 활동 로그 조회
- 차단 관리
- IP 차단 관리
- 환불 관리
- 지갑 정책 관리
- 광고 관리
- AI 도우미/챗봇 관리
- 번역 관리

### 최고관리자

관련 경로:

```text
/superAdmin/**
```

주요 기능:

- 관리자 권한 부여/회수
- 권한 코드 관리
- 권한 그룹 관리
- 권한 정책 관리
- 조직/직책 관리
- 급여 엑셀 업로드 및 적용
- 권한 변경 이력 조회
- 관리자 감사 로그 조회

관련 테이블:

```text
ADMIN_PERMISSION
ADMIN_PERMISSION_GROUP
ADMIN_PERMISSION_GROUP_ITEM
ADMIN_PERMISSION_POLICY
ADMIN_PERMISSION_CODE_POLICY
ADMIN_PERMISSION_CODE_GROUP_ITEM
ADMIN_PERMISSION_CODE_PERMISSION_ITEM
ADMIN_POSITION_POLICY
USER_ROLE_CHANGE_HISTORY
SALARY_CHANGE_AUDIT
```

---

## 차단, 신고, 모더레이션

### 신고

관련 모듈:

```text
report/
community/
detail/
inquiry/
```

주요 기능:

- 게시글 신고
- 댓글 신고
- 리뷰 신고
- 유저 신고
- 신고 취소
- 신고 처리 상태 변경
- 관리자 신고 검토

관련 테이블:

```text
REPORT
```

### 차단

유저 차단 정보는 단일 위치가 아니라 현재 상태, 상세 스냅샷, 이력으로 나뉩니다.

| 구분 | 위치 |
|---|---|
| 현재 계정 상태 | `USERS.account_status` |
| 차단 만료 | `USERS.blocked_until` |
| 차단 사유 | `USERS.blocked_reason` |
| 현재 차단 상세 | `USER_BLOCKLIST` |
| 차단/해제 이력 | `USER_BLOCK_HISTORY` |
| IP 차단 정책 | `IP_BLOCKLIST`, `IP_BLOCK_BATCH` |

차단 유형:

```text
USER_ONLY
IP_ONLY
USER_IP
```

### 모더레이션

관련 기능:

- 신고 누적 기반 BLUR 처리
- 관리자 직접 BLOCKED 처리
- AI 위험도 판정
- Perspective API toxicity 측정
- 모더레이션 정책 외부화

관련 테이블:

```text
CONTENT_MODERATION_POLICY
ADMIN_ASSISTANT_MODERATION
```

---

## AI 연동

### AI 여행 도우미

관련 모듈:

```text
assistant/
```

주요 URL:

```text
GET  /assistant
POST /assistant/chat
GET  /assistant/history/{chatPostIdx}
POST /assistant/history/{chatPostIdx}/title
POST /assistant/history/{chatPostIdx}/delete
POST /assistant/reset
```

기능:

- 다중 턴 여행 상담
- 대화 이력 저장
- 대화 제목 수정
- 대화 삭제
- 사용자별 이전 대화 조회

### 사이트 안내 챗봇

관련 모듈:

```text
common/ChatbotController
```

주요 URL:

```text
POST   /chatbot/ask
GET    /chatbot/conversations
GET    /chatbot/conversations/{id}/messages
PATCH  /chatbot/conversations/{id}/title
PATCH  /chatbot/conversations/order
DELETE /chatbot/conversations/{id}
POST   /chatbot/link-click
```

기능:

- 사이트 기능 안내
- 링크 추천
- 빠른 답변
- 대화 목록 관리
- 링크 클릭 로그
- 사용량/차단/할당량 관리

### AI 일정 생성

관련 모듈:

```text
ai/
courses/
```

기능:

- 여행 기간/목적지 기반 일정 생성
- 여행 코스 작성 폼과 연계
- AI가 생성한 일정 결과를 사용자가 여행 코스로 저장 가능

---

## DB 구조 요약

`TripTogetherDB.sql` 기준 생성문은 96개입니다. 테이블은 도메인별로 분리되어 있고, 상태값과 이력 테이블을 많이 사용하는 구조입니다.

### 회원/인증

```text
USERS
USER_SOCIAL
EMAIL_VERIFICATION
EMAIL_VERIFICATION_REQUEST
USER_LOGIN_HISTORY
USER_SECURITY_HISTORY
USER_ACTIVITY_LOG
```

### 여행지

```text
SPOT_TRAVEL
SPOT_IMAGE
SPOT_TAG
SPOT_TAG_LIST
SPOT_LIKE
SPOT_FAVORITE
SPOT_REVIEW
SPOT_REVIEW_LIKE
SPOT_VIEW_LOG
SPOT_TEXT_TRANSLATION_CACHE
SPOT_TRANSLATION
SPOT_RECOMMEND
```

### 커뮤니티

```text
COMMUNITY_POST
COMMUNITY_COMMENT
COMMUNITY_POST_IMAGE
COMMUNITY_POST_LIKE
COMMUNITY_COMMENT_LIKE
COMMUNITY_TAG
COMMUNITY_TAG_RELATION
COMMUNITY_POST_TAG
```

### 여행 코스

```text
TRAVEL_PLAN
plan_spot
```

### 패키지

```text
TRAVEL_PACKAGE
TRAVEL_PACKAGE_IMAGE
TRAVEL_PACKAGE_REVISION
TRAVEL_PACKAGE_BOOKING
TRAVEL_PACKAGE_REVIEW_HISTORY
BUSINESS_ACCOUNT_APPLICATION
```

### 항공권

```text
FLIGHT_PURCHASE_SIMULATION
```

### 지갑/결제/보상

```text
USER_PAYMENT_HISTORY
USER_WALLET_HISTORY
USER_POINT_HISTORY
USER_EXP_HISTORY
USER_GRADE_HISTORY
POINT_REWARD_POLICY
EXP_REWARD_POLICY
EXP_LEVEL_POLICY
EXP_LEVEL_OVERRIDE
MEMBER_GRADE_POLICY
LEVEL_UP_REWARD_POLICY
USER_LEVEL_UP_REWARD_HISTORY
```

### 아이템샵

```text
POINT_SHOP_ITEM
USER_POINT_PURCHASE_HISTORY
USER_POINT_ITEM_INVENTORY
USER_POINT_ITEM_EQUIP
```

### 신고/차단/모더레이션

```text
REPORT
USER_BLOCKLIST
USER_BLOCK_HISTORY
IP_BLOCKLIST
IP_BLOCK_BATCH
IP_BLOCK_BATCH_OPERATION
IP_BLOCK_BATCH_OPERATION_RULE
CONTENT_MODERATION_POLICY
```

### 관리자/권한

```text
ADMIN_PERMISSION
ADMIN_PERMISSION_GROUP
ADMIN_PERMISSION_GROUP_ITEM
ADMIN_PERMISSION_POLICY
ADMIN_PERMISSION_CODE_POLICY
ADMIN_PERMISSION_CODE_GROUP_ITEM
ADMIN_PERMISSION_CODE_PERMISSION_ITEM
ADMIN_POSITION_POLICY
ADMIN_EFFECTIVE_PERMISSION_VW
USER_ROLE_CHANGE_HISTORY
SALARY_CHANGE_AUDIT
POLICY_CHANGE_HISTORY
SYSTEM_POLICY
SYSTEM_POLICY_HISTORY
```

### AI/챗봇

```text
CHAT_POST
CHAT_COMMENT
CHATBOT_CONVERSATION
CHATBOT_MESSAGE
CHATBOT_LINK_CLICK
CHATBOT_BLOCK
CHATBOT_DAILY_USAGE
CHATBOT_GRADE_QUOTA
ADMIN_ASSISTANT_BLOCK
ADMIN_ASSISTANT_DAILY_USAGE
ADMIN_ASSISTANT_GRADE_QUOTA
ADMIN_ASSISTANT_MODERATION
```

### 문의/광고/번역

```text
INQUIRY
INQUIRY_POST
INQUIRY_ANSWER
INQUIRY_ATTACHMENT
AD_CAMPAIGN
ADMIN_TRANSLATION
ADMIN_TRANSLATION_REVISION
ADMIN_TRANSLATION_SOURCE_SNAPSHOT
```

---

## 개발 규칙과 주의사항

### MyBatis alias

새로운 VO 패키지를 추가하면 `application.properties`의 `mybatis.type-aliases-package`에 명시적으로 추가해야 합니다.

현재 설정은 와일드카드가 아니라 실제 VO 패키지를 나열하는 방식입니다. 이는 Linux 환경에서 대소문자나 패키지 스캔 누락 문제를 줄이기 위한 구조입니다.

### Mapper XML

Mapper XML은 다음 위치에 있습니다.

```text
src/main/resources/mapper/*.xml
```

새 Mapper를 만들 때 확인할 것:

- Mapper interface의 namespace와 XML namespace 일치
- `id`와 메서드명 일치
- VO alias 등록 여부
- MySQL 문법 확인
- `LIMIT`은 MySQL 제약상 서브쿼리 내부 사용을 피할 것

### JSP/EL

프로젝트 JSP 작성 규칙:

- `onclick` 안에 `${}`를 직접 넣지 않고 `data-*` 속성으로 분리
- JS 정규식의 `{}`는 JSP EL과 충돌할 수 있으므로 `\u007B`, `\u007D` 사용
- EL 삼항연산자 안에 EL을 중첩하지 않음
- 이미지 경로는 context path 기준으로 작성

예:

```jsp
${pageContext.request.contextPath}/upload/community/UUID.jpg
```

### 파일 업로드

기본 업로드 경로:

```properties
file.upload.path=src/main/resources/upload/
```

웹 접근 경로:

```text
/upload/**
```

주의:

- 로컬 개발 환경과 배포 환경의 파일 저장 경로가 달라질 수 있습니다.
- 운영 환경에서는 S3, Cloudinary, CDN 등 외부 스토리지 분리가 필요합니다.

### 민감정보

현재 `application.properties`에는 외부 API 키와 DB 접속 정보가 들어갈 수 있습니다. 운영 또는 협업 환경에서는 다음 방식으로 분리하는 것을 권장합니다.

- 환경변수
- 별도 로컬 설정 파일
- CI/CD secret
- Vault
- AWS Secrets Manager
- GCP Secret Manager

---

## 테스트와 빌드

### 전체 테스트

```bash
./mvnw test
```

Windows:

```powershell
.\mvnw.cmd test
```

현재 테스트 파일:

```text
TripTogetherApplicationTests
CommunityServiceTest
InquiryServiceTest
ReportServiceTest
SuperAdminServiceTest
```

### 단일 테스트 클래스

```bash
./mvnw test -Dtest=TripTogetherApplicationTests
```

### 단일 테스트 메서드

```bash
./mvnw test -Dtest=ClassName#methodName
```

### 컴파일 확인

```bash
./mvnw -q -DskipTests compile
```

### WAR 패키징

```bash
./mvnw clean package -DskipTests
```

빌드 결과물은 `target/` 하위에 생성됩니다.

---

## 운영 확장 시 개선 후보

- `application.properties`의 민감정보 외재화
- 세션 기반 인증을 JWT 또는 OAuth2 Resource Server 구조로 확장
- JSP 중심 화면을 Thymeleaf 또는 SPA 구조로 점진 전환
- AI 호출 결과 Redis 캐싱
- 파일 업로드를 S3/Cloudinary/CDN 중심으로 통합
- 지갑/결제 이력에 대한 정산용 일별 집계 테이블 추가
- 테스트 커버리지 확대
- 관리자 권한 정책의 DB/코드 단일 소스화
- APM, 로그 집계, 메트릭 도입
- 실제 항공권 API 연동
- Toss Payments 환불 API 연동

---

## 한 줄 요약

TripTogether는 여행지 탐색에서 예약, 결제, 보상, 커뮤니티, 관리자 운영까지 연결한 JSP 기반 Spring Boot 여행 플랫폼입니다. 핵심 설계 방향은 기능별 도메인 분리, 정책 테이블 기반 운영, 이력 중심 추적, 다국어 지원, AI 연동, 사용자 활동 기반 보상 구조입니다.
