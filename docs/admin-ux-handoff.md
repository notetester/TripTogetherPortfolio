# Admin UX Refactor Handoff

작성일: 2026-05-07

이 문서는 관리자 페이지 UI/UX 전면 정리 작업을 다른 자리의 Codex 세션에서 그대로 이어가기 위한 임시 인수인계 문서입니다.

## 현재 작업 지시

- 작업 브랜치: `LEE-JEONG-GUCK`
- 브랜치를 바꾸지 말고 현재 브랜치에서 계속 진행합니다.
- 사용자 확인 없이 왼쪽 관리자 메뉴 순서대로 하나씩 계속 개선합니다.
- 기능 단위가 끝날 때마다 자주 `git add .` 후 짧은 한국어 커밋 메시지로 커밋합니다.
- `git push`는 사용자가 직접 하거나, 사용자가 명시적으로 요청할 때만 진행합니다.
- AGENTS.md에는 Victor/승인 규칙이 남아 있지만, 이 관리자 UX 작업에서는 사용자가 위 지시를 별도로 명시했습니다.

## 목표

관리자 페이지 전체를 회원 관리와 차단 관리 쪽 UX를 기준으로 통일합니다.

핵심 기준:

- 왼쪽 관리자 메뉴에 있는 모든 화면을 하나씩 점검합니다.
- 한 화면을 완전히 정리한 뒤 다음 메뉴로 넘어갑니다.
- 전체를 한꺼번에 대충 바꾸지 말고, 메뉴 단위로 세밀하게 고칩니다.
- 검색/필터/표시 개수/페이지 로드 범위/내보내기/선택 액션 배치를 일관되게 맞춥니다.
- 선택 상태에 따라 버튼 위치가 크게 흔들리지 않게 합니다.
- 모든 옵션이 활성화되어도 툴바가 불필요하게 3줄 이상 늘어나지 않도록 합니다.
- 좁은 화면에서는 미디어 쿼리로 중요도가 낮은 컨트롤을 접거나 드롭다운/세로 배치로 전환합니다.
- 정렬 가능한 컬럼에는 기본 위아래 화살표를 붙이지 않습니다.
- 현재 정렬 중인 컬럼에만 정렬 방향 표시를 붙입니다.
  - 오름차순: 빨간 삼각형
  - 내림차순: 파란 삼각형
- 오래된 인라인 스타일, 무너진 체크박스/라벨 배치, 의미 없는 여백, 중첩 카드 스타일을 정리합니다.

## 기준 화면

현재 기준으로 삼을 화면:

- 회원 관리
- 차단 관리

특히 회원 관리에서 개선한 툴바 패턴:

- 검색/필터는 한 줄에서 최대한 버티되, 폭이 줄면 자연스럽게 접힘
- 선택 액션 바는 위치가 튀지 않게 고정된 역할 영역을 유지
- 내보내기는 형식 선택과 실행 버튼이 안정적으로 배치
- `전체 로드` / `현재 화면` 같은 로드 범위 선택이 필요한 목록은 빠뜨리지 않음
- 표 상단의 표시 개수, 초기화, 내보내기, 선택 액션이 화면마다 비슷한 위치와 밀도로 동작

## 완료된 화면

다음 화면들은 이 흐름에서 이미 정리했습니다.

- 회원 관리
- 기업 신청
- 이메일 액션 요청
- 이메일 액션 토큰
- Provider 설정
- Provider 헬스체크 이력
- 관리자 알림 설정
- 정책 설정
- 로그인 위험 검토
- 외부 위험 판단
- 보안 위험 판단
- 일반 검토 큐
- 이의제기 정책
- 이의제기
- WAF 동기화
- 로그인 감사
- 보안 감사
- 활동 로그
- 재무 대시보드
- 환불 관리
- 재무 정책
- 재무 사용자 상세
- 문의 관리 목록
- 문의 상세
- 신고 관리 목록
- 신고 상세
- 커뮤니티 게시글 목록
- 커뮤니티 댓글 목록

최근 완료 커밋:

- `9465225 커뮤니티 댓글 목록 UX 정리`

## 다음 작업 위치

다음에 이어서 시작할 화면:

1. 커뮤니티 상세
   - 파일: `src/main/webapp/WEB-INF/views/admin/community/detail.jsp`
   - 현재 문제: 인라인 스타일이 많고, 상세 헤더/버튼/태그/메타/신고 이력/댓글/작성자 패널이 오래된 배치입니다.
   - 목표: 커뮤니티 목록/댓글 목록에서 만든 `adm-community-*` 패턴을 상세 화면에도 적용합니다.

