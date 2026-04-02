<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<div class="mypage-wrap">
  <div class="mypage-inner">

    <!-- 헤더 -->
    <div class="mypage-header">
      <button class="mypage-back"
              onclick="location.href='${pageContext.request.contextPath}/mypage'">
        ← 마이페이지
      </button>
      <h1>회원정보 수정</h1>
      <p>내 계정 정보를 관리하세요</p>
    </div>

    <!-- 성공/오류 플래시 -->
    <c:if test="${not empty successMsg}">
      <div style="background:#f0fdf4;border:1px solid #bbf7d0;border-radius:10px;
                  padding:12px 16px;font-size:14px;color:#15803d;margin-bottom:20px;">
        ✅ ${successMsg}
      </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:10px;
                  padding:12px 16px;font-size:14px;color:#dc2626;margin-bottom:20px;">
        ⚠️ ${errorMsg}
      </div>
    </c:if>

    <!-- ═══════════════════════════════════════
         1. 기본 프로필
    ═══════════════════════════════════════ -->
    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-profile',this)">
        <div class="edit-card-head-icon">👤</div>
        <div>
          <div class="edit-card-head-title">기본 프로필</div>
          <div class="edit-card-head-sub">닉네임, 국적, 언어 설정</div>
        </div>
        <span class="edit-card-chevron open" id="chev-profile">▼</span>
      </div>
      <div class="accordion-body open edit-card-body" id="acc-profile">
        <div class="form-group">
          <label class="form-label" for="nickname">닉네임</label>
          <input class="form-input" type="text" id="nickname"
                 value="${user.nickname}" maxlength="20">
          <div class="field-msg" id="nicknameMsg"></div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="nationality">국적</label>
            <select class="form-select" id="nationality">
              <option value="KR"    ${user.nationality=='KR'    ?'selected':''}>🇰🇷 대한민국</option>
              <option value="US"    ${user.nationality=='US'    ?'selected':''}>🇺🇸 미국</option>
              <option value="JP"    ${user.nationality=='JP'    ?'selected':''}>🇯🇵 일본</option>
              <option value="CN"    ${user.nationality=='CN'    ?'selected':''}>🇨🇳 중국</option>
              <option value="GB"    ${user.nationality=='GB'    ?'selected':''}>🇬🇧 영국</option>
              <option value="FR"    ${user.nationality=='FR'    ?'selected':''}>🇫🇷 프랑스</option>
              <option value="DE"    ${user.nationality=='DE'    ?'selected':''}>🇩🇪 독일</option>
              <option value="AU"    ${user.nationality=='AU'    ?'selected':''}>🇦🇺 호주</option>
              <option value="CA"    ${user.nationality=='CA'    ?'selected':''}>🇨🇦 캐나다</option>
              <option value="OTHER" ${user.nationality=='OTHER' ?'selected':''}>🌍 기타</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label" for="preferredLang">선호 언어</label>
            <select class="form-select" id="preferredLang">
              <option value="ko" ${user.preferredLang=='ko'?'selected':''}>🇰🇷 한국어</option>
              <option value="en" ${user.preferredLang=='en'?'selected':''}>🇺🇸 English</option>
              <option value="ja" ${user.preferredLang=='ja'?'selected':''}>🇯🇵 日本語</option>
              <option value="zh" ${user.preferredLang=='zh'?'selected':''}>🇨🇳 中文</option>
            </select>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
          <button class="btn-save" id="saveProfileBtn">저장</button>
          <span class="save-msg" id="saveProfileMsg"></span>
        </div>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         2. 이메일 관리
    ═══════════════════════════════════════ -->
    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-email',this)">
        <div class="edit-card-head-icon">📧</div>
        <div>
          <div class="edit-card-head-title">이메일 관리</div>
          <div class="edit-card-head-sub">인증 및 이메일 로그인 설정</div>
        </div>
        <span class="edit-card-chevron" id="chev-email">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-email">

        <!-- 현재 이메일 상태 -->
        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;">
          <div style="font-size:13px;font-weight:600;color:var(--gray-600);margin-bottom:4px;">현재 이메일</div>
          <div style="display:flex;align-items:center;flex-wrap:wrap;gap:8px;">
            <span style="font-size:15px;font-weight:600;color:var(--gray-800);" id="currentEmail">
              <c:choose>
                <c:when test="${not empty user.userEmail}">${user.userEmail}</c:when>
                <c:otherwise><span style="color:var(--gray-400);">등록된 이메일 없음</span></c:otherwise>
              </c:choose>
            </span>
            <c:choose>
              <c:when test="${user.emailVerified}">
                <span class="email-status-badge verified">✓ 인증됨</span>
              </c:when>
              <c:when test="${not empty user.userEmail}">
                <span class="email-status-badge unverified">⚠ 미인증</span>
              </c:when>
            </c:choose>
          </div>
        </div>

        <!-- 이메일 변경 / 인증 -->
        <div class="form-group">
          <label class="form-label" for="newEmail">이메일 변경 또는 등록</label>
          <div style="display:flex;gap:8px;">
            <input class="form-input" type="email" id="newEmail"
                   placeholder="새 이메일 주소" style="flex:1;"
                   value="${user.userEmail}">
            <button class="btn-save" id="sendVerifyBtn" style="white-space:nowrap;padding:10px 16px;">
              인증 발송
            </button>
          </div>
          <div class="field-msg" id="emailMsg"></div>
        </div>

        <div style="height:1px;background:var(--gray-100);margin:16px 0;"></div>

        <!-- 이메일 로그인 토글 -->
        <div class="toggle-wrap">
          <div>
            <div class="toggle-label">이메일로 로그인</div>
            <div class="toggle-sub">
              <c:choose>
                <c:when test="${user.emailVerified}">
                  이메일 주소를 아이디 대신 사용합니다
                </c:when>
                <c:otherwise>
                  이메일 인증 후 활성화 가능합니다
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <label class="toggle-switch">
            <input type="checkbox" id="emailLoginToggle"
                   ${user.emailLoginEnabled ? 'checked' : ''}
                   ${!user.emailVerified ? 'disabled' : ''}>
            <span class="toggle-slider"></span>
          </label>
        </div>
        <div class="save-msg" id="emailLoginMsg" style="display:block;margin-top:8px;"></div>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         3. 비밀번호 변경
    ═══════════════════════════════════════ -->
    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-pw',this)">
        <div class="edit-card-head-icon">🔒</div>
        <div>
          <div class="edit-card-head-title">비밀번호 변경</div>
          <div class="edit-card-head-sub">
            <c:choose>
              <c:when test="${user.passwordEnabled}">현재 비밀번호로 로그인 중</c:when>
              <c:otherwise>비밀번호를 설정하면 아이디로도 로그인 가능</c:otherwise>
            </c:choose>
          </div>
        </div>
        <span class="edit-card-chevron" id="chev-pw">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-pw">

        <c:if test="${user.passwordEnabled}">
          <div class="form-group">
            <label class="form-label" for="currentPassword">현재 비밀번호</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="currentPassword"
                     placeholder="현재 비밀번호 입력">
              <button type="button" class="pw-toggle" id="pt0">👁</button>
            </div>
            <div class="field-msg" id="curPwMsg"></div>
          </div>
        </c:if>

        <div class="form-group">
          <label class="form-label" for="newPassword">
            <c:choose>
              <c:when test="${user.passwordEnabled}">새 비밀번호</c:when>
              <c:otherwise>비밀번호 설정</c:otherwise>
            </c:choose>
          </label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="newPassword"
                   placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="64">
            <button type="button" class="pw-toggle" id="pt1">👁</button>
          </div>
          <div class="pw-strength">
            <div class="pw-bar" id="pb1"></div>
            <div class="pw-bar" id="pb2"></div>
            <div class="pw-bar" id="pb3"></div>
          </div>
          <div class="field-msg" id="newPwMsg"></div>
        </div>

        <div class="form-group">
          <label class="form-label" for="confirmPassword">비밀번호 확인</label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="confirmPassword"
                   placeholder="비밀번호 재입력" maxlength="64">
            <button type="button" class="pw-toggle" id="pt2">👁</button>
          </div>
          <div class="field-msg" id="cfmPwMsg"></div>
        </div>

        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
          <button class="btn-save" id="savePwBtn">
            <c:choose>
              <c:when test="${user.passwordEnabled}">비밀번호 변경</c:when>
              <c:otherwise>비밀번호 설정</c:otherwise>
            </c:choose>
          </button>
          <span class="save-msg" id="savePwMsg"></span>
        </div>
      </div>
    </div>

    <!-- ═══════════════════════════════════════
         4. 소셜 계정 연동
    ═══════════════════════════════════════ -->
    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-social',this)">
        <div class="edit-card-head-icon">🔗</div>
        <div>
          <div class="edit-card-head-title">소셜 계정 연동</div>
          <div class="edit-card-head-sub">카카오, 네이버, 구글 계정 연결 관리</div>
        </div>
        <span class="edit-card-chevron" id="chev-social">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-social">

        <!-- 카카오 -->
        <div class="social-link-item">
          <div class="social-link-icon KAKAO">🟡</div>
          <div class="social-link-info">
            <div class="social-link-name">카카오</div>
            <div class="social-link-status ${socialLinkMap['KAKAO'] ? 'linked' : ''}">
              <c:choose>
                <c:when test="${socialLinkMap['KAKAO']}">● 연동됨</c:when>
                <c:otherwise>○ 연동되지 않음</c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['KAKAO']}">
              <button class="btn-social-action unlink" onclick="unlinkSocial('KAKAO', this)">
                연동 해제
              </button>
            </c:when>
            <c:otherwise>
              <button class="btn-social-action link"
                      onclick="location.href='${pageContext.request.contextPath}/auth/link/kakao'">
                연동하기
              </button>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 네이버 -->
        <div class="social-link-item">
          <div class="social-link-icon NAVER" style="font-weight:900;font-size:15px;">N</div>
          <div class="social-link-info">
            <div class="social-link-name">네이버</div>
            <div class="social-link-status ${socialLinkMap['NAVER'] ? 'linked' : ''}">
              <c:choose>
                <c:when test="${socialLinkMap['NAVER']}">● 연동됨</c:when>
                <c:otherwise>○ 연동되지 않음</c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['NAVER']}">
              <button class="btn-social-action unlink" onclick="unlinkSocial('NAVER', this)">
                연동 해제
              </button>
            </c:when>
            <c:otherwise>
              <button class="btn-social-action link"
                      onclick="location.href='${pageContext.request.contextPath}/auth/link/naver'">
                연동하기
              </button>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 구글 -->
        <div class="social-link-item">
          <div class="social-link-icon GOOGLE">
            <svg width="18" height="18" viewBox="0 0 48 48">
              <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
              <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
              <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
              <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
            </svg>
          </div>
          <div class="social-link-info">
            <div class="social-link-name">Google</div>
            <div class="social-link-status ${socialLinkMap['GOOGLE'] ? 'linked' : ''}">
              <c:choose>
                <c:when test="${socialLinkMap['GOOGLE']}">● 연동됨</c:when>
                <c:otherwise>○ 연동되지 않음</c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['GOOGLE']}">
              <button class="btn-social-action unlink" onclick="unlinkSocial('GOOGLE', this)">
                연동 해제
              </button>
            </c:when>
            <c:otherwise>
              <button class="btn-social-action link"
                      onclick="location.href='${pageContext.request.contextPath}/auth/link/google'">
                연동하기
              </button>
            </c:otherwise>
          </c:choose>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);
                    border-radius:8px;font-size:12px;color:var(--gray-500);">
          ⚠️ 비밀번호 없이 소셜 로그인만 사용 중이라면, 마지막 소셜 연동은 해제할 수 없습니다.
        </div>
      </div>
    </div>

    <!-- 수정 완료 -->
    <div style="text-align:center;margin-top:8px;">
      <form action="${pageContext.request.contextPath}/mypage/edit/done" method="post">
        <button type="submit" class="btn-save"
                style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;
                       padding:12px 32px;font-size:15px;">
          ✅ 수정 완료
        </button>
      </form>
    </div>

  </div><!-- /mypage-inner -->
