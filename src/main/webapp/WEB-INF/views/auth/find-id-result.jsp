<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_b70faf86cb" code="auth.findIdResult.foundTitle"/>
<spring:message var="autoMsg_e7c827cae9" code="auth.findIdResult.foundSubtitle"/>
<spring:message var="autoMsg_6ece5a9ca7" code="auth.findIdResult.expiredTitle"/>
<spring:message var="autoMsg_08ef48115f" code="auth.common.backToLogin"/>
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
        <h1 class="auth-title">${autoMsg_b70faf86cb}</h1>
        <p class="auth-sub">${autoMsg_e7c827cae9}</p>

        <div style="background:var(--blue-light);border:1px solid #bfdbfe;border-radius:12px;padding:20px;margin:20px 0;font-size:22px;font-weight:700;color:var(--blue);letter-spacing:.08em;">
          ${foundUserId}
        </div>

        <div style="display:flex;flex-direction:column;gap:10px;">
          <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/login'">
            <spring:message code="auth.findIdResult.login"/>
          </button>
          <button class="btn-submit" style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;" onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            <spring:message code="auth.findIdResult.findPw"/>
          </button>
        </div>
      </c:when>
      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">⏰</div>
        <h1 class="auth-title">${autoMsg_6ece5a9ca7}</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/find-id'">
          <spring:message code="auth.findIdResult.retry"/>
        </button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:20px;">
      <a href="${pageContext.request.contextPath}/auth/login">${autoMsg_08ef48115f}</a>
    </div>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
