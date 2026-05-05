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


## 6. Adapter 라우팅 테스트

| Case | Provider Code / Kind | Expected |
|---|---|---|
| Generic AI | `GENERIC_AI_RISK_HTTP` / `AI_MODEL` | `GenericAiRiskAssessmentAdapter` 사용 |
| Policy Authority | `GENERIC_POLICY_AUTHORITY_HTTP` / `POLICY_AUTHORITY` | `GenericPolicyAuthorityAssessmentAdapter` 사용 |
| Generic WAF | `GENERIC_WAF_HTTP` / `WAF_CDN` | `GenericWafCdnHttpAdapter` 사용 |
| Cloudflare Gateway | `CLOUDFLARE_*` / `WAF_CDN` | `CloudflareWafGatewayAdapter` 사용 |
| AWS WAF Gateway | `AWS_WAF_*` / `WAF_CDN` | `AwsWafGatewayAdapter` 사용 |

## 7. WAF 실패 사유 표시 테스트

| Case | Expected |
|---|---|
| HTTP 4xx | detailMessage에 providerCode, providerKind, HTTP status, failOpen, reason 표시 |
| HTTP 5xx | detailMessage에 providerCode, providerKind, HTTP status, failOpen, reason 표시 |
| Timeout | detailMessage에 exception class, failOpen, reason 표시 |
| Manual retry | status가 PENDING으로 바뀌고 기존 상세 메시지보다 재시도 요청 사유가 표시 |


## 8. Security Review Detail Modal 테스트

| Case | Expected |
|---|---|
| detail button click | 상세 모달이 열린다 |
| outside click | 모달이 닫힌다 |
| Escape key | 열린 모달이 닫힌다 |
| user input fields | summary/detail/reviewComment/userId/nickname 등이 escape 처리되어 출력된다 |
| processed review | reviewedBy/reviewedAt/reviewComment가 상세 모달에 표시된다 |


## 9. Defense in Depth WAF 테스트

| Case | Expected |
|---|---|
| Gateway only enabled | Gateway Provider만 실행되고 결과가 큐에 반영된다 |
| Direct only enabled | Direct Provider만 실행되고 결과가 큐에 반영된다 |
| Gateway + Direct both enabled | 두 Provider가 모두 실행되고 detailMessage에 결과가 모두 남는다 |
| one SYNCED, one FAILED | 최종 status = FAILED |
| one SYNCED, one EXTERNAL_PROVIDER_PENDING | 최종 status = EXTERNAL_PROVIDER_PENDING |
| all SYNCED | 최종 status = SYNCED |

## 10. Direct Provider 테스트

| Case | Expected |
|---|---|
| Cloudflare Direct with endpoint/token | Cloudflare 직접 API URL로 HTTP 호출 |
| AWS WAF SDK with valid modelName | Wafv2Client가 GetIPSet → UpdateIPSet 실행 |
| AWS WAF SDK missing ipSetId/ipSetName | FAILED, MISSING_CONFIG 상세 메시지 |
| AWS WAF SDK IP target | IPv4는 /32, IPv6는 /128로 정규화 |
| Nginx Direct with endpoint/token | Nginx 관리 API로 HTTP 호출 |


## 11. 결정안 기반 Mock E2E 테스트

| Case | Expected |
|---|---|
| INTERNAL_AI_GATEWAY enabled | 외부 HTTP 호출 없이 PASS/LOW Stub 평가가 반환된다 |
| MOCK_WAF_SERVICE enabled | WAF 큐 항목이 외부 호출 없이 SYNCED 처리된다 |
| 실제 WAF Provider disabled | Cloudflare/AWS/Nginx Provider가 호출되지 않는다 |
| Provider 설정 화면 연결 테스트 | 관리자 화면에서 Provider 저장/점검이 가능하다 |
| WAF 큐 적재 후 worker 실행 | Mock 결과가 detailMessage에 기록된다 |

## 12. MANUAL_UPLOAD_FEED 테스트

| Case | Expected |
|---|---|
| CSV header: matchType,targetValue,reason | 기존 IP 배치와 규칙이 생성된다 |
| JSON array upload | 기존 IP 배치와 규칙이 생성된다 |
| COUNTRY row | COUNTRY matchType 규칙이 생성된다 |
| CIDR row | CIDR matchType 규칙이 생성된다 |
| invalid row | skipped 목록에 실패 사유가 남는다 |

## 13. Appeal Cooldown 테스트

| Case | Expected |
|---|---|
| PENDING/HOLD duplicate | 접수 차단 |
| REJECTED within 168h | 접수 차단 |
| REJECTED after 168h and rejected count < 2 | 접수 허용 |
| rejected count >= 2 | 영구 종결 메시지 |
| same IP target 3+ appeals today | 일일 제한 메시지 |


