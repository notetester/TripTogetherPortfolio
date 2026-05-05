# TripTogether Security Appeal Email Verification Flow

## 결정

IP 차단, 비로그인 사용자, 인증 이메일이 없는 사용자 차단은 모두 “로그인 기반 신원 확인”이 어렵다.  
따라서 이의제기는 바로 접수하지 않고, 사용자가 입력한 이메일의 소유권을 먼저 검증한 뒤 접수한다.

## 최종 흐름

```text
차단 안내 페이지 / requestId
→ 이메일 입력
→ 인증 링크 발송
→ 이메일 링크 클릭
→ token 기반 이의제기 본문 작성
→ SECURITY_ACTION_APPEAL 정식 접수
→ publicRequestId 발급
→ 관리자 검토
→ 이메일 통지 + 조건부 사이트 내 알림
→ publicRequestId + 인증 이메일로 비로그인 결과 조회
```

## 왜 이메일 인증을 선행하는가?

- 타인의 이메일을 임의 입력해 CS 접수를 만드는 것을 막는다.
- 공개 항의용 이메일 주소를 노출하지 않아 스팸 표적이 되는 것을 줄인다.
- IP 차단처럼 로그인 상태를 신뢰할 수 없는 경우에도 연락 채널의 소유권을 최소한으로 검증한다.
- 인증 링크를 클릭한 이메일만 `submitter_email`로 저장한다.

## 구현 기준

| Step | Implementation |
|---|---|
| 이메일 인증 요청 | `POST /security/appeal/verify` |
| 인증 링크 | `SECURITY_ACTION_APPEAL_TOKEN.token` |
| 인증 이메일 저장 | `SECURITY_ACTION_APPEAL_TOKEN.submitter_email` |
| 본문 제출 | `POST /security/appeal` with token |
| 결과 조회 | `GET/POST /security/appeal/result` |
| 결과 조회 검증 | `publicRequestId + submitterEmail` 일치 |

## 차단 계정과 알림

차단 계정에는 `MYPAGE_FEED_NOTIFICATION`만 남겨도 사용자가 확인할 수 없다.  
따라서 차단 상태가 유지되는 경우에는 이메일과 publicRequestId 기반 결과 조회를 중심으로 안내한다.

## CAPTCHA/Turnstile

현재 패치는 외부 키 없는 시연/개발 환경을 기준으로 CAPTCHA 검증 Provider는 붙이지 않는다.  
운영 전에는 `POST /security/appeal/verify`에 CAPTCHA/Turnstile 검증 Filter 또는 Service를 붙이는 것이 권장된다.
