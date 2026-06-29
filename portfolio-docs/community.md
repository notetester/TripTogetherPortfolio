# 커뮤니티 · 신고

여행 정보를 공유하는 게시판 도메인입니다. 단순 CRUD를 넘어 **신뢰·안전(Trust & Safety)** 관점에서 콘텐츠 모더레이션을 설계한 것이 특징입니다. 사용자가 작성한 게시글·댓글은 XSS 정화를 거쳐 저장되고, AI 독성 감지와 사용자 신고가 누적되면 점진적으로 가려지며, 결정적 제재(삭제·차단)는 어드민이 최종 판단합니다.

핵심 설계 철학은 **"자동화는 약한 신호(가림)까지, 결정적 액션은 사람이 판단"** 하는 Human-in-the-Loop Moderation입니다(ADR-0001). AI 거짓 양성(false positive)이나 단순 불편 신고로 정상 콘텐츠가 부당하게 사라지는 비용을, 어드민 검토 단계로 흡수합니다. 구현은 컨트롤러(`CommunityController` / `ReportController`)·서비스(`CommunityServiceImpl` / `ReportServiceImpl` / `PerspectiveService`)·DB 캐시 컬럼·JSP 렌더링·스케줄러가 한 신호 체계로 맞물려 동작합니다.

## 주요 기능

- **게시글 유형 분기**: 일반 / 팁(`tip`) / 질문(`question`) / 포토(`photo`). 유형별 부가 테이블·검증 규칙 차등 적용
- **댓글·대댓글·채택**: 단일 깊이 대댓글, 질문 게시글의 답변 채택, 댓글 좋아요·정렬(등록순/좋아요순)
- **좋아요·태그**: 좋아요 토글(캐시 동기화 + 알림), 태그 UPSERT 및 태그 간 공출현(co-occurrence) 집계
- **이미지 업로드**: Summernote 인라인 이미지를 Cloudinary 업로드, 본문 `<img>` 파싱으로 썸네일·갤러리 자동 구성, 이미지 없을 시 Pixabay 자동 배정
- **AI 독성 감지**: Google Perspective API 비동기 호출 → 임계값 초과 시 `ai_flagged` 마킹
- **신고 + 3-스트라이크 블러**: 신고 3회 누적 또는 AI 감지 시 일반 사용자 화면에서 BLUR 오버레이, 어드민은 원본 노출
- **신고 상태머신**: `IN_REVIEW → RESOLVED / DISMISSED / CANCELLED`, 중복 신고 3중 방어, 취소본 재활성화
- **소프트 삭제**: 게시글·댓글·계정 모두 `status='DELETED'` 마킹으로 컨텍스트 보존
- **어드민 도구**: 게시글/댓글/유저 차단·해제, BLUR 해제, IP 일괄 차단, 일괄 처리(7종 액션), 뷰 모드 전환
- **카운터 캐시 + 정합성 스케줄러**: `like_count`/`comment_count`/`report_count` 실시간 동기화 + 매일 새벽 재계산

## 핵심 구현

### 1. 게시글 유형과 작성 파이프라인

`CommunityServiceImpl.writePost()`는 작성 요청을 **도배 방지 → 본문 정화 → 유형 검증 → 저장 → 이미지 → 태그 → 유형별 부가 INSERT → 태그 공출현** 순으로 처리합니다(`@Transactional`).

- **도배 방지(rate limit)**: `moderationPolicyService.getPolicy()`에서 윈도우(분)·최대 횟수를 읽어 `countRecentPostsByUser()`로 최근 작성 수를 체크하고, 초과 시 `IllegalStateException`을 던집니다. 컨트롤러는 이를 잡아 **429 Too Many Requests**로 응답합니다. 임계값은 코드 상수가 아니라 정책 테이블에서 주입됩니다(ADR-0009).
- **유형별 부가 테이블**: `tip`이면 `COMMUNITY_POST_TIP`에 카테고리(기본 `other`)를, `question`이면 `COMMUNITY_POST_QUESTION` 행을 추가합니다. 포토 유형은 목록 갤러리 표시를 위해 본문 내 `<img>`가 **최소 3장** 있어야 하며, 미달 시 작성을 거부합니다.
- **태그 처리**: 콤마 구분 문자열을 분해해 `upsertTag()`(존재 시 재사용) → `selectTagId()` → `insertPostTag()`로 연결합니다.

### 2. 이미지 — Summernote 인라인 + 썸네일 추출 + 자동 배정

이미지는 사이드바 첨부가 아니라 **본문 에디터(Summernote) 내부 삽입**을 1순위로 다룹니다(ADR-0002, 0007).

