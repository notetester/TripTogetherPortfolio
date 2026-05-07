<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_policyHistory_title" code="admin.policyHistory.title"/>
<spring:message var="msg_admin_policyHistory_placeholder_keyword" code="admin.policyHistory.placeholder.keyword"/>
<spring:message var="msg_admin_policyHistory_diffEmpty" code="admin.policyHistory.diffEmpty"/>
<spring:message var="msg_admin_policyHistory_diffInvalidJson" code="admin.policyHistory.diffInvalidJson"/>
<spring:message var="msg_admin_policyHistory_desc" code="admin.policyHistory.desc"/>
<spring:message var="msg_admin_layout_menu_runtimeSettings" code="admin.layout.menu.runtimeSettings"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_appealPolicy" code="security.admin.nav.appealPolicy"/>
<spring:message var="msg_admin_policyHistory_sourceType" code="admin.policyHistory.sourceType"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_policyHistory_keyword" code="admin.policyHistory.keyword"/>
<spring:message var="msg_admin_policyHistory_limit" code="admin.policyHistory.limit"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_policyHistory_listTitle" code="admin.policyHistory.listTitle"/>
<spring:message var="msg_admin_policyHistory_listDesc" code="admin.policyHistory.listDesc"/>
<spring:message var="msg_admin_policyHistory_changedAt" code="admin.policyHistory.changedAt"/>
<spring:message var="msg_admin_policyHistory_itemKey" code="admin.policyHistory.itemKey"/>
<spring:message var="msg_admin_policyHistory_changeType" code="admin.policyHistory.changeType"/>
<spring:message var="msg_admin_policyHistory_actor" code="admin.policyHistory.actor"/>
<spring:message var="msg_admin_policyHistory_snapshot" code="admin.policyHistory.snapshot"/>
<spring:message var="msg_admin_policyHistory_showSnapshot" code="admin.policyHistory.showSnapshot"/>
<spring:message var="msg_admin_policyHistory_before" code="admin.policyHistory.before"/>
<spring:message var="msg_admin_policyHistory_after" code="admin.policyHistory.after"/>
<spring:message var="msg_admin_policyHistory_diff" code="admin.policyHistory.diff"/>
<spring:message var="msg_admin_policyHistory_empty" code="admin.policyHistory.empty"/>
<c:set var="pageTitle" value="${msg_admin_policyHistory_title}"/>
<c:set var="activeMenu" value="policyHistory"/>


<%@ include file="layout.jsp" %>


<div class="adm-content adm-governance-page adm-policy-history-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_policyHistory_title}</h1>
            <p class="adm-page-desc">${msg_admin_policyHistory_desc}</p>
        </div>


        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings">${msg_admin_layout_menu_runtimeSettings}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${msg_security_admin_nav_appealPolicy}</a>
        </div>
    </div>

    <form method="get" class="adm-card adm-policy-history-filter-card">
        <div class="adm-policy-history-filter-grid">
            <label class="adm-policy-history-field">${msg_admin_policyHistory_sourceType}
                <select class="adm-select" name="sourceType">
                    <option value="">${msg_admin_common_all}</option>
                    <option value="SYSTEM_POLICY" ${sourceType == 'SYSTEM_POLICY' ? 'selected' : ''}>SYSTEM_POLICY</option>
                    <option value="LOGIN_RISK_POLICY" ${sourceType == 'LOGIN_RISK_POLICY' ? 'selected' : ''}>LOGIN_RISK_POLICY</option>
                    <option value="SECURITY_APPEAL_POLICY" ${sourceType == 'SECURITY_APPEAL_POLICY' ? 'selected' : ''}>SECURITY_APPEAL_POLICY</option>
                    <option value="RUNTIME_SETTING" ${sourceType == 'RUNTIME_SETTING' ? 'selected' : ''}>RUNTIME_SETTING</option>
                    <option value="PROVIDER_CONFIG" ${sourceType == 'PROVIDER_CONFIG' ? 'selected' : ''}>PROVIDER_CONFIG</option>
                </select>
            </label>
            <label class="adm-policy-history-field adm-policy-history-keyword-field">${msg_admin_policyHistory_keyword}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_admin_policyHistory_placeholder_keyword}">
            </label>
            <label class="adm-policy-history-field">${msg_admin_policyHistory_limit}
                <input class="adm-input" type="number" min="20" max="500" name="limit" value="${limit}">
            </label>
            <div class="adm-policy-history-actions">
                <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_search}</button>
            </div>
        </div>
    </form>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${msg_admin_policyHistory_listTitle}</div>
                <div class="adm-muted">${msg_admin_policyHistory_listDesc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table adm-policy-history-table">
                    <thead>
                    <tr>
                        <th>${msg_admin_policyHistory_changedAt}</th>
                        <th>${msg_admin_policyHistory_sourceType}</th>
                        <th>${msg_admin_policyHistory_itemKey}</th>
                        <th>${msg_admin_policyHistory_changeType}</th>
                        <th>${msg_admin_policyHistory_actor}</th>
                        <th>${msg_admin_policyHistory_snapshot}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <tr>
                            <td><fmt:formatDate value="${h.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><span class="adm-badge"><c:out value="${h.sourceType}"/></span></td>
                            <td><c:out value="${h.itemKey}"/></td>
                            <td><c:out value="${h.changeType}"/></td>
                            <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                            <td>
                                <details class="adm-policy-history-details">
                                    <summary>${msg_admin_policyHistory_showSnapshot}</summary>
                                    <div class="adm-policy-snapshot-grid">
                                        <div>
                                            <div class="adm-muted">${msg_admin_policyHistory_before}</div>
                                            <pre class="js-policy-before adm-policy-snapshot-pre"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${msg_admin_policyHistory_after}</div>
                                            <pre class="js-policy-after adm-policy-snapshot-pre"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                    <div class="adm-policy-diff-block">
                                        <button type="button" class="adm-btn adm-btn-ghost js-policy-diff-run">${msg_admin_policyHistory_diff}</button>
                                        <pre class="js-policy-diff adm-policy-snapshot-pre adm-policy-diff-output"></pre>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty">${msg_admin_policyHistory_empty}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const text = {
        empty: '${msg_admin_policyHistory_diffEmpty}',
        invalid: '${msg_admin_policyHistory_diffInvalidJson}'
    };
    const parseJson = function (value) {
        if (!value || !value.trim()) return {};
        return JSON.parse(value);
    };
    const stringify = function (value) {
        if (value === undefined) return '';
        if (value === null) return 'null';
        if (typeof value === 'object') return JSON.stringify(value);
        return String(value);
    };
    document.querySelectorAll('.js-policy-diff-run').forEach(function (button) {
        button.addEventListener('click', function () {
            const root = button.closest('details');
            const output = root.querySelector('.js-policy-diff');
            try {
                const before = parseJson(root.querySelector('.js-policy-before').textContent);
                const after = parseJson(root.querySelector('.js-policy-after').textContent);
                const keys = Array.from(new Set(Object.keys(before).concat(Object.keys(after)))).sort();
                const lines = [];
                keys.forEach(function (key) {
                    const b = stringify(before[key]);
                    const a = stringify(after[key]);
                    if (b !== a) lines.push(key + ': ' + b + ' -> ' + a);
                });
                output.textContent = lines.length ? lines.join('\\n') : text.empty;
            } catch (e) {
                output.textContent = text.invalid;
            }
        });
    });
});
</script>

