# 인증 · 계정 · 보안

TripTogether의 인증 모듈은 자체 아이디/이메일 로그인, 카카오·네이버·구글 소셜 로그인, 이메일 기반 계정 복구를 하나의 흐름으로 통합합니다. Spring Security의 인증 기능을 사용하지 않고 **세션 기반 자체 인증**을 구현하면서도, 로그인 위험도 평가·계정 잠금·차단 이의신청·WAF 동기화·전 과정 감사 로깅까지 운영 보안 기능을 갖춘 것이 특징입니다.

설계의 핵심 원칙은 두 가지입니다. 첫째, 모든 인증·보안 이벤트는 성공·실패 여부와 무관하게 감사 테이블에 기록되어 추적 가능해야 합니다. 둘째, 위험 판단·외부 연동·정책 임계값 같은 변동 요소는 코드가 아니라 DB 정책·런타임 설정·확장 인터페이스로 외부화하여, 코드 변경 없이 운영 중 조정할 수 있어야 합니다.

## 주요 기능

- 자체 로그인(아이디/이메일 식별자 자동 판별) 및 세션(`loginUser`) 기반 인증
- BCrypt 비밀번호 해싱 및 검증
- 카카오·네이버·구글 OAuth 2.0 로그인 콜백 + 마이페이지 소셜 계정 연동/해제
- 이메일 인증 및 액션 토큰 기반 아이디 찾기 / 비밀번호 재설정
- 계정 상태 관리: 정상(ACTIVE), 차단(BLOCKED), 휴면(DORMANT), 탈퇴(DELETED)
- 로그인 위험도 평가(계정·IP 단위 실패 임계값, 자동 잠금, 관리자 검토 큐 적재)
- 차단 사용자 대상 이의신청(Security Appeal) 공개 채널 — 이메일 인증·레이트리밋 포함
- 외부 위험 평가 모듈 / WAF·CDN 동기화를 위한 확장 인터페이스
- `LoginRequestContext`를 통한 전 과정 감사 로깅(IP, User-Agent, requestId, flowTraceId)

## 핵심 구현

### 1. 식별자 자동 판별 로그인과 세부 정책 게이트

로그인 진입점은 `AuthController.loginProcess`이며, 실제 검증은 `AuthServiceImpl.login(identifier, password, LoginRequestContext)`이 담당합니다. 입력값이 이메일 형식인지(`isValidEmailFormat`) 판별해 `EMAIL` / `ID` 로그인 방식을 결정하고, 이메일이면 `findByEmail`, 아이디면 `findByUserId`로 사용자를 조회합니다.

비밀번호 검증 전후로 여러 정책 게이트를 순차적으로 통과해야 합니다.

- **사전 위험 평가**: `loginRiskPolicyService.checkPreLogin(...)`이 해당 IP에 활성 로그인 잠금이 있으면 비밀번호 확인 이전에 즉시 거부합니다.
- **계정 상태**: `DELETED`는 즉시 거부, `EMAIL`로 로그인하는 경우 이메일 인증 여부(`isEmailVerified`)와 이메일 로그인 활성화 여부(`isEmailLoginEnabled`)를 확인합니다.
- **로그인 수단 가용성**: `isPasswordEnabled`가 false면(소셜 전용 계정) 비밀번호 로그인을 차단합니다.
- **비밀번호**: `bCryptPasswordEncoder.matches`로 검증하며, 실패 시 `handleWrongPassword`로 위험도 카운팅을 위임합니다.
- **잠금/휴면 처리**: `BLOCKED`이고 `blockedUntil`이 지났으면 만료된 차단을 자동 해제(`releaseExpiredMemberBlocks` → IP 룰까지 재계산)한 뒤 통과시키고, 아직 유효하면 `UsersVO`를 반환해 컨트롤러가 사유·해제시각을 응답합니다. `DORMANT`는 휴면 해제 플로우로 분기합니다.

모든 분기마다 `recordLoginResult(...)`를 호출해 성공·실패와 실패 사유 코드(`USER_NOT_FOUND`, `WRONG_PASSWORD`, `EMAIL_NOT_VERIFIED`, `ACCOUNT_BLOCKED` 등)를 `USER_LOGIN_HISTORY`에 남깁니다.

