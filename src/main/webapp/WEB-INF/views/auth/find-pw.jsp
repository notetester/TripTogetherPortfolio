<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <h1 class="auth-title">비밀번호 찾기 🔐</h1>
    <p class="auth-sub">가입한 아이디 또는 이메일을 입력하시면<br>비밀번호 재설정 링크를 보내드립니다.</p>

    <div id="successBanner" class="auth-error-banner"
         style="background:#f0fdf4;border-color:#bbf7d0;color:#15803d;display:none;"></div>
    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="identifier">아이디 또는 이메일</label>
      <input class="form-input" type="text" id="identifier"
             placeholder="아이디 또는 등록된 이메일 주소">
      <div class="field-msg info" style="display:block;">
        ⚠️ 이메일이 등록되지 않은 계정은 재설정 링크를 받을 수 없습니다.
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
document.getElementById('sendBtn').addEventListener('click', async function () {
  const identifier = document.getElementById('identifier').value.trim();
  if (!identifier) {
    document.getElementById('errorBanner').textContent = '⚠️ 아이디 또는 이메일을 입력해주세요.';
    document.getElementById('errorBanner').classList.add('show'); return;
  }
  document.getElementById('errorBanner').classList.remove('show');
  this.classList.add('loading'); this.disabled = true;

  const res  = await fetch('${pageContext.request.contextPath}/auth/find-pw/send', {
    method: 'POST',
    headers: {'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({identifier})
  });
  const data = await res.json();

  const banner = document.getElementById('successBanner');
  banner.style.display = 'flex';
  banner.textContent = '✅ ' + data.message;
  this.classList.remove('loading'); this.disabled = false;
  document.getElementById('sendBtn').textContent = '재발송';
});
</script>
<%@ include file="../common/footer.jsp" %>
</body></html>
