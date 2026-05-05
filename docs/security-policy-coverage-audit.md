# TripTogether Security / Runtime Policy Coverage Audit

## 이번 점검 기준

프로젝트 소유자 결정에 따라 properties/env 성격의 설정도 DB 설정을 우선 사용할 수 있게 한다.  
위험 여부를 코드에서 임의로 제한하지 않고, 정책 담당자가 관리자 UI에서 값을 잠그거나 수정할 수 있는 선택권을 제공한다.

## 이번에 DB 우선 설정으로 연결한 값

| Area | Before | After |
|---|---|---|
| 메일 발신자 | `spring.mail.username` properties 직접 사용 | `APPLICATION_RUNTIME_SETTING.spring.mail.username` 우선 |
| 앱 기준 URL | `app.base-url` properties 직접 사용 | `APPLICATION_RUNTIME_SETTING.app.base-url` 우선 |
| 공개 기준 URL | `app.public-base-url` properties 직접 사용 | `APPLICATION_RUNTIME_SETTING.app.public-base-url` 우선 |
| OAuth Kakao/Naver/Google client/secret/redirect/logout | `@Value` properties 직접 사용 | `APPLICATION_RUNTIME_SETTING.oauth.*` 우선 |
| 차단 캐시 파일 경로 | `security.block.cache.file` properties 직접 사용 | `APPLICATION_RUNTIME_SETTING.security.block.cache.file` 우선 |
| 아이디 찾기 토큰 TTL | 코드 `30분` | `APPLICATION_RUNTIME_SETTING.auth.email.find-id-token-ttl-minutes` |
| 비밀번호 재설정 토큰 TTL | 코드 `30분` | `APPLICATION_RUNTIME_SETTING.auth.email.reset-password-token-ttl-minutes` |
| 프로필 이메일 인증 토큰 TTL | 코드 `30분` | `APPLICATION_RUNTIME_SETTING.auth.email.profile-email-token-ttl-minutes` |
| 휴면 기본 기준일 | 코드 `365일` | `APPLICATION_RUNTIME_SETTING.auth.dormant.inactive-days` |

## fallback 원칙

```text
DB setting_value
→ DB fallback_value
→ properties/@Value
→ code default
```

설정 row가 없거나 테이블이 아직 생성되지 않았더라도 서비스가 바로 죽지 않도록 fallback을 유지한다.

## 관리자 UI

```text
/admin/runtime-settings
```

## 남은 후보

| Area | 상태 |
|---|---|
| 실제 Cloudflare/Turnstile API 키 | Provider 설정/Runtime Setting 양쪽에서 관리 가능. 실제 운영 전 선택 필요 |
| 외부 AI/정책기관 endpoint | 기존 Provider 설정 UI가 우선 담당 |
| 관리자 권한별 설정 잠금 | `is_editable`, `is_secret`, 관리자 권한 체계로 추가 고도화 가능 |
| 초기설정 export/import | 후속 작업 후보. Runtime Setting, Provider Config, Security Appeal Policy, Login Risk Policy를 묶는 방식 권장 |
