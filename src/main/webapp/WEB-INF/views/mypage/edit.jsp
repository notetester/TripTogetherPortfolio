<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="mypage-wrap">
  <div class="mypage-inner">

    <div class="mypage-header">
      <button class="mypage-back" onclick="location.href='${pageContext.request.contextPath}/mypage'"><spring:message code="mypage.edit.back"/></button>
      <h1><spring:message code="mypage.edit.title"/></h1>
      <p><spring:message code="mypage.edit.subtitle"/></p>
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
          <div class="edit-card-head-title"><spring:message code="mypage.edit.profile.title"/></div>
          <div class="edit-card-head-sub"><spring:message code="mypage.edit.profile.subtitle"/></div>
        </div>
        <span class="edit-card-chevron open">▼</span>
      </div>
      <div class="accordion-body open edit-card-body" id="acc-profile">
        <div class="form-group">
          <label class="form-label" for="nickname"><spring:message code="mypage.nickname"/></label>
          <input class="form-input" type="text" id="nickname" value="${user.nickname}" maxlength="20">
          <div class="field-msg" id="nicknameMsg"></div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="nationality"><spring:message code="mypage.nationality"/></label>
            <select class="form-select" id="nationality">
              <option value="KR" ${user.nationality=='KR'?'selected':''}>🇰🇷 <spring:message code="mypage.country.kr"/></option>
              <option value="US" ${user.nationality=='US'?'selected':''}>🇺🇸 <spring:message code="mypage.country.us"/></option>
              <option value="JP" ${user.nationality=='JP'?'selected':''}>🇯🇵 <spring:message code="mypage.country.jp"/></option>
              <option value="CN" ${user.nationality=='CN'?'selected':''}>🇨🇳 <spring:message code="mypage.country.cn"/></option>
              <option value="GB" ${user.nationality=='GB'?'selected':''}>🇬🇧 <spring:message code="mypage.country.gb"/></option>
              <option value="FR" ${user.nationality=='FR'?'selected':''}>🇫🇷 <spring:message code="mypage.country.fr"/></option>
              <option value="DE" ${user.nationality=='DE'?'selected':''}>🇩🇪 <spring:message code="mypage.country.de"/></option>
              <option value="AU" ${user.nationality=='AU'?'selected':''}>🇦🇺 <spring:message code="mypage.country.au"/></option>
              <option value="CA" ${user.nationality=='CA'?'selected':''}>🇨🇦 <spring:message code="mypage.country.ca"/></option>
              <option value="OTHER" ${user.nationality=='OTHER'?'selected':''}>🌍 <spring:message code="mypage.country.other"/></option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label" for="preferredLang"><spring:message code="mypage.language"/></label>
            <select class="form-select" id="preferredLang">
              <option value="ko" ${user.preferredLang=='ko'?'selected':''}>🇰🇷 <spring:message code="mypage.lang.ko"/></option>
              <option value="en" ${user.preferredLang=='en'?'selected':''}>🇺🇸 <spring:message code="mypage.lang.en"/></option>
              <option value="ja" ${user.preferredLang=='ja'?'selected':''}>🇯🇵 <spring:message code="mypage.lang.ja"/></option>
              <option value="zh" ${user.preferredLang=='zh'?'selected':''}>🇨🇳 <spring:message code="mypage.lang.zh"/></option>
            </select>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
          <button class="btn-save" id="saveProfileBtn"><spring:message code="mypage.save"/></button>
          <span class="save-msg" id="saveProfileMsg"></span>
        </div>
      </div>
    </div>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-login',this)">
        <div class="edit-card-head-icon">🪪</div>
        <div>
          <div class="edit-card-head-title"><spring:message code="mypage.edit.login.title"/></div>
          <div class="edit-card-head-sub"><spring:message code="mypage.edit.login.subtitle"/></div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-login">

        <input type="hidden" id="profileEmailRequestId" value="${profileEmailRequestId}">

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;display:flex;flex-wrap:wrap;gap:8px;">
          <span class="email-status-badge ${hasUsableIdLogin ? 'verified' : 'unverified'}"><spring:message code="mypage.edit.idLogin"/> <c:choose><c:when test="${hasUsableIdLogin}"><spring:message code="mypage.available"/></c:when><c:otherwise><spring:message code="mypage.none"/></c:otherwise></c:choose></span>
          <span class="email-status-badge ${hasUsableEmailLogin ? 'verified' : 'unverified'}"><spring:message code="mypage.edit.emailLogin"/> <c:choose><c:when test="${hasUsableEmailLogin}"><spring:message code="mypage.available"/></c:when><c:otherwise><spring:message code="mypage.none"/></c:otherwise></c:choose></span>
          <span class="email-status-badge ${socialCount gt 0 ? 'verified' : 'unverified'}"><spring:message code="mypage.edit.socialLogin"/> <c:choose><c:when test="${socialCount gt 0}"><spring:message code="mypage.social.linkedCount" arguments="${socialCount}"/></c:when><c:otherwise><spring:message code="mypage.none"/></c:otherwise></c:choose></span>
        </div>

        <div class="form-group">
          <label class="form-label"><spring:message code="mypage.profile.userId"/></label>
          <c:choose>
            <c:when test="${not empty user.userId}">
              <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:12px 14px;font-weight:600;color:var(--gray-800);">
                ${user.userId}
              </div>
              <div class="field-msg success"><spring:message code="mypage.userId.once"/></div>
            </c:when>
            <c:otherwise>
              <input class="form-input" type="text" id="localUserId" maxlength="30" placeholder="<spring:message code='mypage.userId.placeholder'/>">
              <div class="field-msg" id="localUserIdMsg"><spring:message code="mypage.userId.help"/></div>
            </c:otherwise>
          </c:choose>
        </div>

        <div style="height:1px;background:var(--gray-100);margin:16px 0;"></div>

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;">
          <div style="font-size:13px;font-weight:600;color:var(--gray-600);margin-bottom:4px;"><spring:message code="mypage.email.state"/></div>
          <div style="display:flex;align-items:center;flex-wrap:wrap;gap:8px;">
            <span style="font-size:15px;font-weight:600;color:var(--gray-800);" id="currentEmail">
              <c:choose>
                <c:when test="${not empty user.userEmail}">${user.userEmail}</c:when>
                <c:otherwise><spring:message code="mypage.email.none"/></c:otherwise>
              </c:choose>
            </span>
            <span class="email-status-badge ${user.emailVerified ? 'verified' : 'unverified'}" id="emailStatusBadge">
              <c:choose>
                <c:when test="${user.emailVerified}"><spring:message code="mypage.email.verified"/></c:when>
                <c:otherwise><spring:message code="mypage.email.unverified"/></c:otherwise>
              </c:choose>
            </span>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="newEmail"><spring:message code="mypage.email.change"/></label>
          <div style="display:flex;gap:8px;">
            <input class="form-input" type="email" id="newEmail" placeholder="<spring:message code='mypage.email.new'/>" style="flex:1;" value="${user.userEmail}">
            <button class="btn-save" id="sendVerifyBtn" style="white-space:nowrap;padding:10px 16px;"><spring:message code="mypage.email.send"/></button>
          </div>
          <div class="field-msg" id="emailMsg"></div>
          <div class="field-msg"><spring:message code="mypage.email.help"/></div>
        </div>

        <div class="toggle-wrap">
          <div>
            <div class="toggle-label"><spring:message code="mypage.email.use"/></div>
            <div class="toggle-sub" id="emailLoginSub">
              <c:choose>
                <c:when test="${user.emailLoginEnabled}"><spring:message code="mypage.email.use.current"/></c:when>
                <c:when test="${user.emailVerified and user.passwordEnabled}"><spring:message code="mypage.email.use.enable"/></c:when>
                <c:when test="${user.emailVerified and not user.passwordEnabled}"><spring:message code="mypage.email.use.needPassword"/></c:when>
                <c:otherwise><spring:message code="mypage.email.use.check"/></c:otherwise>
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
          <div style="font-size:14px;font-weight:700;color:var(--gray-800);margin-bottom:12px;"><spring:message code="mypage.localPassword"/></div>
          <div class="form-group">
            <label class="form-label" for="loginNewPassword"><spring:message code="mypage.password"/></label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginNewPassword" placeholder="<spring:message code='mypage.password.placeholder'/>" maxlength="64">
              <button type="button" class="pw-toggle" id="pt3">👁</button>
            </div>
            <div class="field-msg" id="loginNewPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="loginConfirmPassword"><spring:message code="mypage.password.confirm"/></label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginConfirmPassword" placeholder="<spring:message code='mypage.password.confirm.placeholder'/>" maxlength="64">
              <button type="button" class="pw-toggle" id="pt4">👁</button>
            </div>
            <div class="field-msg" id="loginCfmPwMsg"></div>
          </div>
          <div class="field-msg success" style="margin-top:4px;"><spring:message code="mypage.password.firstTime"/></div>
        </div>

        <div style="display:flex;align-items:center;gap:12px;margin-top:16px;">
          <button class="btn-save" id="saveLoginSettingsBtn"><spring:message code="mypage.loginSave"/></button>
          <span class="save-msg" id="saveLoginSettingsMsg"></span>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          <spring:message code="mypage.loginWarn"/>
        </div>
      </div>
    </div>

    <c:if test="${user.passwordEnabled}">
      <div class="edit-card">
        <div class="edit-card-head" onclick="toggleAcc('acc-pw',this)">
          <div class="edit-card-head-icon">🔒</div>
          <div>
            <div class="edit-card-head-title"><spring:message code="mypage.passwordChange"/></div>
            <div class="edit-card-head-sub"><spring:message code="mypage.passwordChange.subtitle"/></div>
          </div>
          <span class="edit-card-chevron">▼</span>
        </div>
        <div class="accordion-body edit-card-body" id="acc-pw">
          <div class="form-group">
            <label class="form-label" for="currentPassword"><spring:message code="mypage.password.current"/></label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="currentPassword" placeholder="<spring:message code='mypage.password.current.placeholder'/>">
              <button type="button" class="pw-toggle" id="pt0">👁</button>
            </div>
            <div class="field-msg" id="curPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="newPassword"><spring:message code="mypage.password.new"/></label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="newPassword" placeholder="<spring:message code='mypage.password.placeholder'/>" maxlength="64">
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
            <label class="form-label" for="confirmPassword"><spring:message code="mypage.password.confirm"/></label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="confirmPassword" placeholder="<spring:message code='mypage.password.confirm.placeholder'/>" maxlength="64">
              <button type="button" class="pw-toggle" id="pt2">👁</button>
            </div>
            <div class="field-msg" id="cfmPwMsg"></div>
          </div>
          <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
            <button class="btn-save" id="savePwBtn"><spring:message code="mypage.passwordChange"/></button>
            <span class="save-msg" id="savePwMsg"></span>
          </div>
        </div>
      </div>
    </c:if>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-social',this)">
        <div class="edit-card-head-icon">🔗</div>
        <div>
          <div class="edit-card-head-title"><spring:message code="mypage.social.title"/></div>
          <div class="edit-card-head-sub"><spring:message code="mypage.social.subtitle"/></div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-social">

        <div class="social-link-item">
          <div class="social-link-icon KAKAO"><span class="kakao-mark-box">k</span></div>
          <div class="social-link-info">
            <div class="social-link-name"><spring:message code="mypage.social.kakao"/></div>
            <div class="social-link-status ${socialLinkMap['KAKAO'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['KAKAO']}"><spring:message code="mypage.social.status.linked"/></c:when><c:otherwise><spring:message code="mypage.social.status.unlinked"/></c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['KAKAO']}"><button class="btn-social-action unlink" onclick="unlinkSocial('KAKAO', this)"><spring:message code="mypage.social.unlink"/></button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/kakao'"><spring:message code="mypage.social.link"/></button></c:otherwise>
          </c:choose>
        </div>

        <div class="social-link-item">
          <div class="social-link-icon NAVER"><span class="naver-mark-box">N</span></div>
          <div class="social-link-info">
            <div class="social-link-name"><spring:message code="mypage.social.naver"/></div>
            <div class="social-link-status ${socialLinkMap['NAVER'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['NAVER']}"><spring:message code="mypage.social.status.linked"/></c:when><c:otherwise><spring:message code="mypage.social.status.unlinked"/></c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['NAVER']}"><button class="btn-social-action unlink" onclick="unlinkSocial('NAVER', this)"><spring:message code="mypage.social.unlink"/></button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/naver'"><spring:message code="mypage.social.link"/></button></c:otherwise>
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
            <div class="social-link-name"><spring:message code="mypage.social.google"/></div>
            <div class="social-link-status ${socialLinkMap['GOOGLE'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['GOOGLE']}"><spring:message code="mypage.social.status.linked"/></c:when><c:otherwise><spring:message code="mypage.social.status.unlinked"/></c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['GOOGLE']}"><button class="btn-social-action unlink" onclick="unlinkSocial('GOOGLE', this)"><spring:message code="mypage.social.unlink"/></button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/google'"><spring:message code="mypage.social.link"/></button></c:otherwise>
          </c:choose>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          <spring:message code="mypage.social.warn"/>
        </div>
      </div>
    </div>

    <div style="text-align:center;margin-top:8px;">
      <form action="${pageContext.request.contextPath}/mypage/edit/done" method="post">
        <button type="submit" class="btn-save" style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;padding:12px 32px;font-size:15px;">✅ <spring:message code="mypage.edit.done"/></button>
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
const editMessages = {
  emailNone: '<spring:message code="mypage.email.none" javaScriptEscape="true"/>',
  emailPendingSuffix: '<spring:message code="mypage.email.pendingSuffix" javaScriptEscape="true"/>',
  emailEnterAndVerify: '<spring:message code="mypage.email.enterAndVerify" javaScriptEscape="true"/>',
  emailUnverified: '<spring:message code="mypage.email.unverified" javaScriptEscape="true"/>',
  emailVerified: '<spring:message code="mypage.email.verified" javaScriptEscape="true"/>',
  emailVerifiedPending: '<spring:message code="mypage.email.verifiedPending" javaScriptEscape="true"/>',
  emailUseNeedPassword: '<spring:message code="mypage.email.use.needPassword" javaScriptEscape="true"/>',
  emailUseEnable: '<spring:message code="mypage.email.use.enable" javaScriptEscape="true"/>',
  emailUseCheck: '<spring:message code="mypage.email.use.check" javaScriptEscape="true"/>',
  emailValidRequired: '<spring:message code="mypage.email.validRequired" javaScriptEscape="true"/>',
  emailResend: '<spring:message code="mypage.email.resend" javaScriptEscape="true"/>',
  emailUseDisableWithPassword: '<spring:message code="mypage.email.use.disableWithPassword" javaScriptEscape="true"/>',
  emailUseDisable: '<spring:message code="mypage.email.use.disable" javaScriptEscape="true"/>',
  emailStatusChecked: '<spring:message code="mypage.email.statusChecked" javaScriptEscape="true"/>',
  emailRemoveWithDisable: '<spring:message code="mypage.email.removeWithDisable" javaScriptEscape="true"/>',
  nicknameDuplicate: '<spring:message code="mypage.edit.nicknameDuplicate" javaScriptEscape="true"/>',
  passwordMatch: '<spring:message code="mypage.edit.passwordMatch" javaScriptEscape="true"/>',
  passwordMismatch: '<spring:message code="mypage.edit.passwordMismatch" javaScriptEscape="true"/>',
  passwordMinSet: '<spring:message code="mypage.password.minSet" javaScriptEscape="true"/>',
  passwordMinLength: '<spring:message code="mypage.password.minLength" javaScriptEscape="true"/>',
  socialUnlinkConfirm: '<spring:message code="mypage.social.unlinkConfirm" javaScriptEscape="true"/>',
  socialUnlinkFail: '<spring:message code="mypage.social.unlinkFail" javaScriptEscape="true"/>',
  providerKakao: '<spring:message code="mypage.social.kakao" javaScriptEscape="true"/>',
  providerNaver: '<spring:message code="mypage.social.naver" javaScriptEscape="true"/>',
  providerGoogle: '<spring:message code="mypage.social.google" javaScriptEscape="true"/>'
};

