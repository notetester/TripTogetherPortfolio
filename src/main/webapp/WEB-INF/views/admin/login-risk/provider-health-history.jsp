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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_security_admin_providerHealth_checkedAt" code="security.admin.providerHealth.checkedAt"/>
<spring:message var="msg_security_admin_providerHealth_provider" code="security.admin.providerHealth.provider"/>
<spring:message var="msg_security_admin_providerHealth_checkSource" code="security.admin.providerHealth.checkSource"/>
<spring:message var="msg_security_admin_providerHealth_statusBefore" code="security.admin.providerHealth.statusBefore"/>
<spring:message var="msg_security_admin_providerHealth_statusAfter" code="security.admin.providerHealth.statusAfter"/>
<spring:message var="msg_security_admin_providerHealth_actor" code="security.admin.providerHealth.actor"/>
<spring:message var="msg_security_admin_providerHealth_detail" code="security.admin.providerHealth.detail"/>
<spring:message var="msg_security_admin_providerHealth_empty" code="security.admin.providerHealth.empty"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(histories)}"/>
<c:set var="pageTitle" value="${msg_security_admin_providerHealth_title}"/>
<c:set var="activeMenu" value="providerHealthHistory"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-provider-health-page">
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

    <form method="get" class="adm-card adm-provider-health-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-provider-health-filterbar">
                <label class="adm-provider-health-code-field">${msg_security_admin_providerHealth_providerCode}
                    <input class="adm-input" type="text" name="providerCode" value="${fn:escapeXml(providerCode)}" placeholder="${msg_security_admin_providerHealth_providerCodePlaceholder}">
                </label>
                <label class="adm-provider-health-limit-field">${msg_security_admin_providerHealth_limit}
                    <input class="adm-input" type="number" min="1" max="200" name="limit" value="${limit}">
                </label>
                <div class="adm-provider-health-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-health-history">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-provider-health-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_providerHealth_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="providerHealthHistoryTable"
                   class="adm-table adm-section-table-fixed adm-provider-health-table"
                   data-admin-list-ignore="true"
                   data-section="providerHealthHistory">
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
                        <td>
                            <div class="adm-provider-health-provider"><c:out value="${h.providerKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${h.providerCode}"/></div>
                        </td>
                        <td><span class="adm-badge"><c:out value="${h.checkSource}"/></span></td>
                        <td><c:out value="${h.statusBefore}" default="-"/></td>
                        <td><c:out value="${h.statusAfter}" default="-"/></td>
                        <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                        <td><div class="adm-provider-health-detail"><c:out value="${h.detailMessage}" default="-"/></div></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty histories}">
                    <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">${msg_security_admin_providerHealth_empty}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
