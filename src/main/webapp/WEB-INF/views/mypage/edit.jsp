<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_mypage_userId_placeholder" code="mypage.userId.placeholder"/>
<spring:message var="msg_mypage_email_new" code="mypage.email.new"/>
<spring:message var="msg_mypage_password_placeholder" code="mypage.password.placeholder"/>
<spring:message var="msg_mypage_password_confirm_placeholder" code="mypage.password.confirm.placeholder"/>
<spring:message var="msg_mypage_password_current_placeholder" code="mypage.password.current.placeholder"/>
<spring:message var="msg_mypage_email_none_js" code="mypage.email.none" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_pendingSuffix_js" code="mypage.email.pendingSuffix" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_enterAndVerify_js" code="mypage.email.enterAndVerify" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_unverified_js" code="mypage.email.unverified" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_verified_js" code="mypage.email.verified" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_verifiedPending_js" code="mypage.email.verifiedPending" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_use_needPassword_js" code="mypage.email.use.needPassword" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_use_enable_js" code="mypage.email.use.enable" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_use_check_js" code="mypage.email.use.check" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_validRequired_js" code="mypage.email.validRequired" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_resend_js" code="mypage.email.resend" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_use_disableWithPassword_js" code="mypage.email.use.disableWithPassword" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_use_disable_js" code="mypage.email.use.disable" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_statusChecked_js" code="mypage.email.statusChecked" javaScriptEscape="true"/>
<spring:message var="msg_mypage_email_removeWithDisable_js" code="mypage.email.removeWithDisable" javaScriptEscape="true"/>
<spring:message var="msg_mypage_edit_nicknameDuplicate_js" code="mypage.edit.nicknameDuplicate" javaScriptEscape="true"/>
<spring:message var="msg_mypage_edit_passwordMatch_js" code="mypage.edit.passwordMatch" javaScriptEscape="true"/>
<spring:message var="msg_mypage_edit_passwordMismatch_js" code="mypage.edit.passwordMismatch" javaScriptEscape="true"/>
<spring:message var="msg_mypage_password_minSet_js" code="mypage.password.minSet" javaScriptEscape="true"/>
<spring:message var="msg_mypage_password_minLength_js" code="mypage.password.minLength" javaScriptEscape="true"/>
<spring:message var="msg_mypage_social_unlinkConfirm_js" code="mypage.social.unlinkConfirm" javaScriptEscape="true"/>
<spring:message var="msg_mypage_social_unlinkFail_js" code="mypage.social.unlinkFail" javaScriptEscape="true"/>
<spring:message var="msg_mypage_social_kakao_js" code="mypage.social.kakao" javaScriptEscape="true"/>
<spring:message var="msg_mypage_social_naver_js" code="mypage.social.naver" javaScriptEscape="true"/>
<spring:message var="msg_mypage_social_google_js" code="mypage.social.google" javaScriptEscape="true"/>
<spring:message var="msg_mypage_edit_back" code="mypage.edit.back"/>
<spring:message var="msg_mypage_edit_title" code="mypage.edit.title"/>
<spring:message var="msg_mypage_edit_subtitle" code="mypage.edit.subtitle"/>
<spring:message var="msg_mypage_edit_profile_title" code="mypage.edit.profile.title"/>
<spring:message var="msg_mypage_edit_profile_subtitle" code="mypage.edit.profile.subtitle"/>
<spring:message var="msg_mypage_nickname" code="mypage.nickname"/>
<spring:message var="msg_mypage_nationality" code="mypage.nationality"/>
<spring:message var="msg_mypage_country_kr" code="mypage.country.kr"/>
<spring:message var="msg_mypage_country_us" code="mypage.country.us"/>
<spring:message var="msg_mypage_country_jp" code="mypage.country.jp"/>
<spring:message var="msg_mypage_country_cn" code="mypage.country.cn"/>
<spring:message var="msg_mypage_country_gb" code="mypage.country.gb"/>
<spring:message var="msg_mypage_country_fr" code="mypage.country.fr"/>
<spring:message var="msg_mypage_country_de" code="mypage.country.de"/>
<spring:message var="msg_mypage_country_au" code="mypage.country.au"/>
<spring:message var="msg_mypage_country_ca" code="mypage.country.ca"/>
<spring:message var="msg_mypage_country_other" code="mypage.country.other"/>
<spring:message var="msg_mypage_language" code="mypage.language"/>
<spring:message var="msg_mypage_lang_ko" code="mypage.lang.ko"/>
<spring:message var="msg_mypage_lang_en" code="mypage.lang.en"/>
<spring:message var="msg_mypage_lang_ja" code="mypage.lang.ja"/>
<spring:message var="msg_mypage_lang_zh" code="mypage.lang.zh"/>
<spring:message var="msg_mypage_save" code="mypage.save"/>
<spring:message var="msg_mypage_edit_login_title" code="mypage.edit.login.title"/>
<spring:message var="msg_mypage_edit_login_subtitle" code="mypage.edit.login.subtitle"/>
<spring:message var="msg_mypage_edit_idLogin" code="mypage.edit.idLogin"/>
<spring:message var="msg_mypage_available" code="mypage.available"/>
<spring:message var="msg_mypage_none" code="mypage.none"/>
<spring:message var="msg_mypage_edit_emailLogin" code="mypage.edit.emailLogin"/>
<spring:message var="msg_mypage_edit_socialLogin" code="mypage.edit.socialLogin"/>
<spring:message var="msg_mypage_social_linkedCount" code="mypage.social.linkedCount"/>
<spring:message var="msg_mypage_profile_userId" code="mypage.profile.userId"/>
<spring:message var="msg_mypage_userId_once" code="mypage.userId.once"/>
<spring:message var="msg_mypage_userId_help" code="mypage.userId.help"/>
<spring:message var="msg_mypage_email_state" code="mypage.email.state"/>
<spring:message var="msg_mypage_email_none" code="mypage.email.none"/>
<spring:message var="msg_mypage_email_verified" code="mypage.email.verified"/>
<spring:message var="msg_mypage_email_unverified" code="mypage.email.unverified"/>
<spring:message var="msg_mypage_email_change" code="mypage.email.change"/>
<spring:message var="msg_mypage_email_send" code="mypage.email.send"/>
<spring:message var="msg_mypage_email_help" code="mypage.email.help"/>
<spring:message var="msg_mypage_email_use" code="mypage.email.use"/>
<spring:message var="msg_mypage_email_use_current" code="mypage.email.use.current"/>
<spring:message var="msg_mypage_email_use_enable" code="mypage.email.use.enable"/>
<spring:message var="msg_mypage_email_use_needPassword" code="mypage.email.use.needPassword"/>
<spring:message var="msg_mypage_email_use_check" code="mypage.email.use.check"/>
<spring:message var="msg_mypage_localPassword" code="mypage.localPassword"/>
<spring:message var="msg_mypage_password" code="mypage.password"/>
<spring:message var="msg_mypage_password_confirm" code="mypage.password.confirm"/>
<spring:message var="msg_mypage_password_firstTime" code="mypage.password.firstTime"/>
<spring:message var="msg_mypage_loginSave" code="mypage.loginSave"/>
<spring:message var="msg_mypage_loginWarn" code="mypage.loginWarn"/>
<spring:message var="msg_mypage_passwordChange" code="mypage.passwordChange"/>
<spring:message var="msg_mypage_passwordChange_subtitle" code="mypage.passwordChange.subtitle"/>
<spring:message var="msg_mypage_password_current" code="mypage.password.current"/>
<spring:message var="msg_mypage_password_new" code="mypage.password.new"/>
<spring:message var="msg_mypage_social_title" code="mypage.social.title"/>
<spring:message var="msg_mypage_social_subtitle" code="mypage.social.subtitle"/>
<spring:message var="msg_mypage_social_kakao" code="mypage.social.kakao"/>
<spring:message var="msg_mypage_social_status_linked" code="mypage.social.status.linked"/>
<spring:message var="msg_mypage_social_status_unlinked" code="mypage.social.status.unlinked"/>
<spring:message var="msg_mypage_social_unlink" code="mypage.social.unlink"/>
<spring:message var="msg_mypage_social_link" code="mypage.social.link"/>
<spring:message var="msg_mypage_social_naver" code="mypage.social.naver"/>
<spring:message var="msg_mypage_social_google" code="mypage.social.google"/>
<spring:message var="msg_mypage_social_warn" code="mypage.social.warn"/>
<spring:message var="msg_mypage_edit_done" code="mypage.edit.done"/>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>


