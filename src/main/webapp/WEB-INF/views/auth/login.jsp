<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div>
      <span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">다시 만나서 반가워요 👋</h1>
    <p class="auth-sub">계정에 로그인하고 여행을 시작하세요</p>

    <c:if test="${not empty errorMsg}">
      <div class="auth-error-banner show">⚠️ ${errorMsg}</div>
    </c:if>
    <div class="auth-error-banner" id="loginError"></div>

    <div class="social-btns">
      <a href="${pageContext.request.contextPath}/auth/kakao" class="social-btn kakao">
        <span class="social-icon kakao-mark">k</span>
        카카오로 로그인
      </a>
      <a href="${pageContext.request.contextPath}/auth/naver" class="social-btn naver">
        <span class="social-icon" style="font-weight:900;font-size:14px;">N</span>
        네이버로 로그인
      </a>
      <a href="${pageContext.request.contextPath}/auth/google" class="social-btn google">
        <span class="social-icon">
          <svg width="18" height="18" viewBox="0 0 48 48">
            <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
            <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
            <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
            <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
          </svg>
        </span>
        Google로 로그인
      </a>
    </div>

    <div class="auth-divider">또는 계정으로 로그인</div>

    <form id="loginForm" onsubmit="return false;">
      <input type="hidden" id="redirect" value="${redirect}">

      <div class="form-group">
        <label class="form-label" for="identifier">아이디 또는 이메일</label>
        <input class="form-input" type="text" id="identifier" name="identifier"
               placeholder="아이디 또는 이메일 입력" autocomplete="username" required>
      </div>

      <div class="form-group">
        <label class="form-label" for="password">비밀번호</label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="password" name="password"
                 placeholder="비밀번호 입력" autocomplete="current-password" required>
          <button type="button" class="pw-toggle" id="pwToggle" title="비밀번호 표시">👁</button>
        </div>
      </div>

      <div class="auth-row">
        <label class="checkbox-label">
          <input type="checkbox" id="rememberMe"> 로그인 상태 유지
        </label>
        <div style="display:flex; gap:10px; align-items:center;">
          <a class="auth-link" href="${pageContext.request.contextPath}/auth/find-id">아이디 찾기</a>
          <a class="auth-link" href="${pageContext.request.contextPath}/auth/find-pw">비밀번호 찾기</a>
        </div>
      </div>

      <button type="submit" class="btn-submit" id="loginBtn">로그인</button>
    </form>

    <div class="auth-footer">
      계정이 없으신가요?
      <a href="${pageContext.request.contextPath}/auth/register">회원가입</a>
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
      showError('아이디(이메일)와 비밀번호를 모두 입력해주세요.');
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
      } else {
        showError(data.message || '로그인에 실패했습니다.');
      }
    } catch (e) {
      showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
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
