<spring:message var="authRegisterPasswordPlaceholderMsg" code="auth.register.password.placeholder"/>
<spring:message var="authRegisterPasswordConfirmPlaceholderMsg" code="auth.register.passwordConfirm.placeholder"/>
<spring:message var="authCommonPasswordShowMsg" code="auth.common.password.show" javaScriptEscape="true"/>
<spring:message var="authCommonPasswordHideMsg" code="auth.common.password.hide" javaScriptEscape="true"/>
<spring:message var="authRegisterPasswordMatchMsg" code="auth.register.password.match" javaScriptEscape="true"/>
<spring:message var="authRegisterPasswordMismatchMsg" code="auth.register.password.mismatch" javaScriptEscape="true"/>
<spring:message var="authRegisterPasswordShortMsg" code="auth.register.password.short" javaScriptEscape="true"/>
<spring:message var="authCommonErrorPrefixMsg" code="auth.common.errorPrefix" javaScriptEscape="true"/>
<spring:message var="authLoginErrorServerMsg" code="auth.login.error.server" javaScriptEscape="true"/>
﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="${pageContext.response.locale.language}">
<body>
<div class="auth-wrap">
  <div class="auth-card">
    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">T</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <c:choose>
      <c:when test="${not empty error}">
        <div style="text-align:center;">
          <div style="font-size:56px;margin:16px 0 20px;">⏰</div>
          <h1 class="auth-title"><spring:message code="auth.resetPw.expiredTitle"/></h1>
          <p class="auth-sub">${error}</p>
          <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            <spring:message code="auth.resetPw.retry"/>
          </button>
        </div>
      </c:when>
      <c:otherwise>
        <h1 class="auth-title"><spring:message code="auth.resetPw.title"/></h1>
        <p class="auth-sub"><strong>${nickname}</strong><spring:message code="auth.resetPw.subtitle"/></p>
        <div id="errorBanner" class="auth-error-banner"></div>
        <input type="hidden" id="token" value="${token}">

        <div class="form-group">
          <label class="form-label" for="newPassword"><spring:message code="auth.resetPw.newPassword"/></label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="newPassword" placeholder="${authRegisterPasswordPlaceholderMsg}" maxlength="64">
            <button type="button" class="pw-toggle" id="pt1"><spring:message code="auth.common.password.show"/></button>
          </div>
          <div class="pw-strength">
            <div class="pw-bar" id="b1"></div>
            <div class="pw-bar" id="b2"></div>
            <div class="pw-bar" id="b3"></div>
          </div>
          <div class="field-msg" id="pwMsg"></div>
        </div>

        <div class="form-group">
          <label class="form-label" for="confirmPassword"><spring:message code="auth.register.passwordConfirm"/></label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="confirmPassword" placeholder="${authRegisterPasswordConfirmPlaceholderMsg}" maxlength="64">
            <button type="button" class="pw-toggle" id="pt2"><spring:message code="auth.common.password.show"/></button>
          </div>
          <div class="field-msg" id="cfmMsg"></div>
        </div>

        <button type="button" class="btn-submit" id="resetBtn"><spring:message code="auth.resetPw.submit"/></button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login"><spring:message code="auth.common.backToLogin"/></a>
    </div>
  </div>
</div>
<script>
(function(){
  function toggle(btnId, inputId){
    document.getElementById(btnId).addEventListener('click',function(){
      const el=document.getElementById(inputId);
      const t=el.type==='text';
      el.type=t?'password':'text';
      this.textContent=t?'${authCommonPasswordShowMsg}':'${authCommonPasswordHideMsg}';
    });
  }
  toggle('pt1','newPassword');
  toggle('pt2','confirmPassword');

  document.getElementById('newPassword').addEventListener('input',function(){
    const v=this.value, bars=[document.getElementById('b1'),document.getElementById('b2'),document.getElementById('b3')];
    let s=0;
    if(v.length>=8)s++;
    if(/[A-Za-z]/.test(v)&&/\d/.test(v))s++;
    if(/[^A-Za-z0-9]/.test(v))s++;
    const cls=s===1?'weak':s===2?'fair':s===3?'strong':'';
    bars.forEach((b,i)=>{ b.className='pw-bar'+(i<s&&cls?' '+cls:''); });
  });

  document.getElementById('confirmPassword').addEventListener('input',function(){
    const pw=document.getElementById('newPassword').value;
    const msg=document.getElementById('cfmMsg');
    if(!this.value){msg.className='field-msg'; msg.textContent=''; return;}
    if(pw===this.value){msg.className='field-msg success';msg.textContent='${authRegisterPasswordMatchMsg}';} else {msg.className='field-msg error';msg.textContent='${authRegisterPasswordMismatchMsg}';}
  });

  document.getElementById('resetBtn').addEventListener('click',async function(){
    const newPassword=document.getElementById('newPassword').value;
    const cfm=document.getElementById('confirmPassword').value;
    const token=document.getElementById('token').value;
    const errBanner=document.getElementById('errorBanner');
    if(newPassword.length<8){
      document.getElementById('pwMsg').className='field-msg error';
      document.getElementById('pwMsg').textContent='${authRegisterPasswordShortMsg}';
      return;
    }
    if(newPassword!==cfm){
      document.getElementById('cfmMsg').className='field-msg error';
      document.getElementById('cfmMsg').textContent='${authRegisterPasswordMismatchMsg}';
      return;
    }

    this.classList.add('loading'); this.disabled=true;
    const res=await fetch('${pageContext.request.contextPath}/auth/reset-pw',{
      method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:new URLSearchParams({token,newPassword})
    });
    const data=await res.json();
    if(data.success){
      location.href = data.redirect + '?resetOk=1';
    } else {
      errBanner.textContent='${authCommonErrorPrefixMsg} ' + (data.message||'${authLoginErrorServerMsg}');
      errBanner.classList.add('show');
      this.classList.remove('loading'); this.disabled=false;
    }
  });
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
