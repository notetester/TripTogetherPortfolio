<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="mypage-wrap">
  <div class="mypage-inner">

    <div class="mypage-header">
      <button class="mypage-back" onclick="location.href='${pageContext.request.contextPath}/mypage'">← 마이페이지</button>
      <h1>회원정보 수정</h1>
      <p>내 계정 정보를 관리하세요</p>
    </div>

    <c:if test="${not empty successMsg}">
      <div style="background:#f0fdf4;border:1px solid #bbf7d0;border-radius:10px;padding:12px 16px;font-size:14px;color:#15803d;margin-bottom:20px;">✅ ${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:10px;padding:12px 16px;font-size:14px;color:#dc2626;margin-bottom:20px;">⚠️ ${errorMsg}</div>
    </c:if>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-profile',this)">
        <div class="edit-card-head-icon">👤</div>
        <div>
          <div class="edit-card-head-title">기본 프로필</div>
          <div class="edit-card-head-sub">닉네임, 국적, 언어 설정</div>
        </div>
        <span class="edit-card-chevron open">▼</span>
      </div>
      <div class="accordion-body open edit-card-body" id="acc-profile">
        <div class="form-group">
          <label class="form-label" for="nickname">닉네임</label>
          <input class="form-input" type="text" id="nickname" value="${user.nickname}" maxlength="20">
          <div class="field-msg" id="nicknameMsg"></div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="nationality">국적</label>
            <select class="form-select" id="nationality">
              <option value="KR" ${user.nationality=='KR'?'selected':''}>🇰🇷 대한민국</option>
              <option value="US" ${user.nationality=='US'?'selected':''}>🇺🇸 미국</option>
              <option value="JP" ${user.nationality=='JP'?'selected':''}>🇯🇵 일본</option>
              <option value="CN" ${user.nationality=='CN'?'selected':''}>🇨🇳 중국</option>
              <option value="GB" ${user.nationality=='GB'?'selected':''}>🇬🇧 영국</option>
              <option value="FR" ${user.nationality=='FR'?'selected':''}>🇫🇷 프랑스</option>
              <option value="DE" ${user.nationality=='DE'?'selected':''}>🇩🇪 독일</option>
              <option value="AU" ${user.nationality=='AU'?'selected':''}>🇦🇺 호주</option>
              <option value="CA" ${user.nationality=='CA'?'selected':''}>🇨🇦 캐나다</option>
              <option value="OTHER" ${user.nationality=='OTHER'?'selected':''}>🌍 기타</option>
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

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-login',this)">
        <div class="edit-card-head-icon">🪪</div>
        <div>
          <div class="edit-card-head-title">로그인 수단 관리</div>
          <div class="edit-card-head-sub">아이디, 이메일 로그인, 비밀번호 정책</div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-login">

        <input type="hidden" id="profileEmailRequestId" value="${profileEmailRequestId}">

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;display:flex;flex-wrap:wrap;gap:8px;">
          <span class="email-status-badge ${hasUsableIdLogin ? 'verified' : 'unverified'}">아이디 로그인 ${hasUsableIdLogin ? '가능' : '없음'}</span>
          <span class="email-status-badge ${hasUsableEmailLogin ? 'verified' : 'unverified'}">이메일 로그인 ${hasUsableEmailLogin ? '가능' : '없음'}</span>
          <span class="email-status-badge ${socialCount gt 0 ? 'verified' : 'unverified'}">소셜 로그인 ${socialCount gt 0 ? '연동 ' : '없음'}${socialCount gt 0 ? socialCount : ''}</span>
        </div>

        <div class="form-group">
          <label class="form-label">아이디</label>
          <c:choose>
            <c:when test="${not empty user.userId}">
              <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:12px 14px;font-weight:600;color:var(--gray-800);">
                ${user.userId}
              </div>
              <div class="field-msg success">아이디는 계정당 한 번만 등록할 수 있으며, 등록 후에는 변경하거나 삭제할 수 없습니다.</div>
            </c:when>
            <c:otherwise>
              <input class="form-input" type="text" id="localUserId" maxlength="30" placeholder="아이디를 등록하면 이후 변경하거나 삭제할 수 없습니다.">
              <div class="field-msg" id="localUserIdMsg">아이디는 계정당 한 번만 등록할 수 있습니다.</div>
            </c:otherwise>
          </c:choose>
        </div>

        <div style="height:1px;background:var(--gray-100);margin:16px 0;"></div>

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;">
          <div style="font-size:13px;font-weight:600;color:var(--gray-600);margin-bottom:4px;">이메일 상태</div>
          <div style="display:flex;align-items:center;flex-wrap:wrap;gap:8px;">
            <span style="font-size:15px;font-weight:600;color:var(--gray-800);" id="currentEmail">
              <c:choose>
                <c:when test="${not empty user.userEmail}">${user.userEmail}</c:when>
                <c:otherwise>등록된 이메일 없음</c:otherwise>
              </c:choose>
            </span>
            <span class="email-status-badge ${user.emailVerified ? 'verified' : 'unverified'}" id="emailStatusBadge">
              <c:choose>
                <c:when test="${user.emailVerified}">✓ 인증됨</c:when>
                <c:otherwise>⚠ 미인증</c:otherwise>
              </c:choose>
            </span>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="newEmail">이메일 변경 또는 등록</label>
          <div style="display:flex;gap:8px;">
            <input class="form-input" type="email" id="newEmail" placeholder="새 이메일 주소" style="flex:1;" value="${user.userEmail}">
            <button class="btn-save" id="sendVerifyBtn" style="white-space:nowrap;padding:10px 16px;">인증 발송</button>
          </div>
          <div class="field-msg" id="emailMsg"></div>
          <div class="field-msg">이메일은 미인증 상태로도 저장할 수 있습니다. 인증은 별도로 진행되며, 이메일 로그인을 사용하려면 인증이 완료되어야 합니다. 이메일을 제거하려면 입력창을 비운 뒤 저장해 주세요.</div>
        </div>

        <div class="toggle-wrap">
          <div>
            <div class="toggle-label">이메일 로그인 사용</div>
            <div class="toggle-sub" id="emailLoginSub">
              <c:choose>
                <c:when test="${user.emailLoginEnabled}">현재 이메일 로그인 사용 중입니다.</c:when>
                <c:when test="${user.emailVerified and user.passwordEnabled}">저장하면 이메일 로그인을 사용할 수 있습니다.</c:when>
                <c:when test="${user.emailVerified and not user.passwordEnabled}">저장 시 비밀번호를 함께 설정해야 이메일 로그인을 사용할 수 있습니다.</c:when>
                <c:otherwise>이메일 인증 여부는 체크 시점에 다시 확인합니다. 인증 완료 후 저장해야 최종 반영됩니다.</c:otherwise>
              </c:choose>
            </div>
          </div>
          <label class="toggle-switch">
            <input type="checkbox" id="emailLoginToggle" ${user.emailLoginEnabled ? 'checked' : ''}>
            <span class="toggle-slider"></span>
          </label>
        </div>
        <div class="save-msg" id="emailLoginMsg" style="display:block;margin-top:8px;"></div>

        <div id="localPasswordBox" style="display:none;margin-top:16px;padding:16px;border:1px dashed var(--gray-200);border-radius:12px;background:var(--gray-50);">
          <div style="font-size:14px;font-weight:700;color:var(--gray-800);margin-bottom:12px;">로컬 로그인 비밀번호 설정</div>
          <div class="form-group">
            <label class="form-label" for="loginNewPassword">비밀번호</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginNewPassword" placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="64">
              <button type="button" class="pw-toggle" id="pt3">👁</button>
            </div>
            <div class="field-msg" id="loginNewPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="loginConfirmPassword">비밀번호 확인</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginConfirmPassword" placeholder="비밀번호 재입력" maxlength="64">
              <button type="button" class="pw-toggle" id="pt4">👁</button>
            </div>
            <div class="field-msg" id="loginCfmPwMsg"></div>
          </div>
          <div class="field-msg success" style="margin-top:4px;">아이디 로그인 또는 이메일 로그인을 처음 사용할 때만 비밀번호를 함께 설정합니다.</div>
        </div>

        <div style="display:flex;align-items:center;gap:12px;margin-top:16px;">
          <button class="btn-save" id="saveLoginSettingsBtn">로그인 수단 저장</button>
          <span class="save-msg" id="saveLoginSettingsMsg"></span>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          ⚠️ 계정은 언제나 실제로 로그인 가능한 수단을 하나 이상 유지해야 합니다. 이메일 로그인만 사용 중인 상태에서 해제하면 비밀번호도 함께 해제될 수 있습니다.
        </div>
      </div>
    </div>

    <c:if test="${user.passwordEnabled}">
      <div class="edit-card">
        <div class="edit-card-head" onclick="toggleAcc('acc-pw',this)">
          <div class="edit-card-head-icon">🔒</div>
          <div>
            <div class="edit-card-head-title">비밀번호 변경</div>
            <div class="edit-card-head-sub">현재 비밀번호 확인 후 새 비밀번호를 변경합니다</div>
          </div>
          <span class="edit-card-chevron">▼</span>
        </div>
        <div class="accordion-body edit-card-body" id="acc-pw">
          <div class="form-group">
            <label class="form-label" for="currentPassword">현재 비밀번호</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="currentPassword" placeholder="현재 비밀번호 입력">
              <button type="button" class="pw-toggle" id="pt0">👁</button>
            </div>
            <div class="field-msg" id="curPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="newPassword">새 비밀번호</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="newPassword" placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="64">
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
              <input class="form-input" type="password" id="confirmPassword" placeholder="비밀번호 재입력" maxlength="64">
              <button type="button" class="pw-toggle" id="pt2">👁</button>
            </div>
            <div class="field-msg" id="cfmPwMsg"></div>
          </div>
          <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
            <button class="btn-save" id="savePwBtn">비밀번호 변경</button>
            <span class="save-msg" id="savePwMsg"></span>
          </div>
        </div>
      </div>
    </c:if>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-social',this)">
        <div class="edit-card-head-icon">🔗</div>
        <div>
          <div class="edit-card-head-title">소셜 계정 연동</div>
          <div class="edit-card-head-sub">카카오, 네이버, 구글 계정 연결 관리</div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-social">

        <div class="social-link-item">
          <div class="social-link-icon KAKAO"><span class="kakao-mark-box">k</span></div>
          <div class="social-link-info">
            <div class="social-link-name">카카오</div>
            <div class="social-link-status ${socialLinkMap['KAKAO'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['KAKAO']}">● 연동됨</c:when><c:otherwise>○ 연동되지 않음</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['KAKAO']}"><button class="btn-social-action unlink" onclick="unlinkSocial('KAKAO', this)">연동 해제</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/kakao'">연동하기</button></c:otherwise>
          </c:choose>
        </div>

        <div class="social-link-item">
          <div class="social-link-icon NAVER"><span class="naver-mark-box">N</span></div>
          <div class="social-link-info">
            <div class="social-link-name">네이버</div>
            <div class="social-link-status ${socialLinkMap['NAVER'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['NAVER']}">● 연동됨</c:when><c:otherwise>○ 연동되지 않음</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['NAVER']}"><button class="btn-social-action unlink" onclick="unlinkSocial('NAVER', this)">연동 해제</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/naver'">연동하기</button></c:otherwise>
          </c:choose>
        </div>

        <div class="social-link-item">
          <div class="social-link-icon GOOGLE"><span class="google-mark-box">
            <svg width="18" height="18" viewBox="0 0 48 48">
              <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
              <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
              <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
              <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
            </svg>
          </span></div>
          <div class="social-link-info">
            <div class="social-link-name">Google</div>
            <div class="social-link-status ${socialLinkMap['GOOGLE'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['GOOGLE']}">● 연동됨</c:when><c:otherwise>○ 연동되지 않음</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['GOOGLE']}"><button class="btn-social-action unlink" onclick="unlinkSocial('GOOGLE', this)">연동 해제</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/google'">연동하기</button></c:otherwise>
          </c:choose>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          ⚠️ 소셜 연동은 해제 후에도 다른 로그인 수단이 하나 이상 남아 있는 경우에만 해제할 수 있습니다.
        </div>
      </div>
    </div>

    <div style="text-align:center;margin-top:8px;">
      <form action="${pageContext.request.contextPath}/mypage/edit/done" method="post">
        <button type="submit" class="btn-save" style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;padding:12px 32px;font-size:15px;">✅ 수정 완료</button>
      </form>
    </div>

  </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const hasPasswordEnabled = ${user.passwordEnabled ? 'true' : 'false'};
