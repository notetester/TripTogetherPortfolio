<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_auth_findId_invalid_js" code="auth.findId.invalid" javaScriptEscape="true"/>
<spring:message var="msg_auth_findId_title" code="auth.findId.title"/>
<spring:message var="msg_auth_findId_subtitle" code="auth.findId.subtitle"/>
<spring:message var="msg_auth_findId_email" code="auth.findId.email"/>
<spring:message var="msg_auth_findId_submit" code="auth.findId.submit"/>
<spring:message var="msg_auth_common_backToLogin" code="auth.common.backToLogin"/>
<spring:message var="msg_auth_login_findPw" code="auth.login.findPw"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>

<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">${msg_auth_findId_title}</h1>
    <p class="auth-sub">${msg_auth_findId_subtitle}</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="email">${msg_auth_findId_email}</label>
      <input class="form-input" type="email" id="email" placeholder="example@email.com">
      <div class="field-msg" id="emailMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn">${msg_auth_findId_submit}</button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">${msg_auth_common_backToLogin}</a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-pw">${msg_auth_login_findPw}</a>
    </div>
  </div>
</div>
<script>
document.getElementById('sendBtn').addEventListener('click', async function () {
  const email = document.getElementById('email').value.trim();
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    document.getElementById('emailMsg').className = 'field-msg error';
    document.getElementById('emailMsg').textContent = '${msg_auth_findId_invalid_js}';
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
