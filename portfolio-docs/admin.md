# 관리자 · 운영

TripTogether의 관리자·운영 영역은 회원·문의·신고·콘텐츠·판매(패키지)·결제 등 각 도메인이 생성한 데이터를 운영자가 한곳에서 조회·조치·추적하는 횡단(cross-cutting) 거버넌스 계층입니다. 운영 화면은 각 도메인의 데이터를 **소유하지 않고 조회·조치만** 하며, 게시글 본문 같은 원본은 커뮤니티 도메인이 소유하고 관리자는 차단·신고 종결 같은 조치 권한만 가집니다. 이 분리가 소프트 삭제·감사 로그 설계의 전제입니다.

권한 경계는 두 단계로 나뉩니다. 일반 운영 관리자는 `/admin/**`, 관리자 계정·조직·권한 정책 자체를 관리하는 최고관리자는 `/superAdmin/**` 경로를 사용하며, 두 영역 모두 인터셉터 체인으로 보호됩니다.

## 주요 기능

- **통합 대시보드**: 회원·로그인·소셜연동·콘텐츠·문의·신고 요약 카운트, 신규가입/로그인 성공·실패 추세 차트, 일자별 매출 통계.
- **회원 관리**: 다중필터·정렬·페이징 목록, 회원 360 컨텍스트 조회, 상태·권한·등급·차단 변경, 기업회원 신청 승인/반려, CSV·Excel 내보내기.
- **문의·신고 관리**: 1:1 문의 답변·상태 변경, 신고 처리(반려/콘텐츠 삭제/작성자 차단/대상 유저 차단/검토중 복원).
- **판매(패키지) 관리**: 여행 패키지·수정 요청(리비전)의 승인/반려 워크플로우.
- **감사·보안 로그**: 로그인 감사(`/admin/logins`), 보안 이력(`/admin/security`), 일반 활동 텔레메트리(`/admin/activity-logs`), 이메일 인증 요청·토큰 이력.
- **IP 차단·정책 운영**: IP/회원 차단, 모더레이션 정책(독성 민감도·도배 윈도우·신고 임계값) 조정, 정책 스케줄 실행.
- **권한 인터셉터**: `AdminInterceptor`가 서브패스별로 필요 권한을 분기 검사.
- **최고관리자(superAdmin)**: 관리자 계정 부여/해제, 권한 그룹·코드 번들 관리, 조직도, 급여 Excel 업로드/내보내기.

## 핵심 구현

### 1. 서브패스별 권한 분기 인터셉터

관리자 권한은 컨트롤러 코드가 아니라 인터셉터에서 일괄 가로채는 구조입니다. `AdminInterceptor`(`org.triptogether.config.AdminInterceptor`)는 다음 순서로 처리합니다.

1. 비로그인 → 로그인 화면으로 리다이렉트(`?redirect=` 원래 경로 인코딩 보존).
2. 로그인했으나 `loginUser.hasAdminRole()`이 false → 메인으로 리다이렉트.
3. 세션 `adminPermissions`에 `SUPER_ADMIN`이 있으면 전체 통과.
4. 그 외에는 **요청 URI의 서브패스로 필요 권한을 해석**해 보유 권한과 대조.

`resolveRequiredPermission(uri)`가 URL→권한 코드를 매핑합니다. `/admin/members`→`MEMBER_ADMIN`, `/admin/reports`→`REPORT_ADMIN`, `/admin/inquiries`→`INQUIRY_ADMIN`, 감사 계열(`/admin/logins`, `/admin/security`, `/admin/activity-logs`, 이메일 검증)→`AUDIT_ADMIN`처럼 정적 맵으로 1차 분기하고, 더 세밀한 분기는 별도 메서드로 둡니다.

- `/admin/finance/**` → `resolveFinancePermission()`: 환불(`/refund`)은 `FINANCE_OPERATOR`, 정책(`/policy`)은 `FINANCE_POLICY_ADMIN`, 그 외 읽기 전용은 `FINANCE_ADMIN`.
- `/admin/ai-helper/**` → `resolveAiHelperPermission()`: Gemini 챗봇 관리(`/chatbot`, `/conversations`, `/blocks`, `/quotas`)는 `AI_CHATBOT_ADMIN`, Claude 기반 assistant 루트는 `ASSISTANT_ADMIN`.
- `/admin/blocks` → `USER_BLOCK_ADMIN`/`IP_BLOCK_ADMIN`/`BLOCK_POLICY_ADMIN`/`BLOCK_AUDIT_ADMIN` 중 하나만 있어도 허용(OR 조건).

