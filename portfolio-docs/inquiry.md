# 문의 · 알림 · 마이페이지

사용자와 운영진을 잇는 고객 응대(1:1 문의)와, 그 응대 결과를 사용자에게 즉시 전달하는 알림, 그리고 사용자가 자신의 활동·계정을 관리하는 마이페이지를 한 묶음으로 다룹니다. 세 도메인은 서로 강하게 연결되어 있습니다. 문의에 답변이 달리면 알림이 발행되고, 알림은 마이페이지 피드와 헤더 벨에 실시간으로 나타나며, 마이페이지는 사용자의 문의·계정·소셜 연동 상태를 한곳에서 보여줍니다.

특히 고객 문의는 단순 게시글이 아니라 처리 단계가 있는 업무 대상으로 설계했습니다. 작성 직후에는 자유롭게 고칠 수 있어야 하지만 운영진이 답변을 단 뒤에는 내용이 흔들리면 안 되고, 사용자가 스스로 종료하거나 삭제를 원하더라도 운영 기록은 남아야 합니다. 이 요구를 `status` 컬럼 하나로 표현되는 상태머신과, 각 전환을 담당하는 전용 엔드포인트로 구현했습니다.

## 주요 기능

- **1:1 문의 작성·수정·삭제**: 카테고리(service/payment/account/bug/etc)·공개여부·이미지 첨부 지원. 작성 직후(`PENDING`) 상태에서만 수정·삭제 허용
- **운영진 답변**: 문의당 답변 1건 보장. 답변 등록 시 완료 여부(`complete`) 플래그로 처리 단계 분기. 답변 수정·삭제 시 이전 본문 보존
- **문의 생애주기 상태머신**: 사용자·운영진 액션별 전용 엔드포인트가 권한과 현재 상태를 동시에 검증하며 단계적으로 전환
- **AI 답변 초안 생성**: 운영진이 Claude Haiku로 답변 초안을 자동 생성(작성 보조)
- **도배 방지 / 독성 검사**: 운영 정책 기반 작성 한도, 작성·수정 시 Perspective 비동기 독성 검사 후 BLUR 처리
- **SSE 실시간 알림**: 헤더 벨 배지·드롭다운, 토스트 팝업. 멀티탭 구독, 하트비트, 자동 재연결
- **알림 피드 관리**: 최근 알림 조회, 개별·전체 읽음 처리, 개별·전체 삭제, 클릭 시 출처로 이동
- **마이페이지**: 프로필 편집, 비밀번호·로그인 수단 변경, 소셜 계정 연동·해제, 활동 내역(문의·커뮤니티·리뷰·예약 등) 집계, 최근 조회 내역

## 핵심 구현

### 1) 문의 상태머신 — 단일 status 컬럼 + 전환 전용 엔드포인트

문의 한 건의 생애주기를 `INQUIRY_POST.status` 한 컬럼으로 표현합니다. 상태값은 `PENDING`, `IN_PROGRESS`, `COMPLETED`, `USER_COMPLETED`, `CANCELLED`, `DELETE_REQUESTED`, `PRIVATE_REQUESTED`, `PUBLIC_REQUESTED`입니다. `InquiryController`(`/inquiry/**`)는 액션마다 별도 엔드포인트를 두고, 각 엔드포인트가 **행위자 권한 + 현재 상태**를 함께 검증합니다.

- 수정과 삭제는 상태로 잠급니다. `edit`은 현재 상태가 `PENDING`이 아니면 400을 반환해, 답변이 달려 `IN_PROGRESS` 이상이 된 문의의 본문 변조를 구조적으로 차단합니다. `delete`는 `PENDING` 또는 `CANCELLED`에서만 허용합니다.
- 사용자의 삭제·공개전환은 **요청과 운영진 승인을 분리**합니다. 완료된 문의는 운영 기록이므로 즉시 삭제를 막고, 사용자는 `delete-request`로 `DELETE_REQUESTED`만 만들 수 있으며 실제 삭제는 운영진의 `delete-approve`에서 수행됩니다. 사용자는 `delete-cancel`로 다시 `COMPLETED`로 되돌릴 수 있습니다.
- 완료의 주체를 구분하기 위해 운영진 완료(`COMPLETED`)와 사용자 자가 종료(`USER_COMPLETED`)를 별도 상태로 둡니다.