- 에디터에서 이미지를 넣으면 `POST /community/inline-image`가 호출되어 Cloudinary `community/inline/` 폴더에 업로드하고 URL을 돌려줍니다. 이 엔드포인트는 MIME `image/*`·확장자 화이트리스트(`jpg/jpeg/png/gif/webp`)·**5MB 크기 제한**을 검증합니다.
- 저장 시 `collectImageUrlsInHtml()`이 본문 HTML에서 `<img src>`를 파싱해 대표 썸네일·갤러리 후보를 `COMMUNITY_POST_IMAGE`에 저장합니다(포토 3장, 그 외 1장).
- 본문·첨부에 이미지가 하나도 없으면 `assignAutoImage()`가 지역 기반 Pixabay 추천 이미지를 배정해 목록 카드의 빈 썸네일을 방지합니다.
- 대표이미지(`community/`)와 인라인 이미지(`community/inline/`) 폴더를 분리한 이유는, orphan 정리 스케줄러가 **"본문에서 사라진 인라인 이미지만"** 선별 삭제하도록 하기 위함입니다.

### 3. XSS 서버측 정화 — jsoup Safelist (ADR-0005)

신뢰 경계를 서버에 둡니다. 클라이언트 필터링과 별개로 저장 직전 본문을 항상 정화합니다.

- **게시글 본문**: `sanitizeHtml()`이 `Safelist.basicWithImages()`를 확장한 화이트리스트(`COMMUNITY_SAFELIST`)로 정화합니다. 서식·`<img>`·인라인 스타일은 허용하되 `<script>`·`on*` 이벤트 핸들러·`javascript:` URL은 제거됩니다.
- **댓글·대댓글**: plain textarea 입력이므로 `Safelist.none()`으로 **모든 태그를 제거**하고 텍스트만 보존합니다.
- **목록 카드**: `htmlToPlainTextSummary()`가 HTML을 plain text 200자 요약으로 변환해, Summernote HTML이 카드에서 원본 크기로 렌더되는 문제를 막습니다(상세 페이지는 원본 유지).

### 4. AI 독성 감지 파이프라인 — Perspective 비동기 → ai_flagged → BLUR (ADR-0010)

게시글·댓글 작성이 끝나면 컨트롤러가 `PerspectiveService.checkAndFlagPostAsync()` / `checkAndFlagCommentAsync()`를 **`@Async`로 호출**합니다. AI 호출(수 초 지연)이 작성 응답을 막지 않게 하는 설계입니다.

- **HTML 제거 후 검사**: Summernote가 HTML을 저장하므로, Perspective에는 `stripHtml()`로 태그를 벗긴 plain text를 넘깁니다(태그가 인용문으로 오인되어 점수가 왜곡되는 것을 방지).
- **임계값 판단**: `PerspectiveService.isToxic()`은 `TOXICITY` summaryScore(0.0~1.0)를 정책 임계값과 비교합니다. 임계값은 정책 테이블의 민감도 레벨(`STRICT`/`NORMAL`/`LOOSE`)을 `ContentModerationPolicyVO.getToxicityThreshold()`가 각각 0.6 / 0.8 / 0.9로 변환해 산출합니다. **API 실패 시 `false`를 반환하는 fail-safe** 구조라, 외부 장애가 사용자 작성을 막지 않습니다.
- **감지 후 처리**: 임계값 초과 시 `flagPostAsToxic()`이 ① `ai_flagged=1` 마킹, ② SYSTEM 봇 계정 이름으로 `REPORT` 자동 INSERT(어드민 신고 큐 합류), ③ 작성자에게 가림 알림을 발송합니다.
- **렌더링**: 다음 페이지 로드 시 SELECT 결과에 `ai_flagged`가 포함되고, 일반 사용자에게는 JSP가 BLUR 오버레이를, 어드민에게는 원본 + 해제 버튼을 그립니다. 이 풀 스택 흐름(DB → 서비스 → JSP → JS)은 같은 패턴으로 문의(`inquiry`) 모듈에도 동일 적용됩니다.

### 5. 신고 상태머신과 3-스트라이크 블러 (ADR-0001, 0003, 0004)

신고는 `ReportServiceImpl.submitReport()`를 통해 접수되며, **중복 신고 3중 방어**로 보호됩니다.

