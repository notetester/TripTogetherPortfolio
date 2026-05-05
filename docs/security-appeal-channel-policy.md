# TripTogether Security Appeal Channel Policy

## 목적

이의제기 채널은 고객 불만을 줄이기 위해 열어두되, 같은 차단 건에 대한 무제한 접수·조회·인증 메일 발송은 제한한다.

## 정책 저장소

이번 보강 이후 이의제기 채널 정책의 기준 테이블은 `SECURITY_APPEAL_POLICY`다.  
기존 `LOGIN_RISK_POLICY`의 `SECURITY_APPEAL_COOLDOWN` / `SECURITY_APPEAL_RATE_LIMIT` row는 초기 seed 승계용/레거시 호환용으로만 남기고, 실제 이의제기 채널 정책 판단은 전용 테이블을 우선 사용한다.

## 관리자 UI

```text
/admin/login-risk/appeal-policy
```

관리자는 위 화면에서 다음 값을 직접 수정한다.

| Field | Meaning | Default |
|---|---|---:|
| is_active | 이의제기 채널 정책 활성 여부 | 1 |
| allow_multiple_open_appeals | 동일 건 복수 PENDING/HOLD 접수 허용 | 1 |
| max_open_appeals_per_case | 동일 차단 건 동시 PENDING/HOLD 접수 허용 수 | 3 |
| closed_blocks_new_appeals | CLOSED 처리 후 추가 접수 차단 | 1 |
| rejected_cooldown_minutes | REJECTED 후 재접수 제한 시간 | 10080 |
| max_rejected_count | 동일 조치 최대 REJECTED 허용 횟수 | 2 |
| ip_daily_appeal_limit | 동일 IP 대상 일일 접수 제한 | 3 |
| verification_window_minutes | 인증 메일 rate-limit 관찰 시간 | 60 |
| max_verification_emails | 동일 requestId + email 인증 링크 발송 한도 | 3 |
| verification_token_ttl_minutes | 이메일 인증 링크 TTL | 30 |
| result_lookup_window_minutes | 결과 조회 실패 rate-limit 관찰 시간 | 60 |
| max_result_lookup_failures | publicRequestId 결과 조회 실패 한도 | 5 |
| result_lookup_retention_days | 비로그인 결과 조회 가능 기간 | 365 |
| allowed_email_domains | 허용 이메일 도메인 CSV. 비어 있으면 전체 허용 | NULL |
| blocked_email_domains | 차단 이메일 도메인 CSV | NULL |
| captcha_enabled | CAPTCHA/Turnstile 사용 준비 토글 | 0 |
| captcha_provider_code | CAPTCHA Provider 코드 | MOCK_TURNSTILE |

## 종결 정책

관리자가 이의제기 건을 `CLOSED`로 처리하면 같은 차단 접근 건에 대한 새 인증 링크/접수를 막는다.

```text
appeal_status = CLOSED
→ same target_type + target_key + block_access_request_id
→ further verification/appeal blocked
```

단, `closed_blocks_new_appeals = 0`으로 두면 CLOSED가 있어도 추가 접수를 허용할 수 있다.

## 동일 공용 IP 다중 접수

공용 IP 차단처럼 여러 사용자가 같은 차단 건에 걸릴 수 있는 경우를 고려해 기본값은 3건까지 PENDING/HOLD를 허용한다.  
`allow_multiple_open_appeals = 0`이면 동일 건 1건만 허용한다.

## 결과 조회 실패 제한

비로그인 결과 조회는 `publicRequestId + verified email`이 모두 일치해야 한다.  
실패 시 `SECURITY_ACTION_AUDIT`에 `SECURITY_APPEAL_RESULT_LOOKUP_FAILED`를 남기고, 같은 publicRequestId에 대한 실패가 정책 한도를 넘으면 일시 제한한다.

## 인증 링크 발송 제한

`SECURITY_ACTION_APPEAL_TOKEN`을 기준으로 같은 requestId + email 조합의 발송 횟수를 제한한다.

## CAPTCHA/Turnstile

이번 작업은 실제 Cloudflare/Turnstile API를 호출하지 않는다.  
다만 관리자 UI와 정책 테이블에 `captcha_enabled`, `captcha_provider_code`를 두어 운영 전 Provider 연결 시 바로 이어 붙일 수 있게 했다.
