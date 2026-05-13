<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_appealPolicy_title" code="security.admin.appealPolicy.title"/>
<spring:message var="msg_security_admin_appealPolicy_desc" code="security.admin.appealPolicy.desc"/>
<spring:message var="msg_security_admin_nav_appeals" code="security.admin.nav.appeals"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_appealPolicy_cardTitle" code="security.admin.appealPolicy.cardTitle"/>
<spring:message var="msg_security_admin_common_enabled" code="security.admin.common.enabled"/>
<spring:message var="msg_security_admin_appealPolicy_section_channel" code="security.admin.appealPolicy.section.channel"/>
<spring:message var="msg_security_admin_appealPolicy_allowMultipleOpenAppeals" code="security.admin.appealPolicy.allowMultipleOpenAppeals"/>
<spring:message var="msg_security_admin_appealPolicy_maxOpenAppealsPerCase" code="security.admin.appealPolicy.maxOpenAppealsPerCase"/>
<spring:message var="msg_security_admin_appealPolicy_closedBlocksNewAppeals" code="security.admin.appealPolicy.closedBlocksNewAppeals"/>
<spring:message var="msg_security_admin_appealPolicy_section_cooldown" code="security.admin.appealPolicy.section.cooldown"/>
<spring:message var="msg_security_admin_appealPolicy_rejectedCooldownMinutes" code="security.admin.appealPolicy.rejectedCooldownMinutes"/>
<spring:message var="msg_security_admin_appealPolicy_maxRejectedCount" code="security.admin.appealPolicy.maxRejectedCount"/>
<spring:message var="msg_security_admin_appealPolicy_ipDailyAppealLimit" code="security.admin.appealPolicy.ipDailyAppealLimit"/>
<spring:message var="msg_security_admin_appealPolicy_section_email" code="security.admin.appealPolicy.section.email"/>
<spring:message var="msg_security_admin_appealPolicy_verificationWindowMinutes" code="security.admin.appealPolicy.verificationWindowMinutes"/>
<spring:message var="msg_security_admin_appealPolicy_maxVerificationEmails" code="security.admin.appealPolicy.maxVerificationEmails"/>
<spring:message var="msg_security_admin_appealPolicy_verificationTokenTtlMinutes" code="security.admin.appealPolicy.verificationTokenTtlMinutes"/>
<spring:message var="msg_security_admin_appealPolicy_protectedAppealTokenTtlDays" code="security.admin.appealPolicy.protectedAppealTokenTtlDays"/>
<spring:message var="msg_security_admin_appealPolicy_allowedEmailDomains" code="security.admin.appealPolicy.allowedEmailDomains"/>
<spring:message var="msg_security_admin_appealPolicy_blockedEmailDomains" code="security.admin.appealPolicy.blockedEmailDomains"/>
<spring:message var="msg_security_admin_appealPolicy_section_result" code="security.admin.appealPolicy.section.result"/>
<spring:message var="msg_security_admin_appealPolicy_resultLookupWindowMinutes" code="security.admin.appealPolicy.resultLookupWindowMinutes"/>
<spring:message var="msg_security_admin_appealPolicy_maxResultLookupFailures" code="security.admin.appealPolicy.maxResultLookupFailures"/>
<spring:message var="msg_security_admin_appealPolicy_resultLookupRetentionDays" code="security.admin.appealPolicy.resultLookupRetentionDays"/>
<spring:message var="msg_security_admin_appealPolicy_section_captcha" code="security.admin.appealPolicy.section.captcha"/>
<spring:message var="msg_security_admin_appealPolicy_captchaEnabled" code="security.admin.appealPolicy.captchaEnabled"/>
<spring:message var="msg_security_admin_appealPolicy_captchaProviderCode" code="security.admin.appealPolicy.captchaProviderCode"/>
<spring:message var="msg_security_admin_appealPolicy_captchaNote" code="security.admin.appealPolicy.captchaNote"/>
<spring:message var="msg_security_admin_common_description" code="security.admin.common.description"/>
<spring:message var="msg_security_admin_common_save" code="security.admin.common.save"/>
<spring:message var="msg_security_admin_appealPolicy_history_title" code="security.admin.appealPolicy.history.title"/>
<spring:message var="msg_security_admin_appealPolicy_history_desc" code="security.admin.appealPolicy.history.desc"/>
<spring:message var="msg_security_admin_appealPolicy_history_version" code="security.admin.appealPolicy.history.version"/>
<spring:message var="msg_security_admin_appealPolicy_history_changeType" code="security.admin.appealPolicy.history.changeType"/>
<spring:message var="msg_security_admin_appealPolicy_history_actor" code="security.admin.appealPolicy.history.actor"/>
<spring:message var="msg_security_admin_appealPolicy_history_changedAt" code="security.admin.appealPolicy.history.changedAt"/>
<spring:message var="msg_security_admin_appealPolicy_history_snapshot" code="security.admin.appealPolicy.history.snapshot"/>
<spring:message var="msg_security_admin_appealPolicy_history_showSnapshot" code="security.admin.appealPolicy.history.showSnapshot"/>
<spring:message var="msg_security_admin_appealPolicy_history_before" code="security.admin.appealPolicy.history.before"/>
<spring:message var="msg_security_admin_appealPolicy_history_after" code="security.admin.appealPolicy.history.after"/>
<spring:message var="msg_security_admin_appealPolicy_history_empty" code="security.admin.appealPolicy.history.empty"/>
<c:set var="pageTitle" value="${msg_security_admin_appealPolicy_title}"/>
<c:set var="activeMenu" value="securityAppealPolicy"/>

