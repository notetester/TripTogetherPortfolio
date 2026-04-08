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

    <!-- provider 배지 -->
    <div>
      <span class="provider-badge ${socialTemp.provider}">
        <c:choose>
          <c:when test="${socialTemp.provider == 'KAKAO'}"><span class="kakao-badge-mark">k</span>카카오</c:when>
          <c:when test="${socialTemp.provider == 'NAVER'}">N 네이버</c:when>
          <c:when test="${socialTemp.provider == 'GOOGLE'}">G Google</c:when>
        </c:choose>
        로 가입 중
      </span>
    </div>

    <h1 class="auth-title">마지막 단계예요 🎉</h1>
    <p class="auth-sub">TripTogether에서 사용할 프로필 정보를 입력해주세요</p>

    <!-- 소셜에서 받아온 이메일 표시 -->
    <c:if test="${not empty socialTemp.email}">
      <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;
                  padding:10px 14px;font-size:13px;color:var(--gray-600);margin-bottom:16px;">
        📧 연결된 이메일: <strong>${socialTemp.email}</strong>
      </div>
    </c:if>

    <div id="socialCompleteError" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="nickname">닉네임 <span style="color:#ef4444">*</span></label>
      <input class="form-input" type="text" id="nickname" name="nickname"
             placeholder="2~20자 (한글, 영문, 숫자)"
             value="${socialTemp.nickname}" maxlength="20">
      <div class="field-msg" id="nicknameMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="nationality">국적 <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="nationality" name="nationality">
        <option value="">국적을 선택하세요</option>
        <option value="KR">🇰🇷 대한민국</option>
        <option value="US">🇺🇸 미국</option>
        <option value="JP">🇯🇵 일본</option>
        <option value="CN">🇨🇳 중국</option>
        <option value="GB">🇬🇧 영국</option>
        <option value="FR">🇫🇷 프랑스</option>
        <option value="DE">🇩🇪 독일</option>
        <option value="AU">🇦🇺 호주</option>
        <option value="CA">🇨🇦 캐나다</option>
        <option value="OTHER">🌍 기타</option>
      </select>
      <div class="field-msg" id="nationalityMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="preferredLang">선호 언어 <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="preferredLang" name="preferredLang">
        <option value="">언어를 선택하세요</option>
        <option value="ko">🇰🇷 한국어</option>
        <option value="en">🇺🇸 English</option>
        <option value="ja">🇯🇵 日本語</option>
        <option value="zh">🇨🇳 中文</option>
      </select>
      <div class="field-msg" id="langMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="completeBtn" style="margin-top:4px;">
      TripTogether 시작하기 🚀
    </button>

    <div class="auth-footer">
      <a href="${pageContext.request.contextPath}/auth/login">← 로그인으로 돌아가기</a>
    </div>

  </div>
</div>

<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  let debounceTimer;

  // nickname 중복 체크
  document.getElementById('nickname').addEventListener('input', function () {
    const v = this.value.trim();
    const msgEl = document.getElementById('nicknameMsg');
    const input = this;

    if (!v) { input.className = 'form-input'; msgEl.className = 'field-msg'; return; }
    if (v.length < 2 || v.length > 20) {
      input.className = 'form-input error';
      msgEl.className = 'field-msg error';
      msgEl.textContent = '2~20자로 입력해주세요.'; return;
    }

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(async () => {
      const res  = await fetch(ctx + '/auth/check/nickname?value=' + encodeURIComponent(v));
      const data = await res.json();
      if (data.duplicate) {
        input.className = 'form-input error';
        msgEl.className = 'field-msg error';
        msgEl.textContent = '이미 사용 중인 닉네임입니다.';
      } else {
        input.className = 'form-input success';
        msgEl.className = 'field-msg success';
        msgEl.textContent = '사용 가능한 닉네임입니다.';
      }
    }, 500);
  });

  document.getElementById('completeBtn').addEventListener('click', async function () {
    const nickname     = document.getElementById('nickname').value.trim();
    const nationality  = document.getElementById('nationality').value;
    const preferredLang= document.getElementById('preferredLang').value;
    const errorBanner  = document.getElementById('socialCompleteError');

    if (!nickname)      { showFieldError('nickname','nicknameMsg','닉네임을 입력해주세요.'); return; }
    if (!nationality)   { showFieldError('nationality','nationalityMsg','국적을 선택해주세요.'); return; }
    if (!preferredLang) { showFieldError('preferredLang','langMsg','언어를 선택해주세요.'); return; }

    this.classList.add('loading');
    this.disabled = true;
    errorBanner.classList.remove('show');

    try {
      const res = await fetch(ctx + '/auth/social/complete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ nickname, nationality, preferredLang })
      });
      const data = await res.json();

      if (data.success) {
        location.href = data.redirect;
      } else {
        errorBanner.textContent = '⚠️ ' + (data.message || '오류가 발생했습니다.');
        errorBanner.classList.add('show');
      }
    } catch (e) {
      errorBanner.textContent = '⚠️ 서버 오류가 발생했습니다.';
      errorBanner.classList.add('show');
    } finally {
      this.classList.remove('loading');
      this.disabled = false;
    }
  });

  function showFieldError(inputId, msgId, msg) {
    document.getElementById(inputId).className = (inputId.startsWith('preferred') || inputId === 'nationality')
        ? 'form-select' : 'form-input error';
    const msgEl = document.getElementById(msgId);
    msgEl.className = 'field-msg error';
    msgEl.textContent = msg;
  }
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
