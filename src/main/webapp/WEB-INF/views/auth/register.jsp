<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>

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
      <h1 class="auth-title">여행의 시작 ✈️</h1>
      <p class="auth-sub">계정 정보를 입력해주세요</p>

      <!-- 소셜 가입 -->
      <div class="social-btns">
        <a href="${pageContext.request.contextPath}/auth/kakao" class="social-btn kakao">
          <span class="social-icon">🟡</span>
          카카오로 시작하기
        </a>
        <a href="${pageContext.request.contextPath}/auth/naver" class="social-btn naver">
          <span class="social-icon" style="font-weight:900;font-size:14px;">N</span>
          네이버로 시작하기
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
          Google로 시작하기
        </a>
      </div>

      <div class="auth-divider">또는 이메일로 가입</div>

      <div class="form-group">
        <label class="form-label" for="userId">아이디 <span style="color:#ef4444">*</span></label>
        <input class="form-input" type="text" id="userId" name="userId"
               placeholder="영문, 숫자 4~20자" maxlength="20" autocomplete="username">
        <div class="field-msg" id="userIdMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="userEmail">이메일 <span style="color:var(--gray-400);font-weight:400">(선택)</span></label>
        <input class="form-input" type="email" id="userEmail" name="userEmail"
               placeholder="example@email.com" autocomplete="email">
        <div class="field-msg" id="emailMsg"></div>
      </div>

      <div class="form-group">
        <label class="form-label" for="password">비밀번호 <span style="color:#ef4444">*</span></label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="password" name="password"
                 placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="64" autocomplete="new-password">
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
        <label class="form-label" for="passwordConfirm">비밀번호 확인 <span style="color:#ef4444">*</span></label>
        <div class="pw-wrap">
          <input class="form-input" type="password" id="passwordConfirm"
                 placeholder="비밀번호 재입력" maxlength="64" autocomplete="new-password">
          <button type="button" class="pw-toggle" id="pwToggle2">👁</button>
        </div>
        <div class="field-msg" id="pwConfirmMsg"></div>
      </div>

      <button type="button" class="btn-submit" id="step1Btn" style="margin-top:4px;">
        다음 단계 →
      </button>
    </div>

    <!-- ═══ STEP 2 ═══ -->
    <div id="step2" style="display:none">
      <h1 class="auth-title">거의 다 됐어요 🗺️</h1>
      <p class="auth-sub">프로필 정보를 입력해주세요</p>

      <div class="form-group">
        <label class="form-label" for="nickname">닉네임 <span style="color:#ef4444">*</span></label>
        <input class="form-input" type="text" id="nickname" name="nickname"
               placeholder="2~20자 (한글, 영문, 숫자)" maxlength="20">
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

      <div id="registerError" class="auth-error-banner"></div>

      <div style="display:flex;gap:10px;margin-top:4px;">
        <button type="button" class="btn-submit" id="backBtn"
                style="background:var(--gray-100);color:var(--gray-700);
                       box-shadow:none;flex:0 0 80px;font-weight:600;">
          ← 이전
        </button>
        <button type="button" class="btn-submit" id="registerBtn" style="flex:1;">
          가입 완료 🎉
        </button>
      </div>
    </div>

    <div class="auth-footer">
      이미 계정이 있으신가요?
      <a href="${pageContext.request.contextPath}/auth/login">로그인</a>
    </div>

  </div>
</div>

<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';

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
      setFieldStatus('userId','userIdMsg','error','영문, 숫자만 4~20자 입력해주세요.'); return;
    }
    debounce('userId', async () => {
      const dup = await checkDuplicate('userId', v);
      dup
        ? setFieldStatus('userId','userIdMsg','error','이미 사용 중인 아이디입니다.')
        : setFieldStatus('userId','userIdMsg','success','사용 가능한 아이디입니다.');
    });
  });

  // email 중복 체크
  document.getElementById('userEmail').addEventListener('input', function () {
    const v = this.value.trim();
    if (!v) { setFieldStatus('userEmail','emailMsg','',''); return; }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) {
      setFieldStatus('userEmail','emailMsg','error','올바른 이메일 형식이 아닙니다.'); return;
    }
    debounce('email', async () => {
      const dup = await checkDuplicate('email', v);
      dup
        ? setFieldStatus('userEmail','emailMsg','error','이미 사용 중인 이메일입니다.')
        : setFieldStatus('userEmail','emailMsg','success','사용 가능한 이메일입니다.');
    });
  });

  // 비밀번호 확인
  document.getElementById('passwordConfirm').addEventListener('input', function () {
    const pw  = document.getElementById('password').value;
    const cfm = this.value;
    if (!cfm) { setFieldStatus('passwordConfirm','pwConfirmMsg','',''); return; }
    pw === cfm
      ? setFieldStatus('passwordConfirm','pwConfirmMsg','success','비밀번호가 일치합니다.')
      : setFieldStatus('passwordConfirm','pwConfirmMsg','error','비밀번호가 일치하지 않습니다.');
  });

  // nickname 중복 체크
  document.getElementById('nickname').addEventListener('input', function () {
    const v = this.value.trim();
    if (!v) { setFieldStatus('nickname','nicknameMsg','',''); return; }
    if (v.length < 2 || v.length > 20) {
      setFieldStatus('nickname','nicknameMsg','error','2~20자로 입력해주세요.'); return;
    }
    debounce('nickname', async () => {
      const dup = await checkDuplicate('nickname', v);
      dup
        ? setFieldStatus('nickname','nicknameMsg','error','이미 사용 중인 닉네임입니다.')
        : setFieldStatus('nickname','nicknameMsg','success','사용 가능한 닉네임입니다.');
    });
  });

  // ── STEP 이동 ──
  function goToStep2() {
    const userId = document.getElementById('userId').value.trim();
    const pw     = document.getElementById('password').value;
    const pwCfm  = document.getElementById('passwordConfirm').value;

    if (!userId || !/^[a-zA-Z0-9]{4,20}$/.test(userId)) {
      setFieldStatus('userId','userIdMsg','error','아이디를 올바르게 입력해주세요.'); return;
    }
    if (pw.length < 8) {
      setFieldStatus('password','pwMsg','error','비밀번호는 8자 이상이어야 합니다.'); return;
    }
    if (pw !== pwCfm) {
      setFieldStatus('passwordConfirm','pwConfirmMsg','error','비밀번호가 일치하지 않습니다.'); return;
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

    if (!nickname) { setFieldStatus('nickname','nicknameMsg','error','닉네임을 입력해주세요.'); return; }
    if (!nationality) { setFieldStatus('nationality','nationalityMsg','error','국적을 선택해주세요.'); return; }
    if (!preferredLang) { setFieldStatus('preferredLang','langMsg','error','언어를 선택해주세요.'); return; }

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
        errorBanner.textContent = '⚠️ ' + (data.message || '회원가입에 실패했습니다.');
        errorBanner.classList.add('show');
        // 해당 필드로 포커스 이동
        if (data.field) {
          const el = document.getElementById(data.field);
          if (el) { el.focus(); el.classList.add('error'); }
        }
      }
    } catch (e) {
      errorBanner.textContent = '⚠️ 서버 오류가 발생했습니다.';
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
