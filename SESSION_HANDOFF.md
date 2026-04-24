# Session Handoff — 2026-04-24

## 작업 브랜치
`LEE-JEONG-GUCK` (main 브랜치: `dev`)

---

## 완료된 작업

### Task 1 — 흐름 추적 진단 (코드 변경 없음)
- `request_id`와 `flow_trace_id`가 같은 이유 분석 완료
- 원인 3가지: (1) 서비스에서 로컬 UUID 생성, (2) 콜백 컨트롤러에서 flowTraceId 미복원, (3) recordSecurityEvent가 context ID 무시

### Task 2 — 흐름 추적 수정 (커밋 완료)
다음 9개 파일 수정 후 커밋됨:

| 파일 | 변경 내용 |
|------|-----------|
| `TripTogetherDB.sql` | `USER_SECURITY_HISTORY`에 `request_id`, `flow_trace_id` 컬럼 + 인덱스 추가 |
| `sql/security_history_flow_trace_upgrade.sql` | 신규 파일 — 운영 DB용 ALTER TABLE 스크립트 |
| `auth/vo/UserSecurityHistoryVO.java` | `requestId`, `flowTraceId` 필드 추가 |
| `mapper/authMapper.xml` | `insertSecurityHistory` INSERT 컬럼 추가, `findFlowTraceIdByToken` 쿼리 신규 |
| `auth/mapper/AuthMapper.java` | `findFlowTraceIdByToken(String token)` 메서드 추가 |
| `auth/service/AuthService.java` | `resolveFlowTraceIdByToken(String token)` 인터페이스 메서드 추가 |
| `auth/service/AuthServiceImpl.java` | 이메일 발송 메서드에서 로컬 UUID 대신 context.requestId 사용, `recordSecurityEvent`에 requestId/flowTraceId 세팅, `resolveFlowTraceIdByToken` 구현 |
| `auth/controller/AuthController.java` | 6개 엔드포인트(`sendFindId`, `verifyFindId`, `sendResetPw`, `resetPwPage`, `doResetPw`, `verifyEmail`)에 flowTraceId 복원 로직 추가 |
| `views/admin/logs/list.jsp` | 누락된 `<th>` (request_id/flow_trace_id) 추가, colspan 10→11 |
| `views/admin/activity-log/list.jsp` | flowTraceId 앞에 `trace:` 접두어 추가 |

---

## 진행 중인 작업 (Task 3) — 미구현, 승인만 받은 상태

**목표:** 관리자 페이지 모든 컬럼 클릭 가능하게 + 회원관리 BLOCKED 배지 CSS 수정

### 구현 예정 파일 목록

---

### 파일 1: `src/main/webapp/resources/css/admin/admin.css`

**변경 위치:** 라인 522 (`.status-badge.DELETED` 바로 다음)

```css
/* 현재 */
.status-badge.ACTIVE  { background: rgba(34,197,94,.12); color: #4ade80; }
.status-badge.DORMANT { background: rgba(234,179,8,.12); color: #fbbf24; }
.status-badge.DELETED { background: rgba(239,68,68,.10); color: #f87171; }

/* 추가할 것 */
.status-badge.BLOCKED { background: rgba(168,85,247,.15); color: #c084fc; }
```

그리고 이메일 인증 요청 상태 배지용 CSS도 추가:
```css
.status-badge.REQUESTED { background: rgba(234,179,8,.12);  color: #fbbf24; }
.status-badge.VERIFIED  { background: rgba(34,197,94,.12);  color: #4ade80; }
.status-badge.APPLIED   { background: rgba(16,185,129,.12); color: #34d399; }
```

---

### 파일 2: `src/main/webapp/WEB-INF/views/admin/security/list.jsp`

**현재 상태:** 라인 65~76에 `<th>` 10개, colspan="10"

