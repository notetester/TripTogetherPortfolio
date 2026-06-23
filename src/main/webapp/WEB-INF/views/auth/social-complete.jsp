
<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_auth_register_nickname_placeholder" code="auth.register.nickname.placeholder"/>
<spring:message var="msg_auth_register_nickname_rule_js" code="auth.register.nickname.rule" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_nickname_duplicate_js" code="auth.register.nickname.duplicate" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_nickname_ok_js" code="auth.register.nickname.ok" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_nickname_required_js" code="auth.register.nickname.required" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_nationality_required_js" code="auth.register.nationality.required" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_language_required_js" code="auth.register.language.required" javaScriptEscape="true"/>
<spring:message var="msg_auth_common_errorPrefix_js" code="auth.common.errorPrefix" javaScriptEscape="true"/>
<spring:message var="msg_auth_register_server_js" code="auth.register.server" javaScriptEscape="true"/>
<spring:message var="msg_auth_social_processing" code="auth.social.processing"/>
<spring:message var="msg_auth_social_title" code="auth.social.title"/>
<spring:message var="msg_auth_social_subtitle" code="auth.social.subtitle"/>
<spring:message var="msg_auth_social_linkedEmail" code="auth.social.linkedEmail"/>
<spring:message var="msg_auth_social_emailConflictTitle" code="auth.social.emailConflictTitle"/>
<spring:message var="msg_auth_social_emailConflictBody" code="auth.social.emailConflictBody"/>
<spring:message var="msg_auth_social_emailReferenceTitle" code="auth.social.emailReferenceTitle"/>
<spring:message var="msg_auth_social_emailReferenceBody" code="auth.social.emailReferenceBody"/>
<spring:message var="msg_auth_social_emailMissingTitle" code="auth.social.emailMissingTitle"/>
<spring:message var="msg_auth_social_emailMissingBody" code="auth.social.emailMissingBody"/>
<spring:message var="msg_auth_register_nickname" code="auth.register.nickname"/>
<spring:message var="msg_auth_register_nationality" code="auth.register.nationality"/>
<spring:message var="msg_auth_register_nationality_placeholder" code="auth.register.nationality.placeholder"/>
<spring:message var="msg_auth_register_nationality_option_kr" code="auth.register.nationality.option.kr"/>
<spring:message var="msg_auth_register_nationality_option_us" code="auth.register.nationality.option.us"/>
<spring:message var="msg_auth_register_nationality_option_jp" code="auth.register.nationality.option.jp"/>
<spring:message var="msg_auth_register_nationality_option_cn" code="auth.register.nationality.option.cn"/>
<spring:message var="msg_auth_register_nationality_option_gb" code="auth.register.nationality.option.gb"/>
<spring:message var="msg_auth_register_nationality_option_fr" code="auth.register.nationality.option.fr"/>
<spring:message var="msg_auth_register_nationality_option_de" code="auth.register.nationality.option.de"/>
<spring:message var="msg_auth_register_nationality_option_au" code="auth.register.nationality.option.au"/>
<spring:message var="msg_auth_register_nationality_option_ca" code="auth.register.nationality.option.ca"/>
<spring:message var="msg_auth_register_nationality_option_other" code="auth.register.nationality.option.other"/>
<spring:message var="msg_auth_register_language" code="auth.register.language"/>
<spring:message var="msg_auth_register_language_placeholder" code="auth.register.language.placeholder"/>
<spring:message var="msg_auth_register_language_option_ko" code="auth.register.language.option.ko"/>
<spring:message var="msg_auth_register_language_option_en" code="auth.register.language.option.en"/>
<spring:message var="msg_auth_register_language_option_ja" code="auth.register.language.option.ja"/>
<spring:message var="msg_auth_register_language_option_zh" code="auth.register.language.option.zh"/>
<spring:message var="msg_auth_social_submit" code="auth.social.submit"/>
<spring:message var="msg_auth_social_backToLogin" code="auth.social.backToLogin"/>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
        ${msg_auth_social_processing}
      </span>
    </div>

    <h1 class="auth-title">${msg_auth_social_title}</h1>
    <p class="auth-sub">${msg_auth_social_subtitle}</p>

    <c:if test="${socialEmailNotice.emailAvailable}">
      <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:10px 14px;font-size:13px;color:var(--gray-600);margin-bottom:16px;">
        ${msg_auth_social_linkedEmail} <strong>${socialEmailNotice.socialEmail}</strong>
      </div>
    </c:if>

    <c:choose>
      <c:when test="${socialEmailNotice.noticeType == 'RECOMMEND_LINK'}">
        <div style="background:#fff7ed;border:1px solid #fdba74;border-radius:10px;padding:12px 14px;font-size:13px;color:#9a3412;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${msg_auth_social_emailConflictTitle}</div>
          <div>${msg_auth_social_emailConflictBody}</div>
        </div>
      </c:when>
      <c:when test="${socialEmailNotice.noticeType == 'REFERENCE'}">
        <div style="background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;padding:12px 14px;font-size:13px;color:#1d4ed8;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${msg_auth_social_emailReferenceTitle}</div>
          <div>${msg_auth_social_emailReferenceBody}</div>
        </div>
      </c:when>
      <c:otherwise>
        <div style="background:#f8fafc;border:1px solid #cbd5e1;border-radius:10px;padding:12px 14px;font-size:13px;color:#334155;line-height:1.7;margin-bottom:16px;">
          <div style="font-weight:700;margin-bottom:4px;">${msg_auth_social_emailMissingTitle}</div>
          <div>${msg_auth_social_emailMissingBody}</div>
        </div>
      </c:otherwise>
    </c:choose>

    <div id="socialCompleteError" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="nickname">${msg_auth_register_nickname}<span style="color:#ef4444">*</span></label>
      <input class="form-input" type="text" id="nickname" name="nickname" placeholder="${msg_auth_register_nickname_placeholder}" value="${socialTemp.nickname}" maxlength="20">
      <div class="field-msg" id="nicknameMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="nationality">${msg_auth_register_nationality} <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="nationality" name="nationality">
        <option value="">${msg_auth_register_nationality_placeholder}</option>
        <option value="KR">${msg_auth_register_nationality_option_kr}</option>
        <option value="US">${msg_auth_register_nationality_option_us}</option>
        <option value="JP">${msg_auth_register_nationality_option_jp}</option>
        <option value="CN">${msg_auth_register_nationality_option_cn}</option>
        <option value="GB">${msg_auth_register_nationality_option_gb}</option>
        <option value="FR">${msg_auth_register_nationality_option_fr}</option>
        <option value="DE">${msg_auth_register_nationality_option_de}</option>
        <option value="AU">${msg_auth_register_nationality_option_au}</option>
        <option value="CA">${msg_auth_register_nationality_option_ca}</option>
        <option value="OTHER">${msg_auth_register_nationality_option_other}</option>
      </select>
      <div class="field-msg" id="nationalityMsg"></div>
    </div>

    <div class="form-group">
      <label class="form-label" for="preferredLang">${msg_auth_register_language} <span style="color:#ef4444">*</span></label>
      <select class="form-select" id="preferredLang" name="preferredLang">
        <option value="">${msg_auth_register_language_placeholder}</option>
        <option value="ko">${msg_auth_register_language_option_ko}</option>
        <option value="en">${msg_auth_register_language_option_en}</option>
        <option value="ja">${msg_auth_register_language_option_ja}</option>
        <option value="zh">${msg_auth_register_language_option_zh}</option>
      </select>
      <div class="field-msg" id="langMsg"></div>
    </div>

    <button type="button" class="btn-submit" id="completeBtn" style="margin-top:4px;">
      ${msg_auth_social_submit}
    </button>

    <div class="auth-footer">
      <a href="${pageContext.request.contextPath}/auth/login">${msg_auth_social_backToLogin}</a>
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
      msgEl.textContent = '${msg_auth_register_nickname_rule_js}';
      return;
    }

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(async () => {
      const res = await fetch(ctx + '/auth/check/nickname?value=' + encodeURIComponent(v));
      const data = await res.json();
      if (data.duplicate) {
        input.className = 'form-input error';
        msgEl.className = 'field-msg error';
        msgEl.textContent = '${msg_auth_register_nickname_duplicate_js}';
      } else {
        input.className = 'form-input success';
        msgEl.className = 'field-msg success';
        msgEl.textContent = '${msg_auth_register_nickname_ok_js}';
      }
    }, 500);
  });

  document.getElementById('completeBtn').addEventListener('click', async function () {
    const nickname = document.getElementById('nickname').value.trim();
    const nationality = document.getElementById('nationality').value;
    const preferredLang = document.getElementById('preferredLang').value;
    const errorBanner = document.getElementById('socialCompleteError');

    if (!nickname) { showFieldError('nickname', 'nicknameMsg', '${msg_auth_register_nickname_required_js}'); return; }
    if (!nationality) { showFieldError('nationality', 'nationalityMsg', '${msg_auth_register_nationality_required_js}'); return; }
    if (!preferredLang) { showFieldError('preferredLang', 'langMsg', '${msg_auth_register_language_required_js}'); return; }

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
        errorBanner.textContent = '${msg_auth_common_errorPrefix_js} ' + (data.message || '${msg_auth_register_server_js}');
        errorBanner.classList.add('show');
      }
    } catch (e) {
      errorBanner.textContent = '${msg_auth_common_errorPrefix_js} ${msg_auth_register_server_js}';
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