전환 시각은 `InquiryMapper.xml`의 `updateStatusWithTime`가 단일 UPDATE 안에서 CASE 식으로 해당 컬럼만 채웁니다. 새 상태에 대응하는 시각 컬럼에만 `NOW()`를 넣고 나머지는 기존값을 유지하므로, 처리 소요 시간 같은 운영 지표를 사후 집계할 수 있습니다.

```sql
in_progress_at = CASE WHEN #{status} = 'IN_PROGRESS' THEN NOW() ELSE in_progress_at END,
completed_at   = CASE WHEN #{status} IN ('COMPLETED','USER_COMPLETED') THEN NOW() ELSE completed_at END,
cancelled_at   = CASE WHEN #{status} = 'CANCELLED' THEN NOW() ELSE cancelled_at END,
...
```

### 2) 운영진 답변과 답변 변경 이력 보존

답변은 문의당 1건만 존재하도록 `INQUIRY_ANSWER` 테이블에 `UNIQUE KEY (inquiry_id)`(uq_inquiry_answer) 제약을 둡니다. `InquiryServiceImpl.writeAnswer`는 답변을 저장한 뒤 `complete` 플래그로 상태를 분기합니다. 완료 답변이면 `COMPLETED`, 단순 답변이면 `IN_PROGRESS`입니다.

답변 수정·삭제 시에는 변경 직전 본문을 `INQUIRY_ANSWER_HISTORY`에 적재해 추적성을 확보합니다. `updateAnswer`/`deleteAnswer`가 공통 `archiveAnswer`를 호출해 이전 본문·이전 답변자·변경 수행자·변경 유형(`UPDATE`/`DELETE`)을 기록하며, 운영진은 `GET /inquiry/{id}/answer/history`로 이력을 조회할 수 있습니다.

### 3) 권한 검증 — 두 가지 패턴의 혼용

같은 컨트롤러 안에서 두 가지 권한 검증 방식을 함께 사용합니다.

- 대부분의 엔드포인트는 컨트롤러 내부 `isAdmin(session)`/`getLoginUserIdx(session)` 헬퍼로 직접 판정합니다. 이때 `auth` 담당자의 VO를 직접 import하지 않고 **리플렉션으로 세션 속성에 접근**해 담당자 간 모듈 결합을 낮췄습니다.
- 일부 운영진 전용 엔드포인트(`answer/edit`, `answer/history`, `clear-blur`)는 AOP 어노테이션 `@RequireAdmin` + `@LoginUser` 파라미터 주입으로 처리합니다(ADR-0011: 어노테이션 기반 권한 체크 + 글로벌 예외 핸들러).

### 4) SSE 실시간 알림 — 발행·전파·구독

알림 발행의 단일 진입점은 `MyPageService.addNotification(FeedNotificationDto)`입니다. 이 메서드는 먼저 `MYPAGE_FEED_NOTIFICATION`에 영속화한 뒤, `NotificationSseService.sendTo`로 해당 사용자에게 실시간 푸시합니다. **푸시는 DB 저장과 분리해 try/catch로 감싸** SSE 전파가 실패해도 알림이 유실되지 않게 했습니다(저장은 이미 성공한 상태).

```java
myPageMapper.insertNotification(notification);
try {
    notificationSseService.sendTo(notification.getUserIdx(), notification);
} catch (Exception e) {
    log.warn("SSE 푸시 실패 (DB 저장은 완료): userIdx={}", notification.getUserIdx(), e);
}
```

`NotificationSseService`는 한 사용자가 여러 탭을 열 수 있으므로 `ConcurrentHashMap<Long, List<SseEmitter>>`(리스트 구현체는 `CopyOnWriteArrayList`)로 emitter를 관리합니다. 주요 설계점은 다음과 같습니다.

- **타임아웃 30분** 후 브라우저(EventSource)가 자동 재연결합니다.
- **30초 주기 하트비트**(`@Scheduled`)로 주석 라인(`ping`)을 보내 프록시·방화벽의 idle timeout을 회피합니다.
- emitter의 `onCompletion`/`onTimeout`/`onError` 콜백에서 리스트에서 자기 자신을 제거하고, 리스트가 비면 맵 엔트리까지 정리합니다.
- 구독 직후 `connect` 이벤트를 즉시 보내 프록시가 응답을 버퍼링하지 않도록 유도합니다.

구독 컨트롤러 `NotificationSseController`(`GET /sse/notifications`)는 비로그인 시 401을 반환하고, Nginx 등 역방향 프록시가 스트림을 버퍼링하지 않도록 `X-Accel-Buffering: no`, `Cache-Control: no-cache` 헤더를 강제합니다.