같은 모듈 안에서도 읽기와 위험 조치의 권한을 분리한 것이 핵심으로, 환불 실행과 매출 조회를 다른 권한으로 격리합니다.

### 2. 통합 대시보드 (요약·차트·매출)

진입점은 `AdminController.dashboard()` 한 곳에서 세 가지 집계를 Model에 담아 SSR(JSP)로 렌더링합니다.

```java
model.addAttribute("stats", adminService.getStats());           // 요약 카운트
model.addAttribute("chart", adminService.getDashboardChart(7));  // 7일 추세
model.addAttribute("salesStats", adminService.getSalesDailyStats(30)); // 30일 매출
```

- **요약 카운트**: `AdminStatsVO`가 회원(전체/활성/휴면/탈퇴/오늘신규), 오늘 로그인 성공·실패 및 로그아웃(전체 + 로컬/카카오/네이버/구글 제공자별), 소셜 연동 수(카카오/네이버/구글), 커뮤니티 게시글·미처리 신고·문의(전체/대기/완료)를 한 객체로 담습니다. 카운트는 소프트 삭제 패턴과 맞물려 `post_status`, `account_status` 등 **상태 컬럼** 기준으로 집계합니다.
- **추세 차트**: DB는 거래·로그인이 발생한 날짜만 행으로 돌려주므로, 서비스가 시작일부터 하루씩 순회하며 비는 날을 0으로 채워 연속 시계열(`AdminDashboardChartVO`)을 만듭니다.
- **매출 통계 정직 분리**: `AdminSalesDailyStatVO`는 총거래 규모(grossSales)와 현금성 매출(cashSales)을 분리합니다. 결제가 캐시·마일리지 차감 시뮬레이션이라 마일리지 차감액을 현금 매출로 착시하지 않도록 의도적으로 컬럼을 나눴고, 기간 변경은 전용 JSON 엔드포인트 `/admin/sales/stats?days=`로 재조회합니다.

### 3. 공통 운영 목록 패턴 (검색 VO + 페이징 + 3-응답)

회원·로그인 감사·기업신청 등 운영 목록은 동일한 틀을 공유합니다. 한 검색 조건으로 **세 가지 응답**을 제공합니다.

- 전체 페이지(JSP): `GET /admin/members`
- 행 프래그먼트(검색 시 표만 부분 교체): `GET /admin/members/fragment`
- JSON API: `GET /admin/members/api`

프래그먼트 응답에는 `writeAdminListHeaders()`가 `X-Section-Total / -Page / -Size / -Pages` 헤더로 페이징 메타를 실어, 프런트가 전체 새로고침 없이 페이지네이션을 다시 그립니다. 동일 검색 조건은 CSV/Excel 내보내기(`/admin/members/export?scope=search|all|selected&format=csv|excel`)에서도 재사용됩니다.

외부 입력 신뢰 금지 원칙에 따라 정렬 컬럼·페이지 크기는 `AdminSearchVO`의 getter에서 화이트리스트로 정규화합니다. 허용 목록에 없는 정렬 키는 `createdAt`으로, 비표준 페이지 크기는 기본값으로 강제되어 매퍼 도달 전에 차단됩니다. 내보내기 시 선택 ID 파싱도 `s.matches("\\d+")`로 숫자만 통과시킵니다.

### 4. 신고 처리 워크플로우

`POST /admin/report/{reportId}/resolve`가 `action` 값에 따라 분기하며, 대상 유형(post/comment/review/user)별로 허용 동작을 다르게 검증합니다.

