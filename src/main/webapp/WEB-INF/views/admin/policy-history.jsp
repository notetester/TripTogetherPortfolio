<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="policyHistory"/>
<spring:message var="pageTitle" code="admin.policyHistory.title"/>
<spring:message var="keywordPlaceholder" code="admin.policyHistory.placeholder.keyword"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="admin.policyHistory.title"/></h1>
            <p class="adm-page-desc"><spring:message code="admin.policyHistory.desc"/></p>
        </div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const text = {
        empty: '<spring:message code="admin.policyHistory.diffEmpty"/>',
        invalid: '<spring:message code="admin.policyHistory.diffInvalidJson"/>'
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

        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings"><spring:message code="admin.layout.menu.runtimeSettings"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies"><spring:message code="security.admin.nav.policies"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy"><spring:message code="security.admin.nav.appealPolicy"/></a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label><spring:message code="admin.policyHistory.sourceType"/>
                <select class="adm-input" name="sourceType">
                    <option value=""><spring:message code="admin.common.all"/></option>
                    <option value="SYSTEM_POLICY" ${sourceType == 'SYSTEM_POLICY' ? 'selected' : ''}>SYSTEM_POLICY</option>
                    <option value="LOGIN_RISK_POLICY" ${sourceType == 'LOGIN_RISK_POLICY' ? 'selected' : ''}>LOGIN_RISK_POLICY</option>
                    <option value="SECURITY_APPEAL_POLICY" ${sourceType == 'SECURITY_APPEAL_POLICY' ? 'selected' : ''}>SECURITY_APPEAL_POLICY</option>
                    <option value="RUNTIME_SETTING" ${sourceType == 'RUNTIME_SETTING' ? 'selected' : ''}>RUNTIME_SETTING</option>
                    <option value="PROVIDER_CONFIG" ${sourceType == 'PROVIDER_CONFIG' ? 'selected' : ''}>PROVIDER_CONFIG</option>
                </select>
            </label>
            <label><spring:message code="admin.policyHistory.keyword"/>
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <label><spring:message code="admin.policyHistory.limit"/>
                <input class="adm-input" type="number" min="20" max="500" name="limit" value="${limit}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit"><spring:message code="admin.common.search"/></button>
            </div>
        </div>
    </form>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title"><spring:message code="admin.policyHistory.listTitle"/></div>
                <div class="adm-muted"><spring:message code="admin.policyHistory.listDesc"/></div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th><spring:message code="admin.policyHistory.changedAt"/></th>
                        <th><spring:message code="admin.policyHistory.sourceType"/></th>
                        <th><spring:message code="admin.policyHistory.itemKey"/></th>
                        <th><spring:message code="admin.policyHistory.changeType"/></th>
                        <th><spring:message code="admin.policyHistory.actor"/></th>
                        <th><spring:message code="admin.policyHistory.snapshot"/></th>
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
                                <details>
                                    <summary><spring:message code="admin.policyHistory.showSnapshot"/></summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted"><spring:message code="admin.policyHistory.before"/></div>
                                            <pre class="js-policy-before" style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted"><spring:message code="admin.policyHistory.after"/></div>
                                            <pre class="js-policy-after" style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                    <div style="margin-top:10px;">
                                        <button type="button" class="adm-btn js-policy-diff-run"><spring:message code="admin.policyHistory.diff"/></button>
                                        <pre class="js-policy-diff" style="white-space:pre-wrap;max-height:220px;overflow:auto;margin-top:8px;"></pre>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty"><spring:message code="admin.policyHistory.empty"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