const hasFixedUserId = ${not empty user.userId ? 'true' : 'false'};
const originalEmail = '${user.userEmail != null ? user.userEmail : ''}';
const originalEmailVerified = ${user.emailVerified ? 'true' : 'false'};

function toggleAcc(id, head) {
  const body = document.getElementById(id);
  const chev = head.querySelector('.edit-card-chevron');
  const isOpen = body.classList.contains('open');
  body.classList.toggle('open', !isOpen);
  chev.classList.toggle('open', !isOpen);
}

function makePwToggle(btnId, inputId) {
  const btn = document.getElementById(btnId);
  if (!btn) return;
  btn.addEventListener('click', function () {
    const el = document.getElementById(inputId);
    const t = el.type === 'text';
    el.type = t ? 'password' : 'text';
    this.textContent = t ? '👁' : '🙈';
  });
}
makePwToggle('pt0','currentPassword');
makePwToggle('pt1','newPassword');
makePwToggle('pt2','confirmPassword');
makePwToggle('pt3','loginNewPassword');
makePwToggle('pt4','loginConfirmPassword');

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
      if (b) b.className = 'pw-bar' + (i < s && cls ? ' ' + cls : '');
    });
  });
}

const cfmPw = document.getElementById('confirmPassword');
if (cfmPw) {
  cfmPw.addEventListener('input', function () {
    const pw = document.getElementById('newPassword').value;
    const msg = document.getElementById('cfmPwMsg');
    if (!this.value) { msg.className='field-msg'; msg.textContent=''; return; }
    if (pw === this.value) { msg.className='field-msg success'; msg.textContent='비밀번호가 일치합니다.'; }
    else { msg.className='field-msg error'; msg.textContent='비밀번호가 일치하지 않습니다.'; }
  });
}

