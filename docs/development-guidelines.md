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


## Defense in Depth WAF 원칙

- Gateway 방식과 Direct 방식은 양자택일이 아니라 함께 사용할 수 있어야 한다.
- 활성화된 WAF Provider가 여러 개면 가능한 Provider를 모두 실행한다.
- Provider별 실패 결과는 하나의 detailMessage에 모두 남겨야 한다.
- AWS WAF SDK, Cloudflare Direct API, Nginx Direct API는 기존 Provider 설정 테이블을 그대로 사용한다.
- Provider별 새 테이블을 만들지 않는다.


## 보류 결정 질문서 원칙

- 외부 API 계약, Secret 관리, Provider 활성화, 운영 정책처럼 프로젝트 소유자의 결정이 필요한 사안은 임의로 구현하지 않는다.
- 이런 항목은 `docs/security-pending-decisions.md`에 질문으로 정리하고, 답변을 받은 뒤 구현한다.
- 질문은 선택지와 권장 기본값을 함께 제시한다.


## 결정 합의안 반영 원칙

- `docs/security-decision-agreement.md`에 확정된 사항은 후속 구현의 기준으로 삼는다.
- 런칭 전 외부 호출은 Mock/Stub으로 검증하고, 실제 Provider는 명시적으로 활성화될 때만 호출한다.
- 정책기관 피드 수동 업로드는 기존 IP 배치/규칙 구조를 재사용한다.
- 이의제기 정책은 PENDING/HOLD 중복 차단, REJECTED 168시간 쿨타임, 2회 거절 종결, 동일 IP 일일 제한을 기준으로 한다.


## 정책 피드 API 계약 원칙

- 정책기관 피드는 파일 업로드와 JSON API 수신을 같은 내부 DTO로 정규화한다.
- 외부 기관과 협의 전에는 `docs/security-policy-feed-api-contract.md`의 TripTogether 표준 payload를 우선 제안한다.
- API 수신 결과는 새 테이블보다 기존 `IP_BLOCK_BATCH` / `IP_BLOCKLIST` 구조를 우선 재사용한다.

## 보안 알림 적재 원칙

- 이메일 통지와 사이트 내 알림은 별개의 채널로 본다.
- 사용자가 차단 상태라 확인할 수 없는 사이트 내 알림은 무조건 쌓지 않는다.
- 이의제기 ACCEPTED처럼 사용자가 다시 접근 가능해지는 경우에는 사이트 내 알림을 남긴다.
- REJECTED/HOLD는 사용자 계정 상태가 ACTIVE인 경우에만 사이트 내 알림을 남기고, 차단 계정은 이메일/publicRequestId 중심으로 안내한다.



## 이메일 인증 기반 이의제기 원칙

- requestId만으로 곧바로 이의제기를 접수하지 않는다.
- 비로그인/IP 차단/인증 이메일이 없는 사용자 차단은 이메일 소유권 검증 후에만 본문 제출을 허용한다.
- 인증 이메일은 `SECURITY_ACTION_APPEAL_TOKEN.submitter_email`에 저장하고, 정식 접수 시 `SECURITY_ACTION_APPEAL.submitter_email`로 넘긴다.
- 결과 조회는 `publicRequestId`와 인증 이메일이 함께 일치할 때만 표시한다.
- 운영 전에는 CAPTCHA/Turnstile을 `/security/appeal/verify` 앞단에 붙인다.


## 이의제기 채널 정책 원칙

- `SECURITY_APPEAL_COOLDOWN`은 반려 후 재접수/거절 누적/일일 제한 정책으로 사용한다.
- `SECURITY_APPEAL_RATE_LIMIT`은 인증 링크 발송 제한, 결과 조회 실패 제한, 인증 링크 TTL, 동일 건 동시 접수 허용 수를 관리한다.
- 동일 차단 건에 `CLOSED` 이의제기가 있으면 추가 인증/접수를 막는다.
- 공용 IP 차단처럼 여러 사용자가 걸릴 수 있는 경우를 고려해 `warning_before_count`로 동시 접수 허용 수를 조절한다.
- rate-limit 기록은 새 테이블보다 기존 `SECURITY_ACTION_AUDIT`와 토큰 테이블을 우선 재사용한다.


## SECURITY_APPEAL_POLICY 전용 정책 원칙

- 이의제기 채널 정책의 기준 테이블은 `SECURITY_APPEAL_POLICY`다.
- `LOGIN_RISK_POLICY`의 `SECURITY_APPEAL_COOLDOWN` / `SECURITY_APPEAL_RATE_LIMIT`는 레거시/초기 seed 승계용으로만 본다.
- 인증 메일 발송 제한, 결과 조회 실패 제한, 동일 건 동시 접수 허용 수, CLOSED 후 추가 접수 차단, 이메일 도메인 제한은 모두 `/admin/login-risk/appeal-policy`에서 수정 가능해야 한다.
- 실제 CAPTCHA/Turnstile API 연동 전까지는 `captcha_enabled`, `captcha_provider_code`를 시연용 설정값으로만 사용한다.


## 정책 변경 이력/초기설정관리 원칙

- 전용 정책 테이블을 만들 경우, 가능한 한 함께 `*_HISTORY` 테이블을 두어 변경 전/후 스냅샷과 actor_user_idx를 남긴다.
- 정책 화면에서 수정 가능한 값은 하드코딩 fallback이 있더라도 DB 기본 row를 우선 사용한다.
- 초기설정관리/export-import 대상은 Provider 설정, 로그인 위험 정책, 보안 이의제기 정책, 시스템 정책 configJson을 우선 대상으로 삼는다.
- 환경값/Secret/OAuth redirect URI도 `APPLICATION_RUNTIME_SETTING`에서 DB 우선값을 줄 수 있게 한다. 단, 값이 없으면 ENV/properties/Secret Manager fallback으로 동작해야 한다.


## APPLICATION_RUNTIME_SETTING 원칙

- properties/env 성격의 설정도 DB 우선값을 둘 수 있다.
- 코드에서는 `RuntimeSettingService`를 통해 `setting_value -> fallback_value -> properties/default` 순서로 조회한다.
- 테이블이 없거나 row가 없어도 서비스가 중단되지 않도록 fallback을 반드시 둔다.
- 설정 변경 이력은 `APPLICATION_RUNTIME_SETTING_HISTORY`에 남긴다.
- 민감값은 `is_secret`으로 표시하고, 실제 접근 제어는 관리자 권한 정책과 함께 고도화한다.