### 5) 알림 표시 — 헤더 벨과 피드 API

헤더 알림 벨에 필요한 데이터는 `NotificationInterceptor`가 모든 페이지의 `postHandle`에서 Model에 주입합니다. 로그인 사용자에 한해 안읽음 개수(`headerUnreadCount`)와 최근 5개(`headerRecentNotifications`)를 넣고, `ModelAndView`가 없는 AJAX 응답에는 영향이 없도록 가드합니다.

동적 조회·조작은 `NotificationController`(`/api/notifications`)가 REST로 제공합니다. 최근 N개(`/recent`), 전체 목록(`/all`), 안읽음 개수 배지(`/unread-count`), 개별 읽음(`/{id}/read`, targetUrl 반환), 전체 읽음(`/read-all`), 개별·전체 삭제를 지원합니다. 읽음·삭제 같은 변경 작업은 **알림 소유자 본인인지 확인**한 뒤(`noti.getUserIdx().equals(user.getUserIdx())`) 아니면 403을 반환합니다.

알림 클릭 시 이동할 경로는 발행부에서 직접 문자열을 만들지 않고 `NotificationUrlBuilder` 유틸을 경유합니다. `inquiry(id)`, `community(postId)`, `communityComment(postId, commentId)` 등 출처별 상대경로(contextPath 제외)를 한곳에서 생성해 경로 규칙을 통일했습니다.

### 6) addNotification 크로스모듈 발행

`addNotification`은 알림을 발생시키는 거의 모든 모듈에서 호출하는 공용 발행 지점입니다. 실제 호출처는 `inquiry`(답변 등록), `community`(댓글·답글·좋아요 등), `admin`(운영진 조치), `report`(신고 처리), `reward`(레벨업), `myPage/WalletServiceImpl`(지갑) 등 여러 모듈에 걸쳐 있습니다. 각 모듈은 `FeedNotificationDto`에 `userIdx`·`sourceType`·`sourceId`·`message`·`targetUrl`만 채워 넘기면, 영속화와 실시간 푸시는 `MyPageService`가 일괄 처리합니다. 문의 답변 발행 예시는 다음과 같습니다.

```java
FeedNotificationDto notification = new FeedNotificationDto();
notification.setUserIdx(inquiry.getUserIdx());
notification.setSourceType("inquiry");
notification.setSourceId(inquiryId);
notification.setMessage("문의에 답변이 등록되었습니다.");
notification.setTargetUrl(NotificationUrlBuilder.inquiry(inquiryId));
myPageService.addNotification(notification);
```

### 7) 마이페이지 — 프로필·계정·소셜 연동

마이페이지 메인(`ProfileController#myPage`)은 항상 세션 캐시가 아닌 **DB에서 최신 사용자 정보를 다시 조회**해 세션을 갱신한 뒤, 커뮤니티·문의·리뷰·여행일정·항공/패키지 예약·알림·최근 조회 내역 등을 한 화면에 집계합니다. 진입 시 미지급 레벨업 보상을 한 번 자동 정산하고, 미읽은 levelup 알림 중 최고 레벨만 골라 팝업으로 표시한 뒤 해당 알림들을 읽음 처리합니다.

계정 관리는 보안을 고려해 단계적으로 처리합니다.

- 회원정보 수정 진입 전 비밀번호 재확인(`/edit-confirm`)을 거치며, 통과 시 세션 플래그(`editVerified`)를 둡니다. 소셜 전용 계정처럼 비밀번호가 없는 계정은 확인을 건너뜁니다.
- 비밀번호·로그인 수단(아이디/이메일 로그인) 변경 시 실패 이벤트를 감사 로그로 기록하고, 사용 가능한 로컬 로그인 수단이 모두 사라지면 비밀번호를 함께 해제하는 등 일관성을 유지합니다.

소셜 계정 연동·해제는 `AuthController`가 담당합니다. 연동은 `/auth/link/{provider}` → OAuth 콜백(`/auth/link/{provider}/callback`)으로 진행하며, Naver·Google은 CSRF 방지를 위해 발급·소비하는 `state` 토큰을 검증합니다. 해제는 `POST /auth/unlink`로, 마지막 로그인 수단까지 끊기는 위험 상황은 서비스단에서 `IllegalStateException`으로 막습니다. 마이페이지 수정 화면은 `socialLinkMap`과 연동 개수를 받아 제공자별 연동 상태를 표시합니다.