로그인 성공 시 컨트롤러는 세션에 `loginUser`(UsersVO)를 저장하고, 관리자 역할이면 `loadAdminPermissions`로 권한 코드 집합을 함께 적재합니다. `redirect` 파라미터는 `safeRedirect`로 외부 URL·`javascript:` 스킴을 제거해 **오픈 리다이렉트**를 방어합니다.

### 2. 소셜 OAuth 콜백 — 공통 변환 + state 위조 방지

세 소셜 제공자는 `handleKakaoCallback` / `handleNaverCallback` / `handleGoogleCallback`으로 진입합니다. 각 메서드는 (1) 인가 코드를 access token으로 교환하고, (2) 사용자 정보 JSON을 조회한 뒤, (3) 제공자별로 다른 JSON 구조(카카오 `id`/`kakao_account`, 네이버 `response`, 구글 `sub`)를 **공통 DTO `SocialUserInfo`로 변환**합니다. 이후 로직은 `processSocialLogin(SocialUserInfo, context)` 하나로 수렴하여 제공자 차이를 흡수합니다.

`processSocialLogin`은 `USER_SOCIAL` 테이블에서 (provider, providerUserId)로 기존 연동을 조회하여 분기합니다.

- **기존 연동 사용자** → 계정 상태 검증 후 `UsersVO` 반환(곧장 로그인)
- **신규 사용자** → `SocialTempVO` 반환 → `/auth/social/complete`로 보내 닉네임·국적·언어 추가 입력을 받음

컨트롤러의 `handleSocialCallback`은 이 반환 타입(`UsersVO` vs `SocialTempVO`)을 보고 후속 라우팅을 결정합니다. 네이버·구글은 콜백에서 `consumeOauthState`로 **CSRF/state 검증**을 수행하는데, 로그인용·연동용 state를 세션에 `{PROVIDER}_{LOGIN|LINK}_OAUTH_STATE` 키의 집합(Set)으로 보관해 동시 다중 시도를 허용하면서 1회용으로 소비합니다.

소셜 신규 가입(`completeSocialRegister`)은 이메일을 자동 신뢰하지 않습니다. 소셜에서 받은 이메일은 참고용일 뿐, 본인이 별도로 등록·인증해야 정식 로그인 수단이 됩니다(`getSocialEmailNotice`가 동일 이메일의 인증된 기존 계정 존재 시 연동을 권유). 로그아웃은 세션의 `currentSocialProvider`에 따라 제공자별 로그아웃 엔드포인트로 라우팅하며, 네이버·구글은 보관한 access token을 `revokeNaverAccessToken` / `revokeGoogleAccessToken`으로 폐기한 뒤 세션을 무효화합니다.

### 3. 이메일 인증과 액션 토큰 (아이디 찾기 / 비밀번호 재설정)

이메일 기반 작업은 `EMAIL_VERIFICATION_REQUEST`(요청 단위)와 `EMAIL_VERIFICATION`(토큰 단위) 두 테이블로 관리되며 `purpose`로 용도를 구분합니다(`FIND_ID`, `RESET_PW`, `PROFILE_EMAIL`, `VERIFY`).

발급 흐름(예: `sendResetPasswordEmail`)은 다음과 같습니다.

1. 사용자 조회 및 자격 검증(이메일 등록·인증 여부, 비밀번호 로그인 가능 여부, 복구 가능 상태인지)
2. 동일 용도의 기존 활성 요청·토큰 만료 처리(`cancelActiveEmailVerificationRequests`, `expireOldTokens`)
3. `UUID` 토큰 발급 + TTL 적용(용도별 프로퍼티 `auth.email.{용도}-token-ttl-minutes`, 기본 30분, 런타임 설정으로 조정 가능)
4. 요청·토큰 레코드 삽입 후 메일 발송
5. **메일 발송 실패 시 발급한 요청·토큰을 즉시 취소**(롤백)하여 무효 토큰이 남지 않게 함

검증 흐름(`verifyResetToken` → `resetPassword`)은 `findValidToken`으로 유효 토큰을 확인하고, 사용 즉시 `markTokenUsed`로 1회용 처리합니다. 비밀번호 재설정은 새 비밀번호를 BCrypt로 해싱해 저장합니다. **사용자 존재 여부를 응답으로 노출하지 않는 점**이 특징으로, 가입되지 않은 이메일이어도 "일치하는 계정이 있으면 안내를 보냈다"는 동일 메시지를 반환해 계정 열거(enumeration) 공격을 방어합니다. 아이디 찾기 결과는 `maskUserId`로 일부만 노출합니다.

