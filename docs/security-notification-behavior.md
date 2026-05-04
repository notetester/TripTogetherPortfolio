# TripTogether Security Notification Behavior

## 목적

보안 조치 결과는 이메일과 사이트 내 알림을 함께 활용하되, 사용자가 실제로 확인할 수 없는 알림을 무조건 쌓지 않는다.

## 현재 로직

`SECURITY_ACTION_APPEAL` 처리 결과에서 사용자 계정이 식별되는 경우 다음 기준으로 `MYPAGE_FEED_NOTIFICATION`을 남긴다.

| Appeal Decision | Site Notification |
|---|---|
| ACCEPTED | 남김. 수용 처리 과정에서 차단이 해제될 수 있으므로 사용자가 로그인 후 확인 가능 |
| REJECTED | 계정 상태가 ACTIVE인 경우만 남김 |
| HOLD | 계정 상태가 ACTIVE인 경우만 남김 |
| user_idx 없음 | 남기지 않음. 이메일 또는 publicRequestId 기반 확인만 사용 |

## 왜 REJECTED/HOLD 차단 계정에는 알림을 무조건 남기지 않는가?

계정 차단이 유지되는 상황에서 마이페이지 알림만 남기면 사용자는 로그인할 수 없어 확인할 수 없다.  
따라서 차단 계정에는 이메일과 공개 접수번호 중심으로 안내하고, 사이트 내 알림은 실제 접근 가능한 경우에만 사용한다.

## 메서드 기준

```text
LoginRiskPolicyService.sendAppealDecisionNoticeIfPossible(...)
→ shouldWriteAppealSiteNotification(...)
→ MYPAGE_FEED_NOTIFICATION insert
```

## 후속 고도화

- 차단 안내 페이지에서 publicRequestId로 처리 결과 조회
- 비로그인 결과 조회 전용 페이지
- 사이트 내 알림과 이메일 발송 이력의 분리 관리
