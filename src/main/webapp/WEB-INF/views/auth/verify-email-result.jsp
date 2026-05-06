<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_7dda0d9759" code="auth.verifyEmailResult.success.title"/>
<spring:message var="autoMsg_d89bcd36fd" code="auth.verifyEmailResult.success.descHtml"/>
<spring:message var="autoMsg_83c040cf2e" code="auth.verifyEmailResult.fail.title"/>
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
        <h1 class="auth-title">${autoMsg_7dda0d9759}</h1>
        <p class="auth-sub">${autoMsg_d89bcd36fd}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          <spring:message code="auth.verifyEmailResult.success.action"/>
        </button>
      </c:when>
      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">❌</div>
        <h1 class="auth-title">${autoMsg_83c040cf2e}</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          <spring:message code="auth.verifyEmailResult.fail.action"/>
        </button>
      </c:otherwise>
    </c:choose>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
