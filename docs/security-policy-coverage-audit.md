# TripTogether Security Policy Coverage Audit

## 이번 점검 기준

- 관리자 UI에서 수정해야 하는 정책값이 코드 상수로 남아 있는지 확인했다.
- 보안 이의제기 흐름과 직접 연결되는 값은 `SECURITY_APPEAL_POLICY`로 끌어올렸다.
- 일반 인증/메일/OAuth 환경값은 별도 도메인으로 분류했다.

## 이번에 추가 정책화한 값

| Value | Before | After |
|---|---|---|
| 보호조치 안내 메일의 이의제기 링크 TTL | `plusDays(7)` | `SECURITY_APPEAL_POLICY.protected_appeal_token_ttl_days` |
| 이의제기 정책 변경 이력 | 감사 로그 일부 | `SECURITY_APPEAL_POLICY_HISTORY` 버전 이력 |
| 이의제기 상세 확인 | 목록 일부 텍스트 | 관리자 상세 모달 |

## 이미 관리자 UI에서 수정 가능한 보안 정책

| Area | UI |
|---|---|
| 로그인 위험 정책 | `/admin/login-risk/policies` |
| 보안 이의제기 채널 정책 | `/admin/login-risk/appeal-policy` |
| Provider 설정 | `/admin/login-risk/provider-configs` |
| 관리자 알림 설정 | `/admin/login-risk/notification-preferences` |
| WAF 큐 재시도 | `/admin/login-risk/waf-queue` |
| 정책 피드 업로드/API | `/admin/blocks` |

## 남아 있는 고정값 후보

| File / Area | Current | 판단 |
|---|---|---|
| `AuthServiceImpl` 이메일 인증/복구 토큰 TTL | 30분 | 일반 인증 정책. 별도 `AUTH_EMAIL_TOKEN_POLICY` 또는 기존 이메일 토큰 정책 UI로 분리 가능 |
| `AuthServiceImpl.processDormantAccounts(365)` | 365일 | 이미 `AdminPolicyServiceImpl`의 시스템 정책 configJson에서 `inactiveDays`로 실행 가능 |
| OAuth redirect/client 설정 | `@Value` properties | 정책이라기보다 환경/Secret 설정. 관리자 UI 저장보다는 ENV/설정 파일 유지 권장 |
| `BlockRuleCacheService.security.block.cache.file` | properties | 운영 환경 설정. 정책 테이블보다 properties 유지가 적절 |
| `INTERNAL_AI_GATEWAY` / `MOCK_WAF_SERVICE` | provider_code 상수 | 시연용 Provider 식별자. 실제 정책값이 아니라 Adapter 라우팅 키 |

## 후속 권장

- 일반 인증 메일 토큰 TTL도 UI에서 관리하려면 `AUTH_EMAIL_TOKEN_POLICY` 또는 `EMAIL_ACTION_POLICY` 전용 테이블을 별도로 만든다.
- 시스템 정책 configJson은 이미 이력 테이블을 갖고 있으므로, 초기설정관리 화면을 만들 때 `AdminSystemPolicy`와 `SECURITY_APPEAL_POLICY`를 함께 export/import 대상으로 묶는다.
