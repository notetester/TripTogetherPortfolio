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
