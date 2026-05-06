<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<spring:message code="auth.register.email.placeholder" var="authRegisterEmailPlaceholder"/>
<spring:message code="auth.register.nickname.placeholder" var="authRegisterNicknamePlaceholder"/>
<spring:message code="auth.register.password.placeholder" var="authRegisterPasswordPlaceholder"/>
<spring:message code="auth.register.passwordConfirm.placeholder" var="authRegisterPasswordConfirmPlaceholder"/>
<spring:message code="auth.register.userId.placeholder" var="authRegisterUserIdPlaceholder"/>
<html lang="${pageContext.response.locale.language}">
<body>
<div class="auth-wrap">
  <div class="auth-card wide">

    <!-- 로고 -->
    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div>
      <span class="auth-logo-text">TripTogether</span>
    </div>

    <!-- 스텝 인디케이터 -->
    <div class="step-indicator">
      <div class="step-dot active" id="dot1"></div>
      <div class="step-dot" id="dot2"></div>
    </div>

    <!-- ═══ STEP 1 ═══ -->
    <div id="step1">
      <h1 class="auth-title"><spring:message code="auth.register.title1"/></h1>
      <p class="auth-sub"><spring:message code="auth.register.subtitle1"/></p>

      <!-- 소셜 가입 -->
      <div class="social-btns">
        <a href="${kakaoAuthUrl}" class="social-btn kakao">
          <span class="social-icon kakao-mark">k</span>
          <spring:message code="auth.register.kakao"/>
        </a>
        <a href="${naverAuthUrl}" class="social-btn naver">
          <span class="social-icon naver-mark">N</span>
          <spring:message code="auth.register.naver"/>
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
          <spring:message code="auth.register.google"/>
        </a>
      </div>

      <div class="auth-divider"><spring:message code="auth.register.or"/></div>

      <div class="form-group">
        <label class="form-label" for="userId"><spring:message code="auth.register.userId"/> <span style="color:#ef4444">*</span></label>
        <input class="form-input" type="text" id="userId" name="userId"
               placeholder="${authRegisterUserIdPlaceholder}" maxlength="20" autocomplete="username">
        <div class="field-msg" id="userIdMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="userEmail"><spring:message code="auth.register.email"/> <span style="color:var(--gray-400);font-weight:400"><spring:message code="auth.register.optional"/></span></label>
        <input class="form-input" type="email" id="userEmail" name="userEmail"
               placeholder="${authRegisterEmailPlaceholder}" autocomplete="email">
        <div class="field-msg" id="emailMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="password"><spring:message code="auth.register.password"/> <span style="color:#ef4444">*</span></label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="password" name="password"
                 placeholder="${authRegisterPasswordPlaceholder}" maxlength="64" autocomplete="new-password">
          <button type="button" class="pw-toggle" id="pwToggle1">👁</button>
        </div>
        <div class="pw-strength" id="pwStrengthBar">
          <div class="pw-bar" id="bar1"></div>
          <div class="pw-bar" id="bar2"></div>
          <div class="pw-bar" id="bar3"></div>
        </div>
        <div class="field-msg" id="pwMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="passwordConfirm"><spring:message code="auth.register.passwordConfirm"/> <span style="color:#ef4444">*</span></label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="passwordConfirm"
                 placeholder="${authRegisterPasswordConfirmPlaceholder}" maxlength="64" autocomplete="new-password">
          <button type="button" class="pw-toggle" id="pwToggle2">👁</button>
        </div>
        <div class="field-msg" id="pwConfirmMsg"></div>
      </div>

      <button type="button" class="btn-submit" id="step1Btn" style="margin-top:4px;">
        <spring:message code="auth.register.next"/>
      </button>
    </div>

    <!-- ═══ STEP 2 ═══ -->
    <div id="step2" style="display:none">
      <h1 class="auth-title"><spring:message code="auth.register.title2"/></h1>
      <p class="auth-sub"><spring:message code="auth.register.subtitle2"/></p>

      <div class="form-group">
        <label class="form-label" for="nickname"><spring:message code="auth.register.nickname"/> <span style="color:#ef4444">*</span></label>
        <input class="form-input" type="text" id="nickname" name="nickname"
               placeholder="${authRegisterNicknamePlaceholder}" maxlength="20">
        <div class="field-msg" id="nicknameMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="nationality"><spring:message code="auth.register.nationality"/> <span style="color:#ef4444">*</span></label>
        <select class="form-select" id="nationality" name="nationality">
          <option value=""><spring:message code="auth.register.nationality.placeholder"/></option>
          <option value="KR">🇰🇷 <spring:message code="auth.register.nationality.option.kr"/></option>
          <option value="US">🇺🇸 <spring:message code="auth.register.nationality.option.us"/></option>
          <option value="JP">🇯🇵 <spring:message code="auth.register.nationality.option.jp"/></option>
          <option value="CN">🇨🇳 <spring:message code="auth.register.nationality.option.cn"/></option>
          <option value="GB">🇬🇧 <spring:message code="auth.register.nationality.option.gb"/></option>
          <option value="FR">🇫🇷 <spring:message code="auth.register.nationality.option.fr"/></option>
          <option value="DE">🇩🇪 <spring:message code="auth.register.nationality.option.de"/></option>
          <option value="AU">🇦🇺 <spring:message code="auth.register.nationality.option.au"/></option>
          <option value="CA">🇨🇦 <spring:message code="auth.register.nationality.option.ca"/></option>
          <option value="OTHER">🌍 <spring:message code="auth.register.nationality.option.other"/></option>
        </select>
        <div class="field-msg" id="nationalityMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="preferredLang"><spring:message code="auth.register.language"/> <span style="color:#ef4444">*</span></label>
        <select class="form-select" id="preferredLang" name="preferredLang">
          <option value=""><spring:message code="auth.register.language.placeholder"/></option>
          <option value="ko">🇰🇷 <spring:message code="auth.register.language.option.ko"/></option>
          <option value="en">🇺🇸 <spring:message code="auth.register.language.option.en"/></option>
          <option value="ja">🇯🇵 <spring:message code="auth.register.language.option.ja"/></option>
          <option value="zh">🇨🇳 <spring:message code="auth.register.language.option.zh"/></option>
        </select>
        <div class="field-msg" id="langMsg"></div>
      </div>

      <div id="registerError" class="auth-error-banner"></div>

      <div style="display:flex;gap:10px;margin-top:4px;">
        <button type="button" class="btn-submit" id="backBtn"
                style="background:var(--gray-100);color:var(--gray-700);
                       box-shadow:none;flex:0 0 80px;font-weight:600;">
          <spring:message code="auth.register.prev"/>
        </button>
        <button type="button" class="btn-submit" id="registerBtn" style="flex:1;">
          <spring:message code="auth.register.complete"/>
        </button>
      </div>
    </div>

    <div class="auth-footer">
      <spring:message code="auth.register.hasAccount"/>
      <a href="${pageContext.request.contextPath}/auth/login"><spring:message code="header.auth.login"/></a>
    </div>

  </div>
