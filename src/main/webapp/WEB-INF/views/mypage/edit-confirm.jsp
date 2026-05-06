<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_mypage_password_current_placeholder" code="mypage.password.current.placeholder"/>
<spring:message var="msg_mypage_common_cancel" code="mypage.common.cancel"/>
<spring:message var="msg_mypage_common_confirm" code="mypage.common.confirm"/>
<spring:message var="msg_mypage_editConfirm_forgotPassword" code="mypage.editConfirm.forgotPassword"/>
<spring:message var="msg_mypage_editConfirm_invalidPassword_js" code="mypage.editConfirm.invalidPassword" javaScriptEscape="true"/>
<spring:message var="msg_mypage_editConfirm_passwordRequired_js" code="mypage.editConfirm.passwordRequired" javaScriptEscape="true"/>
<spring:message var="msg_mypage_editConfirm_title" code="mypage.editConfirm.title"/>
<spring:message var="msg_mypage_editConfirm_subtitle" code="mypage.editConfirm.subtitle"/>
<spring:message var="msg_mypage_password_current" code="mypage.password.current"/>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>

<html lang="ko">
<body>


<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <div style="text-align:center;margin-bottom:24px;">
      <div style="width:60px;height:60px;background:var(--blue-light);border-radius:50%;
                  display:flex;align-items:center;justify-content:center;
                  margin:0 auto 16px;font-size:28px;">🛡️</div>
      <h1 class="auth-title" style="margin-bottom:8px;">${msg_mypage_editConfirm_title}</h1>
      <p class="auth-sub" style="margin-bottom:0;">${msg_mypage_editConfirm_subtitle}</p>
    </div>

    <div id="errorBanner" class="auth-error-banner"></div>

    <div class="form-group">
      <label class="form-label" for="password">${msg_mypage_password_current}</label>
      <div class="pw-wrap">
        <input class="form-input" type="password" id="password"
               placeholder="${msg_mypage_password_current_placeholder}" autocomplete="current-password">
        <button type="button" class="pw-toggle" id="pwToggle">👁</button>
      </div>
    </div>

    <button type="button" class="btn-submit" id="confirmBtn">${msg_mypage_common_confirm}</button>

    <div style="display:flex;justify-content:center;gap:16px;margin-top:16px;">
      <a class="auth-link" href="${pageContext.request.contextPath}/auth/find-pw">
        ${msg_mypage_editConfirm_forgotPassword}
      </a>
      <span style="color:var(--gray-300);">|</span>
      <a class="auth-link" href="${pageContext.request.contextPath}/">${msg_mypage_common_cancel}</a>
    </div>
  </div>
</div>
<script>
(function(){
  document.getElementById('pwToggle').addEventListener('click',function(){
    const pw=document.getElementById('password');
    const t=pw.type==='text'; pw.type=t?'password':'text'; this.textContent=t?'👁':'🙈';
  });

  async function doConfirm(){
    const password=document.getElementById('password').value;
    const banner=document.getElementById('errorBanner');
    if(!password){ banner.textContent='⚠️ ${msg_mypage_editConfirm_passwordRequired_js}'; banner.classList.add('show'); return; }
    banner.classList.remove('show');

    const btn=document.getElementById('confirmBtn');
    btn.classList.add('loading'); btn.disabled=true;

    const res=await fetch('${pageContext.request.contextPath}/mypage/edit-confirm',{
      method:'POST',
      headers:{'Content-Type':'application/x-www-form-urlencoded'},
      body:new URLSearchParams({password})
    });
    const data=await res.json();
    if(data.success){
      location.href='${pageContext.request.contextPath}/mypage/edit';
    } else {
      banner.textContent='⚠️ '+(data.message||'${msg_mypage_editConfirm_invalidPassword_js}');
      banner.classList.add('show');
      document.getElementById('password').value='';
      document.getElementById('password').focus();
      btn.classList.remove('loading'); btn.disabled=false;
    }
  }

  document.getElementById('confirmBtn').addEventListener('click', doConfirm);
  document.getElementById('password').addEventListener('keydown', e => { if(e.key==='Enter') doConfirm(); });
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