<html lang="ko">
<body>
<div class="mypage-wrap">
  <div class="mypage-inner">

    <div class="mypage-header">
      <button class="mypage-back" onclick="location.href='${pageContext.request.contextPath}/mypage'">${msg_mypage_edit_back}</button>
      <h1>${msg_mypage_edit_title}</h1>
      <p>${msg_mypage_edit_subtitle}</p>
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
          <div class="edit-card-head-title">${msg_mypage_edit_profile_title}</div>
          <div class="edit-card-head-sub">${msg_mypage_edit_profile_subtitle}</div>
        </div>
        <span class="edit-card-chevron open">▼</span>
      </div>
      <div class="accordion-body open edit-card-body" id="acc-profile">
        <div class="form-group">
          <label class="form-label" for="nickname">${msg_mypage_nickname}</label>
          <input class="form-input" type="text" id="nickname" value="${user.nickname}" maxlength="20">
          <div class="field-msg" id="nicknameMsg"></div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="nationality">${msg_mypage_nationality}</label>
            <select class="form-select" id="nationality">
              <option value="KR" ${user.nationality=='KR'?'selected':''}>🇰🇷 ${msg_mypage_country_kr}</option>
              <option value="US" ${user.nationality=='US'?'selected':''}>🇺🇸 ${msg_mypage_country_us}</option>
              <option value="JP" ${user.nationality=='JP'?'selected':''}>🇯🇵 ${msg_mypage_country_jp}</option>
              <option value="CN" ${user.nationality=='CN'?'selected':''}>🇨🇳 ${msg_mypage_country_cn}</option>
              <option value="GB" ${user.nationality=='GB'?'selected':''}>🇬🇧 ${msg_mypage_country_gb}</option>
              <option value="FR" ${user.nationality=='FR'?'selected':''}>🇫🇷 ${msg_mypage_country_fr}</option>
              <option value="DE" ${user.nationality=='DE'?'selected':''}>🇩🇪 ${msg_mypage_country_de}</option>
              <option value="AU" ${user.nationality=='AU'?'selected':''}>🇦🇺 ${msg_mypage_country_au}</option>
              <option value="CA" ${user.nationality=='CA'?'selected':''}>🇨🇦 ${msg_mypage_country_ca}</option>
              <option value="OTHER" ${user.nationality=='OTHER'?'selected':''}>🌍 ${msg_mypage_country_other}</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label" for="preferredLang">${msg_mypage_language}</label>
            <select class="form-select" id="preferredLang">
              <option value="ko" ${user.preferredLang=='ko'?'selected':''}>🇰🇷 ${msg_mypage_lang_ko}</option>
              <option value="en" ${user.preferredLang=='en'?'selected':''}>🇺🇸 ${msg_mypage_lang_en}</option>
              <option value="ja" ${user.preferredLang=='ja'?'selected':''}>🇯🇵 ${msg_mypage_lang_ja}</option>
              <option value="zh" ${user.preferredLang=='zh'?'selected':''}>🇨🇳 ${msg_mypage_lang_zh}</option>
            </select>
          </div>
        </div>
        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
          <button class="btn-save" id="saveProfileBtn">${msg_mypage_save}</button>
          <span class="save-msg" id="saveProfileMsg"></span>
        </div>
      </div>
    </div>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-login',this)">
        <div class="edit-card-head-icon">🪪</div>
        <div>
          <div class="edit-card-head-title">${msg_mypage_edit_login_title}</div>
          <div class="edit-card-head-sub">${msg_mypage_edit_login_subtitle}</div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-login">

        <input type="hidden" id="profileEmailRequestId" value="${profileEmailRequestId}">

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;display:flex;flex-wrap:wrap;gap:8px;">
          <span class="email-status-badge ${hasUsableIdLogin ? 'verified' : 'unverified'}">${msg_mypage_edit_idLogin} <c:choose><c:when test="${hasUsableIdLogin}">${msg_mypage_available}</c:when><c:otherwise>${msg_mypage_none}</c:otherwise></c:choose></span>
          <span class="email-status-badge ${hasUsableEmailLogin ? 'verified' : 'unverified'}">${msg_mypage_edit_emailLogin} <c:choose><c:when test="${hasUsableEmailLogin}">${msg_mypage_available}</c:when><c:otherwise>${msg_mypage_none}</c:otherwise></c:choose></span>
          <span class="email-status-badge ${socialCount gt 0 ? 'verified' : 'unverified'}">${msg_mypage_edit_socialLogin} <c:choose><c:when test="${socialCount gt 0}">${msg_mypage_social_linkedCount}</c:when><c:otherwise>${msg_mypage_none}</c:otherwise></c:choose></span>
        </div>

        <div class="form-group">
          <label class="form-label">${msg_mypage_profile_userId}</label>
          <c:choose>
            <c:when test="${not empty user.userId}">
              <div style="background:var(--gray-50);border:1px solid var(--gray-200);border-radius:10px;padding:12px 14px;font-weight:600;color:var(--gray-800);">
                ${user.userId}
              </div>
              <div class="field-msg success">${msg_mypage_userId_once}</div>
            </c:when>
            <c:otherwise>
              <input class="form-input" type="text" id="localUserId" maxlength="30" placeholder="${msg_mypage_userId_placeholder}">
              <div class="field-msg" id="localUserIdMsg">${msg_mypage_userId_help}</div>
            </c:otherwise>
          </c:choose>
        </div>

        <div style="height:1px;background:var(--gray-100);margin:16px 0;"></div>

        <div style="background:var(--gray-50);border-radius:10px;padding:14px 16px;margin-bottom:16px;">
          <div style="font-size:13px;font-weight:600;color:var(--gray-600);margin-bottom:4px;">${msg_mypage_email_state}</div>
          <div style="display:flex;align-items:center;flex-wrap:wrap;gap:8px;">
            <span style="font-size:15px;font-weight:600;color:var(--gray-800);" id="currentEmail">
              <c:choose>
                <c:when test="${not empty user.userEmail}">${user.userEmail}</c:when>
                <c:otherwise>${msg_mypage_email_none}</c:otherwise>
              </c:choose>
            </span>
            <span class="email-status-badge ${user.emailVerified ? 'verified' : 'unverified'}" id="emailStatusBadge">
              <c:choose>
                <c:when test="${user.emailVerified}">${msg_mypage_email_verified}</c:when>
                <c:otherwise>${msg_mypage_email_unverified}</c:otherwise>
              </c:choose>
            </span>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="newEmail">${msg_mypage_email_change}</label>
          <div style="display:flex;gap:8px;">
            <input class="form-input" type="email" id="newEmail" placeholder="${msg_mypage_email_new}" style="flex:1;" value="${user.userEmail}">
            <button class="btn-save" id="sendVerifyBtn" style="white-space:nowrap;padding:10px 16px;">${msg_mypage_email_send}</button>
          </div>
          <div class="field-msg" id="emailMsg"></div>
          <div class="field-msg">${msg_mypage_email_help}</div>
        </div>

        <div class="toggle-wrap">
          <div>
            <div class="toggle-label">${msg_mypage_email_use}</div>
            <div class="toggle-sub" id="emailLoginSub">
              <c:choose>
                <c:when test="${user.emailLoginEnabled}">${msg_mypage_email_use_current}</c:when>
                <c:when test="${user.emailVerified and user.passwordEnabled}">${msg_mypage_email_use_enable}</c:when>
                <c:when test="${user.emailVerified and not user.passwordEnabled}">${msg_mypage_email_use_needPassword}</c:when>
                <c:otherwise>${msg_mypage_email_use_check}</c:otherwise>
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
          <div style="font-size:14px;font-weight:700;color:var(--gray-800);margin-bottom:12px;">${msg_mypage_localPassword}</div>
          <div class="form-group">
            <label class="form-label" for="loginNewPassword">${msg_mypage_password}</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginNewPassword" placeholder="${msg_mypage_password_placeholder}" maxlength="64">
              <button type="button" class="pw-toggle" id="pt3">👁</button>
            </div>
            <div class="field-msg" id="loginNewPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="loginConfirmPassword">${msg_mypage_password_confirm}</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="loginConfirmPassword" placeholder="${msg_mypage_password_confirm_placeholder}" maxlength="64">
              <button type="button" class="pw-toggle" id="pt4">👁</button>
            </div>
            <div class="field-msg" id="loginCfmPwMsg"></div>
          </div>
          <div class="field-msg success" style="margin-top:4px;">${msg_mypage_password_firstTime}</div>
        </div>

        <div style="display:flex;align-items:center;gap:12px;margin-top:16px;">
          <button class="btn-save" id="saveLoginSettingsBtn">${msg_mypage_loginSave}</button>
          <span class="save-msg" id="saveLoginSettingsMsg"></span>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          ${msg_mypage_loginWarn}
        </div>
      </div>
    </div>

    <c:if test="${user.passwordEnabled}">
      <div class="edit-card">
        <div class="edit-card-head" onclick="toggleAcc('acc-pw',this)">
          <div class="edit-card-head-icon">🔒</div>
          <div>
            <div class="edit-card-head-title">${msg_mypage_passwordChange}</div>
            <div class="edit-card-head-sub">${msg_mypage_passwordChange_subtitle}</div>
          </div>
          <span class="edit-card-chevron">▼</span>
        </div>
        <div class="accordion-body edit-card-body" id="acc-pw">
          <div class="form-group">
            <label class="form-label" for="currentPassword">${msg_mypage_password_current}</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="currentPassword" placeholder="${msg_mypage_password_current_placeholder}">
              <button type="button" class="pw-toggle" id="pt0">👁</button>
            </div>
            <div class="field-msg" id="curPwMsg"></div>
          </div>
          <div class="form-group">
            <label class="form-label" for="newPassword">${msg_mypage_password_new}</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="newPassword" placeholder="${msg_mypage_password_placeholder}" maxlength="64">
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
            <label class="form-label" for="confirmPassword">${msg_mypage_password_confirm}</label>
            <div class="pw-wrap">
              <input class="form-input" type="password" id="confirmPassword" placeholder="${msg_mypage_password_confirm_placeholder}" maxlength="64">
              <button type="button" class="pw-toggle" id="pt2">👁</button>
            </div>
            <div class="field-msg" id="cfmPwMsg"></div>
          </div>
          <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
            <button class="btn-save" id="savePwBtn">${msg_mypage_passwordChange}</button>
            <span class="save-msg" id="savePwMsg"></span>
          </div>
        </div>
      </div>
    </c:if>

    <div class="edit-card">
      <div class="edit-card-head" onclick="toggleAcc('acc-social',this)">
        <div class="edit-card-head-icon">🔗</div>
        <div>
          <div class="edit-card-head-title">${msg_mypage_social_title}</div>
          <div class="edit-card-head-sub">${msg_mypage_social_subtitle}</div>
        </div>
        <span class="edit-card-chevron">▼</span>
      </div>
      <div class="accordion-body edit-card-body" id="acc-social">

        <div class="social-link-item">
          <div class="social-link-icon KAKAO"><span class="kakao-mark-box">k</span></div>
          <div class="social-link-info">
            <div class="social-link-name">${msg_mypage_social_kakao}</div>
            <div class="social-link-status ${socialLinkMap['KAKAO'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['KAKAO']}">${msg_mypage_social_status_linked}</c:when><c:otherwise>${msg_mypage_social_status_unlinked}</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['KAKAO']}"><button class="btn-social-action unlink" onclick="unlinkSocial('KAKAO', this)">${msg_mypage_social_unlink}</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/kakao'">${msg_mypage_social_link}</button></c:otherwise>
          </c:choose>
        </div>

        <div class="social-link-item">
          <div class="social-link-icon NAVER"><span class="naver-mark-box">N</span></div>
          <div class="social-link-info">
            <div class="social-link-name">${msg_mypage_social_naver}</div>
            <div class="social-link-status ${socialLinkMap['NAVER'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['NAVER']}">${msg_mypage_social_status_linked}</c:when><c:otherwise>${msg_mypage_social_status_unlinked}</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['NAVER']}"><button class="btn-social-action unlink" onclick="unlinkSocial('NAVER', this)">${msg_mypage_social_unlink}</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/naver'">${msg_mypage_social_link}</button></c:otherwise>
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
            <div class="social-link-name">${msg_mypage_social_google}</div>
            <div class="social-link-status ${socialLinkMap['GOOGLE'] ? 'linked' : ''}">
              <c:choose><c:when test="${socialLinkMap['GOOGLE']}">${msg_mypage_social_status_linked}</c:when><c:otherwise>${msg_mypage_social_status_unlinked}</c:otherwise></c:choose>
            </div>
          </div>
          <c:choose>
            <c:when test="${socialLinkMap['GOOGLE']}"><button class="btn-social-action unlink" onclick="unlinkSocial('GOOGLE', this)">${msg_mypage_social_unlink}</button></c:when>
            <c:otherwise><button class="btn-social-action link" onclick="location.href='${pageContext.request.contextPath}/auth/link/google'">${msg_mypage_social_link}</button></c:otherwise>
          </c:choose>
        </div>

        <div style="margin-top:12px;padding:10px 14px;background:var(--gray-50);border-radius:8px;font-size:12px;color:var(--gray-500);">
          ${msg_mypage_social_warn}
        </div>
      </div>
    </div>

    <div style="text-align:center;margin-top:8px;">
      <form action="${pageContext.request.contextPath}/mypage/edit/done" method="post">
        <button type="submit" class="btn-save" style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;padding:12px 32px;font-size:15px;">✅ ${msg_mypage_edit_done}</button>
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
  emailNone: '${msg_mypage_email_none_js}',
  emailPendingSuffix: '${msg_mypage_email_pendingSuffix_js}',
  emailEnterAndVerify: '${msg_mypage_email_enterAndVerify_js}',
  emailUnverified: '${msg_mypage_email_unverified_js}',
  emailVerified: '${msg_mypage_email_verified_js}',
  emailVerifiedPending: '${msg_mypage_email_verifiedPending_js}',
  emailUseNeedPassword: '${msg_mypage_email_use_needPassword_js}',
  emailUseEnable: '${msg_mypage_email_use_enable_js}',
  emailUseCheck: '${msg_mypage_email_use_check_js}',
  emailValidRequired: '${msg_mypage_email_validRequired_js}',
  emailResend: '${msg_mypage_email_resend_js}',
  emailUseDisableWithPassword: '${msg_mypage_email_use_disableWithPassword_js}',
  emailUseDisable: '${msg_mypage_email_use_disable_js}',
  emailStatusChecked: '${msg_mypage_email_statusChecked_js}',
  emailRemoveWithDisable: '${msg_mypage_email_removeWithDisable_js}',
  nicknameDuplicate: '${msg_mypage_edit_nicknameDuplicate_js}',
  passwordMatch: '${msg_mypage_edit_passwordMatch_js}',
  passwordMismatch: '${msg_mypage_edit_passwordMismatch_js}',
  passwordMinSet: '${msg_mypage_password_minSet_js}',
  passwordMinLength: '${msg_mypage_password_minLength_js}',
  socialUnlinkConfirm: '${msg_mypage_social_unlinkConfirm_js}',
  socialUnlinkFail: '${msg_mypage_social_unlinkFail_js}',
  providerKakao: '${msg_mypage_social_kakao_js}',
  providerNaver: '${msg_mypage_social_naver_js}',
  providerGoogle: '${msg_mypage_social_google_js}'
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