</div>

<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  <spring:message code="auth.register.email.duplicate" javaScriptEscape="true" var="authRegisterEmailDuplicateJs"/>
  <spring:message code="auth.register.email.ok" javaScriptEscape="true" var="authRegisterEmailOkJs"/>
  <spring:message code="auth.register.email.rule" javaScriptEscape="true" var="authRegisterEmailRuleJs"/>
  <spring:message code="auth.register.fail" javaScriptEscape="true" var="authRegisterFailJs"/>
  <spring:message code="auth.register.language.required" javaScriptEscape="true" var="authRegisterLanguageRequiredJs"/>
  <spring:message code="auth.register.nationality.required" javaScriptEscape="true" var="authRegisterNationalityRequiredJs"/>
  <spring:message code="auth.register.nickname.duplicate" javaScriptEscape="true" var="authRegisterNicknameDuplicateJs"/>
  <spring:message code="auth.register.nickname.ok" javaScriptEscape="true" var="authRegisterNicknameOkJs"/>
  <spring:message code="auth.register.nickname.required" javaScriptEscape="true" var="authRegisterNicknameRequiredJs"/>
  <spring:message code="auth.register.nickname.rule" javaScriptEscape="true" var="authRegisterNicknameRuleJs"/>
  <spring:message code="auth.register.password.match" javaScriptEscape="true" var="authRegisterPasswordMatchJs"/>
  <spring:message code="auth.register.password.mismatch" javaScriptEscape="true" var="authRegisterPasswordMismatchJs"/>
  <spring:message code="auth.register.password.short" javaScriptEscape="true" var="authRegisterPasswordShortJs"/>
  <spring:message code="auth.register.server" javaScriptEscape="true" var="authRegisterServerJs"/>
  <spring:message code="auth.register.userId.duplicate" javaScriptEscape="true" var="authRegisterUserIdDuplicateJs"/>
  <spring:message code="auth.register.userId.invalid" javaScriptEscape="true" var="authRegisterUserIdInvalidJs"/>
  <spring:message code="auth.register.userId.ok" javaScriptEscape="true" var="authRegisterUserIdOkJs"/>
  <spring:message code="auth.register.userId.rule" javaScriptEscape="true" var="authRegisterUserIdRuleJs"/>

  const registerMessages = {
    email: {
      duplicate: '${authRegisterEmailDuplicateJs}',
      ok: '${authRegisterEmailOkJs}',
      rule: '${authRegisterEmailRuleJs}'
    },
    fail: '${authRegisterFailJs}',
    languageRequired: '${authRegisterLanguageRequiredJs}',
    nationalityRequired: '${authRegisterNationalityRequiredJs}',
    nickname: {
      duplicate: '${authRegisterNicknameDuplicateJs}',
      ok: '${authRegisterNicknameOkJs}',
      required: '${authRegisterNicknameRequiredJs}',
      rule: '${authRegisterNicknameRuleJs}'
    },
    password: {
      match: '${authRegisterPasswordMatchJs}',
      mismatch: '${authRegisterPasswordMismatchJs}',
      short: '${authRegisterPasswordShortJs}'
    },
    server: '${authRegisterServerJs}',
    userId: {
      duplicate: '${authRegisterUserIdDuplicateJs}',
      invalid: '${authRegisterUserIdInvalidJs}',
      ok: '${authRegisterUserIdOkJs}',
      rule: '${authRegisterUserIdRuleJs}'
    }
  };

  // ── 비밀번호 토글 ──
  function makePwToggle(btnId, inputId) {
    document.getElementById(btnId).addEventListener('click', function () {
      const pw = document.getElementById(inputId);
      const isText = pw.type === 'text';
      pw.type = isText ? 'password' : 'text';
      this.textContent = isText ? '👁' : '🙈';
    });
  }
  makePwToggle('pwToggle1', 'password');
  makePwToggle('pwToggle2', 'passwordConfirm');

  // ── 비밀번호 강도 ──
  document.getElementById('password').addEventListener('input', function () {
    const v = this.value;
    const score = calcPwStrength(v);
    const bars = [document.getElementById('bar1'), document.getElementById('bar2'), document.getElementById('bar3')];
    const cls  = score === 1 ? 'weak' : score === 2 ? 'fair' : score === 3 ? 'strong' : '';
    bars.forEach((b, i) => { b.className = 'pw-bar' + (i < score && cls ? ' ' + cls : ''); });
  });

  function calcPwStrength(pw) {
    if (pw.length < 6) return 0;
    let s = 0;
    if (pw.length >= 8) s++;
    if (/[A-Za-z]/.test(pw) && /\d/.test(pw)) s++;
    if (/[^A-Za-z0-9]/.test(pw)) s++;
    return s;
  }

  // ── Debounce 중복 체크 ──
  let debounceTimers = {};
  function debounce(key, fn, ms = 500) {
    clearTimeout(debounceTimers[key]);
    debounceTimers[key] = setTimeout(fn, ms);
  }

  async function checkDuplicate(endpoint, value) {
    if (!value) return null;
    const res = await fetch(ctx + '/auth/check/' + endpoint + '?value=' + encodeURIComponent(value));
    const data = await res.json();
    return data.duplicate;
  }

  function setFieldStatus(inputId, msgId, status, msg) {
    const input = document.getElementById(inputId);
    const msgEl = document.getElementById(msgId);
    input.className = 'form-input' + (status ? ' ' + status : '');
    msgEl.className = 'field-msg' + (status ? ' ' + status : '');
    msgEl.textContent = msg;
  }

  // userId 중복 체크
  document.getElementById('userId').addEventListener('input', function () {
    const v = this.value.trim();
    if (!v) { setFieldStatus('userId','userIdMsg','',''); return; }
    if (!/^[a-zA-Z0-9]{4,20}$/.test(v)) {
      setFieldStatus('userId','userIdMsg','error', registerMessages.userId.rule); return;
    }
    debounce('userId', async () => {
      const dup = await checkDuplicate('userId', v);
      dup
        ? setFieldStatus('userId','userIdMsg','error', registerMessages.userId.duplicate)
        : setFieldStatus('userId','userIdMsg','success', registerMessages.userId.ok);
    });
  });

  // email 중복 체크
  document.getElementById('userEmail').addEventListener('input', function () {
    const v = this.value.trim();
    if (!v) { setFieldStatus('userEmail','emailMsg','',''); return; }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) {
      setFieldStatus('userEmail','emailMsg','error', registerMessages.email.rule); return;
    }
    debounce('email', async () => {
      const dup = await checkDuplicate('email', v);
      dup
        ? setFieldStatus('userEmail','emailMsg','error', registerMessages.email.duplicate)
        : setFieldStatus('userEmail','emailMsg','success', registerMessages.email.ok);
    });
  });

  // 비밀번호 확인
  document.getElementById('passwordConfirm').addEventListener('input', function () {
    const pw  = document.getElementById('password').value;
    const cfm = this.value;
    if (!cfm) { setFieldStatus('passwordConfirm','pwConfirmMsg','',''); return; }
    pw === cfm
      ? setFieldStatus('passwordConfirm','pwConfirmMsg','success', registerMessages.password.match)
      : setFieldStatus('passwordConfirm','pwConfirmMsg','error', registerMessages.password.mismatch);
  });

  // nickname 중복 체크
  document.getElementById('nickname').addEventListener('input', function () {
    const v = this.value.trim();
    if (!v) { setFieldStatus('nickname','nicknameMsg','',''); return; }
    if (v.length < 2 || v.length > 20) {
      setFieldStatus('nickname','nicknameMsg','error', registerMessages.nickname.rule); return;
    }
    debounce('nickname', async () => {
      const dup = await checkDuplicate('nickname', v);
      dup
        ? setFieldStatus('nickname','nicknameMsg','error', registerMessages.nickname.duplicate)
        : setFieldStatus('nickname','nicknameMsg','success', registerMessages.nickname.ok);
    });
  });

  // ── STEP 이동 ──
  function goToStep2() {
    const userId = document.getElementById('userId').value.trim();
    const pw     = document.getElementById('password').value;
    const pwCfm  = document.getElementById('passwordConfirm').value;

    if (!userId || !/^[a-zA-Z0-9]{4,20}$/.test(userId)) {
      setFieldStatus('userId','userIdMsg','error', registerMessages.userId.invalid); return;
    }
    if (pw.length < 8) {
      setFieldStatus('password','pwMsg','error', registerMessages.password.short); return;
    }
    if (pw !== pwCfm) {
      setFieldStatus('passwordConfirm','pwConfirmMsg','error', registerMessages.password.mismatch); return;
    }

    document.getElementById('step1').style.display = 'none';
    document.getElementById('step2').style.display = 'block';
    document.getElementById('dot1').className = 'step-dot done';
    document.getElementById('dot2').className = 'step-dot active';
  }

  document.getElementById('step1Btn').addEventListener('click', goToStep2);
  document.getElementById('backBtn').addEventListener('click', function () {
    document.getElementById('step2').style.display = 'none';
    document.getElementById('step1').style.display = 'block';
    document.getElementById('dot1').className = 'step-dot active';
    document.getElementById('dot2').className = 'step-dot';
  });

  // ── 최종 제출 ──
  document.getElementById('registerBtn').addEventListener('click', async function () {
    const nickname     = document.getElementById('nickname').value.trim();
    const nationality  = document.getElementById('nationality').value;
    const preferredLang= document.getElementById('preferredLang').value;
    const errorBanner  = document.getElementById('registerError');

    if (!nickname) { setFieldStatus('nickname','nicknameMsg','error', registerMessages.nickname.required); return; }
    if (!nationality) { setFieldStatus('nationality','nationalityMsg','error', registerMessages.nationalityRequired); return; }
    if (!preferredLang) { setFieldStatus('preferredLang','langMsg','error', registerMessages.languageRequired); return; }

    this.classList.add('loading');
    this.disabled = true;
    errorBanner.classList.remove('show');

    const params = new URLSearchParams({
      userId:       document.getElementById('userId').value.trim(),
      userEmail:    document.getElementById('userEmail').value.trim(),
      password:     document.getElementById('password').value,
      nickname, nationality, preferredLang
    });

    try {
      const res  = await fetch(ctx + '/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
      });
      const data = await res.json();

      if (data.success) {
        location.href = data.redirect;
      } else {
        errorBanner.textContent = '⚠️ ' + (data.message || registerMessages.fail);
        errorBanner.classList.add('show');
        // 해당 필드로 포커스 이동
        if (data.field) {
          const el = document.getElementById(data.field);
          if (el) { el.focus(); el.classList.add('error'); }
        }
      }
    } catch (e) {
      errorBanner.textContent = '⚠️ ' + registerMessages.server;
      errorBanner.classList.add('show');
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