function formatMessage(template) {
  const args = Array.prototype.slice.call(arguments, 1);
  return String(template || '').replace(/\{(\d+)\}/g, function (_, index) {
    return typeof args[index] !== 'undefined' ? args[index] : '';
  });
}

function getProviderLabel(provider) {
  switch (provider) {
    case 'KAKAO': return editMessages.providerKakao;
    case 'NAVER': return editMessages.providerNaver;
    case 'GOOGLE': return editMessages.providerGoogle;
    default: return provider;
  }
}

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
    if (pw === this.value) { msg.className='field-msg success'; msg.textContent=editMessages.passwordMatch; }
    else { msg.className='field-msg error'; msg.textContent=editMessages.passwordMismatch; }
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
    if (loginNewPw.value === this.value) { msg.className='field-msg success'; msg.textContent=editMessages.passwordMatch; }
    else { msg.className='field-msg error'; msg.textContent=editMessages.passwordMismatch; }
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
        msg.className='field-msg error'; msg.textContent=editMessages.nicknameDuplicate;
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
      currentEmailEl.textContent = emailInputValue + ' ' + editMessages.emailPendingSuffix;
    } else {
      currentEmailEl.textContent = originalEmail || editMessages.emailNone;
    }
  }
  if (!emailInputValue) {
    if (badge) {
      badge.className = 'email-status-badge unverified';
      badge.textContent = editMessages.emailUnverified;
    }
    if (sub) sub.textContent = editMessages.emailEnterAndVerify;
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
      badge.textContent = data.pendingVerified ? editMessages.emailVerifiedPending : editMessages.emailVerified;
    } else {
      badge.className = 'email-status-badge unverified';
      badge.textContent = editMessages.emailUnverified;
    }
  }
  if (sub) {
    if (data.emailVerified) {
      sub.textContent = data.requiresPassword
        ? editMessages.emailUseNeedPassword
        : editMessages.emailUseEnable;
    } else {
      sub.textContent = editMessages.emailUseCheck;
    }
  }
  return data;
}

