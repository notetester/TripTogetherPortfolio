# TripTogether 개발 주의사항

## 다국어/i18n 원칙

- 사용자 화면과 관리자 화면에 표시되는 문구는 직접 하드코딩하지 않는다.
- JSP에서는 `<spring:message code="..."/>` 또는 `spring:message var`를 사용한다.
- Java Controller/Service에서 사용자에게 노출되는 메시지는 `MessageSource` 또는 기존 메시지 헬퍼를 사용한다.
- 새 메시지 키를 추가하면 `ko`, `en`, `ja`, `zh` 4개 언어 파일에 모두 추가한다.
- DB에 저장되는 운영 메모는 가능하면 `reason_code` + `reason_args` 구조를 사용하고, 화면 출력 시 언어팩으로 해석한다.

## 보안 출력 원칙

- 사용자가 입력한 값은 관리자 화면에서도 반드시 escape한다.
- JSP에서는 `${...}` 직접 출력 대신 `<c:out value="${...}"/>`를 우선 사용한다.
- 공개 접수 폼, 이의제기, 문의, 신고 내용은 모두 XSS 방어 대상이다.

## 보안 거버넌스 작업 원칙

- 차단/해제/자동 조치에는 감사 로그와 이력 테이블을 함께 남긴다.
- AI/정책기관/WAF 연동은 Provider 인터페이스와 설정 테이블을 통해 분리한다.
- 실제 API 키는 DB에 직접 저장하지 않고 `ENV:` 또는 `PROP:` 참조명으로 관리한다.
- `SCHEMA_MIGRATION_HISTORY`는 운영 기능과 결합하지 않는다.
- 후속 작업은 `docs/security-governance-worklist.md`를 먼저 확인하고 갱신한다.


## 마이그레이션 작업 원칙

- 특별히 적용하지 않았다는 언급이 없으면, 이전에 제시한 SQL은 적용된 것으로 간주하고 후속 작업을 이어간다.
- 기존 테이블을 다시 생성하려고 하기보다, 현재 마이그레이션 이력과 기존 스키마를 기준으로 필요한 컬럼/인덱스/데이터만 증분 보강한다.
- 새 테이블이 정말 필요한 경우에는 먼저 `docs/security-governance-worklist.md`와 `docs/migration-history.md`를 확인하고, 기존 테이블로 표현 가능한지 검토한다.


## SQL 작성 원칙

- DB 구조 변경이나 샘플 데이터 추가가 없으면 SQL 파일을 새로 만들지 않는다.
- 이전 마이그레이션을 다시 반복해서 작성하지 않는다.
- 기존에 제시한 SQL은 특별히 미적용이라고 확인되지 않는 한 적용된 것으로 보고 후속 작업을 이어간다.
- `SCHEMA_MIGRATION_HISTORY`는 운영 기능과 연결하지 않으며, 새 기능 구현을 위해 조회하지 않는다.


## Provider Adapter 작업 원칙

- Provider 설정 테이블을 Provider별로 새로 만들지 않는다.
- `SECURITY_ASSESSMENT_PROVIDER_CONFIG`의 `provider_kind`, `provider_code`, `endpoint_url`, `api_key_ref`, `fail_open`을 기준으로 Java Adapter에서 분기한다.
- 운영 API별 응답 스키마가 확정되면 새 테이블보다 Adapter 응답 파서 분리를 우선 검토한다.
- WAF/CDN 실패 사유는 `LOGIN_RISK_WAF_SYNC_QUEUE.detail_message`에 providerCode, providerKind, status, failOpen, reason을 포함해 운영자가 추적 가능하게 남긴다.


## 관리자 상세 모달 원칙

- 목록 화면에서 사용자 입력/외부 Provider 응답을 상세로 보여줄 때도 반드시 escape한다.
- 모달 내부의 summary, detailMessage, reviewComment, provider response는 `<c:out>` 또는 동등한 escaping을 사용한다.
- 모달 UI 추가만으로 DB 구조를 변경하지 않는다.