마이페이지의 로그인 수단 변경(`saveLoginSettings`)은 "변경 후 사용 가능한 로그인 수단이 최소 하나 남아야 한다"는 불변식을 강제합니다. 아이디 로그인·이메일 로그인·소셜 연동이 모두 사라지는 저장은 거부하고, 마지막 로컬 수단이 제거되면 비밀번호도 자동 비활성화합니다.

### 4. 로그인 위험도 평가 (Login Risk)

위험도 로직은 `LoginRiskPolicyService`에 집중되어 있고, 임계값·관찰 기간·잠금 시간은 코드 상수가 아니라 `LOGIN_RISK_POLICY` 테이블의 정책 레코드(`policyCode`별)에서 읽습니다. 핵심 정책 코드는 다음과 같습니다.

- `ACCOUNT_PASSWORD_FAILURE_LOCK` — 계정 단위 비밀번호 실패 임계 도달 시 일시 잠금
- `ACCOUNT_REPEATED_LOCK_PROTECTION` — 반복 잠금 시 보호 조치 + 관리자 검토 생성
- `IP_FAILED_LOGIN_LOCK` — IP 단위 실패 누적 시 로그인 잠금
- `IP_SUSPICIOUS_LOGIN_REVIEW` — IP 단위 의심 활동 관리자 검토 큐 적재

비밀번호 실패 시 `handleWrongPassword`가 계정·IP 두 축을 동시에 평가합니다. 계정 평가(`evaluateAccountWrongPassword`)는 관찰 기간 내 실패 횟수가 임계값에 도달하면 `adminMapper.markMemberBlocked`로 일시 잠금하고, 남은 시도 횟수가 경고 구간에 들어오면 사용자에게 남은 횟수를 안내합니다. IP 평가(`evaluateIpWrongPassword`)는 실패 횟수와 **서로 다른 대상 아이디 수(distinct identifiers)**를 함께 보아, 무차별 대입(credential stuffing) 패턴을 IP 잠금으로 차단합니다. 임계 미달이라도 더 높은 임계를 넘으면 관리자 검토 큐(`LOGIN_RISK_REVIEW_QUEUE`)에 적재합니다.

위험 판단 결과는 `LoginRiskDecisionVO`로 표현되고, `applyContext`가 이를 `LoginRequestContext`의 `loginRiskMessage`·`remainingAttempts`·`loginRiskDenied`·`loginRiskReviewRequired`에 실어 컨트롤러가 JSON 응답으로 사용자에게 노출합니다. 모든 판단은 `insertRiskEvent`로 감사 이벤트를 남기고, 보호 조치 발동 시 사용자에게 이의신청 링크가 담긴 안내 메일을 발송합니다(`sendProtectionNoticeIfPossible`).

확장성 측면에서 AI/룰 기반 외부 위험 평가는 `LoginRiskAssessmentProvider` 인터페이스로 추상화되어 있습니다. 구현체를 Spring Bean으로 등록하면 `recordAssessmentCandidates`가 이를 자동 수집하며, 연결된 구현이 없으면 평가 후보를 `SECURITY_RISK_ASSESSMENT`에 `PENDING` 상태로 적재해 추후 처리할 수 있게 합니다.

### 5. 차단 이의신청과 WAF 동기화

차단된 사용자/IP는 공개 엔드포인트 `/security/appeal`(`SecurityAppealController`)로 이의신청을 제출합니다. 인증되지 않은 사용자도 접근하는 채널이므로 다단계 방어가 적용됩니다.

1. **이메일 인증 선행** — 제출 전 `requestPublicAppealEmailVerification`이 제출자 이메일로 검증 토큰(`SECURITY_ACTION_APPEAL_TOKEN`)을 발송하고, 토큰이 있어야 제출 가능
2. **레이트리밋** — 검증 메일 발송 횟수·시간 창, IP 일일 신청 한도, 거부 후 쿨다운, 최대 거부 횟수, 결과 조회 실패 횟수를 모두 `SECURITY_ACTION_APPEAL` 정책(`SecurityAppealPolicyVO`)으로 제어
3. **이메일 도메인 허용/차단 목록** — `*.example.com` 와일드카드 매칭 지원
4. **채널 상태** — 종결된 케이스의 재신청 차단, 동시 열린 신청 수 제한

