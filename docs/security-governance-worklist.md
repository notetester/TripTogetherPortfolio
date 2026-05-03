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

## 남은 작업

### 외부 연동

- 실제 운영 AI/정책기관/WAF API 계약 확정
- 운영 API별 실제 응답 스키마 매핑 확정
- Provider별 Secret 관리 방식 최종 확정
- 외부 Provider 장애 시 fail-open / fail-closed 정책별 통합 테스트

### 데이터 모델 고도화

- 기존 DB 감사 사유 중 과거 데이터/타 도메인 로그를 `reason_code` + `reason_args` 구조로 점진 전환
- 기존 `LOGIN_RISK_EXTERNAL_ASSESSMENT`와 `SECURITY_RISK_ASSESSMENT`의 장기 통합 방향 결정
- `SECURITY_REVIEW_QUEUE`와 `SECURITY_RISK_ASSESSMENT` 상태 전이 규칙 상세 문서화

### UI/운영 고도화

- 보안 검토 큐 상세 모달 고도화
- Provider 헬스체크 결과 상세 화면 추가 고도화
- 차단/이의제기 처리 결과 사이트 내 알림 고도화
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
