<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="securityWafSync"/>
<spring:message var="pageTitle" code="security.admin.wafSync.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.wafSync"/>
<spring:message var="targetTypePlaceholder" code="security.admin.placeholder.wafTargetType"/>
<%@ include file="../layout.jsp" %>
<style>
    .sync-detail { white-space: pre-wrap; max-width: 520px; line-height: 1.55; }
    .sync-meta { display:block; color:#64748b; font-size:12px; margin-top:6px; }
</style>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.wafSync.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.wafSync.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs"><spring:message code="security.admin.nav.providerConfigs"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.status"/>
                <select class="adm-input" name="status">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="EXTERNAL_PROVIDER_PENDING" ${status == 'EXTERNAL_PROVIDER_PENDING' ? 'selected' : ''}>EXTERNAL_PROVIDER_PENDING</option>
                    <option value="SYNCED" ${status == 'SYNCED' ? 'selected' : ''}>SYNCED</option>
                    <option value="FAILED" ${status == 'FAILED' ? 'selected' : ''}>FAILED</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.targetType"/>
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="${targetTypePlaceholder}">
            </label>
            <label><spring:message code="security.admin.common.search"/>
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
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
                <th><spring:message code="security.admin.common.status"/></th>
                <th><spring:message code="security.admin.wafSync.source"/></th>
                <th><spring:message code="security.admin.wafSync.action"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.description"/></th>
                <th><spring:message code="security.admin.common.createdAt"/></th>
                <th><spring:message code="security.admin.wafSync.lastResultAt"/></th>
                <th><spring:message code="security.admin.common.action"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="i" items="${items}">
                <tr>
                    <td><span class="adm-badge"><c:out value="${i.status}"/></span></td>
                    <td><c:out value="${i.sourceType}"/> #<c:out value="${i.sourceId}"/></td>
                    <td><c:out value="${i.syncAction}"/></td>
                    <td><c:out value="${i.targetType}"/>: <c:out value="${i.targetValue}"/></td>
                    <td><div class="sync-detail"><c:out value="${i.detailMessage}"/></div></td>
                    <td><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="sync-meta"><spring:message code="security.admin.wafSync.updatedAt"/>: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                        <span class="sync-meta"><spring:message code="security.admin.wafSync.syncedAt"/>: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/waf-sync/${i.syncIdx}/retry">
                            <button class="adm-btn" type="submit"><spring:message code="security.admin.wafSync.retry"/></button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty items}">
                <tr><td colspan="8" class="adm-empty"><spring:message code="security.admin.empty.wafSync"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
