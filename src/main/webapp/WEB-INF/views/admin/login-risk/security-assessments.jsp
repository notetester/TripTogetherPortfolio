<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_securityAssessments_title" code="security.admin.securityAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpEvidenceSource" code="security.admin.placeholder.accountIpEvidenceSource"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_securityAssessments_desc" code="security.admin.securityAssessments.desc"/>
<spring:message var="msg_security_admin_nav_externalAssessmentsLong" code="security.admin.nav.externalAssessmentsLong"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_nav_blocks" code="security.admin.nav.blocks"/>
<spring:message var="msg_security_admin_common_scope" code="security.admin.common.scope"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_scopeSource" code="security.admin.common.scopeSource"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_apply" code="security.admin.common.apply"/>
<spring:message var="msg_security_admin_common_ip" code="security.admin.common.ip"/>
<spring:message var="msg_security_admin_common_enqueueReview" code="security.admin.common.enqueueReview"/>
<spring:message var="msg_security_admin_common_applyUserBlock" code="security.admin.common.applyUserBlock"/>
<spring:message var="msg_security_admin_empty_securityAssessments" code="security.admin.empty.securityAssessments"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(assessments)}"/>
<c:set var="pageTitle" value="${msg_security_admin_securityAssessments_title}"/>
<c:set var="activeMenu" value="securityRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-security-assessment-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_nav_securityAssessments}</h1>
            <p class="adm-page-desc">${msg_security_admin_securityAssessments_desc}</p>
        </div>
        <div class="adm-actions adm-security-assessment-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessmentsLong}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/blocks">${msg_security_admin_nav_blocks}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-security-assessment-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-security-assessment-filterbar">
                <label>${msg_security_admin_common_scope}
                    <select class="adm-select" name="assessmentScope">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="LOGIN_RISK" ${assessmentScope == 'LOGIN_RISK' ? 'selected' : ''}>LOGIN_RISK</option>
                        <option value="USER_SECURITY" ${assessmentScope == 'USER_SECURITY' ? 'selected' : ''}>USER_SECURITY</option>
                        <option value="CONTENT_MODERATION" ${assessmentScope == 'CONTENT_MODERATION' ? 'selected' : ''}>CONTENT_MODERATION</option>
                        <option value="IP_REPUTATION" ${assessmentScope == 'IP_REPUTATION' ? 'selected' : ''}>IP_REPUTATION</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_sourceKind}
                    <select class="adm-select" name="sourceKind">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                        <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                        <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                        <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_riskLevel}
                    <select class="adm-select" name="riskLevel">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                        <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                        <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                        <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="decisionStatus">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                        <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                        <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                        <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label class="adm-security-assessment-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpEvidenceSource}">
                </label>
                <div class="adm-security-assessment-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-security-assessment-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_securityAssessments_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="securityAssessmentTable"
                   class="adm-table adm-section-table-fixed adm-security-assessment-table sa-table"
                   data-section="securityAssessments"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="sa-col-source"/>
                    <col class="sa-col-target"/>
                    <col class="sa-col-risk"/>
                    <col class="sa-col-recommend"/>
                    <col class="sa-col-evidence"/>
                    <col class="sa-col-status"/>
                    <col class="sa-col-date"/>
                    <col class="sa-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 0)"><span class="sa-th-label">${msg_security_admin_common_scopeSource}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 1)"><span class="sa-th-label">${msg_security_admin_common_target}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 2)"><span class="sa-th-label">${msg_security_admin_common_riskLevel}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 3)"><span class="sa-th-label">${msg_security_admin_common_recommendationAction}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 4)"><span class="sa-th-label">${msg_security_admin_common_evidence}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 5)"><span class="sa-th-label">${msg_security_admin_common_status}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="sortStaticAdminTable('securityAssessmentTable', 6)"><span class="sa-th-label">${msg_security_admin_common_createdAt}</span><span class="sa-sort-ico" aria-hidden="true"></span></th>
                    <th class="sa-th" onclick="focusStaticAdminTableAction('securityAssessmentTable')"><span class="sa-th-label">${msg_security_admin_common_apply}</span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${assessments}">
                    <tr>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.assessmentScope}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceName}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${a.subjectType}"/>: <c:out value="${a.subjectKey}"/></div>
                            <c:if test="${not empty a.userId}"><div class="adm-page-muted"><c:out value="${a.userId}"/> / <c:out value="${a.nickname}"/></div></c:if>
                            <c:if test="${not empty a.ipAddress}"><div class="adm-page-muted">${msg_security_admin_common_ip}: <c:out value="${a.ipAddress}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.riskLevel}"/></div>
                            <c:if test="${not empty a.riskScore}"><div class="adm-page-muted">score <c:out value="${a.riskScore}"/></div></c:if>
                            <c:if test="${not empty a.confidenceScore}"><div class="adm-page-muted">confidence <c:out value="${a.confidenceScore}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.recommendationAction}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.recommendationReason}"/></div>
                        </td>
                        <td><div class="adm-security-assessment-evidence"><c:out value="${a.evidenceSummary}"/></div></td>
                        <td><span class="adm-badge"><c:out value="${a.decisionStatus}"/></span></td>
                        <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:if test="${a.decisionStatus != 'APPLIED'}">
                                <div class="adm-security-assessment-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/create-review">
                                        <input type="hidden" name="severity" value="${fn:escapeXml(a.riskLevel)}">
                                        <input type="hidden" name="summary" value="${fn:escapeXml(a.recommendationAction)}">
                                        <input type="hidden" name="detailMessage" value="${fn:escapeXml(a.evidenceSummary)}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_enqueueReview}</button>
                                    </form>
                                    <c:if test="${a.subjectType == 'USER'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/apply-user-block">
                                            <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_applyUserBlock}</button>
                                        </form>
                                    </c:if>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty assessments}">
                    <tr class="adm-local-empty"><td colspan="8" class="adm-local-empty-cell">${msg_security_admin_empty_securityAssessments}</td></tr>
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
(function () {
    const orig = window.sortStaticAdminTable;
    window.sortStaticAdminTable = function (tableId, columnIndex) {
        orig(tableId, columnIndex);
        const table = document.getElementById(tableId);
        if (!table) return;
        const dir = table.dataset.sortDir || 'ASC';
        const idx = Number(table.dataset.sortIndex || -1);
        table.querySelectorAll('th').forEach(function (th, i) {
            const ico = th.querySelector('.sa-sort-ico');
            if (ico) ico.textContent = i === idx ? (dir === 'ASC' ? '▲' : '▼') : '';
        });
    };
})();
</script>

