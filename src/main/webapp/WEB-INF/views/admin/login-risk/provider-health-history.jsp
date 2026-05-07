<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_providerHealth_title" code="security.admin.providerHealth.title"/>
<spring:message var="msg_security_admin_providerHealth_providerCodePlaceholder" code="security.admin.providerHealth.providerCodePlaceholder"/>
<spring:message var="msg_security_admin_providerHealth_desc" code="security.admin.providerHealth.desc"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_security_admin_providerHealth_providerCode" code="security.admin.providerHealth.providerCode"/>
<spring:message var="msg_security_admin_providerHealth_limit" code="security.admin.providerHealth.limit"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_providerHealth_checkedAt" code="security.admin.providerHealth.checkedAt"/>
<spring:message var="msg_security_admin_providerHealth_provider" code="security.admin.providerHealth.provider"/>
<spring:message var="msg_security_admin_providerHealth_checkSource" code="security.admin.providerHealth.checkSource"/>
<spring:message var="msg_security_admin_providerHealth_statusBefore" code="security.admin.providerHealth.statusBefore"/>
<spring:message var="msg_security_admin_providerHealth_statusAfter" code="security.admin.providerHealth.statusAfter"/>
<spring:message var="msg_security_admin_providerHealth_actor" code="security.admin.providerHealth.actor"/>
<spring:message var="msg_security_admin_providerHealth_detail" code="security.admin.providerHealth.detail"/>
<spring:message var="msg_security_admin_providerHealth_empty" code="security.admin.providerHealth.empty"/>
<c:set var="pageTitle" value="${msg_security_admin_providerHealth_title}"/>
<c:set var="activeMenu" value="providerHealthHistory"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_providerHealth_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_providerHealth_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${msg_admin_layout_menu_policyHistory}</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_providerHealth_providerCode}
                <input class="adm-input" type="text" name="providerCode" value="${fn:escapeXml(providerCode)}" placeholder="${msg_security_admin_providerHealth_providerCodePlaceholder}">
            </label>
            <label>${msg_security_admin_providerHealth_limit}
                <input class="adm-input" type="number" min="1" max="200" name="limit" value="${limit}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${msg_security_admin_common_search}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${msg_security_admin_providerHealth_checkedAt}</th>
                <th>${msg_security_admin_providerHealth_provider}</th>
                <th>${msg_security_admin_providerHealth_checkSource}</th>
                <th>${msg_security_admin_providerHealth_statusBefore}</th>
                <th>${msg_security_admin_providerHealth_statusAfter}</th>
                <th>${msg_security_admin_providerHealth_actor}</th>
                <th>${msg_security_admin_providerHealth_detail}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="h" items="${histories}">
                <tr>
                    <td><fmt:formatDate value="${h.checkedAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><c:out value="${h.providerKind}"/> · <c:out value="${h.providerCode}"/></td>
                    <td><span class="adm-badge"><c:out value="${h.checkSource}"/></span></td>
                    <td><c:out value="${h.statusBefore}" default="-"/></td>
                    <td><c:out value="${h.statusAfter}" default="-"/></td>
                    <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                    <td><div style="white-space:pre-wrap;max-width:520px;"><c:out value="${h.detailMessage}" default="-"/></div></td>
                </tr>
            </c:forEach>
            <c:if test="${empty histories}">
                <tr><td colspan="7" class="adm-empty">${msg_security_admin_providerHealth_empty}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
