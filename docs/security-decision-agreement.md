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
