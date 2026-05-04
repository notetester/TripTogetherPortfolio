# TripTogether Policy Feed API Contract

이 문서는 외부 정책기관/관제 시스템과 협의할 때 TripTogether 쪽에서 제안할 수 있는 정책 피드 수신 계약입니다.

## Endpoint

```http
POST /admin/blocks/policy-feed/api
Content-Type: application/json
```

현재는 관리자 인증 세션 기반으로 동작합니다.  
향후 외부 기관/Gateway 연동 시에는 별도 service token, mTLS, IP allowlist, 서명 검증을 추가합니다.

## Request

```json
{
  "sourceName": "MANUAL_UPLOAD_FEED",
  "defaultRuleAction": "BLOCK",
  "rules": [
    {
      "matchType": "IP",
      "targetValue": "203.0.113.10",
      "ruleAction": "BLOCK",
      "reason": "Sample threat feed",
      "detailMessage": "Demo API payload",
      "priority": 50
    },
    {
      "matchType": "COUNTRY",
      "targetValue": "RU",
      "reason": "Sample country rule",
      "priority": 70
    }
  ]
}
```

## Fields

| Field | Required | Description |
|---|---:|---|
| sourceName | N | 피드 출처명. 없으면 `MANUAL_UPLOAD_FEED` 사용 |
| defaultRuleAction | N | 기본 처리. `BLOCK` 또는 `ALLOW` |
| rules | Y | 정책 규칙 배열 |
| rules[].matchType | N | `IP`, `SINGLE_IP`, `CIDR`, `COUNTRY`, `ASN`. 없으면 targetValue에서 추론 |
| rules[].targetValue | Y | 적용 대상값 |
| rules[].ruleAction | N | `BLOCK` 또는 `ALLOW`. 없으면 defaultRuleAction 사용 |
| rules[].reason | N | 운영 사유 |
| rules[].detailMessage | N | 상세 메모 |
| rules[].priority | N | 우선순위. 없으면 50 |

## Response

```json
{
  "success": true,
  "message": "Policy feed upload completed.",
  "batchId": 123,
  "batchCode": "MANUAL_FEED_20260505123000",
  "importMethod": "API",
  "totalCount": 2,
  "successCount": 2,
  "failedCount": 0,
  "skipped": []
}
```

## 처리 구조

수신된 API payload는 새 테이블을 만들지 않고 기존 차단 관리 구조를 재사용합니다.

```text
API payload
→ AdminPolicyFeedImportRequest
→ AdminBlockService.importPolicyFeed(...)
→ IP_BLOCK_BATCH 생성
→ IP_BLOCKLIST 규칙 생성
→ 차단 캐시 갱신
```

## 협의 포인트

- 실제 외부 연동 시 인증 방식은 별도로 확정해야 합니다.
- Cloudflare/AWS WAF 동기화는 즉시 외부 호출이 아니라 기존 WAF 큐/Mock 또는 비동기 worker를 통해 처리합니다.
- ASN은 오탐률 이슈로 기본 시연 대상에서는 제외하고, API 계약상 확장 필드로만 둡니다.