</div><!-- /mypage-wrap -->

<script>
const ctx = '${pageContext.request.contextPath}';

// ── 아코디언 ──
function toggleAcc(id, head) {
  const body = document.getElementById(id);
  const chev = head.querySelector('.edit-card-chevron');
  const isOpen = body.classList.contains('open');
  body.classList.toggle('open', !isOpen);
  chev.classList.toggle('open', !isOpen);
}

// ── 토글 헬퍼 ──
function makePwToggle(btnId, inputId) {
  const btn = document.getElementById(btnId);
  if (!btn) return;
  btn.addEventListener('click', function () {
    const el = document.getElementById(inputId);
    const t  = el.type === 'text';
    el.type  = t ? 'password' : 'text';
    this.textContent = t ? '👁' : '🙈';
  });
}
makePwToggle('pt0','currentPassword');
makePwToggle('pt1','newPassword');
makePwToggle('pt2','confirmPassword');

// ── 비밀번호 강도 ──
const newPw = document.getElementById('newPassword');
if (newPw) {
  newPw.addEventListener('input', function () {
    const v = this.value;
    let s = 0;
    if (v.length >= 8) s++;
    if (/[A-Za-z]/.test(v) && /\d/.test(v)) s++;
    if (/[^A-Za-z0-9]/.test(v)) s++;
    const cls = s===1?'weak':s===2?'fair':s===3?'strong':'';
    ['pb1','pb2','pb3'].forEach((id,i)=>{
      const b = document.getElementById(id);
      if(b) b.className = 'pw-bar'+(i<s&&cls?' '+cls:'');
    });
  });
}

