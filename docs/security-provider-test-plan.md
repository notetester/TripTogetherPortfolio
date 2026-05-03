# Security Provider / WAF Test Plan

이 문서는 실제 API 키를 넣기 전후에 확인할 테스트 항목입니다.  
DB 구조 변경 없이 코드/설정/운영 플로우를 검증하기 위한 체크리스트입니다.

## 1. Provider 설정 테스트

| Case | Setting | Expected |
|---|---|---|
| Disabled Provider | `is_enabled = 0` | status = DISABLED |
| Enabled, no endpoint | `is_enabled = 1`, `endpoint_url` empty | status = READY, no external call |
| Enabled, endpoint set, no secret | endpoint present, missing ENV value | fail-open/fail-closed policy according to provider |
| Enabled, endpoint set, secret resolved | endpoint + `ENV:*` exists | HTTP call attempted |

## 2. AI / Policy Provider 테스트

| Case | Response | Expected |
|---|---|---|
| 2xx valid JSON | riskScore/riskLevel included | `LoginRiskAssessmentResult` created |
| 2xx partial JSON | missing optional fields | fallback values applied |
| 4xx/5xx + fail_open | non-2xx | no blocking result, continue internally |
| 4xx/5xx + fail_closed | non-2xx | REVIEW result generated |
| timeout + fail_open | timeout | no blocking result |
| timeout + fail_closed | timeout | REVIEW result generated |

## 3. WAF/CDN Provider 테스트

| Case | Response | Expected Queue Status |
|---|---|---|
| no enabled provider | none | EXTERNAL_PROVIDER_PENDING |
| 2xx | success | SYNCED |
| 4xx/5xx + fail_open | failure | EXTERNAL_PROVIDER_PENDING |
| 4xx/5xx + fail_closed | failure | FAILED |
| manual retry | admin click | status = PENDING, worker processes again |

## 4. 이의제기 테스트

| Case | Expected |
|---|---|
| token link valid | form opens |
| token expired/used | error displayed |
| requestId valid | form opens from block log |
| duplicate PENDING/HOLD exists | duplicate error displayed |
| accepted | USER/IP block released, email + site notification sent |
| rejected | action remains, result notification sent |
| hold | no release, result notification sent |

## 5. i18n/XSS 테스트

- `ko/en/ja/zh` 언어팩 키 누락이 없어야 한다.
- 공개 이의제기 화면에 직접 하드코딩 문구가 없어야 한다.
- 관리자 화면에서 사용자 입력값은 `c:out` 또는 동등한 escaping으로 출력되어야 한다.
