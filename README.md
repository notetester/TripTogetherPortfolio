# TripTogether

여행 커뮤니티/플래너 통합 플랫폼. 사용자가 여행 코스를 짜고, 후기·팁·사진을 공유하며, AI 챗봇과 어시스턴트로 여행 계획을 보조받는 웹 서비스.

> 팀 프로젝트. 본 README 는 **Victor Jung 담당 영역 (커뮤니티 / 신고 / 문의 모듈)** 위주로 정리되어 있습니다.

---

## 기술 스택

| 영역 | 기술 |
|---|---|
| Backend | Spring Boot 4.0.5, Java 21, MyBatis |
| Frontend | JSP, jQuery, Summernote |
| Database | MySQL 8 |
| Build | Maven (WAR 패키징) |
| External API | Cloudinary, Google Perspective, Anthropic Claude, Google Gemini |
| 보안 | jsoup HTML Sanitizer, BCrypt, Servlet Session |
| i18n | Spring MessageSource (ko / en / ja / zh) |

---

## 담당 모듈

### 커뮤니티 (`/community`)

- 게시글 CRUD, 4가지 유형 (review / photo / tip / question)
- **Summernote WYSIWYG** 본문 + **Cloudinary** 인라인 이미지 (Phase 2)
- 댓글 / 대댓글 / 좋아요 / 신고 / 채택 (질문 유형)
- **AI 독성 감지** (Google Perspective) + 자동 BLUR 처리
- **캐시 컬럼** (like_count / comment_count / report_count) + **일일 Reconcile 스케줄러** 로 정합성 안전망
- **인라인 이미지 orphan 정리 스케줄러** (jsoup 으로 본문 HTML 의 사용 중 이미지 추적)
- 어드민 일괄 차단 / 삭제 / IP 차단 도구

### 신고 (`/report`)

- post / comment / reply / user 통합 신고 처리
- **신고 게시판 = 어드민 판단 큐** (Human-in-the-Loop Moderation)
- **중복 방지 3중 방어**: DB UNIQUE + 서비스 사전 SELECT + CANCELLED 재활성화
- 4단계 상태 머신 (IN_REVIEW / RESOLVED / DISMISSED / CANCELLED)
- 자동 제재는 BLUR 까지, 콘텐츠 삭제 / 유저 차단은 어드민 수동 결정
- 처리 결과 신고자 알림

### 문의 (`/inquiry`)

- 1:1 문의 작성 / 조회 / 수정 / 삭제, 비공개 처리
- 어드민 답변 작성, **AI 초안 생성** (Claude 3.5 Haiku)
- **7단계 상태 머신** (PENDING / IN_PROGRESS / COMPLETED / USER_COMPLETED / CANCELLED / DELETE_REQUESTED / PRIVATE_REQUESTED / PUBLIC_REQUESTED)
- Cloudinary 첨부파일 (이미지 화이트리스트 검증)

---

## 아키텍처 결정 기록 (ADR)

