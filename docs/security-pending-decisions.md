# TripTogether 보안 거버넌스 보류 결정 질문서

이 문서는 현재 코드/DB 구조로 더 이상 임의 구현하면 가정이 커지는 항목을 정리한 질문서입니다.  
아래 질문에 답하면 다음 작업자는 바로 구현/검증으로 이어갈 수 있습니다.

## 1. 운영 AI Provider

### Q1. 실제 운영 AI Provider를 무엇으로 둘까요?

선택지:

- A. OpenAI API
- B. Gemini API
- C. Claude API
- D. 자체/사내 AI Gateway
- E. 당장은 Generic HTTP Stub 유지

결정 필요값:

```text
provider_code =
provider_kind = AI_MODEL
endpoint_url =
api_key_ref = ENV:
model_name =
fail_open = 1 or 0
timeout_millis =
```

권장 기본값:

```text
당장 런칭 전이면 E.
시연/포트폴리오 목적이면 Generic HTTP Stub 유지.
실운영 연결 시에는 사내 AI Gateway를 하나 두고 그 뒤에 OpenAI/Gemini/Claude를 붙이는 방식이 가장 관리하기 쉽다.
```

## 2. 정책기관 / 상위 보안 피드 Provider

### Q2. 실제 정책기관/관제센터 연동 대상이 있나요?

선택지:

- A. 없음. RULE_ALGORITHM / AI_MODEL 판단만 사용
- B. 공공/상용 Threat Intelligence Feed 사용
- C. 사내/학교/조직 관제 API 사용
- D. CSV/JSON 파일 수동 업로드 방식부터 시작
- E. 향후 확장만 열어두고 비활성 유지

결정 필요값:

```text
provider_code =
provider_kind = POLICY_AUTHORITY
endpoint_url =
api_key_ref = ENV:
model_name or feed_name =
fail_open = 1 or 0
timeout_millis =
```

권장 기본값:

```text
현재는 E 또는 D.
정책기관 연동은 실제 계약/키/데이터 사용 조건이 필요하므로 임의 구현하지 않는다.
```

## 3. WAF / CDN Provider 활성화 순서

### Q3. 런칭 시 어떤 Provider를 실제로 켤까요?

현재 구현 가능 구조:

- Gateway 방식
  - CLOUDFLARE_GATEWAY_WAF
  - AWS_WAF_GATEWAY_WAF
  - NGINX_GATEWAY_WAF
- Direct 방식
  - CLOUDFLARE_DIRECT_WAF
  - AWS_WAF_SDK_IPSET
  - NGINX_DIRECT_WAF

선택지:

- A. Gateway만 우선 활성화
- B. Direct만 우선 활성화
- C. Gateway + Direct 둘 다 활성화
- D. 런칭 전까지 모두 비활성, 시연 데이터만 사용

권장 기본값:

```text
보안 원칙상 C.
다만 실제 운영 전까지는 D.
시연에서는 Provider 설정 화면과 WAF 큐만 보여주고 실제 외부 호출은 비활성 상태로 둔다.
```

## 4. Cloudflare Direct 설정

### Q4. Cloudflare를 실제로 쓸 예정인가요?

답변 필요:

```text
사용 여부: yes/no
zone_id:
ruleset_id or list_id:
endpoint_url:
api_key_ref: ENV:TRIPTOGETHER_CLOUDFLARE_TOKEN
차단 대상: IP / CIDR / COUNTRY / ASN 중 무엇?
```

결정 포인트:

```text
Cloudflare API를 직접 호출할지,
내부 Gateway를 거쳐 호출할지,
둘 다 켤지 결정해야 한다.
```

## 5. AWS WAF SDK 설정

### Q5. AWS WAF IPSet을 실제로 사용할 예정인가요?

답변 필요:

```text
사용 여부: yes/no
region:
scope: REGIONAL or CLOUDFRONT
ipSetId:
ipSetName:
AWS credential 방식: 환경변수 / IAM Role / profile
```

현재 `model_name` 형식:

```text
region=ap-northeast-2;scope=REGIONAL;ipSetId=...;ipSetName=...
```

결정 포인트:

```text
AWS SDK 직접 연동은 이미 구조가 있으므로,
실제 IPSet 값만 확정되면 토글로 활성화 가능하다.
```

## 6. Nginx Direct 설정

### Q6. Nginx는 어떤 방식으로 제어할까요?

선택지:

- A. Nginx Plus API
- B. 내부 관리 API 직접 구현
- C. Gateway를 통해 Nginx 설정 반영
- D. Nginx 직접 제어는 하지 않고 Cloudflare/AWS만 사용
- E. 시연용 Stub만 유지

답변 필요:

```text
사용 여부:
endpoint_url:
api_key_ref:
method:
reload 필요 여부:
rollback 방식:
```

권장 기본값:

```text
운영 안정성을 위해 파일 직접 수정 + reload 방식은 피한다.
Nginx Plus API 또는 별도 관리 API/Gateway 방식이 안전하다.
```

## 7. Secret 관리 방식

### Q7. API Key / Secret을 어디서 관리할까요?

선택지:

- A. OS 환경변수
- B. application-secret.properties + 운영 서버 외부 파일
- C. Docker/Kubernetes Secret
- D. AWS Secrets Manager / Parameter Store
- E. 런칭 전까지 ENV 참조명만 유지

결정 필요:

```text
로컬 개발:
시연 서버:
운영 서버:
CI/CD:
```

권장 기본값:

```text
로컬/시연: ENV
운영: Secret Manager 또는 서버 환경변수
DB에는 절대 실제 키를 저장하지 않는다.
```

## 8. fail-open / fail-closed 정책

### Q8. Provider 장애 시 어떻게 처리할까요?

정책별 권장:

| 영역 | 권장 |
|---|---|
| AI 판단 Provider | fail_open = 1 |
| 정책기관 Provider | fail_open = 1 또는 검토 큐 |
| Cloudflare/AWS/Nginx WAF 동기화 | fail_open = 0 |
| 사용자 로그인 자체 | 내부 정책 우선, 외부 Provider 장애로 로그인 전체 중단 금지 |

답변 필요:

```text
AI_MODEL fail_open:
POLICY_AUTHORITY fail_open:
WAF_CDN fail_open:
```

## 9. AI / 정책기관 응답 스키마 확정

### Q9. 실제 Provider 응답 JSON을 현재 계약에 맞출 수 있나요?

현재 기대 응답:

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

선택지:

- A. 현재 계약 그대로 사용
- B. Provider별 응답이 다르므로 Adapter별 parser 추가
- C. 내부 Gateway에서 표준 계약으로 변환
- D. 아직 미정

권장 기본값:

```text
C.
외부 AI/정책기관 API 응답은 변동 가능성이 크므로,
TripTogether 내부 표준 계약으로 변환하는 Gateway 계층을 두는 편이 안정적이다.
```

## 10. 감사 로그 reason_code 백필 범위

### Q10. 보안 도메인 외 일반 ActivityLog/관리자 로그도 reason_code 구조로 바꿀까요?

현재 완료:

```text
SECURITY_ACTION_AUDIT 보안 계열 action_type 백필
```

남은 후보:

```text
ACTIVITY_LOG
LOGIN_HISTORY
USER_SECURITY_HISTORY
관리자 문의/신고/기업승인 처리 로그
```

선택지:

- A. 보안 도메인만 reason_code 적용
- B. 관리자 조치 로그까지 확대
- C. 모든 운영 로그에 확대
- D. 신규 로그만 적용하고 과거 데이터는 유지
- E. 당분간 유지

권장 기본값:

```text
B.
모든 로그를 한 번에 바꾸면 범위가 커진다.
차단/신고/문의/기업승인 같은 관리자 조치 로그부터 점진 적용한다.
```

## 11. `LOGIN_RISK_EXTERNAL_ASSESSMENT`와 `SECURITY_RISK_ASSESSMENT` 통합 방향

### Q11. 두 테이블을 장기적으로 어떻게 가져갈까요?

선택지:

- A. 둘 다 유지
  - LOGIN_RISK_EXTERNAL_ASSESSMENT: 로그인 전용
  - SECURITY_RISK_ASSESSMENT: 일반 보안/콘텐츠/IP/정책기관
- B. SECURITY_RISK_ASSESSMENT로 통합
- C. 기존 테이블은 유지하되 신규 판단은 SECURITY_RISK_ASSESSMENT만 사용
- D. 운영 전까지 유지, 런칭 전 정리

권장 기본값:

```text
C.
기존 데이터/코드 호환성을 깨지 않고,
신규 판단은 범용 테이블로 모으는 방식이 안전하다.
```

## 12. 이의제기 중복 접수 정책

### Q12. 동일 조치에 대한 중복 이의제기를 어떻게 제한할까요?

현재 1차 정책:

```text
같은 target_type + target_key + block_access_request_id에 PENDING/HOLD가 있으면 제한
```

결정 필요:

```text
동일 조치 중복 제한 시간:
REJECTED 후 재접수 가능 여부:
ACCEPTED 후 재접수 가능 여부:
비회원 IP 차단 이의제기 제한 기준:
```

권장 기본값:

```text
PENDING/HOLD 중복 제한 유지.
REJECTED 후 7일 뒤 재접수 허용.
ACCEPTED는 동일 조치가 해제되므로 재접수 불필요.
```

## 13. 관리자 알림/사이트 내 알림 고도화

### Q13. 어떤 이벤트를 관리자 알림으로 보낼까요?

후보:

- 보안 검토 큐 신규 생성
- 이의제기 신규 접수
- WAF 동기화 실패
- Provider Health ERROR
- 기업 승인 요청
- 신고 접수
- 문의 미답변
- 결제/환불 이상 징후

답변 필요:

```text
즉시 알림 대상:
일일 요약 대상:
알림 제외 대상:
관리자 역할별 수신 범위:
```

권장 기본값:

```text
즉시: WAF 실패, Provider 오류, 보안 이의제기, 신고
요약: 문의, 기업승인, 일반 검토 큐
역할별 알림 설정은 기존 관리자 알림 설정 화면과 연동
```

## 14. 실제 통합 테스트 가능 시점

### Q14. 외부 API 키와 테스트 계정은 언제 받을 수 있나요?

답변 필요:

```text
Cloudflare:
AWS:
Nginx:
AI Provider:
정책기관 Provider:
테스트 서버 URL:
```

권장 기본값:

```text
키가 없으면 Provider는 비활성 상태 유지.
시연에서는 설정 화면, 큐, 샘플 로그, 실패/대기 상태를 보여준다.
```

## 답변 양식

아래 형식으로 답하면 다음 작업자가 바로 이어갈 수 있습니다.

```text
Q1:
Q2:
Q3:
Q4:
Q5:
Q6:
Q7:
Q8:
Q9:
Q10:
Q11:
Q12:
Q13:
Q14:
```