2. 탐색 관리
   - `src/main/webapp/WEB-INF/views/admin/explore/list.jsp`
   - `src/main/webapp/WEB-INF/views/admin/explore/detail.jsp`
   - `src/main/webapp/WEB-INF/views/admin/explore/reviews.jsp`

3. 패키지
   - `src/main/webapp/WEB-INF/views/admin/package/list.jsp`

4. 코스
   - `src/main/webapp/WEB-INF/views/admin/courses/list.jsp`
   - `src/main/webapp/WEB-INF/views/admin/courses/detail.jsp`

5. 광고
   - `src/main/webapp/WEB-INF/views/admin/ad/list.jsp`
   - `src/main/webapp/WEB-INF/views/admin/ad/form.jsp`

6. AI
   - `src/main/webapp/WEB-INF/views/admin/ai-helper/assistant.jsp`
   - `src/main/webapp/WEB-INF/views/admin/ai-helper/chatbot.jsp`

7. 시스템/정책/모더레이션
   - `src/main/webapp/WEB-INF/views/admin/runtime-settings.jsp`
   - `src/main/webapp/WEB-INF/views/admin/initial-settings.jsp`
   - `src/main/webapp/WEB-INF/views/admin/policy-history.jsp`
   - `src/main/webapp/WEB-INF/views/admin/policy/list.jsp`
   - `src/main/webapp/WEB-INF/views/admin/moderation/index.jsp`

8. 최고관리자
   - `/superAdmin/**` 접근 화면이 있으면 마지막에 별도로 확인합니다.
   - superAdmin CSS 프리픽스는 `sa-` 규칙을 지킵니다.

## 주요 수정 파일

공통 CSS:

- `src/main/webapp/resources/css/admin/admin.css`

이미 많은 관리자 전용 스타일이 이 파일에 추가되어 있습니다.

최근 추가/정리된 스타일 그룹:

- `adm-finance-*`
- `adm-inquiry-*`
- `adm-report-*`
- `adm-community-*`
- 감사/로그 필터 및 행 상세 모달 관련 클래스

커뮤니티 상세를 고칠 때 재사용할 만한 클래스:

- `adm-community-page`
- `adm-community-author-name`
- `adm-community-author-id`
- `adm-community-ip-cell`
- `adm-community-muted`
- `adm-community-date-cell`
- `adm-community-danger-btn`
- `adm-community-muted-btn`
- `adm-community-author-modal`
- `adm-community-modal-status`

상세 전용으로 필요하면 다음 같은 scoped 클래스를 추가합니다.

- `adm-community-detail-card`
- `adm-community-detail-head-actions`
- `adm-community-detail-tags`
- `adm-community-detail-meta`
- `adm-community-detail-count`
- `adm-community-report-history-table`
- `adm-community-comments-list`
- `adm-community-comment-row`
- `adm-community-side-label`
- `adm-community-side-value`
- `adm-community-side-full-btn`
- `adm-community-detail-action-btn`

## 검증 루틴

각 화면 또는 작은 묶음이 끝나면 다음을 실행합니다.

```bash
git diff --check
./mvnw test
```

현재까지 반복적으로 확인된 테스트 상태:

- `./mvnw test` 통과
- 31 tests, 0 failures, 0 errors, 0 skipped

테스트 중 정상적으로 보이던 경고:

- Mockito dynamic agent 경고
- inquiry 파일 경고 로그
- `CommunityImageScheduler`의 Pixabay 429 로그가 간헐적으로 출력될 수 있음

## 커밋 루틴

화면 하나 또는 의미 있는 묶음이 끝날 때마다:

```bash
git status --short
git add .
git commit -m "짧은 한국어 요약"
```

커밋 메시지 스타일 예시:

- `커뮤니티 상세 UX 정리`
- `탐색 관리 목록 UX 정리`
- `탐색 상세 UX 정리`
- `탐색 리뷰 목록 UX 정리`

커밋 메시지에 `Co-Authored-By: Codex`는 넣지 않습니다.

## 새 Codex 세션 시작 프롬프트

새 자리에서 원격 브랜치를 받은 뒤 다음 문장을 그대로 붙여 시작하면 됩니다.

```text
D:\dev\TripTogether / branch LEE-JEONG-GUCK에서 관리자 UI/UX 전면 정리 작업을 이어가자.
docs/admin-ux-handoff.md를 먼저 읽고, 왼쪽 관리자 메뉴 순서대로 하나씩 계속 진행해.
브랜치는 바꾸지 말고, 사용자 확인 없이 구현하고, 기능 단위로 자주 git add . 후 커밋해.
기준 UX는 회원 관리와 차단 관리다.
다음 시작점은 src/main/webapp/WEB-INF/views/admin/community/detail.jsp 커뮤니티 상세 화면이다.
완료 후 git diff --check와 ./mvnw test를 실행하고 커밋해.
```
