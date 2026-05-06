<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_auth_verifyEmailResult_success_title" code="auth.verifyEmailResult.success.title"/>
<spring:message var="msg_auth_verifyEmailResult_success_descHtml" code="auth.verifyEmailResult.success.descHtml"/>
<spring:message var="msg_auth_verifyEmailResult_success_action" code="auth.verifyEmailResult.success.action"/>
<spring:message var="msg_auth_verifyEmailResult_fail_title" code="auth.verifyEmailResult.fail.title"/>
<spring:message var="msg_auth_verifyEmailResult_fail_action" code="auth.verifyEmailResult.fail.action"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="${pageContext.response.locale.language}">
<body>
<div class="auth-wrap">
  <div class="auth-card" style="text-align:center;">

    <div class="auth-logo" style="justify-content:center;"
         onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <c:choose>
      <c:when test="${success}">
        <div style="font-size:56px;margin:16px 0 20px;">✅</div>
        <h1 class="auth-title">${msg_auth_verifyEmailResult_success_title}</h1>
        <p class="auth-sub">${msg_auth_verifyEmailResult_success_descHtml}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          ${msg_auth_verifyEmailResult_success_action}
        </button>
      </c:when>
      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">❌</div>
        <h1 class="auth-title">${msg_auth_verifyEmailResult_fail_title}</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          ${msg_auth_verifyEmailResult_fail_action}
        </button>
      </c:otherwise>
    </c:choose>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