| action | 동작 | 신고 상태 |
| --- | --- | --- |
| `REJECTED` | 콘텐츠·계정 유지, 반려 | `DISMISSED` |
| `DELETE_CONTENT` | 게시글/댓글 삭제 또는 리뷰 차단 | `RESOLVED` |
| `BLOCK_AUTHOR` | 작성자 계정 차단 | `RESOLVED` |
| `BLOCK_USER` | 신고 대상 유저 차단(user 전용) | `RESOLVED` |
| `DELETE_AND_BLOCK` | 콘텐츠 삭제/차단 + 작성자 차단 | `RESOLVED` |
| `REVERT_TO_PENDING` | 반려/완료 → `IN_REVIEW` 복원 | - |

콘텐츠 삭제는 `communityService.deletePost/deleteComment`(소프트 삭제)나 `adminExploreService.blockReview`로, 계정 차단은 `adminService.changeMemberStatus(idx, "BLOCKED")`로 위임합니다. 즉 관리자는 도메인 서비스에 조치를 위임할 뿐 데이터를 직접 소유하지 않습니다.

### 5. 감사 로그 — 책임 범위별 분리 + 추적 식별자

감사 기록은 단일 테이블이 아니라 책임 범위별 네 갈래로 나뉩니다.

| 책임 | 테이블 | 조회/기록 컴포넌트 |
| --- | --- | --- |
| 관리자 의도적 조치 | `ADMIN_ACTION_AUDIT` | `AdminActionAuditService.record(...)`, `AdminActionAuditVO` |
| 로그인/로그아웃 이력 | `USER_LOGIN_HISTORY` | `AdminLoginAuditVO`(조회용) |
| 계정/인증 보안 이벤트 | `USER_SECURITY_HISTORY` | `AdminSecurityAuditVO`(조회용) |
| 일반 활동 텔레메트리 | `USER_ACTIVITY_LOG` | `ActivityLogInterceptor`, `UserActivityLogVO` |

`AdminActionAuditService.record(actionType, actionDomain, actorUserIdx, targetType, targetId, reasonCode, reasonArgs, detailSummary)`가 단일 진입점으로 한 줄 INSERT 합니다. 핵심은 사유를 **자유 텍스트가 아니라 표준 사유 코드(`reason_code`)** 로 남기고 가변 인자는 `reason_args` JSON으로 구조화한 점입니다. 자유 텍스트는 사람이 읽기엔 좋지만 집계·필터·다국어 표기가 불가능하므로 코드화했습니다. 조회용 VO는 이력 테이블과 `USERS`를 조인해 actor/target 닉네임까지 함께 담습니다.

추적성은 `ActivityLogInterceptor`가 `preHandle`에서 생성한 `request_id`(UUID)와 `flow_trace_id`로 확보합니다. `flow_trace_id`의 기본값은 `request_id`이며, 이메일 발송→검증처럼 여러 요청이 한 흐름일 때만 첫 요청 식별자를 이어받습니다. 같은 식별자가 활동·로그인·보안 이력에 공통으로 박혀 있어 한 사건을 테이블을 가로질러 재구성할 수 있습니다. 저장 전 `token`·`password`·`code`·`state` 등 민감 쿼리 키는 `***`로 마스킹합니다.

### 6. 최고관리자(superAdmin) — 권한 그룹·조직·급여

`SuperAdminController`(`/superAdmin/**`)는 관리자 계정 자체를 관리합니다. 접근은 `SuperAdminInterceptor`가 보호하며(관리자 계열 진입 후 세부 권한은 정책 테이블/화면에서 통제), CSS 프리픽스 `sa-`로 모듈을 격리합니다.

권한 모델은 **정책(policy)과 부여(grant)를 테이블 수준에서 분리**합니다. 개별 권한 정책(`ADMIN_PERMISSION_POLICY`), 권한 묶음인 그룹 정책, 실효 권한 코드 번들(`adminPermissionCode`)을 별도로 관리하고, 관리자에게는 그룹/코드를 부여합니다. 따라서 그룹 구성만 바꾸면 소속 관리자 전원의 실효 권한이 한 번에 바뀝니다. 컨트롤러는 권한 생성·토글·삭제, 그룹 생성·권한 추가/제거, 코드 번들 구성, 관리자 부여/해제·일괄 처리, 권한·그룹 변경 이력 조회를 모두 제공합니다.