<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-appeal-policy-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_appealPolicy_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_appealPolicy_desc}</p>
        </div>
        <div class="adm-actions adm-appeal-policy-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/appeals">${msg_security_admin_nav_appeals}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeal-policy" class="adm-card adm-appeal-policy-card adm-overflow-visible">
        <div class="adm-card-header adm-appeal-policy-head">
            <div>
                <div class="adm-card-title">${msg_security_admin_appealPolicy_cardTitle}</div>
                <div class="adm-muted"><c:out value="${policy.policyCode}" default="DEFAULT"/></div>
            </div>
            <label class="adm-check adm-appeal-policy-active">
                <input type="checkbox" name="active" ${policy.active ? 'checked' : ''}>
                ${msg_security_admin_common_enabled}
            </label>
        </div>

        <div class="adm-card-body adm-appeal-policy-body">
            <input type="hidden" name="policyIdx" value="${policy.policyIdx}">
            <input type="hidden" name="policyCode" value="${fn:escapeXml(policy.policyCode)}">

            <section class="adm-appeal-policy-section">
                <h3 class="adm-appeal-policy-section-title">${msg_security_admin_appealPolicy_section_channel}</h3>
                <div class="adm-appeal-policy-grid">
                    <label class="adm-check adm-appeal-policy-check">
                        <input type="checkbox" name="allowMultipleOpenAppeals" ${policy.allowMultipleOpenAppeals ? 'checked' : ''}>
                        ${msg_security_admin_appealPolicy_allowMultipleOpenAppeals}
                    </label>
                    <label>${msg_security_admin_appealPolicy_maxOpenAppealsPerCase}
                        <input class="adm-input" type="number" min="1" name="maxOpenAppealsPerCase" value="${policy.maxOpenAppealsPerCase}">
                    </label>
                    <label class="adm-check adm-appeal-policy-check">
                        <input type="checkbox" name="closedBlocksNewAppeals" ${policy.closedBlocksNewAppeals ? 'checked' : ''}>
                        ${msg_security_admin_appealPolicy_closedBlocksNewAppeals}
                    </label>
                </div>
            </section>

            <section class="adm-appeal-policy-section">
                <h3 class="adm-appeal-policy-section-title">${msg_security_admin_appealPolicy_section_cooldown}</h3>
                <div class="adm-appeal-policy-grid">
                    <label>${msg_security_admin_appealPolicy_rejectedCooldownMinutes}
                        <input class="adm-input" type="number" min="0" name="rejectedCooldownMinutes" value="${policy.rejectedCooldownMinutes}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_maxRejectedCount}
                        <input class="adm-input" type="number" min="1" name="maxRejectedCount" value="${policy.maxRejectedCount}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_ipDailyAppealLimit}
                        <input class="adm-input" type="number" min="1" name="ipDailyAppealLimit" value="${policy.ipDailyAppealLimit}">
                    </label>
                </div>
            </section>

            <section class="adm-appeal-policy-section">
                <h3 class="adm-appeal-policy-section-title">${msg_security_admin_appealPolicy_section_email}</h3>
                <div class="adm-appeal-policy-grid">
                    <label>${msg_security_admin_appealPolicy_verificationWindowMinutes}
                        <input class="adm-input" type="number" min="1" name="verificationWindowMinutes" value="${policy.verificationWindowMinutes}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_maxVerificationEmails}
                        <input class="adm-input" type="number" min="1" name="maxVerificationEmails" value="${policy.maxVerificationEmails}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_verificationTokenTtlMinutes}
                        <input class="adm-input" type="number" min="1" name="verificationTokenTtlMinutes" value="${policy.verificationTokenTtlMinutes}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_protectedAppealTokenTtlDays}
                        <input class="adm-input" type="number" min="1" name="protectedAppealTokenTtlDays" value="${policy.protectedAppealTokenTtlDays}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_allowedEmailDomains}
                        <input class="adm-input" type="text" name="allowedEmailDomains" value="${fn:escapeXml(policy.allowedEmailDomains)}" placeholder="example.com,*.example.org">
                    </label>
                    <label>${msg_security_admin_appealPolicy_blockedEmailDomains}
                        <input class="adm-input" type="text" name="blockedEmailDomains" value="${fn:escapeXml(policy.blockedEmailDomains)}" placeholder="spam.example.com">
                    </label>
                </div>
            </section>

            <section class="adm-appeal-policy-section">
                <h3 class="adm-appeal-policy-section-title">${msg_security_admin_appealPolicy_section_result}</h3>
                <div class="adm-appeal-policy-grid">
                    <label>${msg_security_admin_appealPolicy_resultLookupWindowMinutes}
                        <input class="adm-input" type="number" min="1" name="resultLookupWindowMinutes" value="${policy.resultLookupWindowMinutes}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_maxResultLookupFailures}
                        <input class="adm-input" type="number" min="1" name="maxResultLookupFailures" value="${policy.maxResultLookupFailures}">
                    </label>
                    <label>${msg_security_admin_appealPolicy_resultLookupRetentionDays}
                        <input class="adm-input" type="number" min="0" name="resultLookupRetentionDays" value="${policy.resultLookupRetentionDays}">
                    </label>
                </div>
            </section>

            <section class="adm-appeal-policy-section">
                <h3 class="adm-appeal-policy-section-title">${msg_security_admin_appealPolicy_section_captcha}</h3>
                <div class="adm-appeal-policy-grid adm-appeal-policy-grid-compact">
                    <label class="adm-check adm-appeal-policy-check">
                        <input type="checkbox" name="captchaEnabled" ${policy.captchaEnabled ? 'checked' : ''}>
                        ${msg_security_admin_appealPolicy_captchaEnabled}
                    </label>
                    <label>${msg_security_admin_appealPolicy_captchaProviderCode}
                        <input class="adm-input" type="text" name="captchaProviderCode" value="${fn:escapeXml(policy.captchaProviderCode)}" placeholder="MOCK_TURNSTILE">
                    </label>
                </div>
                <p class="adm-muted adm-appeal-policy-note">${msg_security_admin_appealPolicy_captchaNote}</p>
            </section>

            <label class="adm-appeal-policy-description">${msg_security_admin_common_description}
                <textarea class="adm-input" name="description" rows="3"><c:out value="${policy.description}"/></textarea>
            </label>

            <div class="adm-actions adm-appeal-policy-actions">
                <button type="submit" class="adm-btn adm-btn-primary">${msg_security_admin_common_save}</button>
            </div>
        </div>
    </form>

    <div class="adm-card adm-appeal-policy-history-card adm-overflow-visible">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${msg_security_admin_appealPolicy_history_title}</div>
                <div class="adm-muted">${msg_security_admin_appealPolicy_history_desc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table id="appealPolicyHistoryTable" class="adm-table adm-appeal-policy-history-table aph-table" data-admin-list-ignore="hard">
                    <colgroup>
                        <col class="aph-col-check"/>
                        <col class="aph-col-version"/>
                        <col class="aph-col-change"/>
                        <col class="aph-col-actor"/>
                        <col class="aph-col-date"/>
                        <col class="aph-col-snapshot"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="aph-th aph-th-check"><input type="checkbox" aria-label="전체 선택"></th>
                        <th class="aph-th" onclick="sortStaticAdminTable('appealPolicyHistoryTable', 1)"><span class="aph-th-label">${msg_security_admin_appealPolicy_history_version}</span><span class="aph-sort-ico" aria-hidden="true"></span></th>
                        <th class="aph-th" onclick="sortStaticAdminTable('appealPolicyHistoryTable', 2)"><span class="aph-th-label">${msg_security_admin_appealPolicy_history_changeType}</span><span class="aph-sort-ico" aria-hidden="true"></span></th>
                        <th class="aph-th" onclick="sortStaticAdminTable('appealPolicyHistoryTable', 3)"><span class="aph-th-label">${msg_security_admin_appealPolicy_history_actor}</span><span class="aph-sort-ico" aria-hidden="true"></span></th>
                        <th class="aph-th" onclick="sortStaticAdminTable('appealPolicyHistoryTable', 4)"><span class="aph-th-label">${msg_security_admin_appealPolicy_history_changedAt}</span><span class="aph-sort-ico" aria-hidden="true"></span></th>
                        <th class="aph-th" onclick="openFirstAppealPolicySnapshot()"><span class="aph-th-label">${msg_security_admin_appealPolicy_history_snapshot}</span></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="h" items="${policyHistories}">
                        <tr>
                            <td class="aph-cell-check"><input type="checkbox" aria-label="행 선택"></td>
                            <td><c:out value="${h.versionNo}"/></td>
                            <td><span class="adm-badge"><c:out value="${h.changeType}"/></span></td>
                            <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                            <td><fmt:formatDate value="${h.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <details>
                                    <summary>${msg_security_admin_appealPolicy_history_showSnapshot}</summary>
                                    <div class="adm-appeal-policy-snapshot-grid">
                                        <div>
                                            <div class="adm-muted">${msg_security_admin_appealPolicy_history_before}</div>
                                            <pre class="adm-appeal-policy-snapshot"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${msg_security_admin_appealPolicy_history_after}</div>
                                            <pre class="adm-appeal-policy-snapshot"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty policyHistories}">
                        <tr class="adm-local-empty"><td colspan="6" class="adm-local-empty-cell">${msg_security_admin_appealPolicy_history_empty}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
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
    Array.from(tbody.querySelectorAll('tr'))
        .filter(function(row) { return row.children.length > columnIndex && !row.querySelector('td[colspan]'); })
        .sort(function(a, b) {
            const av = (a.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            const bv = (b.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * (nextDir === 'ASC' ? 1 : -1);
        })
        .forEach(function(row) { tbody.appendChild(row); });
    table.querySelectorAll('th').forEach(function(th, idx) {
        const ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = idx === columnIndex ? (nextDir === 'ASC' ? '▲' : '▼') : '';
    });
}
function openFirstAppealPolicySnapshot() {
    const details = document.querySelector('#appealPolicyHistoryTable tbody details');
    if (details) {
        details.open = true;
        details.scrollIntoView({ block: 'center', behavior: 'smooth' });
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
            const ico = th.querySelector('.aph-sort-ico');
            if (ico) ico.textContent = i === idx ? (dir === 'ASC' ? '▲' : '▼') : '';
        });
    };
})();
</script>

