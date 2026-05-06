<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<spring:message var="authFindPwIdentifierPlaceholderMsg" code="auth.findPw.identifier.placeholder"/>
<spring:message var="authFindPwEmptyMsg" code="auth.findPw.empty" javaScriptEscape="true"/>
<spring:message var="authFindPwFailMsg" code="auth.findPw.fail" javaScriptEscape="true"/>
<spring:message var="authFindPwSentMsg" code="auth.findPw.sent" javaScriptEscape="true"/>
<spring:message var="authFindPwResendMsg" code="auth.findPw.resend" javaScriptEscape="true"/>
<spring:message var="authFindPwServerMsg" code="auth.findPw.server" javaScriptEscape="true"/>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title"><spring:message code="auth.findPw.title"/></h1>
    <p class="auth-sub"><spring:message code="auth.findPw.subtitle"/></p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="identifier"><spring:message code="auth.findPw.identifier"/></label>
      <input class="form-input" type="text" id="identifier"
             placeholder="${authFindPwIdentifierPlaceholderMsg}">
      <div class="field-msg info" style="display:block;">
        <spring:message code="auth.findPw.help"/>
      </div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn"><spring:message code="auth.findPw.submit"/></button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login"><spring:message code="auth.common.backToLogin"/></a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-id"><spring:message code="auth.login.findId"/></a>
    </div>
  </div>
</div>
<script>
(function(){
  const ctx = '${pageContext.request.contextPath}';
  const sendBtn = document.getElementById('sendBtn');
  const successBanner = document.getElementById('successBanner');
  const errorBanner = document.getElementById('errorBanner');
  const identifierInput = document.getElementById('identifier');

  function showError(message) {
    errorBanner.textContent = '⚠️ ' + message;
    errorBanner.classList.add('show');
  }

  function hideError() {
    errorBanner.classList.remove('show');
    errorBanner.textContent = '';
  }

  function showSuccess(message) {
    successBanner.style.display = 'flex';
    successBanner.textContent = '✅ ' + message;
  }

  sendBtn.addEventListener('click', async function () {
    const identifier = identifierInput.value.trim();
    if (!identifier) {
      showError('${authFindPwEmptyMsg}');
      return;
    }

    hideError();
    this.classList.add('loading');
    this.disabled = true;

    try {
      const res = await fetch(ctx + '/auth/find-pw/send', {
        method: 'POST',
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body: new URLSearchParams({identifier})
      });

      const data = await res.json();
      if (!data.success) {
        showError(data.message || '${authFindPwFailMsg}');
        return;
      }

      showSuccess(data.message || '${authFindPwSentMsg}');
      this.textContent = '${authFindPwResendMsg}';
    } catch (e) {
      showError('${authFindPwServerMsg}');
    } finally {
      this.classList.remove('loading');
      this.disabled = false;
    }
  });
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
