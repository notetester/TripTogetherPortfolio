# TripTogether Remaining Work Audit

## 점검 기준

- `TripTogether(35).zip`
- `TripTogetherDB(61).sql`
- 기존 `docs/security-governance-worklist.md`
- 기존 통합 정책 이력/런타임 설정 문서

## 이번에 추가 처리한 항목

| Area | Result |
|---|---|
| Provider 설정 상세 화면 | `/admin/login-risk/provider-configs`에 상세 모달 추가 |
| Provider 설정 이력 연결 | Provider 카드에서 `/admin/policy-history?sourceType=PROVIDER_CONFIG`로 바로 이동 |
| WAF 동기화 상세 화면 | `/admin/login-risk/waf-sync`에 상세 모달 추가 |
| WAF 재시도 판단 보조 | 상태/대상/source/detailMessage/시간 정보를 모달로 확인 후 retry 가능 |
| 보안 검토 큐 상세 모달 | 실제 상세 모달 markup 보강, 바깥 클릭 닫기 추가 |
| i18n/XSS | 신규 문구 4언어 추가, 사용자/외부 입력값 `c:out` 출력 |

## 현재 남은 작업 분류

### 외부 의존 작업

아래 작업은 실제 계약/API key/운영 인프라 정보가 있어야 완성 가능하다.

- 실제 운영 AI Gateway/정책기관 Gateway endpoint 확정
- 운영 AI/정책기관 API별 실제 응답 스키마 매핑 확정
- AWS Secrets Manager/Parameter Store 실제 연동 검증
- CAPTCHA/Turnstile 실제 Provider 연동
- Cloudflare/AWS WAF 실제 Provider 통합 테스트

### 수동 검증 작업

현재 코드 산출물로는 자동 확인했지만, 실제 애플리케이션 실행 환경에서 확인해야 하는 항목이다.

- `mvn -DskipTests compile`
- 4언어 화면 스모크 테스트
- 보안 이의제기 requestId/token 경로 수동 테스트
- 관리자 검토 승인/보류/미승인 상태 전이 테스트
- USER/IP 차단 해제 후 캐시 갱신 테스트
- WAF 동기화 큐 retry 테스트

### 후속 개선 후보

- 초기설정 export/import 화면: Runtime Setting, Provider Config, System Policy, Login Risk Policy, Appeal Policy를 묶어 백업/복원
- 정책 snapshot diff UI: 현재는 before/after JSON 원문 표시, 후속으로 key 단위 diff 표시 가능
- Provider health check 상세 이력 테이블: 현재는 provider config history와 audit 중심, 헬스체크 전용 history가 필요하면 별도 테이블 검토
- 보안 도메인 외 관리자 조치 로그 reason_code 전환: 문의/신고/기업승인까지 단계적 확대 가능

## 판단

코드로 바로 처리 가능한 UI/이력/정책 설정 보강은 이번 단계에서 대부분 마무리되었다.  
남은 것은 운영 외부 연동값 확정, 실제 실행 환경 검증, 그리고 편의성 중심의 후속 고도화다.