**변경 1 — eventType 컬럼 클릭 가능하게 (라인 120~130)**
```html
<!-- 변경 전 -->
<td>
    <c:choose>
        <c:when test="${item.eventType eq 'FIND_ID'}">...</c:when>
        ...
    </c:choose>
</td>

<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${item.eventType eq 'FIND_ID'}"><spring:message code="admin.security.eventType.findId"/></c:when>
            <c:when test="${item.eventType eq 'FIND_PASSWORD'}"><spring:message code="admin.security.eventType.findPassword"/></c:when>
            <c:when test="${item.eventType eq 'RESET_PASSWORD'}"><spring:message code="admin.security.eventType.resetPassword"/></c:when>
            <c:when test="${item.eventType eq 'PASSWORD_CHANGE'}"><spring:message code="admin.security.eventType.passwordChange"/></c:when>
            <c:when test="${item.eventType eq 'EMAIL_VERIFY'}"><spring:message code="admin.security.eventType.emailVerify"/></c:when>
            <c:when test="${item.eventType eq 'EMAIL_LOGIN_TOGGLE'}"><spring:message code="admin.security.eventType.emailLoginToggle"/></c:when>
            <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 2 — eventStage 컬럼 클릭 가능하게 (라인 131~138)**
```html
<!-- 변경 전 -->
<td>
    <c:choose>
        <c:when test="${item.eventStage eq 'REQUEST'}">...</c:when>
        ...
    </c:choose>
</td>

<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="eventStage" data-param-value="${item.eventStage}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${item.eventStage eq 'REQUEST'}"><spring:message code="admin.security.stage.request"/></c:when>
            <c:when test="${item.eventStage eq 'ISSUE'}"><spring:message code="admin.security.stage.issue"/></c:when>
            <c:when test="${item.eventStage eq 'VERIFY'}"><spring:message code="admin.security.stage.verify"/></c:when>
            <c:when test="${item.eventStage eq 'COMPLETE'}"><spring:message code="admin.security.stage.complete"/></c:when>
            <c:otherwise><c:out value="${item.eventStage}"/></c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 3 — result(성공/실패) 배지 클릭 가능하게 (라인 168~173)**
```html
<!-- 변경 전 -->
<td>
    <c:choose>
        <c:when test="${item.success}"><span class="status-badge ACTIVE">...</span></c:when>
        <c:otherwise><span class="status-badge DELETED">...</span></c:otherwise>
    </c:choose>
</td>

<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
        <c:choose>
            <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
            <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
        </c:choose>
    </button>
</td>
```

**변경 4 — failReason 클릭 가능하게 (라인 174~194)**
```html
<!-- 변경 전 -->
<td style="max-width:280px;white-space:normal;">
    <div><c:out value="${empty item.failReason ? '-' : item.failReason}"/></div>
    <c:if test="${not empty item.failReason}">
        <div class="adm-tr-inline js-admin-translation-widget" ...></div>
    </c:if>
    <c:if test="${not empty item.detailMessage}">
        <div ...></div>
        <div class="adm-tr-inline js-admin-translation-widget" ...></div>
    </c:if>
</td>

<!-- 변경 후 -->
<td style="max-width:280px;white-space:normal;">
    <c:choose>
        <c:when test="${not empty item.failReason}">
            <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                <span><c:out value="${item.failReason}"/></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
            </button>
            <div class="adm-tr-inline js-admin-translation-widget"
                 data-label="<spring:message code='admin.translation.label.securityFailReason'/>"
                 data-source-type="SECURITY_AUDIT"
                 data-source-idx="${item.securityIdx}"
                 data-field-name="fail_reason"
                 data-default-source-lang="ko"
                 data-source-text="${fn:escapeXml(item.failReason)}"></div>
        </c:when>
        <c:otherwise><div>-</div></c:otherwise>
    </c:choose>
    <c:if test="${not empty item.detailMessage}">
        <div style="margin-top:8px;font-size:12px;color:#94a3b8;"><c:out value="${item.detailMessage}"/></div>
        <div class="adm-tr-inline js-admin-translation-widget"
             data-label="<spring:message code='admin.translation.label.securityDetailMessage'/>"
             data-source-type="SECURITY_AUDIT"
             data-source-idx="${item.securityIdx}"
             data-field-name="detail_message"
             data-default-source-lang="ko"
             data-source-text="${fn:escapeXml(item.detailMessage)}"></div>
    </c:if>
</td>
```

**변경 5 — request_id/flow_trace_id 컬럼 신규 추가**

`<th>` 헤더: IP `<th>` 다음에 추가
```html
<th><spring:message code="admin.context.requestId"/></th>
```