## 14. Policy Feed API Contract 테스트

| Case | Expected |
|---|---|
| POST `/admin/blocks/policy-feed/api` valid JSON | IP_BLOCK_BATCH + IP_BLOCKLIST 생성 |
| omitted matchType with CIDR target | CIDR로 추론 |
| omitted matchType with two-letter country | COUNTRY로 추론 |
| invalid rule row | skipped에 실패 사유 기록 |
| sourceName omitted | MANUAL_UPLOAD_FEED 사용 |

## 15. Appeal Policy UI 테스트

| Case | Expected |
|---|---|
| SECURITY_APPEAL_COOLDOWN observation_minutes 변경 | REJECTED 쿨타임 기준 변경 |
| SECURITY_APPEAL_COOLDOWN threshold_count 변경 | 영구 종결 기준 변경 |
| SECURITY_APPEAL_COOLDOWN distinct_account_threshold 변경 | 동일 IP 일일 접수 제한 변경 |
| policy inactive | PENDING/HOLD 중복 차단 외 쿨타임/횟수 제한 비활성 |

## 16. Security Notification 테스트

| Case | Expected |
|---|---|
| ACCEPTED + user_idx exists | MYPAGE_FEED_NOTIFICATION 생성 |
| REJECTED + ACTIVE user | MYPAGE_FEED_NOTIFICATION 생성 |
| REJECTED + blocked/non-active user | 사이트 내 알림 생략, 이메일 중심 |
| HOLD + blocked/non-active user | 사이트 내 알림 생략, 이메일 중심 |



## 17. Email Verified Appeal 테스트

| Case | Expected |
|---|---|
| requestId valid + email valid | 인증 링크 메일 발송 |
| requestId invalid | 인증 요청 차단 |
| email invalid | 인증 요청 차단 |
| token link valid | 이의제기 본문 작성 화면 표시 |
| direct submit without token | emailVerificationRequired 오류 |
| token submit | SECURITY_ACTION_APPEAL 정식 접수 |
| used token resubmit | tokenInvalid 오류 |
| result lookup publicRequestId + verified email | 처리 상태 표시 |
| result lookup wrong email | notFound 오류 |


## 18. Appeal Channel Policy / Rate Limit 테스트

| Case | Expected |
|---|---|
| SECURITY_APPEAL_RATE_LIMIT threshold_count = 3 | 같은 requestId/email 인증 링크 3회 초과 시 제한 |
| SECURITY_APPEAL_RATE_LIMIT warning_before_count = 1 | 동일 차단 건 PENDING/HOLD 1건만 허용 |
| SECURITY_APPEAL_RATE_LIMIT warning_before_count = 3 | 동일 차단 건 PENDING/HOLD 3건까지 허용 |
| admin close appeal | appeal_status = CLOSED |
| same case has CLOSED appeal | 인증 링크 요청/이의제기 접수 차단 |
| result lookup wrong email repeatedly | SECURITY_APPEAL_RESULT_LOOKUP_FAILED 감사 로그 누적 |
| result lookup failed over distinct_account_threshold | 결과 조회 rate-limit 메시지 |


## 19. Dedicated SECURITY_APPEAL_POLICY UI 테스트

| Case | Expected |
|---|---|
| `/admin/login-risk/appeal-policy` open | DEFAULT 정책 row가 화면에 표시된다 |
| max_open_appeals_per_case 변경 | 동일 차단 건 PENDING/HOLD 허용 수가 즉시 변경된다 |
| allow_multiple_open_appeals off | 동일 차단 건은 1건만 PENDING/HOLD 허용 |
| closed_blocks_new_appeals off | CLOSED가 있어도 추가 인증/접수 허용 |
| verification_token_ttl_minutes 변경 | 새 인증 링크 만료 시간이 변경된다 |
| allowed_email_domains 설정 | 지정 도메인 외 이메일 인증 요청 차단 |
| blocked_email_domains 설정 | 지정 도메인 이메일 인증 요청 차단 |
| result_lookup_retention_days = 0 | 결과 조회 기간 제한 없음 |
| captcha_enabled toggle | 실제 외부 호출 없이 정책값만 저장 |


## 20. Appeal Policy History / Detail Modal 테스트

| Case | Expected |
|---|---|
| appeal policy save | `SECURITY_APPEAL_POLICY_HISTORY` version_no 증가 |
| appeal policy history open | 변경 전/후 JSON 스냅샷 표시 |
| protected_appeal_token_ttl_days 변경 | 보호조치 안내 메일 이의제기 링크 TTL 변경 |
| appeals detail button click | 상세 모달 열린다 |
| appeals detail modal outside click | 모달 닫힌다 |
| appeals detail modal Escape | 모달 닫힌다 |
| user input in modal | `c:out`으로 escape 처리 |
