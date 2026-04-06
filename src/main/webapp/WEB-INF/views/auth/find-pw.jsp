<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">비밀번호 찾기 🔐</h1>
    <p class="auth-sub">가입한 아이디 또는 이메일을 입력하시면<br>확인 가능한 계정이 있는 경우 비밀번호 재설정 안내를 보내드립니다.</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="identifier">아이디 또는 이메일</label>
      <input class="form-input" type="text" id="identifier"
             placeholder="아이디 또는 등록된 이메일 주소">
      <div class="field-msg info" style="display:block;">
        ⚠️ 인증된 이메일이 등록된 계정에 한해 비밀번호 재설정 안내를 받을 수 있습니다.
      </div>
    </div>

    <button type="button" class="btn-submit" id="sendBtn">재설정 링크 발송</button>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">← 로그인으로</a>
      &nbsp;·&nbsp;
      <a href="${pageContext.request.contextPath}/auth/find-id">아이디 찾기</a>
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
      showError('아이디 또는 이메일을 입력해주세요.');
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
        showError(data.message || '비밀번호 재설정 요청 처리 중 오류가 발생했습니다.');
        return;
      }

      showSuccess(data.message || '비밀번호 재설정 링크를 발송했습니다.');
      this.textContent = '재발송';
    } catch (e) {
      showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
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