`<td>` 셀: IP `<td>` 다음, `</tr>` 바로 전에 추가
```html
<td>
    <c:choose>
        <c:when test="${not empty item.requestId or not empty item.flowTraceId}">
            <button type="button"
                    class="adm-cell-link"
                    data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}"
                    onclick="openRelatedActivity(this)">
                <span style="font-size:12px;color:#64748b;"><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                <c:if test="${not empty item.flowTraceId}">
                    <span class="adm-cell-link-note"><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></span>
                </c:if>
            </button>
        </c:when>
        <c:otherwise><div style="font-size:12px;color:#64748b;">-</div></c:otherwise>
    </c:choose>
</td>
```

**변경 6 — colspan 10 → 11, JS 함수 추가**

`colspan="10"` → `colspan="11"`

`<script>` 블록에 두 함수 추가:
```javascript
function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/security?' + params.toString();
}

function openRelatedActivity(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    var params = new URLSearchParams();
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/activity-logs?' + params.toString();
}
```

---

### 파일 3: `src/main/webapp/WEB-INF/views/admin/logs/list.jsp`

**변경 1 — event type 배지 (라인 118~126)**
```html
<!-- 변경 전 -->
<td>
    <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">...</span>
</td>

<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
        <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">
            <c:choose>
                <c:when test="${item.eventType eq 'LOGIN'}"><spring:message code="admin.logs.event.login"/></c:when>
                <c:when test="${item.eventType eq 'LOGOUT'}"><spring:message code="admin.logs.event.logout"/></c:when>
                <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
            </c:choose>
        </span>
    </button>
</td>
```

**변경 2 — authType (라인 127~133)**
```html
<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="authType" data-param-value="${item.authType}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${item.authType eq 'PASSWORD'}"><spring:message code="admin.logs.authType.password"/></c:when>
            <c:when test="${item.authType eq 'SOCIAL'}"><spring:message code="admin.logs.authType.social"/></c:when>
            <c:otherwise><c:out value="${item.authType}"/></c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 3 — authProvider (라인 134~141)**
```html
<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="authProvider" data-param-value="${item.authProvider}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${item.authProvider eq 'LOCAL'}"><spring:message code="admin.logs.provider.local"/></c:when>
            <c:when test="${item.authProvider eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
            <c:when test="${item.authProvider eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
            <c:when test="${item.authProvider eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
            <c:otherwise><c:out value="${item.authProvider}"/></c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 4 — authFlow (라인 143~166): requestUri를 adm-cell-link-note로 이동**
```html
<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'LOCAL'}"><spring:message code="admin.logs.authFlow.local"/></c:when>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'ID'}"><spring:message code="admin.logs.authFlow.id"/></c:when>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'EMAIL'}"><spring:message code="admin.logs.authFlow.email"/></c:when>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
            <c:when test="${empty item.authFlow and item.loginMethod eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
            <c:when test="${item.authFlow eq 'PASSWORD_ID'}"><spring:message code="admin.logs.authFlow.passwordId"/></c:when>
            <c:when test="${item.authFlow eq 'PASSWORD_EMAIL'}"><spring:message code="admin.logs.authFlow.passwordEmail"/></c:when>
            <c:when test="${item.authFlow eq 'SOCIAL_LOGIN'}"><spring:message code="admin.logs.authFlow.socialLogin"/></c:when>
            <c:when test="${item.authFlow eq 'SOCIAL_REGISTER'}"><spring:message code="admin.logs.authFlow.socialRegister"/></c:when>
            <c:when test="${item.authFlow eq 'LOGOUT_LOCAL'}"><spring:message code="admin.logs.authFlow.logoutLocal"/></c:when>
            <c:when test="${item.authFlow eq 'LOGOUT_SOCIAL'}"><spring:message code="admin.logs.authFlow.logoutSocial"/></c:when>
            <c:otherwise><c:out value="${empty item.authFlow ? item.loginMethod : item.authFlow}"/></c:otherwise>
        </c:choose></span>
        <c:if test="${not empty item.requestUri}">
            <span class="adm-cell-link-note"><c:out value="${item.requestUri}"/></span>
        </c:if>
    </button>
</td>
```

