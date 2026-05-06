<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<spring:message var="authFindIdInvalidMsg" code="auth.findId.invalid" javaScriptEscape="true"/>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title"><spring:message code="auth.findId.title"/></h1>
    <p class="auth-sub"><spring:message code="auth.findId.subtitle"/></p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="email"><spring:message code="auth.findId.email"/></label>
      <input class="form-input" type="email" id="email" placeholder="example@email.com">
      <div class="field-msg" id="emailMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn"><spring:message code="auth.findId.submit"/></button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login"><spring:message code="auth.common.backToLogin"/></a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-pw"><spring:message code="auth.login.findPw"/></a>
    </div>
  </div>
</div>
<script>
document.getElementById('sendBtn').addEventListener('click', async function () {
  const email = document.getElementById('email').value.trim();
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    document.getElementById('emailMsg').className = 'field-msg error';
    document.getElementById('emailMsg').textContent = '${authFindIdInvalidMsg}';
    return;
  }
  document.getElementById('emailMsg').className = 'field-msg';
  this.classList.add('loading'); this.disabled = true;

  const res  = await fetch('${pageContext.request.contextPath}/auth/find-id/send', {
    method: 'POST',
    headers: {'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({email})
  });
  const data = await res.json();

  document.getElementById('successBanner').style.display = 'flex';
  document.getElementById('successBanner').textContent = '✅ ' + data.message;
  this.classList.remove('loading'); this.disabled = false;
});
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
