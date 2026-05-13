<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_loginReviews_title" code="security.admin.loginReviews.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpSummary" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="msg_security_admin_comment_approved" code="security.admin.comment.approved"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_notBlocked" code="security.admin.comment.notBlocked"/>
<spring:message var="msg_security_admin_loginReviews_desc" code="security.admin.loginReviews.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_externalAssessments" code="security.admin.nav.externalAssessments"/>
<spring:message var="msg_security_admin_nav_notifications" code="security.admin.nav.notifications"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_common_type" code="security.admin.common.type"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_reviewType" code="security.admin.common.reviewType"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_summary" code="security.admin.common.summary"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_approve" code="security.admin.common.approve"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_reject" code="security.admin.common.reject"/>
<spring:message var="msg_security_admin_empty_reviews" code="security.admin.empty.reviews"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(reviews)}"/>
<c:set var="pageTitle" value="${msg_security_admin_loginReviews_title}"/>
<c:set var="activeMenu" value="loginRiskReviews"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-login-review-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_loginReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_loginReviews_desc}</p>
        </div>
        <div class="adm-actions adm-login-review-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${msg_security_admin_nav_notifications}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-login-review-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-login-review-filterbar">
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="status">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                        <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_severity}
                    <select class="adm-select" name="severity">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                        <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                        <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_type}
                    <input class="adm-input" type="text" name="reviewType" value="${fn:escapeXml(reviewType)}" placeholder="IP_LOGIN_RISK">
                </label>
                <label class="adm-login-review-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
                </label>
                <div class="adm-login-review-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-login-review-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_loginReviews_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="loginRiskReviewTable"
                   class="adm-table adm-section-table-fixed adm-login-review-table lrr-table"
                   data-section="loginRiskReviews"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="lrr-col-check"/>
                    <col class="lrr-col-status"/>
                    <col class="lrr-col-severity"/>
                    <col class="lrr-col-type"/>
                    <col class="lrr-col-target"/>
                    <col class="lrr-col-summary"/>
                    <col class="lrr-col-date"/>
                    <col class="lrr-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="lrr-th lrr-th-check"><input type="checkbox" aria-label="전체 선택"></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 1)"><span class="lrr-th-label">${msg_security_admin_common_status}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 2)"><span class="lrr-th-label">${msg_security_admin_common_severity}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 3)"><span class="lrr-th-label">${msg_security_admin_common_reviewType}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 4)"><span class="lrr-th-label">${msg_security_admin_common_target}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 5)"><span class="lrr-th-label">${msg_security_admin_common_summary}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="sortStaticAdminTable('loginRiskReviewTable', 6)"><span class="lrr-th-label">${msg_security_admin_common_createdAt}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th" onclick="focusStaticAdminTableAction('loginRiskReviewTable')"><span class="lrr-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${reviews}">
                    <tr>
                        <td class="lrr-cell-check"><input type="checkbox" value="${r.reviewIdx}" aria-label="행 선택"></td>
                        <td><span class="adm-badge"><c:out value="${r.reviewStatus}"/></span></td>
                        <td><c:out value="${r.severity}"/></td>
                        <td>
                            <div class="adm-login-review-type"><c:out value="${r.reviewType}"/></div>
                            <div class="adm-page-muted"><c:out value="${r.policyCode}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/></div>
                            <c:if test="${not empty r.userId}"><div class="adm-page-muted"><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-login-review-summary">
                                <strong><c:out value="${r.summary}"/></strong>
                                <span><c:out value="${r.detailMessage}"/></span>
                                <c:if test="${not empty r.reviewComment}">
                                    <span>${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></span>
                                </c:if>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                                <div class="adm-login-review-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_approved}">
                                        <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_approve}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_notBlocked}">
                                        <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_reject}</button>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                                <div class="adm-page-muted"><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr class="adm-local-empty"><td colspan="8" class="adm-local-empty-cell">${msg_security_admin_empty_reviews}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function sortStaticAdminTable(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    const tbody = table ? table.querySelector('tbody') : null;
    if (!tbody) return;
    const prevIndex = Number(table.dataset.sortIndex || -1);
    const prevDir = table.dataset.sortDir || 'ASC';
    const nextDir = prevIndex === columnIndex && prevDir === 'ASC' ? 'DESC' : 'ASC';
    table.dataset.sortIndex = String(columnIndex);
    table.dataset.sortDir = nextDir;
    const rows = Array.from(tbody.querySelectorAll('tr')).filter(function(row) {
        return row.children.length > columnIndex && !row.querySelector('td[colspan]');
    });
    rows.sort(function(a, b) {
        const av = (a.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
        const bv = (b.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
        return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * (nextDir === 'ASC' ? 1 : -1);
    }).forEach(function(row) { tbody.appendChild(row); });
    table.querySelectorAll('th').forEach(function(th, idx) {
        const ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = idx === columnIndex ? (nextDir === 'ASC' ? '▲' : '▼') : '';
    });
}
function focusStaticAdminTableAction(tableId) {
    const table = document.getElementById(tableId);
    const target = table ? table.querySelector('tbody button, tbody a, tbody input, tbody select, tbody textarea') : null;
    if (target) {
        target.scrollIntoView({ block: 'center', behavior: 'smooth' });
        target.focus({ preventScroll: true });
    }
}
/* 정렬 헤더 sort-ico 셀렉터 — lrr-sort-ico에도 적용 */
(function () {
    const orig = window.sortStaticAdminTable;
    window.sortStaticAdminTable = function (tableId, columnIndex) {
        orig(tableId, columnIndex);
        const table = document.getElementById(tableId);
        if (!table) return;
        const dir = table.dataset.sortDir || 'ASC';
        const idx = Number(table.dataset.sortIndex || -1);
        table.querySelectorAll('th').forEach(function (th, i) {
            const ico = th.querySelector('.lrr-sort-ico');
            if (ico) ico.textContent = i === idx ? (dir === 'ASC' ? '▲' : '▼') : '';
        });
    };
})();
</script>

<style>
/* ── 로그인 위험 검토 페이지 전용 ── */
.adm-login-review-page .lrr-table { width: 100%; min-width: 1120px; table-layout: fixed; }
.adm-login-review-page .lrr-col-check    { width: 42px; }
.adm-login-review-page .lrr-th-check, .adm-login-review-page .lrr-cell-check { text-align: center; padding: 8px 4px; }
.adm-login-review-page .lrr-col-status   { width: 100px; }
.adm-login-review-page .lrr-col-severity { width: 90px; }
.adm-login-review-page .lrr-col-type     { width: 170px; }
.adm-login-review-page .lrr-col-target   { width: 200px; }
.adm-login-review-page .lrr-col-summary  { width: auto; }
.adm-login-review-page .lrr-col-date     { width: 140px; }
.adm-login-review-page .lrr-col-action   { width: 230px; }

.adm-login-review-page .lrr-th {
    white-space: nowrap; overflow: hidden;
    cursor: pointer; user-select: none;
    padding-right: 18px;
    position: relative;
    box-sizing: border-box;
}
.adm-login-review-page .lrr-th .lrr-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-login-review-page .lrr-th .lrr-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-login-review-page .lrr-th .lrr-sort-ico { color: #2563eb; }

.adm-login-review-page .lrr-table td {
    vertical-align: top;
    overflow: hidden; text-overflow: ellipsis;
    word-break: break-word;
}
.adm-login-review-page .lrr-table td .adm-login-review-summary { white-space: normal; line-height: 1.45; }
.adm-login-review-page .lrr-table td .adm-login-review-row-actions {
    display: flex; flex-wrap: wrap; gap: 4px;
}
.adm-login-review-page .lrr-table td .adm-login-review-row-actions form { display: inline-flex; }

@media (max-width: 1080px) {
    .adm-login-review-page .adm-login-review-filterbar { flex-wrap: wrap; }
}
</style>

<%@ include file="../layout-close.jsp" %>