// ── 비밀번호 확인 ──
const cfmPw = document.getElementById('confirmPassword');
if (cfmPw) {
  cfmPw.addEventListener('input', function () {
    const pw  = document.getElementById('newPassword').value;
    const msg = document.getElementById('cfmPwMsg');
    if (!this.value) { msg.className='field-msg'; return; }
    if (pw === this.value) { msg.className='field-msg success'; msg.textContent='비밀번호가 일치합니다.'; }
    else                    { msg.className='field-msg error';   msg.textContent='비밀번호가 일치하지 않습니다.'; }
  });
}

// ── 닉네임 중복 체크 ──
let nickTimer;
const nickInput = document.getElementById('nickname');
nickInput.addEventListener('input', function () {
  const v = this.value.trim();
  const msg = document.getElementById('nicknameMsg');
  if (!v || v.length < 2) { msg.className='field-msg'; return; }
  clearTimeout(nickTimer);
  nickTimer = setTimeout(async () => {
    const res  = await fetch(ctx+'/auth/check/nickname?value='+encodeURIComponent(v));
    const data = await res.json();
    if (data.duplicate && v !== '${user.nickname}') {
      msg.className='field-msg error'; msg.textContent='이미 사용 중인 닉네임입니다.';
    } else {
      msg.className='field-msg'; msg.textContent='';
    }
  }, 400);
});