<style>
/* ── 보안 위험 판단 페이지 전용 ── */
.adm-security-assessment-page .sa-table { width: 100%; min-width: 1280px; table-layout: fixed; }
.adm-security-assessment-page .sa-col-source    { width: 170px; }
.adm-security-assessment-page .sa-col-target    { width: 190px; }
.adm-security-assessment-page .sa-col-risk      { width: 130px; }
.adm-security-assessment-page .sa-col-recommend { width: 180px; }
.adm-security-assessment-page .sa-col-evidence  { width: auto; }
.adm-security-assessment-page .sa-col-status    { width: 100px; }
.adm-security-assessment-page .sa-col-date      { width: 140px; }
.adm-security-assessment-page .sa-col-action    { width: 200px; }

.adm-security-assessment-page .sa-th {
    white-space: nowrap; overflow: hidden;
    cursor: pointer; user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-security-assessment-page .sa-th .sa-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-security-assessment-page .sa-th .sa-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-security-assessment-page .sa-th .sa-sort-ico { color: #2563eb; }

.adm-security-assessment-page .sa-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-security-assessment-page .sa-table .adm-security-assessment-evidence {
    white-space: pre-wrap; overflow-wrap: anywhere;
    max-height: 8em; overflow: hidden;
    text-overflow: ellipsis; font-size: 12px; line-height: 1.45;
}
.adm-security-assessment-page .sa-table .adm-security-assessment-row-actions {
    display: flex; flex-wrap: wrap; gap: 4px;
}

@media (max-width: 1280px) {
    .adm-security-assessment-page .adm-security-assessment-filterbar { flex-wrap: wrap; }
}
</style>

<%@ include file="../layout-close.jsp" %>
