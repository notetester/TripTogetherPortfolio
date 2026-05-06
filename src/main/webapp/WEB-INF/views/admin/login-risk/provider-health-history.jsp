<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_48cb318b3b" code="security.admin.providerHealth.title"/>
<spring:message var="autoMsg_e38e8f3cff" code="security.admin.providerHealth.desc"/>
<spring:message var="autoMsg_c6a6403563" code="security.admin.nav.providerConfigs"/>
<spring:message var="autoMsg_4a460657ff" code="admin.layout.menu.policyHistory"/>
<spring:message var="autoMsg_ed43e5dec9" code="security.admin.providerHealth.providerCode"/>
<spring:message var="autoMsg_0346d1cb63" code="security.admin.providerHealth.limit"/>
<spring:message var="autoMsg_76a835e0a4" code="security.admin.common.search"/>
<spring:message var="autoMsg_f2606d7e1b" code="security.admin.providerHealth.checkedAt"/>
<spring:message var="autoMsg_edfd74e917" code="security.admin.providerHealth.provider"/>
<spring:message var="autoMsg_34c8fd393e" code="security.admin.providerHealth.checkSource"/>
<spring:message var="autoMsg_50bb77d7c1" code="security.admin.providerHealth.statusBefore"/>
<spring:message var="autoMsg_81de4e3042" code="security.admin.providerHealth.statusAfter"/>
<spring:message var="autoMsg_324b05c6b7" code="security.admin.providerHealth.actor"/>
<spring:message var="autoMsg_f96e25d918" code="security.admin.providerHealth.detail"/>
<spring:message var="autoMsg_a8695e0525" code="security.admin.providerHealth.empty"/>
<c:set var="activeMenu" value="providerHealthHistory"/>
<spring:message var="pageTitle" code="security.admin.providerHealth.title"/>
<spring:message var="providerCodePlaceholder" code="security.admin.providerHealth.providerCodePlaceholder"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_48cb318b3b}</h1>
            <p class="adm-page-desc">${autoMsg_e38e8f3cff}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${autoMsg_c6a6403563}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${autoMsg_4a460657ff}</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_ed43e5dec9}
                <input class="adm-input" type="text" name="providerCode" value="${fn:escapeXml(providerCode)}" placeholder="${providerCodePlaceholder}">
            </label>
            <label>${autoMsg_0346d1cb63}
                <input class="adm-input" type="number" min="1" max="200" name="limit" value="${limit}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_76a835e0a4}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_f2606d7e1b}</th>
                <th>${autoMsg_edfd74e917}</th>
                <th>${autoMsg_34c8fd393e}</th>
                <th>${autoMsg_50bb77d7c1}</th>
                <th>${autoMsg_81de4e3042}</th>
                <th>${autoMsg_324b05c6b7}</th>
                <th>${autoMsg_f96e25d918}</th>
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
                <tr><td colspan="7" class="adm-empty">${autoMsg_a8695e0525}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