// ── 프로필 저장 ──
document.getElementById('saveProfileBtn').addEventListener('click', async function () {
  const btn = this, msg = document.getElementById('saveProfileMsg');
  btn.classList.add('loading'); btn.disabled = true;
  const res  = await fetch(ctx+'/mypage/edit/profile', {
    method:'POST',
    headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({
      nickname:      document.getElementById('nickname').value.trim(),
      nationality:   document.getElementById('nationality').value,
      preferredLang: document.getElementById('preferredLang').value
    })
  });
  const data = await res.json();
  showMsg(msg, data.success, data.message);
  btn.classList.remove('loading'); btn.disabled = false;
});

// ── 이메일 인증 발송 ──
document.getElementById('sendVerifyBtn').addEventListener('click', async function () {
  const email = document.getElementById('newEmail').value.trim();
  const msg   = document.getElementById('emailMsg');
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    msg.className='field-msg error'; msg.textContent='유효한 이메일 주소를 입력해주세요.'; return;
  }
  msg.className='field-msg';
  this.classList.add('loading'); this.disabled = true;
  const res  = await fetch(ctx+'/mypage/edit/email/send', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({email})
  });
  const data = await res.json();
  msg.className = 'field-msg '+(data.success?'success':'error');
  msg.textContent = data.message;
  this.classList.remove('loading'); this.disabled = false;
  if (data.success) this.textContent = '재발송';
});

