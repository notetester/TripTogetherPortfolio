# TripTogether 보안 거버넌스 작업 목록

이 문서는 보안/차단/AI 판단/이의제기 기능의 작업 상태를 잃지 않기 위한 기준 문서입니다.  
새 보안 패치를 진행할 때는 이 문서를 먼저 확인하고, 완료/보류 상태를 갱신합니다.

## 완료됨

- 로그인 위험 정책 엔진
- 로그인 실패 기반 계정/IP 제한
- 로그인 위험 관리자 검토 큐
- 보호 조치 안내 메일
- 관리자 알림 설정 UI
- WAF/CDN 동기화 후보 큐
- AI/알고리즘/상위 정책기관 판단 저장 구조
- 실제 Provider 연결 인터페이스
- 일반 보안 판단 테이블 `SECURITY_RISK_ASSESSMENT`
- `USER_BLOCKLIST` / `USER_BLOCK_HISTORY` 메타데이터 확장
- SYSTEM 역할 계정 기반 자동 조치 감사 추적
- 보안 위험 판단 관리자 화면
- 일반 보안 검토 큐
- Provider 설정 화면
- 보안 조치 감사 로그
- 보안 조치 이의제기 관리자 화면
- 차단 안내 페이지 기반 사용자 이의제기 접수
- 이메일 토큰 기반 이의제기 접수
- 이의제기 수용 시 USER/IP 차단 해제 및 판단 상태 보정
- 공개 사용자 보안 이의제기 화면 i18n
- 관리자 보안 화면 `admin/login-risk/*.jsp` i18n 1차 정리
- 이의제기 관리자 화면 사용자 입력 출력부 `c:out` 적용
- Provider 상태 점검 스케줄러 골격
- WAF 동기화 큐 처리 스케줄러 골격
- Generic HTTP AI Provider 골격
- Generic HTTP Policy Authority Provider 골격
- Generic HTTP WAF/CDN Provider 골격
- WAF 동기화 큐 관리자 조회/재시도 화면
- 이의제기 중복 접수 제한 1차 정책
- 이의제기 처리 결과 이메일 통지
- `SECURITY_ACTION_AUDIT.reason_code` / `reason_args` 1차 컬럼 추가
- Provider 요청/응답 기본 계약 문서화
- 보안 검토/이의제기/WAF 상태 전이 문서화
- 차단/이의제기 처리 결과 사이트 내 알림 1차 연동
- 보안 검토/이의제기/Provider 설정 감사 로그 reason_code 사용 확대
- 이의제기 중복 접수 제한 UI 안내
- Provider/WAF fail-open/fail-closed 테스트 계획 문서화
- Provider 수동 헬스체크 버튼
- 기존 보안 검토/이의제기/Provider/Assessment 감사 로그 reason_code 사용 확대
- WAF Provider별 실패 사유 상세 표시 강화
- WAF/CDN Provider Adapter 분리
- AI/정책기관 Provider Adapter 분리
- 보안 판단/검토 관리자 화면 추가 XSS escape 정리
- 보안 검토 큐 상세 모달 1차 구현
- 과거 SECURITY_ACTION_AUDIT reason_code/reason_args 백필 SQL
- Nginx Direct API WAF Adapter
- AWS WAF SDK IPSet Adapter
- Cloudflare Direct API WAF Adapter
- Gateway + Direct Defense in Depth WAF 실행 구조
- Provider 결정안 seed SQL
- 이의제기 REJECTED 7일 쿨타임 및 2회 거절 종결 정책
- MANUAL_UPLOAD_FEED CSV/JSON 업로드 API/UI
- MOCK_WAF_SERVICE WAF Adapter
- INTERNAL_AI_GATEWAY Stub Adapter
- 보안 거버넌스 결정 합의안 문서화
- 차단 관리 주요 Ajax 성공 메시지 i18n 정리
- 정책 피드 API 계약/샘플 JSON/CSV 문서화
- 보안 알림 동작 문서화
- 보안 이의제기 결과 사이트 내 알림 조건부 적재 로직
- SECURITY_APPEAL_COOLDOWN 정책 row 기반 이의제기 제한값 UI 수정 연동
- 정책 피드 JSON API 수신 계약 및 `/admin/blocks/policy-feed/api` 구현

## 남은 작업

> 보류된 운영 판단은 `docs/security-pending-decisions.md` 질문서에 답변한 뒤 진행한다.


### 외부 연동

- 실제 운영 AI Gateway/정책기관 Gateway endpoint 확정
- 운영 AI/정책기관 API별 실제 응답 스키마 매핑 확정
- AWS Secrets Manager/Parameter Store 실제 연동 구현
- 외부 Provider 장애 시 fail-open / fail-closed 정책별 통합 테스트

### 데이터 모델 고도화

- 보안 도메인 외 타 도메인 감사 로그의 `reason_code` + `reason_args` 전환 여부 검토
- `LOGIN_RISK_EXTERNAL_ASSESSMENT`와 `SECURITY_RISK_ASSESSMENT` 역할 분리 운영 문서 고도화
- `SECURITY_REVIEW_QUEUE`와 `SECURITY_RISK_ASSESSMENT` 상태 전이 규칙 상세 문서화

### UI/운영 고도화

- 보안 검토 큐 상세 모달 추가 고도화
- Provider 헬스체크 결과 상세 화면 추가 고도화
- 차단/이의제기 처리 결과 publicRequestId 기반 비로그인 결과 조회 화면 검토
- 이의제기 중복 접수 제한 정책 세부 문구/UX 고도화
- WAF Provider별 재시도/실패 사유 UI 추가 고도화

### 검증

- `mvn -DskipTests compile`
- 보안 이의제기 requestId/token 경로 수동 테스트
- 관리자 검토 승인/보류/미승인 상태 전이 테스트
- USER/IP 차단 해제 후 캐시 갱신 테스트
- 4언어 화면 스모크 테스트
- Provider enabled/disabled/fail-open/fail-closed 실제 API 통합 테스트
- WAF 동기화 큐 retry 테스트

## 작업 원칙

1. 사용자/관리자 화면 문구는 언어팩으로 분리한다.
2. 사용자 입력을 관리자 화면에 출력할 때는 반드시 `c:out` 또는 동등한 escaping을 적용한다.
3. 차단/해제/자동 조치에는 감사 로그와 이력 테이블을 함께 남긴다.
4. 외부 API 호출은 설정/Provider/큐 구조와 실제 호출 구현을 분리한다.
5. `SCHEMA_MIGRATION_HISTORY`는 운영 기능과 연결하지 않는다. 삭제해도 서비스 기능에 영향이 없어야 한다.
6. 새 SQL은 가능하면 `CREATE IF NOT EXISTS`, `ADD COLUMN IF MISSING` 방식으로 작성한다.
7. 새 작업을 시작할 때 이 문서를 먼저 갱신한다.

## 참고 문서

- `docs/security-provider-contract.md`
- `docs/security-state-transitions.md`
- `docs/security-provider-test-plan.md`
- `docs/development-guidelines.md`
- `docs/security-pending-decisions.md`
- `docs/security-decision-agreement.md`
- `docs/security-policy-feed-api-contract.md`
- `docs/security-notification-behavior.md`
