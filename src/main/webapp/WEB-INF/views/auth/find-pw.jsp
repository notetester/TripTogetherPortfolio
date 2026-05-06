<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_auth_findPw_identifier_placeholder" code="auth.findPw.identifier.placeholder"/>
<spring:message var="msg_auth_findPw_empty_js" code="auth.findPw.empty" javaScriptEscape="true"/>
<spring:message var="msg_auth_findPw_fail_js" code="auth.findPw.fail" javaScriptEscape="true"/>
<spring:message var="msg_auth_findPw_sent_js" code="auth.findPw.sent" javaScriptEscape="true"/>
<spring:message var="msg_auth_findPw_resend_js" code="auth.findPw.resend" javaScriptEscape="true"/>
<spring:message var="msg_auth_findPw_server_js" code="auth.findPw.server" javaScriptEscape="true"/>
<spring:message var="msg_auth_findPw_title" code="auth.findPw.title"/>
<spring:message var="msg_auth_findPw_subtitle" code="auth.findPw.subtitle"/>
<spring:message var="msg_auth_findPw_identifier" code="auth.findPw.identifier"/>
<spring:message var="msg_auth_findPw_help" code="auth.findPw.help"/>
<spring:message var="msg_auth_findPw_submit" code="auth.findPw.submit"/>
<spring:message var="msg_auth_common_backToLogin" code="auth.common.backToLogin"/>
<spring:message var="msg_auth_login_findId" code="auth.login.findId"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>


<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">${msg_auth_findPw_title}</h1>
    <p class="auth-sub">${msg_auth_findPw_subtitle}</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="identifier">${msg_auth_findPw_identifier}</label>
      <input class="form-input" type="text" id="identifier"
             placeholder="${msg_auth_findPw_identifier_placeholder}">
      <div class="field-msg info" style="display:block;">
        ${msg_auth_findPw_help}
      </div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn">${msg_auth_findPw_submit}</button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">${msg_auth_common_backToLogin}</a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-id">${msg_auth_login_findId}</a>
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
      showError('${msg_auth_findPw_empty_js}');
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
        showError(data.message || '${msg_auth_findPw_fail_js}');
        return;
      }

      showSuccess(data.message || '${msg_auth_findPw_sent_js}');
      this.textContent = '${msg_auth_findPw_resend_js}';
    } catch (e) {
      showError('${msg_auth_findPw_server_js}');
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