- **Layer 1 — 사전 SELECT**: `selectReportByUserAndTarget()`로 기존 신고를 조회합니다. `IN_REVIEW`/`RESOLVED`/`DISMISSED`면 거부(`false` 반환 → 컨트롤러가 **409 Conflict**), `CANCELLED`면 `reactivateCancelledReport()`로 재활성화(사용자 의도 변경 케이스).
- **Layer 2 — DB UNIQUE 제약**: `(user_idx, target_type, target_id)` 유니크 키가 SELECT–INSERT 사이 race condition을 막는 최후 보루입니다. 위반 시 `DataIntegrityViolationException`을 잡아 중복으로 처리합니다.
- **3-스트라이크 블러**: 신고 접수 성공 시 `updatePostReportCache()` / `updateCommentReportCache()`가 `report_count`를 증가시킵니다. **임계값(기본 3) 이상이거나 `ai_flagged=1`이면** 일반 사용자 화면에서 BLUR 처리됩니다. 중요한 점은 신고 누적이 `post_status`를 바꾸지 않는다는 것입니다 — 상태는 `ACTIVE`로 유지하고 `report_count`만으로 가림을 결정합니다(ADR-0003). 비(非)블러 → 블러로 전환되는 순간에만 작성자에게 알림을 보냅니다.

| 상황 | `post_status` | `report_count` | 일반 사용자 | 어드민 |
|---|---|---|---|---|
| 정상 | `ACTIVE` | < 임계 | 노출 | 노출 |
| 신고 누적(자동) | `ACTIVE` 유지 | ≥ 임계 | **BLUR 오버레이** | 원본 + 가림 표시 |
| 어드민 직접 차단 | `BLOCKED` | 무관 | **완전 숨김** | 차단 표시 + 해제 |
| 삭제 | `DELETED` | 무관 | 완전 숨김 | 감사 로그에만 |

신고 게시판은 어드민의 **판단 큐**로 동작합니다. 어드민은 건마다 BLUR 유지 / 해제(`clearPostBlur`, 오신고 판정 시 `report_count`·`ai_flagged` 리셋) / 삭제 / 유저 차단 / 기각(`DISMISSED`) 중에서 결정합니다. `RESOLVED`/`DISMISSED` 처리 시 신고자에게 알림이 발송됩니다.

### 6. 소프트 삭제와 카운터 캐시 정합성 (ADR-0006, 0008)

- **소프트 삭제**: `deletePost()`는 `post_status='DELETED'`, `deleteComment()`는 `comment_status='DELETED'`로 마킹합니다. 실제 행을 지우지 않아 신고·감사 컨텍스트가 보존되고 복구가 가능합니다. 어드민 직접 차단은 `BLOCKED`로, 같은 상태 컬럼 안에서 일관되게 표현됩니다.
- **카운터 캐시**: `like_count`/`comment_count`/`report_count`는 매 조회 시 `COUNT(*)`를 돌리는 대신 캐시 컬럼으로 보관하고, 토글·작성·삭제·신고 시점에 같은 트랜잭션 안에서 `+1/-1` 동기화합니다. 인기순 정렬(`ORDER BY like_count DESC`)도 인덱스로 처리됩니다.
- **정합성 안전망**: `CommunityCacheReconcileScheduler`가 매일 새벽 4:30(KST) `reconcilePostCounts()` / `reconcileCommentCounts()`로 실제 행 수를 다시 집계해 캐시를 정정합니다. 댓글 수는 `comment_status != 'DELETED'`, 신고 수는 `status != 'CANCELLED'` 기준으로 재계산되어 사용자 표시값과 일치합니다. 동시성 누락이나 DB 직접 조작이 있어도 24시간 내 자동 복구되는 **Eventually Consistent** 설계입니다.

### 7. 태그 공출현과 어드민 일괄 처리

- **태그 공출현**: `updateTagRelation()`이 한 게시글의 태그 쌍마다 `upsertTagRelation()`으로 동시 등장 횟수를 누적합니다(태그 추천 기반 데이터).
- **일괄 처리**: `POST /community/admin/bulk`(게시글) / `bulk/comment`(댓글)는 `delete`, `blockUser`, `blockIp`, `blockBoth`, `blockUserAndDelete`, `blockIpAndDelete`, `blockAndDelete` 7종 액션을 분기합니다. IP 차단은 대상 게시글/댓글의 작성 IP를 모아 `IpBlockMapper.insertBlockedIps()`로 일괄 등록합니다. 모든 어드민 액션은 컨트롤러에서 역할(`isAdminLike()`)을 검사해 비관리자에게 **403**을 반환합니다.

## 설계 결정과 트레이드오프

