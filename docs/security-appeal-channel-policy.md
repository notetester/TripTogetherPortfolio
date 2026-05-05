# TripTogether Security Appeal Channel Policy

## 목적

이의제기 채널은 고객 불만을 줄이기 위해 열어두되, 같은 차단 건에 대한 무제한 접수·조회·인증 메일 발송은 제한한다.

## 정책 구성

### SECURITY_APPEAL_COOLDOWN

기존 반려/재접수 정책이다.

| Field | Meaning |
|---|---|
| observation_minutes | REJECTED 후 재접수 제한 시간 |
| threshold_count | 동일 조치 최대 REJECTED 허용 횟수 |
| distinct_account_threshold | 동일 IP 대상 일일 접수 제한 |

### SECURITY_APPEAL_RATE_LIMIT

이번에 추가한 채널/rate-limit 정책이다.

| Field | Meaning | Default |
|---|---|---:|
| observation_minutes | rate-limit 관찰 시간(분) | 60 |
| threshold_count | 동일 requestId + email 인증 링크 발송 한도 | 3 |
| distinct_account_threshold | publicRequestId 결과 조회 실패 한도 | 5 |
| lock_duration_minutes | 이메일 인증 링크 TTL(분) | 30 |
| warning_before_count | 동일 건 동시 PENDING/HOLD 접수 허용 수 | 3 |

## 종결 정책

관리자가 이의제기 건을 `CLOSED`로 처리하면 같은 차단 접근 건에 대한 새 인증 링크/접수를 막는다.

```text
appeal_status = CLOSED
→ same target_type + target_key + block_access_request_id
→ further verification/appeal blocked
```

## 동일 공용 IP 다중 접수

공용 IP 차단처럼 여러 사용자가 같은 차단 건에 걸릴 수 있는 경우를 고려해 기본값은 3건까지 PENDING/HOLD를 허용한다.  
관리자가 `SECURITY_APPEAL_RATE_LIMIT.warning_before_count`를 1로 낮추면 기존처럼 1건만 허용하는 정책이 된다.

## 결과 조회 실패 제한

비로그인 결과 조회는 `publicRequestId + verified email`이 모두 일치해야 한다.  
실패 시 `SECURITY_ACTION_AUDIT`에 `SECURITY_APPEAL_RESULT_LOOKUP_FAILED`를 남기고, 같은 publicRequestId에 대한 실패가 정책 한도를 넘으면 일시 제한한다.

## 인증 링크 발송 제한

`SECURITY_ACTION_APPEAL_TOKEN`을 기준으로 같은 requestId + email 조합의 발송 횟수를 제한한다.  
기본은 60분에 3회다.