**변경 5 — result 배지 (라인 183~188)**
```html
<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
        <c:choose>
            <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
            <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
        </c:choose>
    </button>
</td>
```

**변경 6 — failReason (라인 189~199)**
```html
<!-- 변경 후 -->
<td style="max-width:280px;white-space:normal;">
    <c:choose>
        <c:when test="${not empty item.failReason}">
            <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                <span><c:out value="${item.failReason}"/></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
            </button>
            <div class="adm-tr-inline js-admin-translation-widget"
                 data-label="<spring:message code='admin.translation.label.loginFailReason'/>"
                 data-source-type="LOGIN_AUDIT"
                 data-source-idx="${item.loginIdx}"
                 data-field-name="fail_reason"
                 data-default-source-lang="ko"
                 data-source-text="${fn:escapeXml(item.failReason)}"></div>
        </c:when>
        <c:otherwise><div>-</div></c:otherwise>
    </c:choose>
</td>
```

**변경 7 — JS에 applySelectFilter 추가 (기존 `<script>` 블록 내)**
```javascript
function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/logins?' + params.toString();
}
```

---

### 파일 4: `src/main/webapp/WEB-INF/views/admin/activity-log/list.jsp`

**변경 1 — activityDomain (라인 55~65)**
```html
<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="activityDomain" data-param-value="${item.activityDomain}" onclick="applySelectFilter(this)">
    <span><c:choose>
      <c:when test="${item.activityDomain eq 'GENERAL'}"><spring:message code="admin.activity.domain.general"/></c:when>
      <c:when test="${item.activityDomain eq 'AUTH'}"><spring:message code="admin.activity.domain.auth"/></c:when>
      <c:when test="${item.activityDomain eq 'ADMIN'}"><spring:message code="admin.activity.domain.admin"/></c:when>
      <c:when test="${item.activityDomain eq 'COMMUNITY'}"><spring:message code="admin.activity.domain.community"/></c:when>
      <c:when test="${item.activityDomain eq 'MYPAGE'}"><spring:message code="admin.activity.domain.mypage"/></c:when>
      <c:when test="${item.activityDomain eq 'INQUIRY'}"><spring:message code="admin.activity.domain.inquiry"/></c:when>
      <c:otherwise><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></c:otherwise>
    </c:choose></span>
    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
  </button>
</td>
```

**변경 2 — activityType (라인 66~74)**
```html
<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="activityType" data-param-value="${item.activityType}" onclick="applySelectFilter(this)">
    <span><c:choose>
      <c:when test="${item.activityType eq 'PAGE_VIEW'}"><spring:message code="admin.activity.type.pageView"/></c:when>
      <c:when test="${item.activityType eq 'ACTION'}"><spring:message code="admin.activity.type.action"/></c:when>
      <c:when test="${item.activityType eq 'AJAX'}"><spring:message code="admin.activity.type.ajax"/></c:when>
      <c:when test="${item.activityType eq 'API'}"><spring:message code="admin.activity.type.api"/></c:when>
      <c:otherwise><c:out value="${item.activityType}"/></c:otherwise>
    </c:choose></span>
    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
  </button>
</td>
```

**변경 3 — httpMethod (라인 148~156)**
```html
<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="httpMethod" data-param-value="${item.httpMethod}" onclick="applySelectFilter(this)">
    <span><c:choose>
      <c:when test="${item.httpMethod eq 'GET'}"><spring:message code="admin.activity.method.get"/></c:when>
      <c:when test="${item.httpMethod eq 'POST'}"><spring:message code="admin.activity.method.post"/></c:when>
      <c:when test="${item.httpMethod eq 'PUT'}"><spring:message code="admin.activity.method.put"/></c:when>
      <c:when test="${item.httpMethod eq 'DELETE'}"><spring:message code="admin.activity.method.delete"/></c:when>
      <c:otherwise><c:out value="${item.httpMethod}"/></c:otherwise>
    </c:choose></span>
    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
  </button>
</td>
```

**변경 4 — responseStatus (라인 157)**
```html
<!-- 변경 전 -->
<td><c:out value="${item.responseStatus}"/> / <c:out value="${item.success ? adminActivitySuccessLabel : adminActivityFailLabel}"/></td>

<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
    <span><c:out value="${item.responseStatus}"/></span>
    <span class="adm-cell-link-note"><c:out value="${item.success ? adminActivitySuccessLabel : adminActivityFailLabel}"/></span>
  </button>
</td>
```