## 설계 결정과 트레이드오프

- **상태를 단일 status 컬럼으로 모음**: 수정·삭제·답변 가능 여부를 if 한 줄(현재 상태 비교)로 일관되게 강제할 수 있습니다. 다만 상태를 enum으로 강타입화하지 않고 문자열 상수로 비교하며, 단일 컬럼 기반이라 동시 요청에 대한 낙관적 잠금 같은 동시성 제어는 두지 않았습니다(현 트래픽 수준에서 의도적으로 단순화).
- **사용자 삭제 요청과 운영진 승인 분리**: 완료된 문의는 운영 기록이므로 사용자가 일방적으로 데이터를 지우지 못하게 했습니다. ADR-0008(소프트삭제 원칙)과 같은 철학의 운영 안전장치입니다.
- **권한 검증 두 방식 혼용**: 기존 컨트롤러 내부 `isAdmin` 방식 위에, 신규/정리 대상 엔드포인트는 `@RequireAdmin` AOP로 전환했습니다(ADR-0011). 점진적 이행 과정에서 두 방식이 공존합니다.
- **세션 접근에 리플렉션 사용**: 컨트롤러가 `auth` 모듈 VO에 직접 의존하지 않도록 리플렉션으로 세션 속성을 읽습니다. 컴파일타임 타입 안정성을 일부 포기한 대신 담당자 간 모듈 결합도를 낮췄습니다.
- **알림은 저장 우선, 푸시는 best-effort**: DB insert와 SSE 전파를 분리해 푸시 실패가 알림 유실로 이어지지 않게 했습니다. 끊긴 연결(다른 탭/오프라인)은 다음 폴링·재접속 시 DB에서 복구됩니다.
- **AI 초안은 fail-safe**: AI 호출이 실패해도 빈 문자열을 반환해 운영진의 수동 답변 작성을 막지 않습니다. inquiry 모듈은 전용 API 키(`inquiry.claude.api.key`)를 사용해 다른 AI 기능과 완전히 분리했습니다.
- **첨부 검증**: 확장자·MIME·5MB 화이트리스트로 이미지 첨부를 검증합니다(ADR-0007 관련). 검증 유틸의 공통화는 TODO로 남아 있습니다.

## 데이터 모델 / 연동

| 테이블 | 역할 |
| --- | --- |
| `INQUIRY_POST` | 문의 본문 + `status` + 전환 시각 컬럼(`in_progress_at`/`completed_at`/`cancelled_at`/`delete_requested_at`/`visibility_requested_at`) + `is_private`/`view_count`/`ai_flagged` |
| `INQUIRY_ANSWER` | 문의당 답변 1건(`UNIQUE KEY uq_inquiry_answer`), 답변자(`admin_user_idx`) |
| `INQUIRY_ANSWER_HISTORY` | 답변 수정·삭제 직전 본문 보존(`prev_content`/`change_type` UPDATE·DELETE) |
| `INQUIRY_ATTACHMENT` | 첨부 이미지 메타(URL·파일명) |
| `MYPAGE_FEED_NOTIFICATION` | 피드 알림(`source_type`/`source_id`/`message`/`target_url`/`is_read`), `idx_user_unread(user_idx, is_read, created_at DESC)` 인덱스로 안읽음 조회 최적화 |

외부 연동: 첨부 이미지는 Cloudinary 업로드(`CloudinaryService`, ADR-0007), 답변 초안은 Anthropic Messages API(Claude Haiku 모델), 작성·수정 본문은 Perspective API 비동기 독성 검사(ADR-0010), 실시간 알림은 SSE(`text/event-stream`)로 브라우저에 전달합니다.

## 사용 기술

- **백엔드**: Spring Boot 4 / Java 21, Spring MVC `@Controller`·`@RestController`, MyBatis(`*Mapper.xml`), MySQL
- **실시간**: Spring `SseEmitter`(서버 발신 이벤트), `@Scheduled` 하트비트, 브라우저 `EventSource` 자동 재연결
- **권한·보안**: 세션 기반 인증(`loginUser`), `@RequireAdmin` AOP + 글로벌 예외 핸들러(ADR-0011), OAuth state 토큰 검증, 소유자 검증
- **AI / 외부 API**: Anthropic Claude(답변 초안), Perspective(독성 검사), Cloudinary(이미지 저장)
- **프론트**: JSP/JSTL, `spring:message` 기반 i18n(ko/en/ja/zh), 헤더 벨 배지·드롭다운·토스트
