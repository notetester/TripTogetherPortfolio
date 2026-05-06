<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="adminNotificationPreferences"/>
<spring:message var="pageTitle" code="security.admin.notifications.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.notifications.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.notifications.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies"><spring:message code="security.admin.nav.policies"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews"><spring:message code="security.admin.nav.reviews"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="post" class="adm-card">
        <div class="adm-card-header">
            <div class="adm-card-title"><spring:message code="security.admin.notifications.category"/></div>
        </div>
        <div class="adm-card-body">
            <c:forEach var="p" items="${preferences}">
                <label class="adm-check" style="display:block;margin:12px 0;">
                    <input type="checkbox" name="enabledCategories" value="${p.notificationCategory}" ${p.enabled ? 'checked' : ''}>
                    <strong>${p.notificationCategory}</strong>
                    <span class="adm-muted">
                        <c:choose>
                            <c:when test="${p.notificationCategory == 'LOGIN_RISK'}"><spring:message code="security.admin.notifications.loginRisk"/></c:when>
                            <c:when test="${p.notificationCategory == 'BUSINESS_APPLICATION'}"><spring:message code="security.admin.notifications.business"/></c:when>
                            <c:when test="${p.notificationCategory == 'REPORT'}"><spring:message code="security.admin.notifications.report"/></c:when>
                            <c:when test="${p.notificationCategory == 'INQUIRY'}"><spring:message code="security.admin.notifications.inquiry"/></c:when>
                            <c:when test="${p.notificationCategory == 'BLOCK_REVIEW'}"><spring:message code="security.admin.notifications.blockReview"/></c:when>
                            <c:otherwise><spring:message code="security.admin.notifications.etc"/></c:otherwise>
                        </c:choose>
                    </span>
                </label>
            </c:forEach>
            <div class="adm-actions" style="margin-top:16px;">
                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.save"/></button>
            </div>
        </div>
    </form>
</div>
