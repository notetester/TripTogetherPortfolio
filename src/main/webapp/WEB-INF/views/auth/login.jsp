<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="autoMsg_a9e2195892" code="auth.login.title"/>
<spring:message var="autoMsg_145495e759" code="auth.login.subtitle"/>
<spring:message var="autoMsg_525a50f8c7" code="auth.login.or"/>
<spring:message var="autoMsg_7a9e6475a3" code="auth.login.identifier"/>
<spring:message var="autoMsg_5df5b5bf63" code="auth.login.identifier.placeholder"/>
<spring:message var="autoMsg_741c35e6fc" code="auth.login.password"/>
<spring:message var="autoMsg_572be388bf" code="auth.login.password.placeholder"/>
<spring:message var="autoMsg_c435127d4c" code="auth.login.password.title"/>
<spring:message var="autoMsg_8ceb86248c" code="auth.login.remember"/>
<spring:message var="autoMsg_609efc40e7" code="auth.login.findId"/>
<spring:message var="autoMsg_a9add67e2d" code="auth.login.findPw"/>
<spring:message var="autoMsg_3eacb1afa6" code="header.auth.login"/>
<spring:message var="autoMsg_2dde5ceb5f" code="auth.login.register"/>
<spring:message var="autoMsg_9ec5453749" code="auth.login.error.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_ea523b68ce" code="auth.login.dormant.confirmDefault" javaScriptEscape="true"/>
<spring:message var="autoMsg_2549d23c53" code="auth.login.dormant.confirmGuide" javaScriptEscape="true"/>
<spring:message var="autoMsg_cc003b970c" code="auth.login.dormant.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_de45129d30" code="auth.login.dormant.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_4003854027" code="auth.login.error.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_18414c1e66" code="auth.login.error.server" javaScriptEscape="true"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="${pageContext.response.locale.language}">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div>
      <span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">${autoMsg_a9e2195892}</h1>
    <p class="auth-sub">${autoMsg_145495e759}</p>

    <c:if test="${not empty errorMsg}">
      <div class="auth-error-banner show">⚠️ ${errorMsg}</div>
    </c:if>
    <div class="auth-error-banner" id="loginError"></div>

    <div class="social-btns">
      <a href="${kakaoAuthUrl}" class="social-btn kakao">
        <span class="social-icon kakao-mark">k</span>
        <spring:message code="auth.login.kakao"/>
      </a>
      <a href="${naverAuthUrl}" class="social-btn naver">
        <span class="social-icon naver-mark">N</span>
        <spring:message code="auth.login.naver"/>
      </a>
      <a href="${googleAuthUrl}" class="social-btn google">
        <span class="social-icon google-mark">
          <svg width="18" height="18" viewBox="0 0 48 48">
            <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
            <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
            <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
            <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
          </svg>
        </span>
        <spring:message code="auth.login.google"/>
      </a>
    </div>

    <div class="auth-divider">${autoMsg_525a50f8c7}</div>

    <form id="loginForm" onsubmit="return false;">
      <input type="hidden" id="redirect" value="${redirect}">

      <div class="form-group">
        <label class="form-label" for="identifier">${autoMsg_7a9e6475a3}</label>
        <input class="form-input" type="text" id="identifier" name="identifier"
               placeholder="${autoMsg_5df5b5bf63}" autocomplete="username" required>
      </div>

      <div class="form-group">
        <label class="form-label" for="password">${autoMsg_741c35e6fc}</label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="password" name="password"
                 placeholder="${autoMsg_572be388bf}" autocomplete="current-password" required>
          <button type="button" class="pw-toggle" id="pwToggle" title="${autoMsg_c435127d4c}">👁</button>
        </div>
      </div>

      <div class="auth-row">
        <label class="checkbox-label">
          <input type="checkbox" id="rememberMe"> ${autoMsg_8ceb86248c}
        </label>
        <div style="display:flex; gap:10px; align-items:center;">
          <a class="auth-link" href="${pageContext.request.contextPath}/auth/find-id">${autoMsg_609efc40e7}</a>
          <a class="auth-link" href="${pageContext.request.contextPath}/auth/find-pw">${autoMsg_a9add67e2d}</a>
        </div>
      </div>

      <button type="submit" class="btn-submit" id="loginBtn">${autoMsg_3eacb1afa6}</button>
    </form>

    <div class="auth-footer">
      <spring:message code="auth.login.noAccount"/>
      <a href="${pageContext.request.contextPath}/auth/register">${autoMsg_2dde5ceb5f}</a>
    </div>

  </div>
</div>

<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';

  document.getElementById('pwToggle').addEventListener('click', function () {
    const pw = document.getElementById('password');
    const isText = pw.type === 'text';
    pw.type = isText ? 'password' : 'text';
    this.textContent = isText ? '👁' : '🙈';
  });

  document.getElementById('loginForm').addEventListener('submit', async function () {
    const identifier = document.getElementById('identifier').value.trim();
    const password   = document.getElementById('password').value;
    const redirect   = document.getElementById('redirect').value;
    const btn        = document.getElementById('loginBtn');
    const errorBanner = document.getElementById('loginError');

    if (!identifier || !password) {
      showError('${autoMsg_9ec5453749}');
      return;
    }

    btn.classList.add('loading');
    btn.disabled = true;
    errorBanner.classList.remove('show');

    try {
      const res = await fetch(ctx + '/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ identifier, password, redirect })
      });
      const data = await res.json();

      if (data.success) {
        location.href = data.redirect;
      } else if (data.dormantReleaseRequired) {
        const dormantMessage = data.message || '${autoMsg_ea523b68ce}';
        const ok = confirm(dormantMessage + '\n\n' + '${autoMsg_2549d23c53}');
        if (!ok) {
          showError(data.message || '${autoMsg_cc003b970c}');
          return;
        }
        const releaseRes = await fetch(ctx + '/auth/dormant/release', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: new URLSearchParams({})
        });
        const releaseData = await releaseRes.json();
        if (releaseData.success) {
          location.href = releaseData.redirect;
        } else {
          showError(releaseData.message || '${autoMsg_de45129d30}');
        }
      } else {
        showError(data.message || '${autoMsg_4003854027}');
      }
    } catch (e) {
      showError('${autoMsg_18414c1e66}');
    } finally {
      btn.classList.remove('loading');
      btn.disabled = false;
    }
  });

  function showError(msg) {
    const banner = document.getElementById('loginError');
    banner.textContent = '⚠️ ' + msg;
    banner.classList.add('show');
    banner.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') {
      document.getElementById('loginForm').dispatchEvent(new Event('submit'));
    }
  });
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