function updateLocalPasswordBox() {
  const box = document.getElementById('localPasswordBox');
  if (!box) return;
  const wantId = !hasFixedUserId && document.getElementById('localUserId') && document.getElementById('localUserId').value.trim().length > 0;
  const wantEmailLogin = document.getElementById('emailLoginToggle').checked;
  box.style.display = (!hasPasswordEnabled && (wantId || wantEmailLogin)) ? 'block' : 'none';
}

const loginNewPw = document.getElementById('loginNewPassword');
const loginCfmPw = document.getElementById('loginConfirmPassword');
if (loginCfmPw) {
  loginCfmPw.addEventListener('input', function () {
    const msg = document.getElementById('loginCfmPwMsg');
    if (!this.value) { msg.className='field-msg'; msg.textContent=''; return; }
    if (loginNewPw.value === this.value) { msg.className='field-msg success'; msg.textContent='비밀번호가 일치합니다.'; }
    else { msg.className='field-msg error'; msg.textContent='비밀번호가 일치하지 않습니다.'; }
  });
}

const localUserIdInput = document.getElementById('localUserId');
if (localUserIdInput) {
  localUserIdInput.addEventListener('input', updateLocalPasswordBox);
}

let nickTimer;
const nickInput = document.getElementById('nickname');
if (nickInput) {
  nickInput.addEventListener('input', function () {
    const v = this.value.trim();
    const msg = document.getElementById('nicknameMsg');
    if (!v || v.length < 2) { msg.className='field-msg'; msg.textContent=''; return; }
    clearTimeout(nickTimer);
    nickTimer = setTimeout(async () => {
      const res = await fetch(ctx + '/auth/check/nickname?value=' + encodeURIComponent(v));
      const data = await res.json();
      if (data.duplicate && v !== '${user.nickname}') {
        msg.className='field-msg error'; msg.textContent='이미 사용 중인 닉네임입니다.';
      } else {
        msg.className='field-msg'; msg.textContent='';
      }
    }, 400);
  });
}

