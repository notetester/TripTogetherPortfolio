<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_93c5bf4f2c" code="auth.social.title"/>
<spring:message var="autoMsg_96753a3e42" code="auth.social.subtitle"/>
<spring:message var="autoMsg_71635c4ff1" code="auth.social.linkedEmail"/>
<spring:message var="autoMsg_3d0493b6df" code="auth.social.emailConflictTitle"/>
<spring:message var="autoMsg_698a8de978" code="auth.social.emailConflictBody"/>
<spring:message var="autoMsg_5d18463485" code="auth.social.emailReferenceTitle"/>
<spring:message var="autoMsg_8cd0b47542" code="auth.social.emailReferenceBody"/>
<spring:message var="autoMsg_ffeccd3254" code="auth.social.emailMissingTitle"/>
<spring:message var="autoMsg_bae3aa1adb" code="auth.social.emailMissingBody"/>
<spring:message var="autoMsg_b64ba1d853" code="auth.register.nickname"/>
<spring:message var="autoMsg_c927c4d217" code="auth.register.nickname.placeholder"/>
<spring:message var="autoMsg_1d9dd87dca" code="auth.register.nationality"/>
<spring:message var="autoMsg_91972fbc66" code="auth.register.nationality.placeholder"/>
<spring:message var="autoMsg_0814d9940e" code="auth.register.nationality.option.kr"/>
<spring:message var="autoMsg_faca1f9d83" code="auth.register.nationality.option.us"/>
<spring:message var="autoMsg_187d2275c5" code="auth.register.nationality.option.jp"/>
<spring:message var="autoMsg_5ba3fdf7ff" code="auth.register.nationality.option.cn"/>
<spring:message var="autoMsg_e87624e016" code="auth.register.nationality.option.gb"/>
<spring:message var="autoMsg_72a942ba63" code="auth.register.nationality.option.fr"/>
<spring:message var="autoMsg_96fb864746" code="auth.register.nationality.option.de"/>
<spring:message var="autoMsg_3a199d80a7" code="auth.register.nationality.option.au"/>
<spring:message var="autoMsg_ce0fa54cb9" code="auth.register.nationality.option.ca"/>
<spring:message var="autoMsg_e0383b1245" code="auth.register.nationality.option.other"/>
<spring:message var="autoMsg_4c9fa90bf1" code="auth.register.language"/>
<spring:message var="autoMsg_bf465a6c00" code="auth.register.language.placeholder"/>
<spring:message var="autoMsg_1a1da7a31a" code="auth.register.language.option.ko"/>
<spring:message var="autoMsg_7b80d5cdf6" code="auth.register.language.option.en"/>
<spring:message var="autoMsg_9c683a74c9" code="auth.register.language.option.ja"/>
<spring:message var="autoMsg_3629c56522" code="auth.register.language.option.zh"/>
<spring:message var="autoMsg_846ed7b09b" code="auth.social.backToLogin"/>
<spring:message var="autoMsg_2eb9893aa2" code="auth.register.nickname.rule" javaScriptEscape="true"/>
<spring:message var="autoMsg_5a132b06b9" code="auth.register.nickname.duplicate" javaScriptEscape="true"/>
<spring:message var="autoMsg_0de62eb4ce" code="auth.register.nickname.ok" javaScriptEscape="true"/>
<spring:message var="autoMsg_21f1f8662c" code="auth.register.nickname.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_ba072e5129" code="auth.register.nationality.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_96cabee644" code="auth.register.language.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_483d246c30" code="auth.common.errorPrefix" javaScriptEscape="true"/>
<spring:message var="autoMsg_b0e90b04c8" code="auth.register.server" javaScriptEscape="true"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="${pageContext.response.locale.language}">
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
          <c:when test="${socialTemp.provider == 'KAKAO'}"><span class="social-icon kakao-mark">k</span>Kakao</c:when>
          <c:when test="${socialTemp.provider == 'NAVER'}"><span class="social-icon naver-mark">N</span>Naver</c:when>
          <c:when test="${socialTemp.provider == 'GOOGLE'}"><span class="social-icon google-mark">
            <svg width="18" height="18" viewBox="0 0 48 48">
              <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
              <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
              <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
              <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
            </svg>
          </span>Google</c:when>
        </c:choose>
        <spring:message code="auth.social.processing"/>
      </span>
    </div>

    <h1 class="auth-title">${autoMsg_93c5bf4f2c}</h1>
    <p class="auth-sub">${autoMsg_96753a3e42}</p>

    <c:if test="${socialEmailNotice.emailAvailable}">
      <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:10px 14px;font-size:13px;color:var(--gray-600);margin-bottom:16px;">
        ${autoMsg_71635c4ff1} <strong>${socialEmailNotice.socialEmail}</strong>
      </div>
    </c:if>

    <c:choose>
      <c:when test="${socialEmailNotice.noticeType == 'RECOMMEND_LINK'}">
        <div style="background:#fff7ed;border:1px solid #fdba74;border-radius:10px;padding:12px 14px;font-size:13px;color:#9a3412;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${autoMsg_3d0493b6df}</div>
          <div>${autoMsg_698a8de978}</div>
        </div>
      </c:when>
      <c:when test="${socialEmailNotice.noticeType == 'REFERENCE'}">
        <div style="background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;padding:12px 14px;font-size:13px;color:#1d4ed8;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${autoMsg_5d18463485}</div>
          <div>${autoMsg_8cd0b47542}</div>
        </div>
      </c:when>
      <c:otherwise>
        <div style="background:#f8fafc;border:1px solid #cbd5e1;border-radius:10px;padding:12px 14px;font-size:13px;color:#334155;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${autoMsg_ffeccd3254}</div>
          <div>${autoMsg_bae3aa1adb}</div>
        </div>
      </c:otherwise>
    </c:choose>

    <div id="socialCompleteError" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="nickname">${autoMsg_b64ba1d853}<span style="color:#ef4444">*</span></label>
      <input class="form-input" type="text" id="nickname" name="nickname" placeholder="${autoMsg_c927c4d217}" value="${socialTemp.nickname}" maxlength="20">
      <div class="field-msg" id="nicknameMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="nationality">${autoMsg_1d9dd87dca} <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="nationality" name="nationality">
        <option value="">${autoMsg_91972fbc66}</option>
        <option value="KR">${autoMsg_0814d9940e}</option>
        <option value="US">${autoMsg_faca1f9d83}</option>
        <option value="JP">${autoMsg_187d2275c5}</option>
        <option value="CN">${autoMsg_5ba3fdf7ff}</option>
        <option value="GB">${autoMsg_e87624e016}</option>
        <option value="FR">${autoMsg_72a942ba63}</option>
        <option value="DE">${autoMsg_96fb864746}</option>
        <option value="AU">${autoMsg_3a199d80a7}</option>
        <option value="CA">${autoMsg_ce0fa54cb9}</option>
        <option value="OTHER">${autoMsg_e0383b1245}</option>
      </select>
      <div class="field-msg" id="nationalityMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="preferredLang">${autoMsg_4c9fa90bf1} <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="preferredLang" name="preferredLang">
        <option value="">${autoMsg_bf465a6c00}</option>
        <option value="ko">${autoMsg_1a1da7a31a}</option>
        <option value="en">${autoMsg_7b80d5cdf6}</option>
        <option value="ja">${autoMsg_9c683a74c9}</option>
        <option value="zh">${autoMsg_3629c56522}</option>
      </select>
      <div class="field-msg" id="langMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="completeBtn" style="margin-top:4px;">
      <spring:message code="auth.social.submit"/>
    </button>

    <div class="auth-footer">
      <a href="${pageContext.request.contextPath}/auth/login">${autoMsg_846ed7b09b}</a>
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
      msgEl.textContent = '${autoMsg_2eb9893aa2}';
      return;
    }

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(async () => {
      const res = await fetch(ctx + '/auth/check/nickname?value=' + encodeURIComponent(v));
      const data = await res.json();
      if (data.duplicate) {
        input.className = 'form-input error';
        msgEl.className = 'field-msg error';
        msgEl.textContent = '${autoMsg_5a132b06b9}';
      } else {
        input.className = 'form-input success';
        msgEl.className = 'field-msg success';
        msgEl.textContent = '${autoMsg_0de62eb4ce}';
      }
    }, 500);
  });

  document.getElementById('completeBtn').addEventListener('click', async function () {
    const nickname = document.getElementById('nickname').value.trim();
    const nationality = document.getElementById('nationality').value;
    const preferredLang = document.getElementById('preferredLang').value;
    const errorBanner = document.getElementById('socialCompleteError');

    if (!nickname) { showFieldError('nickname', 'nicknameMsg', '${autoMsg_21f1f8662c}'); return; }
    if (!nationality) { showFieldError('nationality', 'nationalityMsg', '${autoMsg_ba072e5129}'); return; }
    if (!preferredLang) { showFieldError('preferredLang', 'langMsg', '${autoMsg_96cabee644}'); return; }

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
        errorBanner.textContent = '${autoMsg_483d246c30} ' + (data.message || '${autoMsg_b0e90b04c8}');
        errorBanner.classList.add('show');
      }
    } catch (e) {
      errorBanner.textContent = '${autoMsg_483d246c30} ${autoMsg_b0e90b04c8}';
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
