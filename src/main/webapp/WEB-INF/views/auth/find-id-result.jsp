
<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_auth_findIdResult_foundTitle" code="auth.findIdResult.foundTitle"/>
<spring:message var="msg_auth_findIdResult_foundSubtitle" code="auth.findIdResult.foundSubtitle"/>
<spring:message var="msg_auth_findIdResult_login" code="auth.findIdResult.login"/>
<spring:message var="msg_auth_findIdResult_findPw" code="auth.findIdResult.findPw"/>
<spring:message var="msg_auth_findIdResult_expiredTitle" code="auth.findIdResult.expiredTitle"/>
<spring:message var="msg_auth_findIdResult_retry" code="auth.findIdResult.retry"/>
<spring:message var="msg_auth_common_backToLogin" code="auth.common.backToLogin"/>
﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card" style="text-align:center;">
    <div class="auth-logo" style="justify-content:center;" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">T</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <c:choose>
      <c:when test="${not empty foundUserId}">
        <div style="font-size:56px;margin:16px 0 20px;">🔎</div>
        <h1 class="auth-title">${msg_auth_findIdResult_foundTitle}</h1>
        <p class="auth-sub">${msg_auth_findIdResult_foundSubtitle}</p>

        <div style="background:var(--blue-light);border:1px solid #bfdbfe;border-radius:12px;padding:20px;margin:20px 0;font-size:22px;font-weight:700;color:var(--blue);letter-spacing:.08em;">
          ${foundUserId}
        </div>

        <div style="display:flex;flex-direction:column;gap:10px;">
          <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/login'">
            ${msg_auth_findIdResult_login}
          </button>
          <button class="btn-submit" style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;" onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            ${msg_auth_findIdResult_findPw}
          </button>
        </div>
      </c:when>
      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">⏰</div>
        <h1 class="auth-title">${msg_auth_findIdResult_expiredTitle}</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/find-id'">
          ${msg_auth_findIdResult_retry}
        </button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:20px;">
      <a href="${pageContext.request.contextPath}/auth/login">${msg_auth_common_backToLogin}</a>
    </div>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