<style>
/* ── 이의제기 정책 페이지 (이력 표) 전용 ── */
.aph-table { width: 100%; min-width: 800px; table-layout: fixed; }
.aph-col-check    { width: 42px; }
.aph-th-check, .aph-cell-check { text-align: center; padding: 8px 4px; }
.aph-col-version  { width: 90px; }
.aph-col-change   { width: 140px; }
.aph-col-actor    { width: 120px; }
.aph-col-date     { width: 160px; }
.aph-col-snapshot { width: auto; }

.aph-th {
    white-space: nowrap; overflow: hidden;
    cursor: pointer; user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.aph-th .aph-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.aph-th .aph-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .aph-th .aph-sort-ico { color: #2563eb; }

.aph-table td { vertical-align: top; overflow: hidden; word-break: break-word; }
.aph-table td details { font-size: 12px; }
.aph-table td details summary { cursor: pointer; }
.aph-table td .adm-appeal-policy-snapshot-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-top: 6px;
}
.aph-table td .adm-appeal-policy-snapshot {
    white-space: pre-wrap; overflow-wrap: anywhere;
    background: rgba(15,23,42,.4); padding: 8px; border-radius: 6px;
    max-height: 220px; overflow: auto;
    font-size: 11px; font-family: ui-monospace, "Consolas", monospace;
}
body.sa-light .aph-table td .adm-appeal-policy-snapshot { background: #f1f5f9; }
@media (max-width: 720px) {
    .aph-table td .adm-appeal-policy-snapshot-grid { grid-template-columns: 1fr; }
}
</style>

<%@ include file="../layout-close.jsp" %>
