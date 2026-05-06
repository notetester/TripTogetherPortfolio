<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_0a046cde5f" code="auth.findPw.title"/>
<spring:message var="autoMsg_9082fa0580" code="auth.findPw.subtitle"/>
<spring:message var="autoMsg_077b4d49bd" code="auth.findPw.identifier"/>
<spring:message var="autoMsg_da42f9d90a" code="auth.findPw.identifier.placeholder"/>
<spring:message var="autoMsg_49a0cbf03f" code="auth.findPw.submit"/>
<spring:message var="autoMsg_b31d718efa" code="auth.common.backToLogin"/>
<spring:message var="autoMsg_3b75cc2ce8" code="auth.login.findId"/>
<spring:message var="autoMsg_475a097b8c" code="auth.findPw.empty" javaScriptEscape="true"/>
<spring:message var="autoMsg_4cf0e9eadb" code="auth.findPw.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_9e14cc31e3" code="auth.findPw.sent" javaScriptEscape="true"/>
<spring:message var="autoMsg_af70b91d3b" code="auth.findPw.resend" javaScriptEscape="true"/>
<spring:message var="autoMsg_3718d5cfe0" code="auth.findPw.server" javaScriptEscape="true"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">${autoMsg_0a046cde5f}</h1>
    <p class="auth-sub">${autoMsg_9082fa0580}</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="identifier">${autoMsg_077b4d49bd}</label>
      <input class="form-input" type="text" id="identifier"
             placeholder="${autoMsg_da42f9d90a}">
      <div class="field-msg info" style="display:block;">
        <spring:message code="auth.findPw.help"/>
      </div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn">${autoMsg_49a0cbf03f}</button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">${autoMsg_b31d718efa}</a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-id">${autoMsg_3b75cc2ce8}</a>
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
      showError('${autoMsg_475a097b8c}');
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
        showError(data.message || '${autoMsg_4cf0e9eadb}');
        return;
      }

      showSuccess(data.message || '${autoMsg_9e14cc31e3}');
      this.textContent = '${autoMsg_af70b91d3b}';
    } catch (e) {
      showError('${autoMsg_3718d5cfe0}');
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
