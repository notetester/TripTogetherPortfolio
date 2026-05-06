# TripTogether Code-Only Remaining Work Closure Audit

## 기준

- `TripTogether(36).zip`
- `TripTogetherDB(62).sql`
- 외부 endpoint/key/계약 정보가 필요한 작업과 실제 실행 환경 수동 검증은 제외

## 이번에 코드로 완료한 항목

| 후보 | 처리 |
|---|---|
| 초기설정 export/import 화면 | `/admin/initial-settings` 추가 |
| 정책 snapshot diff UI | `/admin/policy-history`의 before/after JSON에 key 단위 diff 버튼 추가 |
| Provider health check 전용 이력 | `SECURITY_PROVIDER_HEALTH_CHECK_HISTORY`, `/admin/login-risk/provider-health-history` 추가 |
| Provider health check 저장 | 수동 점검과 스케줄러 점검 모두 이력 저장 |
| 설정 이관 기준 | PK가 아니라 `settingKey`, `providerCode`, `policyCode` 기준으로 import |
| i18n/XSS | 신규 화면 문구 4언어 추가, 사용자/외부 입력값 escape 유지 |

## 초기설정 export/import 포함 범위

- `APPLICATION_RUNTIME_SETTING`
- `SECURITY_ASSESSMENT_PROVIDER_CONFIG`
- `LOGIN_RISK_POLICY`
- `SECURITY_APPEAL_POLICY`
- `SYSTEM_POLICY`

## 아직 제외되는 것

### 외부 의존

- 실제 운영 AI Gateway/정책기관 Gateway endpoint 확정
- 실제 AI/정책기관 API별 응답 스키마 매핑 확정
- 실제 AWS Secrets Manager/Parameter Store 연결 검증
- 실제 CAPTCHA/Turnstile Provider 연결
- 실제 Cloudflare/AWS WAF 통합 테스트

### 수동 검증

- `mvn -DskipTests compile`
- 4언어 화면 스모크 테스트
- 보안 이의제기 requestId/token 경로 테스트
- 관리자 검토 승인/보류/미승인 상태 전이 테스트
- USER/IP 차단 해제 후 캐시 갱신 테스트
- WAF 동기화 큐 retry 테스트

## 보안 도메인 외 reason_code 전환 판단

보안 외 관리자 조치 로그의 reason_code 전환은 단일 기능이 아니라 문의/신고/기업승인/광고/패키지/환불/커뮤니티 등 전체 운영 도메인에 걸친 작업이다.  
이번 범위에서는 보안/정책 거버넌스 축의 코드 작업을 모두 닫고, 보안 외 도메인은 각 도메인의 기존 감사 테이블과 UI 문구 체계가 정리된 뒤 도메인별로 적용하는 것이 안전하다.

## 결론

외부 의존 작업과 수동 검증을 제외하면, 보안 거버넌스/정책 설정/Provider 운영과 직접 연결되는 코드 작업은 이번 단계에서 마무리되었다.
