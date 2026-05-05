# TripTogether Unified Policy History

## 목적

TripTogether의 정책/설정 변경 이력은 정책 도메인별 테이블에 저장하고, 운영자는 통합 화면에서 최신순으로 확인한다.

## 기준 화면

```text
/admin/policy-history
```

## 통합 조회 대상

| Source Type | History Table | Primary Owner |
|---|---|---|
| SYSTEM_POLICY | SYSTEM_POLICY_HISTORY | 운영 시스템 정책 |
| LOGIN_RISK_POLICY | LOGIN_RISK_POLICY_HISTORY | 로그인 위험/락/검토 정책 |
| SECURITY_APPEAL_POLICY | SECURITY_APPEAL_POLICY_HISTORY | 보안 이의제기 채널 정책 |
| RUNTIME_SETTING | APPLICATION_RUNTIME_SETTING_HISTORY | DB 우선 런타임 설정 |
| PROVIDER_CONFIG | SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY | AI/정책기관/WAF Provider 설정 |

## 설계 원칙

- 각 정책 도메인은 자기 전용 history table에 변경 전/후 snapshot을 남긴다.
- 통합 화면은 별도 중복 저장 없이 UNION 조회로 최신 이력을 모아 보여준다.
- 새 정책 테이블을 만들면 `*_HISTORY` 테이블을 함께 만들고, `/admin/policy-history`의 통합 조회 대상에 추가한다.
- snapshot은 사용자 입력/외부 응답을 포함할 수 있으므로 화면 출력 시 반드시 escape한다.

## 이번 보강

- `LOGIN_RISK_POLICY_HISTORY` 추가
- `SECURITY_ASSESSMENT_PROVIDER_CONFIG_HISTORY` 추가
- 로그인 위험 정책 저장 시 history version 증가
- Provider 설정 저장 시 history version 증가
- `layout.jsp`의 보안 메뉴 하드코딩 문구와 spring:message attribute 직접 삽입 패턴 정리
