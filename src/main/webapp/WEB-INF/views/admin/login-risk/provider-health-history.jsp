<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="providerHealthHistory"/>
<spring:message var="pageTitle" code="security.admin.providerHealth.title"/>
<spring:message var="providerCodePlaceholder" code="security.admin.providerHealth.providerCodePlaceholder"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.providerHealth.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.providerHealth.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs"><spring:message code="security.admin.nav.providerConfigs"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG"><spring:message code="admin.layout.menu.policyHistory"/></a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.providerHealth.providerCode"/>
                <input class="adm-input" type="text" name="providerCode" value="${fn:escapeXml(providerCode)}" placeholder="${providerCodePlaceholder}">
            </label>
            <label><spring:message code="security.admin.providerHealth.limit"/>
                <input class="adm-input" type="number" min="1" max="200" name="limit" value="${limit}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.search"/></button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th><spring:message code="security.admin.providerHealth.checkedAt"/></th>
                <th><spring:message code="security.admin.providerHealth.provider"/></th>
                <th><spring:message code="security.admin.providerHealth.checkSource"/></th>
                <th><spring:message code="security.admin.providerHealth.statusBefore"/></th>
                <th><spring:message code="security.admin.providerHealth.statusAfter"/></th>
                <th><spring:message code="security.admin.providerHealth.actor"/></th>
                <th><spring:message code="security.admin.providerHealth.detail"/></th>
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
                <tr><td colspan="7" class="adm-empty"><spring:message code="security.admin.providerHealth.empty"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