관리자가 이의신청을 승인(`decideSecurityAppeal` → `ACCEPTED`)하면 대상 유형(USER/IP)에 따라 사용자 차단 해제·상태 복원 또는 IP 차단 해제를 수행하고, 블록 룰 캐시를 무효화·갱신합니다. 결과는 제출자 이메일과 사이트 알림으로 통지됩니다.

승인된 IP/CIDR 차단은 외부 보안 인프라와 동기화해야 하므로 `LOGIN_RISK_WAF_SYNC_QUEUE`에 적재되며, `WafSyncProvider` 구현체(Cloudflare/Nginx/AWS WAF 어댑터 등)가 `@Scheduled` 배치(`processWafSyncQueueOnce`)에서 큐를 소비합니다. 연결된 어댑터가 없으면 `EXTERNAL_PROVIDER_PENDING` 상태로 보존해, 외부 인프라 미연동 환경(포트폴리오/데모)에서도 파이프라인 구조 자체는 검증 가능합니다.

### 6. 감사 로깅 — LoginRequestContext

`LoginRequestContext`는 한 번의 요청에서 발생하는 인증/보안 이벤트를 일관되게 추적하기 위한 컨텍스트 객체입니다. `ipAddress`, `userAgent`, `requestId`, `flowTraceId`, `sessionId`, `requestUri` 등을 담아 서비스 계층 전반으로 전달됩니다.

- IP는 `getClientIp`가 `X-Forwarded-For` 등 프록시 헤더를 우선 고려해 추출합니다.
- `flowTraceId`는 메일 토큰을 통해 다른 요청으로 이어지는 흐름(예: 비밀번호 재설정 메일 클릭)에도 **동일 추적 ID**를 유지하도록 `resolveFlowTraceIdByToken`으로 연결합니다.
- 로그인/로그아웃 이벤트는 `recordHistory` → `USER_LOGIN_HISTORY`에, 아이디 찾기·비밀번호 재설정·이메일 변경 등 보안 이벤트는 `recordSecurityEvent` → `USER_SECURITY_HISTORY`에 분리 기록됩니다.
- 관리자 행위(정책 변경, 검토 결정, 차단 적용 등)는 별도 보안 감사 테이블에 변경 전/후 스냅샷(JSON)과 사유를 함께 남깁니다.

## 설계 결정과 트레이드오프

- **Spring Security 인증 대신 자체 세션 인증** — 자체 인증 시스템과 Spring Security 인증 메커니즘의 충돌, 팀원 담당 모듈에 대한 회귀 위험을 피하기 위한 선택입니다. 단, CSRF 보호는 필요하다고 판단해 Spring Security를 **CSRF 필터 전용 모드**로 부분 도입했습니다. `authorizeHttpRequests`는 전부 `permitAll`로 두어 인가는 자체 인터셉터/AOP가 담당하고, formLogin·httpBasic·logout은 비활성화했습니다. 일관성 결여(적용/미적용 영역 혼재)를 트레이드오프로 받아들이되 ADR에 점진적 확장 경로를 명시했습니다. ([ADR-0012](../docs/adr/0012-spring-security-csrf-partial-adoption.md))

- **선언적 권한 체크(AOP)와의 결합** — 컨트롤러마다 반복되던 권한 체크·예외→응답 변환 보일러플레이트를 커스텀 어노테이션(`@RequireLogin`/`@RequireAdmin`) + AOP + `@LoginUser` ArgumentResolver로 대체했습니다. 인증 모듈의 세션 기반 인증과 자연스럽게 맞물립니다. ([ADR-0011](../docs/adr/0011-authorization-aop-and-global-exception-handler.md))

- **위험 정책의 DB 외부화** — 실패 임계값·관찰 기간·잠금 시간을 코드 상수가 아닌 `LOGIN_RISK_POLICY` 레코드로 분리해 운영 중 무중단 조정이 가능합니다. 정책 변경은 이력 테이블에 스냅샷으로 남깁니다.

