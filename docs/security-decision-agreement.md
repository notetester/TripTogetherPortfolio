# TripTogether 보안 거버넌스 결정 합의안 반영 기록

이 문서는 `docs/security-pending-decisions.md`의 질문에 대한 프로젝트 소유자 결정 사항을 반영한 실행 기준입니다.

## 확정 사항

| 질문 | 결정 | 반영 방향 |
|---|---|---|
| Q1 | 현재 `INTERNAL_AI_GATEWAY` Stub, 향후 사내 AI Gateway | Stub Adapter 우선, fail-open=1, timeout=3000 |
| Q2 | `MANUAL_UPLOAD_FEED` CSV/JSON 수동 업로드 | 기존 IP 배치/규칙으로 업로드 반영 |
| Q3 | 런칭 전 WAF 비활성 + Mock, 향후 Gateway + Direct | `MOCK_WAF_SERVICE` 우선 활성 |
| Q4 | Cloudflare 사용 예정, IP/COUNTRY, 비동기 큐 | Direct/Gateway Adapter 유지, 실제 Provider는 비활성 |
| Q5 | AWS WAF 사용 예정, REGIONAL, IAM Role | AWS WAF SDK Adapter 유지, 실제 Provider는 비활성 |
| Q6 | Nginx 직접 제어 안 함 | Nginx Direct는 비활성/후순위, Cloudflare/AWS 중심 |
| Q7 | 운영 AWS Secrets Manager/Parameter Store, 시연은 properties/UI | 실제 키 DB 저장 금지 원칙 유지 |
| Q8 | AI/Policy fail-open, WAF fail-closed/DLQ | Provider 설정 seed에 반영 |
| Q9 | 내부 Gateway가 표준 DTO로 변환 | 표준 DTO 계약 유지 |
| Q10 | 관리자 조치 로그까지 reason_code 확대 | 보안 도메인 우선 완료, 타 관리자 조치 로그는 후속 |
| Q11 | 평가 테이블 둘 다 유지 | 로그인 전용/범용 보안 평가 역할 분리 |
| Q12 | PENDING/HOLD 중복 차단, REJECTED 7일 후 1회, 2회 거절 시 종결 | 제출 정책 검증 로직 반영 |
| Q13 | 즉시/요약 알림 이원화 | 후속 알림 고도화 기준으로 반영 |
| Q14 | 키 발급 전 Mock E2E 우선 | Provider 설정 → WAF 큐 → Mock 동기화 흐름 우선 |

## 이번 반영

- `INTERNAL_AI_GATEWAY` Stub Adapter 추가
- `MOCK_WAF_SERVICE` WAF Adapter 추가
- `MANUAL_UPLOAD_FEED` CSV/JSON 업로드 API/UI 추가
- 이의제기 쿨타임/영구 종결/일일 제한 정책 추가
- Provider seed SQL 추가
- 작업 목록과 테스트 계획 갱신

## 후속 구현 기준

- 실제 외부 WAF Provider는 운영 키/endpoint가 확정되기 전까지 비활성 유지
- WAF Provider는 Gateway + Direct 구조를 유지하되, 개발/시연은 Mock Provider로 검증
- 정책기관 피드는 우선 CSV/JSON 업로드로 등록하고, 외부 계약/API가 확정되면 Provider Adapter로 확장
- 일반 사용자 활동 로그는 reason_code 전환 대상에서 제외
- 관리자 조치 로그는 신고/문의/기업승인부터 점진 확대


## 추가 반영

- 정책 피드 수신은 CSV/JSON 파일 업로드뿐 아니라 `/admin/blocks/policy-feed/api` JSON 계약도 지원한다.
- TripTogether가 외부 기관에 제안할 수 있는 표준 payload는 `docs/security-policy-feed-api-contract.md`에 문서화한다.
- 이의제기 제한 정책은 `SECURITY_APPEAL_COOLDOWN` 정책 row로 관리하며, 관리자 정책 화면에서 수정한다.
- 이의제기 결과 사이트 내 알림은 ACCEPTED 또는 ACTIVE 계정에 한해 남긴다.



## 이의제기 이메일 인증 흐름 추가 결정

- IP 차단/비로그인/인증 이메일이 없는 사용자 차단은 로그인 기반 신원 확인이 어렵기 때문에 이메일 소유권 검증을 선행한다.
- 공개 항의용 이메일 주소를 노출하지 않는다.
- 사용자가 임의로 입력한 이메일로 곧바로 CS 티켓을 만들지 않는다.
- 인증 링크를 클릭한 이메일에 한해 이의제기 본문 제출을 허용한다.
- 처리 결과는 이메일과 `publicRequestId + 인증 이메일` 기반 비로그인 조회로 확인한다.


## 이의제기 채널 정책 추가 결정

- 같은 차단 건에 대한 이의제기는 무제한 허용하지 않는다.
- 관리자는 이의제기 건을 `CLOSED`로 종결할 수 있고, 동일 차단 건의 추가 접수는 막는다.
- 공용 IP 차단을 고려해 동일 건 다중 접수 허용 수는 정책값으로 둔다.
- 결과 조회 실패와 인증 링크 발송도 정책값으로 rate-limit한다.
- CAPTCHA/Turnstile 연동은 이번 범위에서 제외하고, 운영 전 별도 Provider로 붙인다.


## 이의제기 정책 전용 테이블 추가 결정

- 기존 `LOGIN_RISK_POLICY`의 범용 숫자 필드에 이의제기 채널 정책을 계속 얹지 않는다.
- `SECURITY_APPEAL_POLICY`를 전용 정책 테이블로 두고, 관리자 UI에서 명시적 필드명으로 수정한다.
- 기존 `SECURITY_APPEAL_COOLDOWN` / `SECURITY_APPEAL_RATE_LIMIT` row는 초기 seed 승계용/레거시 호환용으로만 유지한다.
- 실제 Cloudflare/Turnstile API 연동은 제외하되, 시연용 정책 토글과 Provider 코드는 보관한다.


## 정책 변경 이력/초기설정관리 추가 결정

- 보안 이의제기 정책은 `SECURITY_APPEAL_POLICY_HISTORY`로 버전 이력을 남긴다.
- 보호조치 안내 메일의 이의제기 링크 TTL도 `SECURITY_APPEAL_POLICY`에 포함한다.
- 모든 설정을 무조건 DB 정책화하지 않고, 환경/Secret 값은 별도 설정 체계를 유지한다.
- 향후 초기설정관리 화면은 Provider 설정, 로그인 위험 정책, 보안 이의제기 정책, 시스템 정책 configJson을 묶어 export/import하는 방향으로 확장한다.
