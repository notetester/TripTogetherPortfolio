<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_notifications_title" code="security.admin.notifications.title"/>
<spring:message var="msg_security_admin_notifications_desc" code="security.admin.notifications.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_reviews" code="security.admin.nav.reviews"/>
<spring:message var="msg_security_admin_notifications_category" code="security.admin.notifications.category"/>
<spring:message var="msg_security_admin_notifications_loginRisk" code="security.admin.notifications.loginRisk"/>
<spring:message var="msg_security_admin_notifications_business" code="security.admin.notifications.business"/>
<spring:message var="msg_security_admin_notifications_report" code="security.admin.notifications.report"/>
<spring:message var="msg_security_admin_notifications_inquiry" code="security.admin.notifications.inquiry"/>
<spring:message var="msg_security_admin_notifications_blockReview" code="security.admin.notifications.blockReview"/>
<spring:message var="msg_security_admin_notifications_etc" code="security.admin.notifications.etc"/>
<spring:message var="msg_security_admin_common_save" code="security.admin.common.save"/>
<c:set var="pageTitle" value="${msg_security_admin_notifications_title}"/>
<c:set var="activeMenu" value="adminNotificationPreferences"/>

<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_notifications_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_notifications_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_security_admin_nav_reviews}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="post" class="adm-card">
        <div class="adm-card-header">
            <div class="adm-card-title">${msg_security_admin_notifications_category}</div>
        </div>
        <div class="adm-card-body">
            <c:forEach var="p" items="${preferences}">
                <label class="adm-check" style="display:block;margin:12px 0;">
                    <input type="checkbox" name="enabledCategories" value="${p.notificationCategory}" ${p.enabled ? 'checked' : ''}>
                    <strong>${p.notificationCategory}</strong>
                    <span class="adm-muted">
                        <c:choose>
                            <c:when test="${p.notificationCategory == 'LOGIN_RISK'}">${msg_security_admin_notifications_loginRisk}</c:when>
                            <c:when test="${p.notificationCategory == 'BUSINESS_APPLICATION'}">${msg_security_admin_notifications_business}</c:when>
                            <c:when test="${p.notificationCategory == 'REPORT'}">${msg_security_admin_notifications_report}</c:when>
                            <c:when test="${p.notificationCategory == 'INQUIRY'}">${msg_security_admin_notifications_inquiry}</c:when>
                            <c:when test="${p.notificationCategory == 'BLOCK_REVIEW'}">${msg_security_admin_notifications_blockReview}</c:when>
                            <c:otherwise>${msg_security_admin_notifications_etc}</c:otherwise>
                        </c:choose>
                    </span>
                </label>
            </c:forEach>
            <div class="adm-actions" style="margin-top:16px;">
                <button class="adm-btn primary" type="submit">${msg_security_admin_common_save}</button>
            </div>
        </div>
    </form>
</div>