document.getElementById('saveProfileBtn').addEventListener('click', async function () {
  const btn = this, msg = document.getElementById('saveProfileMsg');
  btn.classList.add('loading'); btn.disabled = true;
  const res = await fetch(ctx + '/mypage/edit/profile', {
    method:'POST',
    headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({
      nickname: document.getElementById('nickname').value.trim(),
      nationality: document.getElementById('nationality').value,
      preferredLang: document.getElementById('preferredLang').value
    })
  });
  const data = await res.json();
  showMsg(msg, data.success, data.message);
  btn.classList.remove('loading'); btn.disabled = false;
});

async function refreshEmailVerificationState(emailInputValue) {
  const badge = document.getElementById('emailStatusBadge');
  const sub = document.getElementById('emailLoginSub');
  const currentEmailEl = document.getElementById('currentEmail');
  if (currentEmailEl) {
    if (emailInputValue && emailInputValue !== originalEmail) {
      currentEmailEl.textContent = emailInputValue + ' (저장 전)';
    } else {
      currentEmailEl.textContent = originalEmail || '등록된 이메일 없음';
    }
  }
  if (!emailInputValue) {
    if (badge) {
      badge.className = 'email-status-badge unverified';
      badge.textContent = '⚠ 미인증';
    }
    if (sub) sub.textContent = '이메일을 입력한 뒤 인증을 진행해 주세요.';
    return {success:false, emailVerified:false, pendingVerified:false};
  }

  const res = await fetch(ctx + '/mypage/edit/email/status', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({email: emailInputValue})
  });
  const data = await res.json();
  if (badge) {
    if (data.emailVerified) {
      badge.className = 'email-status-badge verified';
      badge.textContent = data.pendingVerified ? '✓ 인증 완료(저장 대기)' : '✓ 인증됨';
    } else {
      badge.className = 'email-status-badge unverified';
      badge.textContent = '⚠ 미인증';
    }
  }
  if (sub) {
    if (data.emailVerified) {
      sub.textContent = data.requiresPassword
        ? '저장 시 비밀번호를 함께 설정해야 이메일 로그인을 사용할 수 있습니다.'
        : '저장하면 이메일 로그인을 활성화할 수 있습니다.';
    } else {
      sub.textContent = '이메일 인증 여부는 체크 시점에 다시 확인합니다. 인증 완료 후 저장해야 최종 반영됩니다.';
    }
  }
  return data;
}