document.getElementById('sendVerifyBtn').addEventListener('click', async function () {
  const email = document.getElementById('newEmail').value.trim();
  const msg = document.getElementById('emailMsg');
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    msg.className='field-msg error'; msg.textContent=editMessages.emailValidRequired; return;
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
    this.textContent = editMessages.emailResend;
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
        ? editMessages.emailUseDisableWithPassword
        : editMessages.emailUseDisable;
      updateLocalPasswordBox();
      return;
    }

    const data = await refreshEmailVerificationState(emailInputValue);
    showMsg(msg, data.success, data.message || editMessages.emailStatusChecked);
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
    showMsg(msg, false, editMessages.emailRemoveWithDisable);
    return;
  }

  if (passwordBoxVisible) {
    if (pw.length < 8) {
      document.getElementById('loginNewPwMsg').className='field-msg error';
      document.getElementById('loginNewPwMsg').textContent=editMessages.passwordMinSet;
      return;
    }
    if (pw !== pw2) {
      document.getElementById('loginCfmPwMsg').className='field-msg error';
      document.getElementById('loginCfmPwMsg').textContent=editMessages.passwordMismatch;
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
      nm.className='field-msg error'; nm.textContent=editMessages.passwordMinLength; return;
    }
    if (newPwVal !== cfmVal) {
      document.getElementById('cfmPwMsg').className='field-msg error';
      document.getElementById('cfmPwMsg').textContent=editMessages.passwordMismatch; return;
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
  if (!confirm(formatMessage(editMessages.socialUnlinkConfirm, getProviderLabel(provider)))) return;
  btn.disabled = true;
  const res = await fetch(ctx + '/auth/unlink', {
    method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: new URLSearchParams({provider})
  });
  const data = await res.json();
  if (data.success) {
    location.reload();
  } else {
    alert(data.message || editMessages.socialUnlinkFail);
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