- **외부 연동의 인터페이스화 + Fail-safe** — AI 위험 평가(`LoginRiskAssessmentProvider`)와 WAF 동기화(`WafSyncProvider`)를 인터페이스로 추상화하고, 구현체 미연동 시에도 후보를 PENDING 상태로 보존합니다. 실제 외부 인프라 없이도 전체 파이프라인을 데모/검증할 수 있도록 한 설계입니다.

- **계정 열거 방어 vs 사용성** — 아이디 찾기·비밀번호 재설정에서 계정 존재 여부를 응답으로 구분하지 않습니다. 사용자에게는 다소 모호한 안내가 되는 대신, 이메일 보유 여부를 외부에서 탐지할 수 없게 했습니다.

- **메일 발송 실패 시 토큰 롤백** — 토큰을 먼저 발급하고 메일을 보내되, 발송 실패 시 발급분을 즉시 취소합니다. "발송되지 않은 유효 토큰"이라는 모순 상태를 차단하기 위한 보상 처리입니다.

## 데이터 모델 / 연동

| 테이블 | 역할 |
|---|---|
| `USERS` | 계정 본체. `account_status`(ACTIVE/BLOCKED/DORMANT/DELETED), `password_enabled`, `email_verified`, `email_login_enabled`, `blocked_until` 등 |
| `USER_SOCIAL` | 소셜 연동(provider, providerUserId)과 사용자 매핑 |
| `EMAIL_VERIFICATION_REQUEST` / `EMAIL_VERIFICATION` | 이메일 액션 토큰(요청 단위 / 토큰 단위, `purpose`로 용도 구분) |
| `USER_LOGIN_HISTORY` | 로그인/로그아웃 감사 로그(성공·실패·사유·IP·UA·flowTraceId) |
| `USER_SECURITY_HISTORY` | 아이디 찾기·비밀번호 재설정·이메일 변경 등 보안 이벤트 감사 |
| `LOGIN_RISK_POLICY` / `LOGIN_RISK_POLICY_HISTORY` | 위험 정책 정의 및 변경 이력 |
| `LOGIN_RISK_REVIEW_QUEUE` | 위험 활동 관리자 검토 큐 |
| `SECURITY_RISK_ASSESSMENT` | 외부/AI 위험 평가 결과 적재(미연동 시 PENDING) |
| `SECURITY_ACTION_APPEAL` / `SECURITY_ACTION_APPEAL_TOKEN` | 차단 이의신청 및 검증 토큰 |
| `LOGIN_RISK_WAF_SYNC_QUEUE` | 승인된 IP/CIDR 차단의 WAF 동기화 큐 |
| `SECURITY_ASSESSMENT_PROVIDER_CONFIG` / `_HISTORY` | 외부 평가 제공자 설정 및 헬스체크 이력 |

**외부 API**: 카카오(`kauth.kakao.com`, `kapi.kakao.com`), 네이버(`nid.naver.com`, `openapi.naver.com`), 구글(`oauth2.googleapis.com`, `googleapis.com/oauth2`)의 OAuth 2.0 토큰·사용자 정보·토큰 폐기 엔드포인트. 모든 클라이언트 자격증명·리다이렉트 URI는 프로퍼티 키(`oauth.{provider}.client-id` 등)로 외부화되어 있으며 런타임 설정으로 덮어쓸 수 있습니다.

## 사용 기술

- **언어/프레임워크**: Java 21, Spring Boot 4, Spring MVC
- **인증/보안**: 세션 기반 자체 인증(`loginUser`), `BCryptPasswordEncoder`, Spring Security(CSRF 필터 전용 부분 도입), 커스텀 AOP 권한 어노테이션
- **OAuth 2.0**: 카카오 / 네이버 / 구글, `RestTemplate` 기반 토큰 교환, Gson JSON 파싱
- **퍼시스턴스**: MyBatis(`AuthMapper`, `LoginRiskPolicyMapper`), MySQL
- **메일**: `JavaMailSender`(MIME HTML 메일)
- **비동기/배치**: `@Scheduled`(휴면 계정 처리, 제공자 헬스체크, WAF 동기화 큐 소비)
- **확장 포인트**: `LoginRiskAssessmentProvider`, `WafSyncProvider` 인터페이스
- **국제화**: `MessageSource` 기반 ko/en/ja/zh 메시지(위험 안내·메일 본문·이의신청 안내)