document.getElementById('sendVerifyBtn').addEventListener('click', async function () {
  const email = document.getElementById('newEmail').value.trim();
  const msg = document.getElementById('emailMsg');
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    msg.className='field-msg error'; msg.textContent='유효한 이메일 주소를 입력해 주세요.'; return;
  }
  this.classList.add('loading'); this.disabled = true;
  const res = await fetch(ctx + '/mypage/edit/email/send', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({email})
  });
  const data = await res.json();
  msg.className = 'field-msg ' + (data.success ? 'success' : 'error');
  msg.textContent = data.message;
  this.classList.remove('loading'); this.disabled = false;
  if (data.success) {
    this.textContent = '재발송';
    await refreshEmailVerificationState(email);
  }
});

const emailToggle = document.getElementById('emailLoginToggle');
if (emailToggle) {
  emailToggle.addEventListener('change', async function () {
    const msg = document.getElementById('emailLoginMsg');
    const emailInputValue = document.getElementById('newEmail').value.trim();
    if (!this.checked) {
      const hasOnlyEmailLocal = !hasFixedUserId && hasPasswordEnabled && originalEmailVerified;
      const sub = document.getElementById('emailLoginSub');
      sub.textContent = hasOnlyEmailLocal
        ? '저장 시 이메일 로그인을 해제하면 비밀번호도 함께 해제될 수 있습니다.'
        : '저장 시 이메일 로그인이 해제됩니다.';
      updateLocalPasswordBox();
      return;
    }

    const data = await refreshEmailVerificationState(emailInputValue);
    showMsg(msg, data.success, data.message || '이메일 인증 상태를 확인했습니다.');
    if (!data.success) {
      this.checked = false;
      updateLocalPasswordBox();
      return;
    }
    updateLocalPasswordBox();
  });
}
updateLocalPasswordBox();
refreshEmailVerificationState(document.getElementById('newEmail').value.trim()).catch(() => {});