**변경 5 — JS에 applySelectFilter 추가 (기존 `<script>` 블록 내)**
```javascript
function applySelectFilter(button){
  var paramName=button.getAttribute('data-param-name');
  var paramValue=button.getAttribute('data-param-value');
  if(!paramName||!paramValue) return;
  var params=new URLSearchParams(window.location.search);
  params.set(paramName,paramValue);
  params.set('page','1');
  location.href='${pageContext.request.contextPath}/admin/activity-logs?'+params.toString();
}
```

---

### 파일 5: `src/main/webapp/WEB-INF/views/admin/email-token/list.jsp`

**변경 1 — purpose (라인 70~76)**
```html
<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="purpose" data-param-value="${item.purpose}" onclick="applySelectFilter(this)">
    <span><c:choose>
      <c:when test="${item.purpose == 'PROFILE_EMAIL'}"><spring:message code="admin.emailRequests.purpose.profileEmail"/></c:when>
      <c:when test="${item.purpose == 'FIND_ID'}"><spring:message code="admin.emailRequests.purpose.findId"/></c:when>
      <c:when test="${item.purpose == 'RESET_PW'}"><spring:message code="admin.emailRequests.purpose.resetPw"/></c:when>
      <c:when test="${item.purpose == 'VERIFY'}"><spring:message code="admin.emailRequests.purpose.verify"/></c:when>
      <c:otherwise><c:out value="${item.purpose}"/></c:otherwise>
    </c:choose></span>
    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
  </button>
</td>
```

**변경 2 — used(사용/미사용) (라인 87~91)**
```html
<!-- 변경 후 -->
<td>
  <button type="button" class="adm-cell-link" data-param-name="used" data-param-value="${item.used ? 'USED' : 'UNUSED'}" onclick="applySelectFilter(this)">
    <span><c:choose>
      <c:when test="${item.used}"><spring:message code="admin.context.used"/></c:when>
      <c:otherwise><spring:message code="admin.context.unused"/></c:otherwise>
    </c:choose></span>
    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
  </button>
</td>
```

**변경 3 — JS에 applySelectFilter 추가 (기존 `<script>` 블록 내)**
```javascript
function applySelectFilter(button){var paramName=button.getAttribute('data-param-name');var paramValue=button.getAttribute('data-param-value');if(!paramName||!paramValue)return;var params=new URLSearchParams(window.location.search);params.set(paramName,paramValue);params.set('page','1');location.href='${pageContext.request.contextPath}/admin/email-tokens?'+params.toString();}
```

---

### 파일 6: `src/main/webapp/WEB-INF/views/admin/email-verification/list.jsp`

**변경 1 — purpose (라인 94~101)**
```html
<!-- 변경 후 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="purpose" data-param-value="${item.purpose}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${item.purpose == 'PROFILE_EMAIL'}"><spring:message code="admin.emailRequests.purpose.profileEmail"/></c:when>
            <c:when test="${item.purpose == 'FIND_ID'}"><spring:message code="admin.emailRequests.purpose.findId"/></c:when>
            <c:when test="${item.purpose == 'RESET_PW'}"><spring:message code="admin.emailRequests.purpose.resetPw"/></c:when>
            <c:when test="${item.purpose == 'VERIFY'}"><spring:message code="admin.emailRequests.purpose.verify"/></c:when>
            <c:otherwise><c:out value="${item.purpose}"/></c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 2 — status 배지: `class="status-badge ACTIVE"` 고정 오류 수정 + 클릭 추가 (라인 112~123)**
```html
<!-- 변경 전: class가 항상 ACTIVE로 고정되어 있어 모든 상태가 초록색으로 표시됨 -->
<td>
    <span class="status-badge ACTIVE">...</span>
</td>

