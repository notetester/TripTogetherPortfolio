# Security Review State Transitions

## SECURITY_REVIEW_QUEUE

| Action | review_status | SECURITY_RISK_ASSESSMENT.decision_status |
|---|---|---|
| approve | APPROVED | APPLIED |
| reject | REJECTED | IGNORED |
| hold | HOLD | PENDING |

## SECURITY_ACTION_APPEAL

| Action | appeal_status | Follow-up |
|---|---|---|
| accept | ACCEPTED | USER/IP 차단 해제, 사용자 상태 복구, assessment REVERSED |
| reject | REJECTED | 조치 유지 |
| hold | HOLD | 추가 검토 |

## LOGIN_RISK_WAF_SYNC_QUEUE

| Status | Meaning |
|---|---|
| PENDING | 내부 큐 대기 |
| EXTERNAL_PROVIDER_PENDING | 외부 WAF/CDN Provider 연결 또는 응답 대기 |
| SYNCED | 외부 앞단 동기화 완료 |
| FAILED | 외부 동기화 실패. 관리자 재시도 필요 |