document.getElementById('saveLoginSettingsBtn').addEventListener('click', async function () {
  const btn = this;
  const msg = document.getElementById('saveLoginSettingsMsg');
  const userIdInput = document.getElementById('localUserId');
  const userId = userIdInput ? userIdInput.value.trim() : '';
  const emailValue = document.getElementById('newEmail').value.trim();
  const enableEmailLogin = document.getElementById('emailLoginToggle').checked;
  const passwordBoxVisible = document.getElementById('localPasswordBox').style.display !== 'none';
  const pw = loginNewPw ? loginNewPw.value : '';
  const pw2 = loginCfmPw ? loginCfmPw.value : '';

  if (enableEmailLogin && !emailValue) {
    showMsg(msg, false, '이메일을 삭제하려면 이메일 로그인 사용을 함께 해제한 뒤 저장해 주세요.');
    return;
  }

  if (passwordBoxVisible) {
    if (pw.length < 8) {
      document.getElementById('loginNewPwMsg').className='field-msg error';
      document.getElementById('loginNewPwMsg').textContent='비밀번호는 8자 이상으로 설정해 주세요.';
      return;
    }
    if (pw !== pw2) {
      document.getElementById('loginCfmPwMsg').className='field-msg error';
      document.getElementById('loginCfmPwMsg').textContent='비밀번호가 일치하지 않습니다.';
      return;
    }
  }

  btn.classList.add('loading'); btn.disabled = true;
  const res = await fetch(ctx + '/mypage/edit/login-settings', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({
      userId,
      email: emailValue,
      emailLoginEnabled: enableEmailLogin,
      newPassword: passwordBoxVisible ? pw : ''
    })
  });
  const data = await res.json();
  showMsg(msg, data.success, data.message);
  btn.classList.remove('loading'); btn.disabled = false;

  if (data.success) {
    setTimeout(() => location.reload(), 800);
  }
});

const savePwBtn = document.getElementById('savePwBtn');
if (savePwBtn) {
  savePwBtn.addEventListener('click', async function () {
    const btn = this;
    const newPwVal = document.getElementById('newPassword').value;
    const cfmVal = document.getElementById('confirmPassword').value;
    const msg = document.getElementById('savePwMsg');
    const curPwEl = document.getElementById('currentPassword');
    const curPwMsg = document.getElementById('curPwMsg');

    if (newPwVal.length < 8) {
      const nm = document.getElementById('newPwMsg');
      nm.className='field-msg error'; nm.textContent='비밀번호는 8자 이상이어야 합니다.'; return;
    }
    if (newPwVal !== cfmVal) {
      document.getElementById('cfmPwMsg').className='field-msg error';
      document.getElementById('cfmPwMsg').textContent='비밀번호가 일치하지 않습니다.'; return;
    }

    btn.classList.add('loading'); btn.disabled = true;
    const res = await fetch(ctx + '/mypage/edit/password', {
      method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
      body: new URLSearchParams({ currentPassword: curPwEl.value, newPassword: newPwVal })
    });
    const data = await res.json();
    showMsg(msg, data.success, data.message);

    if (data.success) {
      document.getElementById('newPassword').value='';
      document.getElementById('confirmPassword').value='';
      curPwEl.value='';
    } else if (data.field === 'currentPassword' && curPwMsg) {
      curPwMsg.className='field-msg error'; curPwMsg.textContent=data.message;
    }
    btn.classList.remove('loading'); btn.disabled=false;
  });
}

async function unlinkSocial(provider, btn) {
  if (!confirm(provider + ' 연동을 해제하시겠습니까?')) return;
  btn.disabled = true;
  const res = await fetch(ctx + '/auth/unlink', {
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

function showMsg(el, success, text) {
  el.className = 'save-msg show ' + (success ? 'success' : 'error');
  el.textContent = text;
  setTimeout(() => { el.className='save-msg'; }, 3500);
}
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