<!-- 변경 후: 실제 status 값으로 클래스 설정 + 클릭 기능 -->
<td>
    <button type="button" class="adm-cell-link" data-param-name="status" data-param-value="${item.status}" onclick="applySelectFilter(this)">
        <span class="status-badge ${item.status}">
            <c:choose>
                <c:when test="${item.status == 'REQUESTED'}"><spring:message code="admin.emailRequests.status.requested"/></c:when>
                <c:when test="${item.status == 'VERIFIED'}"><spring:message code="admin.emailRequests.status.verified"/></c:when>
                <c:when test="${item.status == 'APPLIED'}"><spring:message code="admin.emailRequests.status.applied"/></c:when>
                <c:when test="${item.status == 'EXPIRED'}"><spring:message code="admin.emailRequests.status.expired"/></c:when>
                <c:when test="${item.status == 'CANCELLED'}"><spring:message code="admin.emailRequests.status.cancelled"/></c:when>
                <c:otherwise><c:out value="${item.status}"/></c:otherwise>
            </c:choose>
        </span>
    </button>
</td>
```

**변경 3 — JS에 applySelectFilter 추가 (기존 `<script>` 블록 내)**
```javascript
function applySelectFilter(button) {
  var paramName = button.getAttribute('data-param-name');
  var paramValue = button.getAttribute('data-param-value');
  if (!paramName || !paramValue) return;
  var params = new URLSearchParams(window.location.search);
  params.set(paramName, paramValue);
  params.set('page', '1');
  location.href = '${pageContext.request.contextPath}/admin/email-verifications?' + params.toString();
}
```

---

### 파일 7: `src/main/webapp/WEB-INF/views/admin/community/list.jsp`

**변경 1 — postType (라인 207~215)**
```html
<!-- 변경 후 -->
<td style="font-size:12px;color:#94a3b8;">
    <button type="button" class="adm-cell-link" data-param-name="postType" data-param-value="${p.postType}" onclick="applySelectFilter(this)">
        <span><c:choose>
            <c:when test="${p.postType == 'review'}"><spring:message code="admin.community.postType.review"/></c:when>
            <c:when test="${p.postType == 'photo'}"><spring:message code="admin.community.postType.photo"/></c:when>
            <c:when test="${p.postType == 'tip'}"><spring:message code="admin.community.postType.tip"/></c:when>
            <c:when test="${p.postType == 'question'}"><spring:message code="admin.community.postType.question"/></c:when>
            <c:otherwise>${p.postType}</c:otherwise>
        </c:choose></span>
        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
    </button>
</td>
```

**변경 2 — reportCount (라인 218~231): 신고 목록 페이지로 이동**
```html
<!-- 변경 후 -->
<td>
    <a href="${pageContext.request.contextPath}/admin/reports?targetType=post&keyword=${p.postId}"
       class="adm-cell-link adm-cell-link--inline"
       onclick="event.stopPropagation();">
        <c:choose>
            <c:when test="${p.reportCount >= 3}">
                <span style="color:#f87171;font-weight:700;">🔴 ${p.reportCount}</span>
            </c:when>
            <c:when test="${p.reportCount > 0}">
                <span style="color:#fbbf24;">${p.reportCount}</span>
            </c:when>
            <c:otherwise>
                <span style="color:#475569;">0</span>
            </c:otherwise>
        </c:choose>
    </a>
</td>
```

**변경 3 — JS에 applySelectFilter 추가 (기존 `<script>` 블록 내, `goPage` 함수 위)**
```javascript
function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = ctx + '/admin/community?' + params.toString();
}
```

---

## 작업 재개 방법

새 PC에서 Claude Code 실행 후:
```
SESSION_HANDOFF.md 읽고 Task 3 구현 시작해줘. 브랜치는 LEE-JEONG-GUCK.
```

또는 더 구체적으로:
```
SESSION_HANDOFF.md의 Task 3을 구현해줘. 파일 1(admin.css)부터 순서대로 진행해.
```

---

## 참고사항

- `admin.common.sameValue` 메시지 키는 이미 존재함 (security/list.jsp에서 사용 중)
- `applySelectFilter` 패턴은 각 페이지별로 URL이 다르므로 파일마다 별도 함수 필요 (공유 불가)
- `data-param-name` + `data-param-value` 속성으로 어떤 URL 파라미터든 set 가능한 범용 패턴
- `email-verification/list.jsp`의 status 배지 버그(항상 ACTIVE 클래스)는 이 작업에서 함께 수정됨