주요 설계 결정은 [`docs/adr/`](./docs/adr/) 에 [MADR 0.6](https://adr.github.io/madr/) 표준 양식으로 기록되어 있습니다.

| ID | 제목 |
|---|---|
| [ADR-0001](./docs/adr/0001-report-no-auto-user-block.md) | 신고 누적 자동 제재 범위 — BLUR 까지, 그 외 어드민 수동 판단 |
| [ADR-0002](./docs/adr/0002-summernote-editor.md) | 커뮤니티 글쓰기 WYSIWYG — Summernote 채택 |
| [ADR-0003](./docs/adr/0003-blur-vs-blocked-policy.md) | BLUR vs BLOCKED 분기 정책 |
| [ADR-0004](./docs/adr/0004-duplicate-report-prevention.md) | 중복 신고 방지 — 3중 방어 |
| [ADR-0005](./docs/adr/0005-xss-server-sanitize.md) | XSS 방지 — jsoup Safelist 서버측 sanitize |
| [ADR-0006](./docs/adr/0006-counter-cache-reconcile.md) | 캐시 컬럼 + Reconcile 스케줄러 |
| [ADR-0007](./docs/adr/0007-cloudinary-image-storage.md) | 이미지 스토리지 — Cloudinary 외부 CDN |
| [ADR-0008](./docs/adr/0008-soft-delete-pattern.md) | Soft Delete 패턴 — `status='DELETED'` |
| [ADR-0009](./docs/adr/0009-moderation-policy-externalization.md) | 모더레이션 정책 외부화 — `ContentModerationPolicyVO` |
| [ADR-0010](./docs/adr/0010-ai-moderation-pipeline.md) | AI 모더레이션 풀 스택 파이프라인 |
| [ADR-0011](./docs/adr/0011-authorization-aop-and-global-exception-handler.md) | 어노테이션 기반 권한 체크(AOP) + 글로벌 예외 처리 |
| [ADR-0012](./docs/adr/0012-spring-security-csrf-partial-adoption.md) | Spring Security CSRF 부분 도입 |
| [ADR-0013](./docs/adr/0013-i18n-api-message-coverage.md) | API 응답 메시지 i18n 적용 (4개 언어) |
| [ADR-0014](./docs/adr/0014-junit-test-strategy.md) | JUnit 테스트 전략 — Service 단위 + ADR 검증 |

→ 전체 인덱스 및 작성 가이드: [`docs/adr/README.md`](./docs/adr/README.md)

---

## 자주 받는 오해 (FAQ)

코드만 분석할 때 결함으로 오인되기 쉬운 부분을 정리합니다. 자동화된 코드 리뷰 도구가 아래 항목을 결함으로 분류할 수 있으나, 모두 **의도된 설계**입니다.

### Q1. 신고 누적 시 유저 자동 차단이 미구현 아닌가요?

**의도된 정책입니다.** 자동 제재는 콘텐츠 BLUR 까지만 수행하고, 콘텐츠 삭제·유저 차단은 어드민 수동 결정으로 둡니다. 사용자들이 단순한 불편/취향 차이만으로도 신고할 수 있어서 자동 제재의 false positive 비용이 매우 크기 때문입니다. Reddit AutoModerator, Discord AutoMod, YouTube Trust & Safety 가 사용하는 **Human-in-the-Loop Moderation** 표준 패턴과 일치합니다.

→ 상세: [ADR-0001](./docs/adr/0001-report-no-auto-user-block.md)

### Q2. 중복 신고 방지가 보이지 않는데요?

**3중 방어로 구현되어 있습니다.** ① DB UNIQUE 제약(`REPORT.uq_report`) ② 서비스 사전 SELECT 체크(`selectReportByUserAndTarget`) ③ CANCELLED 재활성화 분기. 동시성 이슈와 사용자 의도 변경(취소 → 재신고) 시나리오를 모두 커버합니다.

→ 상세: [ADR-0004](./docs/adr/0004-duplicate-report-prevention.md)

### Q3. `post_status='BLOCKED'` 와 `report_count>=3` 가 다른 의미인가요?

**예, 명확히 분리되어 있습니다.** 자동 BLUR(신고 누적, ACTIVE 유지)와 어드민 직접 차단(BLOCKED, 완전 숨김)은 다른 신뢰 신호를 표현합니다. 같은 status 컬럼에 합치면 의미 모순(BLOCKED 면 blind 되어야 하는데 BLUR 오버레이는 사용자 펼침을 전제) 이 발생하므로 분리했습니다.

→ 상세: [ADR-0003](./docs/adr/0003-blur-vs-blocked-policy.md)

### Q4. 도배 방지 정책의 시간/횟수 제한이 하드코딩 아닌가요?

**아닙니다, 정책 객체로 외부화되어 있습니다.** `ContentModerationPolicyVO` (`moderation` 모듈) 가 시간 윈도우/최대 횟수를 보유하며, 커뮤니티·문의 등 모든 모듈이 `ModerationPolicyService.getPolicy()` 로 가져와 사용합니다. 코드의 숫자 리터럴은 정책 객체 주입 결과이지 magic number 가 아닙니다.

```java
ContentModerationPolicyVO policy = moderationPolicyService.getPolicy();
if (countRecent(...) >= policy.getInquiryMaxCount()) { ... }
```

→ 상세: [ADR-0009](./docs/adr/0009-moderation-policy-externalization.md)

### Q5. AI 독성 감지 BLUR 이 화면에 반영 안 되는 거 아닌가요?

**풀 스택 구현 완료입니다.** Perspective API 비동기 호출 → `ai_flagged` 컬럼 → JSP `isBlurred` 조건 → 어드민 배지 / 일반 사용자 BLUR 오버레이 / 어드민 해제 버튼까지 전체 파이프라인이 동작합니다. Java 코드만 보면 보이지 않으므로 JSP/CSS 까지 함께 보아야 합니다.

| 레이어 | 위치 |
|---|---|
| API 호출 | `PerspectiveService` (비동기) |
| 서비스 | `flagInquiryAsToxic()`, `clearInquiryBlur()` |
| DB | `inquiry.ai_flagged` 컬럼 |
| JSP | `list.jsp` `<c:set var="isBlurred" .../>` + `detail.jsp` 어드민 배지 |
| JS | 어드민 BLUR 해제 fetch 핸들러 |

→ 상세: [ADR-0010](./docs/adr/0010-ai-moderation-pipeline.md)

---

## 실행

```bash
# 개발 모드 (hot reload)
./mvnw spring-boot:run

# WAR 빌드
./mvnw clean package -DskipTests

# 테스트
./mvnw test
```

서비스: `http://localhost:8080/TripTogether`

---

## 데이터베이스

`TripTogetherDB.sql` 에 전체 스키마와 샘플 데이터가 포함되어 있습니다.

주요 테이블:
- `COMMUNITY_POST`, `COMMUNITY_COMMENT`, `COMMUNITY_LIKE`, `COMMUNITY_TAG`, `COMMUNITY_POST_IMAGE`
- `REPORT` (UNIQUE 제약 `uq_report (user_idx, target_type, target_id)`)
- `INQUIRY_POST`, `INQUIRY_ANSWER`, `INQUIRY_ATTACHMENT`
- `USERS` (`account_status` 컬럼이 차단/탈퇴 상태 표현)

---

## 프로젝트 구조

```
src/main/
├── java/org/triptogether/
│   ├── community/        ← 본 README 담당 모듈
│   ├── report/           ← 본 README 담당 모듈
│   ├── inquiry/          ← 본 README 담당 모듈
│   ├── auth/             (다른 팀원 담당)
│   ├── courses/          (다른 팀원 담당)
│   ├── admin/            (공동)
│   ├── myPage/           (공동)
│   └── ...
├── resources/
│   ├── mapper/           ← MyBatis SQL XML
│   ├── messages/         ← i18n 4개국어
│   └── application.properties
└── webapp/WEB-INF/views/ ← JSP 뷰

docs/adr/                  ← 아키텍처 결정 기록 (MADR 표준)
```

---

## 라이선스 / 저자

* 담당자: Victor Jung (jungwonil11@gmail.com)
* 팀 프로젝트
