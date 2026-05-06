<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_9b6c43d4e2" code="admin.policyHistory.title"/>
<spring:message var="autoMsg_29e4e00dce" code="admin.policyHistory.desc"/>
<spring:message var="autoMsg_55b834f07d" code="admin.policyHistory.diffEmpty"/>
<spring:message var="autoMsg_099a32b35f" code="admin.policyHistory.diffInvalidJson"/>
<spring:message var="autoMsg_c65aae56fa" code="admin.layout.menu.runtimeSettings"/>
<spring:message var="autoMsg_3b08ecef87" code="security.admin.nav.policies"/>
<spring:message var="autoMsg_60a2746841" code="security.admin.nav.appealPolicy"/>
<spring:message var="autoMsg_bcc281ee8e" code="admin.policyHistory.sourceType"/>
<spring:message var="autoMsg_0a8c72fe2a" code="admin.common.all"/>
<spring:message var="autoMsg_54af038c87" code="admin.policyHistory.keyword"/>
<spring:message var="autoMsg_33271a7e80" code="admin.policyHistory.limit"/>
<spring:message var="autoMsg_fd07e4e9d5" code="admin.common.search"/>
<spring:message var="autoMsg_38683caff5" code="admin.policyHistory.listTitle"/>
<spring:message var="autoMsg_32e966df54" code="admin.policyHistory.listDesc"/>
<spring:message var="autoMsg_6311ec7180" code="admin.policyHistory.changedAt"/>
<spring:message var="autoMsg_e5c8d23b17" code="admin.policyHistory.itemKey"/>
<spring:message var="autoMsg_3615058312" code="admin.policyHistory.changeType"/>
<spring:message var="autoMsg_216f80001e" code="admin.policyHistory.actor"/>
<spring:message var="autoMsg_0213f255d2" code="admin.policyHistory.snapshot"/>
<spring:message var="autoMsg_ac676e48a8" code="admin.policyHistory.showSnapshot"/>
<spring:message var="autoMsg_a47b71747a" code="admin.policyHistory.before"/>
<spring:message var="autoMsg_ddd0340b25" code="admin.policyHistory.after"/>
<spring:message var="autoMsg_83b085d4a5" code="admin.policyHistory.diff"/>
<spring:message var="autoMsg_0b6c498e0d" code="admin.policyHistory.empty"/>
<c:set var="activeMenu" value="policyHistory"/>
<spring:message var="pageTitle" code="admin.policyHistory.title"/>
<spring:message var="keywordPlaceholder" code="admin.policyHistory.placeholder.keyword"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_9b6c43d4e2}</h1>
            <p class="adm-page-desc">${autoMsg_29e4e00dce}</p>
        </div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const text = {
        empty: '${autoMsg_55b834f07d}',
        invalid: '${autoMsg_099a32b35f}'
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
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings">${autoMsg_c65aae56fa}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${autoMsg_3b08ecef87}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${autoMsg_60a2746841}</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_bcc281ee8e}
                <select class="adm-input" name="sourceType">
                    <option value="">${autoMsg_0a8c72fe2a}</option>
                    <option value="SYSTEM_POLICY" ${sourceType == 'SYSTEM_POLICY' ? 'selected' : ''}>SYSTEM_POLICY</option>
                    <option value="LOGIN_RISK_POLICY" ${sourceType == 'LOGIN_RISK_POLICY' ? 'selected' : ''}>LOGIN_RISK_POLICY</option>
                    <option value="SECURITY_APPEAL_POLICY" ${sourceType == 'SECURITY_APPEAL_POLICY' ? 'selected' : ''}>SECURITY_APPEAL_POLICY</option>
                    <option value="RUNTIME_SETTING" ${sourceType == 'RUNTIME_SETTING' ? 'selected' : ''}>RUNTIME_SETTING</option>
                    <option value="PROVIDER_CONFIG" ${sourceType == 'PROVIDER_CONFIG' ? 'selected' : ''}>PROVIDER_CONFIG</option>
                </select>
            </label>
            <label>${autoMsg_54af038c87}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <label>${autoMsg_33271a7e80}
                <input class="adm-input" type="number" min="20" max="500" name="limit" value="${limit}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_fd07e4e9d5}</button>
            </div>
        </div>
    </form>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_38683caff5}</div>
                <div class="adm-muted">${autoMsg_32e966df54}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th>${autoMsg_6311ec7180}</th>
                        <th>${autoMsg_bcc281ee8e}</th>
                        <th>${autoMsg_e5c8d23b17}</th>
                        <th>${autoMsg_3615058312}</th>
                        <th>${autoMsg_216f80001e}</th>
                        <th>${autoMsg_0213f255d2}</th>
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
                                    <summary>${autoMsg_ac676e48a8}</summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted">${autoMsg_a47b71747a}</div>
                                            <pre class="js-policy-before" style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${autoMsg_ddd0340b25}</div>
                                            <pre class="js-policy-after" style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                    <div style="margin-top:10px;">
                                        <button type="button" class="adm-btn js-policy-diff-run">${autoMsg_83b085d4a5}</button>
                                        <pre class="js-policy-diff" style="white-space:pre-wrap;max-height:220px;overflow:auto;margin-top:8px;"></pre>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty">${autoMsg_0b6c498e0d}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