// ── 이메일 로그인 토글 ──
const emailToggle = document.getElementById('emailLoginToggle');
if (emailToggle && !emailToggle.disabled) {
  emailToggle.addEventListener('change', async function () {
    const enable = this.checked;
    const msg    = document.getElementById('emailLoginMsg');
    const res    = await fetch(ctx+'/mypage/edit/email/login-toggle', {
      method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
      body: new URLSearchParams({enable})
    });
    const data = await res.json();
    showMsg(msg, data.success, data.message);
    if (!data.success) this.checked = !enable; // 롤백
  });
}

// ── 비밀번호 저장 ──
document.getElementById('savePwBtn').addEventListener('click', async function () {
  const btn       = this;
  const newPwVal  = document.getElementById('newPassword').value;
  const cfmVal    = document.getElementById('confirmPassword').value;
  const msg       = document.getElementById('savePwMsg');
  const curPwEl   = document.getElementById('currentPassword');
  const curPwMsg  = document.getElementById('curPwMsg');

  if (newPwVal.length < 8) {
    const nm = document.getElementById('newPwMsg');
    nm.className='field-msg error'; nm.textContent='비밀번호는 8자 이상이어야 합니다.'; return;
  }
  if (newPwVal !== cfmVal) {
    document.getElementById('cfmPwMsg').className='field-msg error';
    document.getElementById('cfmPwMsg').textContent='비밀번호가 일치하지 않습니다.'; return;
  }

  btn.classList.add('loading'); btn.disabled = true;
  const params = { newPassword: newPwVal };
  if (curPwEl) params.currentPassword = curPwEl.value;

  const res  = await fetch(ctx+'/mypage/edit/password', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams(params)
  });
  const data = await res.json();
  showMsg(msg, data.success, data.message);

  if (data.success) {
    document.getElementById('newPassword').value='';
    document.getElementById('confirmPassword').value='';
    if (curPwEl) curPwEl.value='';
  } else if (data.field === 'currentPassword' && curPwMsg) {
    curPwMsg.className='field-msg error'; curPwMsg.textContent=data.message;
  }
  btn.classList.remove('loading'); btn.disabled=false;
});

// ── 소셜 연동 해제 ──
async function unlinkSocial(provider, btn) {
  if (!confirm(provider + ' 연동을 해제하시겠습니까?')) return;
  btn.disabled = true;
  const res  = await fetch(ctx+'/auth/unlink', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({provider})
  });
  const data = await res.json();
  if (data.success) {
    location.reload();
  } else {
    alert(data.message || '해제에 실패했습니다.');
    btn.disabled = false;
  }
}

// ── 공통 메시지 표시 ──
function showMsg(el, success, text) {
  el.className = 'save-msg show '+(success?'success':'error');
  el.textContent = text;
  setTimeout(() => { el.className='save-msg'; }, 3500);
}
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