급여/역량 관리는 Apache POI 기반 Excel 워크플로우입니다. `salaryExport`(`SalaryExcelExporter`)로 현황을 내보내고, 업로드는 **미리보기(`/salary/upload/preview`) → 확정 적용(`/salary/upload/apply`)** 2단계로 나눠 검증 후 반영하며 변경자(changedBy)를 기록합니다. 조직도(`/superAdmin/org`)는 권한 코드를 사람이 읽는 라벨(`display_name`)로 매핑해 표시합니다.

## 설계 결정과 트레이드오프

- **권한을 인터셉터 서브패스 분기로 처리**: 컨트롤러는 비즈니스 로직에 집중하고, URL→권한 매핑을 한곳(`AdminInterceptor`)에 모았습니다. 정적 맵 + 메서드 분기 조합이라 신규 화면 추가 시 매핑 한 줄로 권한이 강제됩니다. 단, URL 컨벤션에 의존하므로 경로 설계가 권한 모델과 일치해야 합니다.
- **자동 차단 대신 Human-in-the-Loop 모더레이션(ADR-0010)**: AI 독성 감지 후 즉시 삭제하지 않고 BLUR 처리 + 관리자 해제를 두어 false positive 비용을 줄입니다. 신고도 자동 계정 차단을 두지 않고 운영자 판단을 거칩니다(ADR-0001).
- **사유 코드 표준화 + 외래키 ON DELETE SET NULL**: 조치 사유를 코드로 남겨 집계·다국어를 가능하게 하고, 감사 행은 관리자 계정이 삭제돼도 보존되도록 actor를 NULL 처리합니다. 다만 `record(...)` 호출은 컨트롤러의 수작업 의존이며 AOP 강제·로그 무결성(append-only)은 미적용으로 향후 과제입니다.
- **정책·런타임 값의 DB 외부화(ADR-0009)**: 도배 윈도우·신고 BLUR 임계값·독성 민감도 등을 코드 재배포 없이 관리자 화면에서 조정합니다.
- **권한 정책/부여 분리**: 개별 부여 대신 그룹/코드 번들로 묶어, 운영 규모가 커져도 권한 일괄 변경이 한 번에 반영됩니다.

## 데이터 모델 / 연동

- **감사·이력**: `ADMIN_ACTION_AUDIT`(action_type, action_domain, actor_user_idx, target_type/id, reason_code, reason_args JSON, detail_summary), `USER_LOGIN_HISTORY`, `USER_SECURITY_HISTORY`, `USER_ACTIVITY_LOG`. 사용자 외래키는 모두 `ON DELETE SET NULL`, 조회 패턴별 복합 인덱스(예: `(action_domain, created_at)`, `(reason_code, created_at)`).
- **권한**: `ADMIN_PERMISSION_POLICY`(개별 권한), 그룹 정책/아이템, 실효 권한 코드 번들. 세션 `adminPermissions`(Set)로 인터셉터에서 검사.
- **통계 VO**: `AdminStatsVO`, `AdminDashboardChartVO`, `AdminSalesDailyStatVO`.
- **연동 도메인**: 신고(`ReportService`), 커뮤니티(`CommunityService`), 패키지(`TravelPackageService`), 탐색/리뷰(`ExploreService`), 모더레이션 정책(`ModerationPolicyService`). 매출은 결제 시뮬레이션 기반이며 항공권은 Mock 프로바이더입니다.

## 사용 기술

- Spring Boot 4 / Java 21, Spring MVC `@Controller`·`@RestController`, `HandlerInterceptor` 기반 권한 체인.
- MyBatis 매퍼(`AdminMapper`, `SuperAdminMapper` 등) + MySQL, 상태 컬럼 기반 소프트 삭제·집계.
- JSP/JSTL SSR + 행 프래그먼트 부분 갱신 + JSON API의 3-응답 패턴.
- Apache POI(XSSF) 기반 CSV/Excel 내보내기·급여 업로드.
- 표준 사유 코드 + request_id/flow_trace_id 추적성 감사 인프라, DB 외부화 런타임 정책.
- 관련 ADR: 0001(신고 자동 차단 배제), 0008(소프트 삭제), 0009(모더레이션 정책 외부화), 0010(AI 모더레이션 파이프라인), 0011(권한 AOP·전역 예외 처리).
