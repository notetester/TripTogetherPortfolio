<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_externalAssessments_title" code="security.admin.externalAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_ipAccountSourceReason" code="security.admin.placeholder.ipAccountSourceReason"/>
<spring:message var="msg_security_admin_externalAssessments_desc" code="security.admin.externalAssessments.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_reviews" code="security.admin.nav.reviews"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_decisionStatus" code="security.admin.common.decisionStatus"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_source" code="security.admin.common.source"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_empty_externalAssessments" code="security.admin.empty.externalAssessments"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(assessments)}"/>
<c:set var="pageTitle" value="${msg_security_admin_externalAssessments_title}"/>
<c:set var="activeMenu" value="loginRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-external-assessment-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_externalAssessments_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_externalAssessments_desc}</p>
        </div>
        <div class="adm-actions adm-external-assessment-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_security_admin_nav_reviews}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <form method="get" class="adm-card adm-external-assessment-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-external-assessment-filterbar">
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
                <label>${msg_security_admin_common_decisionStatus}
                    <select class="adm-select" name="decisionStatus">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                        <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                        <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                        <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label class="adm-external-assessment-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_ipAccountSourceReason}">
                </label>
                <div class="adm-external-assessment-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-external-assessment-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_externalAssessments_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="externalAssessmentTable"
                   class="adm-table adm-section-table-fixed adm-external-assessment-table ea-table"
                   data-section="externalAssessments"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="ea-col-check"/>
                    <col class="ea-col-source"/>
                    <col class="ea-col-target"/>
                    <col class="ea-col-risk"/>
                    <col class="ea-col-recommend"/>
                    <col class="ea-col-evidence"/>
                    <col class="ea-col-status"/>
                    <col class="ea-col-date"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="ea-th ea-th-check"><input type="checkbox" aria-label="전체 선택"></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 1)"><span class="ea-th-label">${msg_security_admin_common_source}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 2)"><span class="ea-th-label">${msg_security_admin_common_target}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 3)"><span class="ea-th-label">${msg_security_admin_common_riskLevel}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 4)"><span class="ea-th-label">${msg_security_admin_common_recommendationAction}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 5)"><span class="ea-th-label">${msg_security_admin_common_evidence}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 6)"><span class="ea-th-label">${msg_security_admin_common_status}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th" onclick="sortStaticAdminTable('externalAssessmentTable', 7)"><span class="ea-th-label">${msg_security_admin_common_createdAt}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${assessments}">
                    <tr>
                        <td class="ea-cell-check"><input type="checkbox" aria-label="행 선택"></td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.sourceKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceName}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceCode}"/> <c:out value="${a.sourceVersion}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${a.subjectType}"/>: <c:out value="${a.subjectKey}"/></div>
                            <c:if test="${not empty a.userId}"><div class="adm-page-muted"><c:out value="${a.userId}"/> / <c:out value="${a.nickname}"/></div></c:if>
                            <c:if test="${not empty a.ipAddress}"><div class="adm-page-muted">IP: <c:out value="${a.ipAddress}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.riskLevel}"/></div>
                            <c:if test="${not empty a.riskScore}"><div class="adm-page-muted">score <c:out value="${a.riskScore}"/></div></c:if>
                            <c:if test="${not empty a.confidenceScore}"><div class="adm-page-muted">confidence <c:out value="${a.confidenceScore}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.recommendationAction}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.recommendationReason}"/></div>
                        </td>
                        <td><div class="adm-external-assessment-evidence"><c:out value="${a.evidenceSummary}"/></div></td>
                        <td><span class="adm-badge"><c:out value="${a.decisionStatus}"/></span></td>
                        <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty assessments}">
                    <tr class="adm-local-empty"><td colspan="8" class="adm-local-empty-cell">${msg_security_admin_empty_externalAssessments}</td></tr>
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
        const ico = th.querySelector('.sort-ico') || th.querySelector('.ea-sort-ico');
        if (ico) ico.textContent = idx === columnIndex ? (nextDir === 'ASC' ? '▲' : '▼') : '';
    });
}
</script>

<style>
/* ── 외부 위험 판단 페이지 전용 ── */
.adm-external-assessment-page .ea-table { width: 100%; min-width: 1220px; table-layout: fixed; }
.adm-external-assessment-page .ea-col-check     { width: 42px; }
.adm-external-assessment-page .ea-th-check, .adm-external-assessment-page .ea-cell-check { text-align: center; padding: 8px 4px; }
.adm-external-assessment-page .ea-col-source    { width: 180px; }
.adm-external-assessment-page .ea-col-target    { width: 200px; }
.adm-external-assessment-page .ea-col-risk      { width: 130px; }
.adm-external-assessment-page .ea-col-recommend { width: 180px; }
.adm-external-assessment-page .ea-col-evidence  { width: auto; }
.adm-external-assessment-page .ea-col-status    { width: 110px; }
.adm-external-assessment-page .ea-col-date      { width: 140px; }

.adm-external-assessment-page .ea-th {
    white-space: nowrap; overflow: hidden;
    cursor: pointer; user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-external-assessment-page .ea-th .ea-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-external-assessment-page .ea-th .ea-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-external-assessment-page .ea-th .ea-sort-ico { color: #2563eb; }

.adm-external-assessment-page .ea-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-external-assessment-page .ea-table .adm-external-assessment-evidence {
    white-space: pre-wrap; overflow-wrap: anywhere;
    max-height: 8em; overflow: hidden;
    text-overflow: ellipsis; font-size: 12px; line-height: 1.45;
}

@media (max-width: 1180px) {
    .adm-external-assessment-page .adm-external-assessment-filterbar { flex-wrap: wrap; }
}
</style>

<%@ include file="../layout-close.jsp" %>
