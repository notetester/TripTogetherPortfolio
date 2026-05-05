# TripTogether Application Runtime Settings

## 목적

`APPLICATION_RUNTIME_SETTING`은 properties/env 성격의 설정값을 DB에서 우선 관리하기 위한 전용 테이블이다.  
운영 정책 담당자는 관리자 UI에서 우선값을 직접 입력할 수 있고, 값이 비어 있으면 fallback 또는 기존 properties 값을 사용한다.

## 관리자 UI

```text
/admin/runtime-settings
```

## 동작 우선순위

```text
1. APPLICATION_RUNTIME_SETTING.setting_value
2. APPLICATION_RUNTIME_SETTING.fallback_value
3. 코드에 주입된 properties/@Value 값
4. 코드 default
```

DB 테이블이 아직 없거나 조회 중 오류가 발생해도 인증/차단 흐름이 즉시 깨지지 않도록 fallback을 유지한다.

## 관리 대상 1차 범위

| Group | Key Examples |
|---|---|
| APP | `app.base-url`, `app.public-base-url` |
| MAIL | `spring.mail.username` |
| AUTH_EMAIL | `auth.email.find-id-token-ttl-minutes`, `auth.email.reset-password-token-ttl-minutes`, `auth.email.profile-email-token-ttl-minutes` |
| AUTH_ACCOUNT | `auth.dormant.inactive-days` |
| SECURITY | `security.block.cache.file` |
| OAUTH_KAKAO | `oauth.kakao.client-id`, `oauth.kakao.redirect-uri`, `oauth.kakao.logout-redirect-uri` |
| OAUTH_NAVER | `oauth.naver.client-id`, `oauth.naver.redirect-uri`, `oauth.naver.logout-redirect-uri` |
| OAUTH_GOOGLE | `oauth.google.client-id`, `oauth.google.redirect-uri`, `oauth.google.logout-redirect-uri` |

## 변경 이력

`APPLICATION_RUNTIME_SETTING_HISTORY`는 설정별 버전 번호와 변경 전/후 스냅샷을 저장한다.

## 보안 운영

민감값은 `is_secret = 1`로 표시한다.  
이번 구현은 정책 담당자에게 DB 입력 권한을 제공하는 것이 목적이며, 실제 접근 통제/마스킹 강도는 관리자 권한 체계에서 별도로 잠글 수 있다.
