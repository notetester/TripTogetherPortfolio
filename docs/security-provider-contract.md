# TripTogether Security Provider Contract

이 문서는 실제 운영 AI/정책기관/WAF API를 붙일 때의 기본 계약입니다.  
현재 구현은 Generic HTTP Provider 골격이며, 운영 API별 어댑터가 필요해지면 이 계약을 기준으로 분리합니다.

## AI / Policy Authority Assessment Request

`HttpSecurityAssessmentProvider`는 `SECURITY_ASSESSMENT_PROVIDER_CONFIG`에서 활성화된 `AI_MODEL` 또는 `POLICY_AUTHORITY` Provider를 조회한 뒤 아래 JSON을 POST합니다.

```json
{
  "providerCode": "GENERIC_AI_RISK_HTTP",
  "providerKind": "AI_MODEL",
  "modelName": "external-risk-model",
  "policyCode": "ACCOUNT_PASSWORD_FAIL_LOCK",
  "reviewType": "ACCOUNT_LOCK",
  "subjectType": "USER",
  "subjectKey": "USER:146",
  "userIdx": 146,
  "ipAddress": "203.0.113.10",
  "countryCode": "KR",
  "asn": "4766",
  "observedCount": 5,
  "distinctIdentifierCount": 1,
  "detailMessage": "..."
}
```

## AI / Policy Authority Assessment Response

```json
{
  "riskScore": 87,
  "riskLevel": "HIGH",
  "confidenceScore": 91,
  "recommendationAction": "REVIEW",
  "recommendationReason": "Repeated failed login pattern",
  "evidenceSummary": "5 failures in 10 minutes from same IP"
}
```

## WAF/CDN Sync Request

`HttpWafSyncProvider`는 `WAF_CDN`, `WAF`, `CDN`, `EDGE_SECURITY` Provider를 조회한 뒤 아래 JSON을 POST합니다.

```json
{
  "syncIdx": 1,
  "sourceType": "SECURITY_RISK_ASSESSMENT",
  "sourceId": 21,
  "syncAction": "BLOCK",
  "targetType": "IP",
  "targetValue": "203.0.113.200"
}
```

## WAF/CDN Sync Response

현재는 HTTP 2xx이면 `SYNCED`, 2xx가 아니면 Provider의 fail-open/fail-closed 정책에 따라 `EXTERNAL_PROVIDER_PENDING` 또는 `FAILED`로 처리합니다.

## Secret 관리

- 실제 API 키는 DB에 직접 저장하지 않는다.
- `api_key_ref`에는 `ENV:NAME` 또는 `PROP:name` 형식의 참조명을 저장한다.
- 런타임에서 `SecurityProviderSecretResolver`가 값을 해석한다.

## Fail-open / Fail-closed

- `fail_open = 1`: 외부 API 실패 시 즉시 운영 차단하지 않고 대기/검토 상태로 둔다.
- `fail_open = 0`: 외부 API 실패 시 보수적으로 실패 상태를 남기고 운영자가 재시도/검토한다.


## Provider Adapter 구조

현재 코드는 DB 설정을 바꾸지 않고 Java Bean 레벨에서 Provider를 분리한다.

### Assessment

- `HttpSecurityAssessmentProvider`: 활성 Provider 설정을 조회하고 지원 가능한 Adapter로 라우팅한다.
- `SecurityAssessmentAdapter`: AI/정책기관 Provider별 어댑터 인터페이스.
- `GenericAiRiskAssessmentAdapter`: `provider_kind = AI_MODEL` 처리.
- `GenericPolicyAuthorityAssessmentAdapter`: `provider_kind = POLICY_AUTHORITY` 처리.
- `SecurityAssessmentHttpClient`: 공통 HTTP POST/응답 파싱/Fail-open/Fail-closed 처리.

### WAF/CDN

- `HttpWafSyncProvider`: 활성 WAF Provider 설정을 조회하고 지원 가능한 Adapter로 라우팅한다.
- `WafSyncAdapter`: WAF Provider별 어댑터 인터페이스.
- `GenericWafCdnHttpAdapter`: `WAF_CDN`, `WAF`, `CDN`, `EDGE_SECURITY` 공통 처리.
- `CloudflareWafGatewayAdapter`: `provider_code`가 `CLOUDFLARE`로 시작하는 Provider 처리.
- `AwsWafGatewayAdapter`: `provider_code`가 `AWS` 또는 `AWS_WAF`로 시작하는 Provider 처리.
- `WafSyncHttpClient`: 공통 HTTP POST/실패 사유 상세 메시지 생성.

운영 API별 응답 스키마가 확정되면 Adapter별로 응답 파싱만 분리하고, 설정 테이블 구조는 그대로 유지한다.
