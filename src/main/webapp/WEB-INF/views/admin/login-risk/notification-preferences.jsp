<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_52312396d6" code="security.admin.notifications.title"/>
<spring:message var="autoMsg_2b2be5d9f0" code="security.admin.notifications.desc"/>
<spring:message var="autoMsg_1d4561bd82" code="security.admin.nav.policies"/>
<spring:message var="autoMsg_f1f9847e95" code="security.admin.nav.reviews"/>
<spring:message var="autoMsg_d8d2dae046" code="security.admin.notifications.category"/>
<spring:message var="autoMsg_b7ddcc8a29" code="security.admin.notifications.loginRisk"/>
<spring:message var="autoMsg_6f9ea95e76" code="security.admin.notifications.business"/>
<spring:message var="autoMsg_39f74eb465" code="security.admin.notifications.report"/>
<spring:message var="autoMsg_106b2b7280" code="security.admin.notifications.inquiry"/>
<spring:message var="autoMsg_83a9550035" code="security.admin.notifications.blockReview"/>
<spring:message var="autoMsg_d479cde98f" code="security.admin.notifications.etc"/>
<spring:message var="autoMsg_0127a87000" code="security.admin.common.save"/>
<c:set var="activeMenu" value="adminNotificationPreferences"/>
<spring:message var="pageTitle" code="security.admin.notifications.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_52312396d6}</h1>
            <p class="adm-page-desc">${autoMsg_2b2be5d9f0}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${autoMsg_1d4561bd82}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${autoMsg_f1f9847e95}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="post" class="adm-card">
        <div class="adm-card-header">
            <div class="adm-card-title">${autoMsg_d8d2dae046}</div>
        </div>
        <div class="adm-card-body">
            <c:forEach var="p" items="${preferences}">
                <label class="adm-check" style="display:block;margin:12px 0;">
                    <input type="checkbox" name="enabledCategories" value="${p.notificationCategory}" ${p.enabled ? 'checked' : ''}>
                    <strong>${p.notificationCategory}</strong>
                    <span class="adm-muted">
                        <c:choose>
                            <c:when test="${p.notificationCategory == 'LOGIN_RISK'}">${autoMsg_b7ddcc8a29}</c:when>
                            <c:when test="${p.notificationCategory == 'BUSINESS_APPLICATION'}">${autoMsg_6f9ea95e76}</c:when>
                            <c:when test="${p.notificationCategory == 'REPORT'}">${autoMsg_39f74eb465}</c:when>
                            <c:when test="${p.notificationCategory == 'INQUIRY'}">${autoMsg_106b2b7280}</c:when>
                            <c:when test="${p.notificationCategory == 'BLOCK_REVIEW'}">${autoMsg_83a9550035}</c:when>
                            <c:otherwise>${autoMsg_d479cde98f}</c:otherwise>
                        </c:choose>
                    </span>
                </label>
            </c:forEach>
            <div class="adm-actions" style="margin-top:16px;">
                <button class="adm-btn primary" type="submit">${autoMsg_0127a87000}</button>
            </div>
        </div>
    </form>
</div>
