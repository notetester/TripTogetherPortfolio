# TripTogether 보안 후속 작업 하드코딩 점검 보고서

## 점검 기준

- 사용자/관리자 화면 표시 문구는 언어팩 사용
- JSP 출력값은 `c:out` 또는 `fn:escapeXml` 적용
- Java Controller/Service의 사용자 노출 성공 메시지는 `MessageSource` 사용
- 운영 메모/DB 사유는 reason_code/reason_args 또는 비표시 운영 메모로 분류

## 이번 패치에서 정리한 항목

- `admin/login-risk/policies.jsp`
  - 직접 출력 `${message}`, `${p.policyName}`, `${p.description}` 등을 escape 처리
  - 이의제기 정책 안내 문구를 `security_ko/en/ja/zh.properties`로 분리
- `admin/block/list.jsp`
  - 런타임 캐시 카드의 한국어 문구를 `admin_ko/en/ja/zh.properties`로 분리
  - 정책 피드 업로드 UI 문구를 `admin_ko/en/ja/zh.properties`로 분리
- `AdminBlockController`
  - 차단 관리 주요 Ajax 성공 메시지를 `MessageSource` 기반으로 전환
  - 정책 피드 업로드 오류 코드 메시지를 언어팩으로 해석
- `LoginRiskPolicyService`
  - 이의제기 쿨타임/횟수 오류는 `security_ko/en/ja/zh.properties` 키 사용
- `InternalAiGatewayStubAssessmentAdapter`, `MockWafSyncAdapter`
  - 사용자 노출 한국어 하드코딩 없음

## 자동 점검 결과

| Scope | Result |
|---|---|
| `admin/login-risk/policies.jsp` 한국어 직접 문구 | 0건 |
| `LoginRiskPolicyService.java` 한국어 직접 문구 | 0건 |
| `InternalAiGatewayStubAssessmentAdapter.java` 한국어 직접 문구 | 0건 |
| `MockWafSyncAdapter.java` 한국어 직접 문구 | 0건 |
| `security_ko/en/ja/zh.properties` 키 수 일치 | 일치 |
| `admin_ko/en/ja/zh.properties` 키 수 일치 | 일치 |

## 남아 있는 레거시 항목

`AdminBlockServiceImpl.java`에는 기존 차단 관리 서비스에서 작성된 한국어 운영 메모/예외 메시지가 남아 있다.

대표 유형:

```text
배치 코드, 배치명, 출처 유형은 필수입니다.
단일 IP 규칙은 IP 주소가 필요합니다.
CIDR 규칙은 올바른 CIDR 표기가 필요합니다.
관리자가 개별 규칙을 비활성화했습니다.
현재 평가 대상입니다.
```

이 항목들은 이번 패치에서 새로 만든 문구는 아니며, 차단 관리 전체의 레거시 서비스 메시지다.  
일부는 사용자에게 노출될 수 있는 예외 메시지이고, 일부는 DB에 남는 운영 메모다.

## 후속 권장

- `AdminBlockServiceImpl`의 사용자 노출 예외는 message code 방식으로 전환
- DB 운영 메모는 가능하면 `reason_code/reason_args` 구조로 전환
- VO의 `get*Label()` 한국어 반환값은 화면에서 직접 쓰지 않거나 언어팩 기반으로 대체
- `admin/block/list.jsp`의 기존 `title="<spring:message .../>"` 속성 사용 패턴은 별도 JSP 정리 작업에서 `spring:message var` 방식으로 변경
