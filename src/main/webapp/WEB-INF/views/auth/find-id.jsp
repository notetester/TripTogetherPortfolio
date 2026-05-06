<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_341d73b690" code="auth.findId.title"/>
<spring:message var="autoMsg_472530b0e6" code="auth.findId.subtitle"/>
<spring:message var="autoMsg_b8d0b3f972" code="auth.findId.email"/>
<spring:message var="autoMsg_18a284bf19" code="auth.findId.submit"/>
<spring:message var="autoMsg_6124574932" code="auth.common.backToLogin"/>
<spring:message var="autoMsg_451d9aac7c" code="auth.login.findPw"/>
<spring:message var="autoMsg_08cfe927b9" code="auth.findId.invalid" javaScriptEscape="true"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">${autoMsg_341d73b690}</h1>
    <p class="auth-sub">${autoMsg_472530b0e6}</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="email">${autoMsg_b8d0b3f972}</label>
      <input class="form-input" type="email" id="email" placeholder="example@email.com">
      <div class="field-msg" id="emailMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn">${autoMsg_18a284bf19}</button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">${autoMsg_6124574932}</a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-pw">${autoMsg_451d9aac7c}</a>
    </div>
  </div>
</div>
<script>
document.getElementById('sendBtn').addEventListener('click', async function () {
  const email = document.getElementById('email').value.trim();
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    document.getElementById('emailMsg').className = 'field-msg error';
    document.getElementById('emailMsg').textContent = '${autoMsg_08cfe927b9}';
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