- **자동 차단 대신 BLUR + 어드민 판단(ADR-0001)**: 교과서 패턴인 "N회 누적 → 자동 차단"은 구현이 단순하지만 false positive 비용이 크고 신고 도배(brigading) 공격에 취약합니다. 자동화를 가림까지로 제한해 부당 제재 위험을 제거했고, 대신 어드민 운영 부담과 판단 UI를 추가로 떠안았습니다.
- **BLUR vs BLOCKED 분리(ADR-0003)**: 신고 누적은 `ACTIVE` 유지 + `report_count` 기반 가림, 어드민 차단은 `BLOCKED` + 완전 숨김으로 분기했습니다. 표시 결정에 두 컬럼을 함께 봐야 하는 복잡성은 있으나, 자동(약한 신호)·수동(강한 결정)의 의미를 명확히 구분합니다.
- **비동기 AI 모더레이션(ADR-0010)**: 동기 호출은 작성 응답을 수 초 지연시키므로 `@Async`로 분리했습니다. 트레이드오프로 비동기 호출 실패 시 `ai_flagged`가 갱신되지 않는 구간이 생기며, 재시도 정책은 향후 과제로 남겨두었습니다.
- **캐시 컬럼 + Reconcile vs Redis(ADR-0006)**: 현 규모에서 Redis는 외부 의존성 추가로 과한 선택이라 보고, 캐시 컬럼과 스케줄러로 성능과 정합성을 동시에 확보했습니다. 강한 일관성을 포기하고 24시간 내 수렴을 택한 것입니다.
- **소프트 삭제(ADR-0008)**: Hard Delete는 신고·감사 컨텍스트를 영구히 잃습니다. 이미 존재하는 `status` 컬럼에 `DELETED` 값을 더하는 비용이 가장 낮아 채택했고, 대신 모든 리스트 쿼리에 상태 필터가 필요한 부담을 받아들였습니다.
- **모더레이션 임계값 외부화(ADR-0009)**: rate limit·독성 임계·신고 임계를 코드 상수가 아닌 정책 테이블에서 주입해, 재배포 없이 운영 중 조정할 수 있게 했습니다.

## 데이터 모델 / 연동

**주요 테이블**

- `COMMUNITY_POST` — 본문·`post_status`(ACTIVE/BLOCKED/DELETED)·`post_type`·`region`·`ai_flagged`·캐시 컬럼(`like_count`/`comment_count`/`report_count`)
- `COMMUNITY_COMMENT` — `comment_status`·`parent_comment_id`(대댓글)·`ai_flagged`·`like_count`/`report_count`
- `COMMUNITY_POST_TIP` / `COMMUNITY_POST_QUESTION` — 유형별 부가 정보(팁 카테고리, 질문 해결 여부)
- `COMMUNITY_POST_IMAGE` — 대표/갤러리 이미지(sort_order)
- `COMMUNITY_TAG` / `COMMUNITY_POST_TAG` / 태그 공출현 테이블
- `COMMUNITY_POST_LIKE` / `COMMUNITY_COMMENT_LIKE` — 좋아요 원장(캐시 컬럼의 정합성 기준)
- `REPORT` — `target_type`(post/comment/review/user)·`status`(IN_REVIEW/RESOLVED/DISMISSED/CANCELLED)·`UNIQUE(user_idx, target_type, target_id)`

**외부 연동**

- **Google Perspective API** (`perspective.api.key`) — 한국어(`ko`) TOXICITY 점수
- **Cloudinary** — 게시글·인라인 이미지 CDN 저장
- **Pixabay** — 이미지 없는 게시글의 지역별 자동 썸네일

**모듈 연계**: 좋아요·댓글·가림 이벤트는 `MyPageService.addNotification()`으로 알림 발송, 작성·좋아요는 `RewardService.awardAction()`으로 보상 지급, AI 감지 시 `ReportService.submitReport()`로 신고 큐에 자동 합류합니다.

## 사용 기술

- **백엔드**: Spring Boot 4 / Java 21 / MyBatis / MySQL, `@Transactional` 트랜잭션 경계, `@Async` 비동기, `@Scheduled` 배치
- **보안·모더레이션**: jsoup Safelist 서버측 XSS 정화, Google Perspective API, IP·계정 차단, 역할 기반 권한 검사, 중복 신고 3중 방어(DB UNIQUE + 사전 SELECT + 재활성화)
- **프론트/뷰**: JSP·JSTL, Summernote 에디터(인라인 이미지 후크), AJAX 댓글 프래그먼트, BLUR 오버레이 UI
- **외부 연동**: Cloudinary(이미지 CDN), Pixabay(자동 이미지)
- **설계 근거**: ADR-0001 ~ 0010 (모더레이션 정책, BLUR/BLOCKED 분기, 중복 신고 방지, XSS 정화, 캐시 정합성, 소프트 삭제, 정책 외부화, AI 파이프라인)
