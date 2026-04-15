<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">
    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">T</div>
      <span class="auth-logo-text">TripTogether</span>
    </div>

    <div>
      <span class="provider-badge ${socialTemp.provider}">
        <c:choose>
          <c:when test="${socialTemp.provider == 'KAKAO'}"><span class="kakao-badge-mark">k</span>Kakao</c:when>
          <c:when test="${socialTemp.provider == 'NAVER'}">N Naver</c:when>
          <c:when test="${socialTemp.provider == 'GOOGLE'}">G Google</c:when>
        </c:choose>
        <spring:message code="auth.social.processing"/>
      </span>
    </div>

    <h1 class="auth-title"><spring:message code="auth.social.title"/></h1>
    <p class="auth-sub"><spring:message code="auth.social.subtitle"/></p>

    <c:if test="${not empty socialTemp.email}">
      <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:10px 14px;font-size:13px;color:var(--gray-600);margin-bottom:16px;">
        <spring:message code="auth.social.linkedEmail"/> <strong>${socialTemp.email}</strong>
      </div>
    </c:if>

    <div id="socialCompleteError" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="nickname"><spring:message code="auth.register.nickname"/><span style="color:#ef4444">*</span></label>
      <input class="form-input" type="text" id="nickname" name="nickname" placeholder="<spring:message code='auth.register.nickname.placeholder'/>" value="${socialTemp.nickname}" maxlength="20">
      <div class="field-msg" id="nicknameMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="nationality"><spring:message code="auth.register.nationality"/> <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="nationality" name="nationality">
        <option value=""><spring:message code="auth.register.nationality.placeholder"/></option>
        <option value="KR">대한민국</option>
        <option value="US">미국</option>
        <option value="JP">일본</option>
        <option value="CN">중국</option>
        <option value="GB">영국</option>
        <option value="FR">프랑스</option>
        <option value="DE">독일</option>
        <option value="AU">호주</option>
        <option value="CA">캐나다</option>
        <option value="OTHER">기타</option>
      </select>
      <div class="field-msg" id="nationalityMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="preferredLang"><spring:message code="auth.register.language"/> <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="preferredLang" name="preferredLang">
        <option value=""><spring:message code="auth.register.language.placeholder"/></option>
        <option value="ko">한국어</option>
        <option value="en">English</option>
        <option value="ja">日本語</option>
        <option value="zh">中文</option>
      </select>
      <div class="field-msg" id="langMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="completeBtn" style="margin-top:4px;">
      <spring:message code="auth.social.submit"/>
    </button>

    <div class="auth-footer">
      <a href="${pageContext.request.contextPath}/auth/login"><spring:message code="auth.social.backToLogin"/></a>
    </div>
  </div>
</div>
<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  let debounceTimer;

  document.getElementById('nickname').addEventListener('input', function () {
    const v = this.value.trim();
    const msgEl = document.getElementById('nicknameMsg');
    const input = this;
    if (!v) { input.className = 'form-input'; msgEl.className = 'field-msg'; msgEl.textContent = ''; return; }
    if (v.length < 2 || v.length > 20) {
      input.className = 'form-input error';
      msgEl.className = 'field-msg error';
      msgEl.textContent = '<spring:message code="auth.register.nickname.rule" javaScriptEscape="true"/>';
      return;
    }

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(async () => {
      const res = await fetch(ctx + '/auth/check/nickname?value=' + encodeURIComponent(v));
      const data = await res.json();
      if (data.duplicate) {
        input.className = 'form-input error';
        msgEl.className = 'field-msg error';
        msgEl.textContent = '<spring:message code="auth.register.nickname.duplicate" javaScriptEscape="true"/>';
      } else {
        input.className = 'form-input success';
        msgEl.className = 'field-msg success';
        msgEl.textContent = '<spring:message code="auth.register.nickname.ok" javaScriptEscape="true"/>';
      }
    }, 500);
  });

  document.getElementById('completeBtn').addEventListener('click', async function () {
    const nickname = document.getElementById('nickname').value.trim();
    const nationality = document.getElementById('nationality').value;
    const preferredLang = document.getElementById('preferredLang').value;
    const errorBanner = document.getElementById('socialCompleteError');

    if (!nickname) { showFieldError('nickname', 'nicknameMsg', '<spring:message code="auth.register.nickname.required" javaScriptEscape="true"/>'); return; }
    if (!nationality) { showFieldError('nationality', 'nationalityMsg', '<spring:message code="auth.register.nationality.required" javaScriptEscape="true"/>'); return; }
    if (!preferredLang) { showFieldError('preferredLang', 'langMsg', '<spring:message code="auth.register.language.required" javaScriptEscape="true"/>'); return; }

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
        errorBanner.textContent = '오류 ' + (data.message || '<spring:message code="auth.register.server" javaScriptEscape="true"/>');
        errorBanner.classList.add('show');
      }
    } catch (e) {
      errorBanner.textContent = '오류 <spring:message code="auth.register.server" javaScriptEscape="true"/>';
      errorBanner.classList.add('show');
    } finally {
      this.classList.remove('loading');
      this.disabled = false;
    }
  });

  function showFieldError(inputId, msgId, msg) {
    document.getElementById(inputId).className = (inputId.startsWith('preferred') || inputId === 'nationality') ? 'form-select' : 'form-input error';
    const msgEl = document.getElementById(msgId);
    msgEl.className = 'field-msg error';
    msgEl.textContent = msg;
  }
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
