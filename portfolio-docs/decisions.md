# 설계 결정 (ADR 종합)

TripTogether는 주요 아키텍처·정책 결정을 **ADR(Architecture Decision Record)** 로 명문화했습니다. 단순히 "이렇게 짰다"가 아니라, *어떤 맥락에서, 어떤 대안을 검토하고, 왜 그 선택을 했는지* 를 [MADR](https://adr.github.io/madr/) 형식으로 14건(`docs/adr/0001~0014`) 기록했습니다. 이 문서는 그 14개 결정을 채용 담당자가 한눈에 읽을 수 있도록 **맥락 → 결정 → 근거** 순으로 압축 종합한 것입니다.

이 결정들은 신고 모듈 정책, 커뮤니티, 보안/공통, 인프라 4개 영역으로 나뉘며, 대부분이 *Trust & Safety(콘텐츠 모더레이션)* 라는 일관된 철학 — **자동화는 약한 신호까지, 결정적 액션은 인간이 판단(Human-in-the-Loop)** — 으로 연결됩니다. 마지막에는 비공개 원본을 공개 레포로 전환하면서 적용한 **민감정보 제거 및 배포 시점 시크릿 스캔 게이트**를 함께 정리합니다.

## 신고·모더레이션 정책

### ADR-0001 — 신고 누적 자동 제재 범위: BLUR 까지, 그 외 어드민 수동 판단
신고는 단순 불편·취향 차이만으로도 발생하므로 *N회 누적 → 자동 차단* 의 교과서 패턴은 false positive(오신고 제재) 비용이 큽니다. 따라서 자동화 경계를 **신고 3회 누적 시 콘텐츠 BLUR 처리 + 신고 게시판 INSERT** 까지로만 긋고, 글 삭제·유저 차단 같은 결정적 액션은 어드민이 5가지 액션(BLUR 유지/해제/삭제/차단/기각) 중 직접 선택하게 했습니다. 신고 게시판이 *Admin Decision Queue* 로 동작하며, 이는 Reddit AutoModerator·Discord AutoMod 등 업계 표준인 Human-in-the-Loop Moderation 패턴과 일치합니다. (`ReportServiceImpl.submitReport()`, `CommunityServiceImpl.updatePostReportCache()`)

### ADR-0003 — BLUR vs BLOCKED 분기 정책
자동 처리(신고 누적)와 어드민 처리(직접 차단)는 표시 방식도 달라야 합니다. 초기 설계는 *"신고 3회 → BLOCKED + BLUR"* 로 합쳐져 있었으나, BLOCKED는 완전 숨김이라 BLUR 오버레이 개념과 모순됩니다. 이를 분리해 **신고 누적은 `post_status='ACTIVE'` 유지 + BLUR 오버레이(점진적 공개, 클릭 시 펼침)**, **어드민 직접 차단은 `post_status='BLOCKED'`(완전 숨김)** 로 정의했습니다. BLUR 렌더링 조건은 `report_count >= 3 AND !isAdminMode` 단일 규칙으로, `post_status` 와 무관합니다. (`clearPostBlur()`, `blockPost()`)

### ADR-0004 — 중복 신고 방지: 3중 방어
같은 사용자의 동일 대상 중복 신고를 막되, 취소했던 신고의 재활성화도 자연스럽게 처리해야 했습니다. 단일 수단은 모두 한계가 있어(UNIQUE만 → 친절한 응답 불가, SELECT 체크만 → race condition) **3중 방어**를 채택했습니다: ① DB `UNIQUE KEY uq_report(user_idx, target_type, target_id)`(최후 보루, 동시성 차단), ② 서비스 사전 SELECT 체크(`selectReportByUserAndTarget`, 사용자 친화 응답), ③ `CANCELLED` 상태면 UNIQUE 위반 없이 UPDATE로 재활성화(`reactivateCancelledReport`). 동시성·UX·사용자 의도 변경을 한 번에 커버합니다. (`ReportServiceImpl.submitReport()`)

## 커뮤니티

### ADR-0002 — 커뮤니티 글쓰기 WYSIWYG: Summernote 채택
JSP + jQuery 스택에 번들러 파이프라인이 없는 환경에서, 본문에 이미지를 자유롭게 섞는 에디터가 필요했습니다. Toast UI·Quill·TipTap·CKEditor 5를 검토했으나, **Summernote**가 이미 로드된 jQuery 위에 CDN 한 줄로 도입되고, `onImageUpload` 후크가 단순해 이미지 저장 방식을 base64(Phase 1) → Cloudinary(Phase 2)로 한 곳만 바꿔 전환할 수 있으며, 한국어 lang 팩을 공식 지원해 선택했습니다. HTML 직접 출력의 XSS 위험은 ADR-0005로 보완합니다. (`community/write.jsp`)

### ADR-0006 — 캐시 컬럼 + Reconcile 스케줄러: 카운트 정합성
리스트 페이지에서 글마다 좋아요·댓글·신고 수를 `COUNT(*)` 서브쿼리로 조회하면 N×3 서브쿼리로 성능이 급락합니다. 그래서 `like_count`·`comment_count`·`report_count` **캐시 컬럼**에 갱신 시점(`@Transactional` 내)에 증감을 누적해 조회 비용을 0으로 만들고, 인기순 정렬에 인덱스를 활용합니다. 캐시의 약점인 정합성 깨짐은 **매일 새벽 4시 Reconcile 스케줄러**(`CommunityCacheReconcileScheduler`)가 전체 카운트를 재계산해 24시간 내 자동 복구하는 안전망으로 보완합니다. CAP 관점에서 *Eventually Consistent* 설계입니다.

## 보안 · 공통

### ADR-0005 — XSS 방지: jsoup Safelist 서버측 sanitize
Summernote가 HTML을 그대로 저장하므로 `<script>`·`onerror`·`javascript:` 등 XSS 벡터에 노출됩니다. 클라이언트 필터는 우회 가능하므로(신뢰 경계 원칙) **저장 시점에 jsoup `Safelist.basicWithImages()` 화이트리스트로 정화**합니다. 화이트리스트 방식이라 새 공격 벡터에도 자동 안전하고, jsoup이 인라인 이미지 정리 스케줄러에서 이미 쓰여 추가 의존성이 없으며, 저장 시 1회 정화로 출력 누락 위험이 없습니다. (`CommunityServiceImpl.sanitizeHtml()`, `writePost()`/`editPost()`)

### ADR-0008 — Soft Delete 패턴: `status='DELETED'` 상태 컬럼
Hard Delete는 신고·감사 이력과 복구 가능성을 잃고 FK 연쇄 삭제·캐시 컬럼 정합성 문제를 일으킵니다. 특히 어드민이 신고 게시판(ADR-0001 판단 큐)에서 검토할 때 콘텐츠 컨텍스트가 보존돼야 합니다. 이미 존재하는 `post_status`/`comment_status`/`account_status` 상태 머신 컬럼에 **`'DELETED'` 값을 추가**해, 추가 컬럼 없이 `ACTIVE`/`BLOCKED`/`DELETED`를 한 컬럼에서 일관 표현합니다. 캐시 컬럼은 `comment_status != 'DELETED'` 조건으로 동기화됩니다. (`deletePost()`, `deleteComment()`)

### ADR-0009 — 모더레이션 정책 외부화: `ContentModerationPolicyVO`
도배 방지 윈도우/임계값, 신고 BLUR 임계값 등은 운영 중 자주 조정되고 여러 모듈에서 공유됩니다. 코드 리터럴(재배포 필요)이나 `application.properties`(재시작 필요) 대신 **DB 테이블 + 정책 VO + `ModerationPolicyService`** 로 외부화해, DB UPDATE만으로 운영 중 조정하고 다중 모듈이 단일 출처를 참조하게 했습니다. 코드의 숫자는 `policy.getInquiryMaxCount()` 처럼 정책 객체에서 가져온 값이므로 magic number가 아닙니다. (`ContentModerationPolicyVO`, `ModerationPolicyService`)

### ADR-0010 — AI 모더레이션 풀 스택 파이프라인: Perspective + ai_flagged + JSP BLUR
AI 독성 감지를 작성 시점에 동기 호출하면 응답이 지연되고, false positive를 자동 차단하면 정상 콘텐츠가 사라집니다. 그래서 ADR-0001의 Human-in-the-Loop를 AI 신호에도 일관 적용해 **비동기 호출 → `ai_flagged` 컬럼 → JSP BLUR 렌더링 → 어드민 해제 버튼** 의 풀 스택 파이프라인을 구성했습니다. 커뮤니티 게시글·댓글·문의 세 모듈이 동일 패턴(`flag*AsToxic`/`clear*Blur`)으로 구현되어 재사용성이 높습니다. AI 신호를 자동 차단에 직결하지 않고 "약한 시그널"로 다루는 것이 핵심 철학입니다.

### ADR-0011 — 어노테이션 기반 권한 체크(AOP) + 글로벌 예외 처리
컨트롤러마다 `isAdmin()` 체크와 try/catch→응답 변환 보일러플레이트가 반복되고, `getLoginUserIdx()`·`isAdmin()`이 리플렉션 ad-hoc로 사본 정의돼 있었습니다. URL 패턴 인터셉터는 메서드 단위 분기에 부적합하므로 **AOP `@RequireLogin`/`@RequireAdmin` 어노테이션 + `@LoginUser` ArgumentResolver + `@RestControllerAdvice` 글로벌 핸들러** 조합을 도입했습니다. 시범 적용 결과 컨트롤러 메서드가 23줄 → 8줄(64% 감소)로 줄고 의도가 선언적으로 드러납니다. 기존 코드와의 혼재를 피하기 위해 메서드 단위 점진 마이그레이션(Phase 1~5)을 계획에 명시했습니다. (`common/annotation`, `AuthorizationAspect`, `LoginUserArgumentResolver`)

### ADR-0012 — Spring Security CSRF 부분 도입 + 점진적 확장
자체 세션·인터셉터·AOP로 인증/인가를 처리하던 환경에 CSRF 보호가 없어 모든 POST/PUT/DELETE가 위조 요청에 노출돼 있었습니다. Spring Security 풀 도입은 다른 팀원 담당 모듈의 회귀 위험이 크므로, **본인 담당 영역(`/community`, `/report`, `/inquiry`)의 변경 요청에만 CSRF를 적용**하고 Security의 나머지 기능(formLogin/httpBasic/logout)은 모두 비활성화해 자체 인증과 충돌을 피했습니다(CSRF 필터 1개만 동작하는 모드). `header.jsp`의 monkey-patch로 `fetch`·`$.ajax`에 토큰을 자동 첨부해 기존 코드는 무수정으로 보호됩니다. 다른 모듈로의 확장 경로(Phase 2~4)를 ADR에 남겨 협업 컨텍스트를 고려했습니다. (`SecurityConfig.victorModuleMatcher()`)

### ADR-0013 — API 응답 메시지 i18n: 컨트롤러/서비스까지 4개 언어 일관 적용
CLAUDE.md의 i18n 규칙은 JSP 노출 문자열만 강제했으나, 컨트롤러의 `result.put("message", "한국어")`·서비스의 `IllegalStateException("한국어")`는 규칙 밖이라 다른 로케일 사용자에게도 한국어가 전달됐습니다. "사용자 노출 문자열"의 정신을 백엔드까지 확장해, **본인 담당 모듈의 응답·예외 메시지를 `MessageUtil`(`MessageSource` + `LocaleContextHolder`) 기반 4개 언어(ko/en/ja/zh) i18n 키로 일관 적용**했습니다(약 51개 키). 신규 인프라 도입이 아니라 팀 공통 자산(번역 담당·공통 인프라 담당의 작업)을 본인 영역에 일관 적용한 협업 보강 사례입니다.

### ADR-0014 — JUnit 테스트 전략: Service 단위 + ADR 정책 검증
ADR-0001~0013의 설계 결정이 실제 코드로 동작하는지 검증할 자동화 테스트가 부족했습니다. 풀 통합 테스트(느림)·Mapper 테스트(H2/MySQL 방언 차이)·Controller 슬라이스(부팅 비용) 대신, 핵심 정책이 모두 Service 레이어에 있다는 점에 착안해 **JUnit 5 + Mockito 5 + AssertJ 기반 Service 단위 테스트**를 메인으로 채택했습니다(총 31개, 약 12초). 각 테스트를 ADR 정책에 매핑(예: ADR-0004 3중 방어 → `submitReport_cancelledReactivation_returnsTrue`, ADR-0005 → `addComment_sanitize_removesScriptTag`, ADR-0008 → `deletePost_softDelete_setsStatusDeleted`)해 "정책이 문서가 아니라 검증된 동작"임을 증명하고 회귀를 방지합니다.

## 인프라

### ADR-0007 — 이미지 스토리지: Cloudinary 외부 CDN 채택
Phase 1의 base64 임시 삽입은 DB 사이즈 폭증·응답 무거움·변환 불가 문제가 있었습니다. 자체 디스크·S3+CloudFront·Firebase를 검토했으나, **Cloudinary**가 무료 티어로 포트폴리오 단계 비용이 0이고, URL 파라미터(`w_300,c_fill,f_auto,q_auto`)로 즉석 변환·글로벌 CDN 캐싱을 제공하며, Java SDK가 단순해 Spring 통합 비용이 가장 낮아 채택했습니다. 본문 HTML에 외부 URL만 박히는 구조라, 글을 올리지 않고 업로드만 한 고아 이미지는 **매일 새벽 3시 정리 스케줄러**(`CommunityImageScheduler`, jsoup으로 사용 중 publicId 수집 후 차집합 삭제)로 청소합니다. (`CloudinaryService`)

## ADR 요약표

| ADR | 영역 | 결정 한 줄 |
|---|---|---|
| 0001 | 신고 | 자동 제재는 BLUR까지, 결정적 액션은 어드민 수동(Human-in-the-Loop) |
| 0002 | 커뮤니티 | 글쓰기 WYSIWYG = Summernote (CDN 한 줄, jQuery 적합) |
| 0003 | 신고 | 신고 누적=ACTIVE+BLUR(점진 공개), 어드민 차단=BLOCKED(완전 숨김) |
| 0004 | 신고 | 중복 신고 방지 = DB UNIQUE + 사전 SELECT + CANCELLED 재활성화 3중 방어 |
| 0005 | 보안 | XSS 방지 = jsoup Safelist 서버측 sanitize(저장 시점) |
| 0006 | 커뮤니티 | 카운트 = 캐시 컬럼 + 새벽 Reconcile 스케줄러(Eventually Consistent) |
| 0007 | 인프라 | 이미지 = Cloudinary 외부 CDN + 고아 이미지 정리 스케줄러 |
| 0008 | 공통 | 삭제 = `status='DELETED'` Soft Delete(컨텍스트 보존·복구 가능) |
| 0009 | 공통 | 모더레이션 정책 = DB + 정책 VO 외부화(운영 중 조정, 단일 출처) |
| 0010 | 보안 | AI 모더레이션 = 비동기 Perspective + `ai_flagged` + JSP BLUR + 어드민 해제 |
| 0011 | 보안 | 권한 = AOP 어노테이션 + `@LoginUser` 주입 + 글로벌 예외 핸들러 |
| 0012 | 보안 | CSRF = Spring Security 부분 도입 + monkey-patch 자동 토큰 첨부 |
| 0013 | 공통 | i18n = 컨트롤러/서비스 응답·예외 메시지까지 4개 언어 일관 적용 |
| 0014 | 공통 | 테스트 = Service 단위(JUnit5+Mockito) + ADR 정책 매핑 검증 31개 |

## 보안: 공개 전 민감정보 제거

이 포트폴리오의 공개 레포는 비공개 원본에서 **API 키·비밀번호·DB 접속 정보 같은 민감 리터럴을 전 커밋 이력에서 제거**한 뒤 발행했습니다. 단순히 최신 커밋에서 값을 지우는 것만으로는 `git log`·`git show`로 과거 커밋에서 그대로 복원되므로, 커밋 이력 전체를 다시 쓰는 방식과 발행 시점 차단을 함께 적용했습니다.

### 전 이력 치환 — git filter-repo
`git filter-repo` 의 치환 룰셋으로 **모든 커밋·모든 브랜치에 걸쳐** 민감 문자열을 플레이스홀더로 일괄 치환했습니다. 대상은 다음과 같습니다.

- AI/외부 API 키 — Gemini(`gemini.api.key` / `AIza…` 패턴), Claude(`sk-ant-…`), OpenAI(`sk-proj-…`), Google OAuth 시크릿(`GOCSPX-…`)
- DB 접속 정보 — JDBC URL·계정·비밀번호
- 공통 패스워드 리터럴(예: 팀 공용 계정 비밀번호)

치환 후에는 설정 키의 *이름*(예: `cloudinary.api-key`, `claude.api.key`)만 코드/문서에 남고, 실제 값은 어떤 과거 커밋에서도 복원되지 않습니다. 운영 환경 값은 레포 밖(환경 변수·비공개 설정)에서 주입하는 구조로 정리했습니다.

### 배포 시점 시크릿 스캔 게이트 — GitHub Actions
이력을 한 번 정리해도 이후 작업에서 키가 다시 섞여 들어갈 수 있으므로, **GitHub Pages 배포 워크플로(`.github/workflows/pages.yml`)에 시크릿 스캔 게이트를 두어 발행 자체를 막는 2차 방어선**을 만들었습니다.

- 빌드 잡 첫 단계 *"Secret scan gate"* 가 `demo/`·`portfolio-docs/` 를 정규식으로 스캔
- 탐지 패턴: `AIza…`(Google/Gemini), `sk-ant-…`(Claude), `sk-proj-…`(OpenAI), `GOCSPX-…`(Google OAuth), 공통 패스워드 리터럴
- 하나라도 매치되면 `::error::` 출력 후 `exit 1` 로 **배포 파이프라인 중단** — VitePress 빌드·Pages 업로드 단계로 넘어가지 않음

즉 *이력 정리(git filter-repo)* 로 과거를 청소하고, *배포 게이트(Actions)* 로 미래 유입을 차단하는 이중 방어 구조입니다. 포트폴리오 문서에서도 키의 *이름* 은 언급하되 *값* 은 절대 싣지 않는 원칙을 동일하게 유지합니다.
