<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_df6bad1ae7" code="auth.resetPw.expiredTitle"/>
<spring:message var="autoMsg_ac8d45cfbf" code="auth.resetPw.title"/>
<spring:message var="autoMsg_2d79abf2a0" code="auth.resetPw.subtitle"/>
<spring:message var="autoMsg_506753a4e0" code="auth.resetPw.newPassword"/>
<spring:message var="autoMsg_a51cb52918" code="auth.register.password.placeholder"/>
<spring:message var="autoMsg_bf889546d7" code="auth.common.password.show"/>
<spring:message var="autoMsg_2e764c176f" code="auth.register.passwordConfirm"/>
<spring:message var="autoMsg_e80f3d5bf1" code="auth.register.passwordConfirm.placeholder"/>
<spring:message var="autoMsg_7179c4f6f4" code="auth.resetPw.submit"/>
<spring:message var="autoMsg_99273072b7" code="auth.common.backToLogin"/>
<spring:message var="autoMsg_ee9a76fc27" code="auth.common.password.show" javaScriptEscape="true"/>
<spring:message var="autoMsg_254cca57b8" code="auth.common.password.hide" javaScriptEscape="true"/>
<spring:message var="autoMsg_34e634a3b2" code="auth.register.password.match" javaScriptEscape="true"/>
<spring:message var="autoMsg_fec4436972" code="auth.register.password.mismatch" javaScriptEscape="true"/>
<spring:message var="autoMsg_685cbadcef" code="auth.register.password.short" javaScriptEscape="true"/>
<spring:message var="autoMsg_4e6a8b7c30" code="auth.common.errorPrefix" javaScriptEscape="true"/>
<spring:message var="autoMsg_c974b0b7c2" code="auth.login.error.server" javaScriptEscape="true"/>
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
          <h1 class="auth-title">${autoMsg_df6bad1ae7}</h1>
          <p class="auth-sub">${error}</p>
          <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            <spring:message code="auth.resetPw.retry"/>
          </button>
        </div>
      </c:when>
      <c:otherwise>
        <h1 class="auth-title">${autoMsg_ac8d45cfbf}</h1>
        <p class="auth-sub"><strong>${nickname}</strong>${autoMsg_2d79abf2a0}</p>
        <div id="errorBanner" class="auth-error-banner"></div>
        <input type="hidden" id="token" value="${token}">

        <div class="form-group">
          <label class="form-label" for="newPassword">${autoMsg_506753a4e0}</label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="newPassword" placeholder="${autoMsg_a51cb52918}" maxlength="64">
            <button type="button" class="pw-toggle" id="pt1">${autoMsg_bf889546d7}</button>
          </div>
          <div class="pw-strength">
            <div class="pw-bar" id="b1"></div>
            <div class="pw-bar" id="b2"></div>
            <div class="pw-bar" id="b3"></div>
          </div>
          <div class="field-msg" id="pwMsg"></div>
        </div>

        <div class="form-group">
          <label class="form-label" for="confirmPassword">${autoMsg_2e764c176f}</label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="confirmPassword" placeholder="${autoMsg_e80f3d5bf1}" maxlength="64">
            <button type="button" class="pw-toggle" id="pt2">${autoMsg_bf889546d7}</button>
          </div>
          <div class="field-msg" id="cfmMsg"></div>
        </div>

        <button type="button" class="btn-submit" id="resetBtn">${autoMsg_7179c4f6f4}</button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">${autoMsg_99273072b7}</a>
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
      this.textContent=t?'${autoMsg_ee9a76fc27}':'${autoMsg_254cca57b8}';
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
    if(pw===this.value){msg.className='field-msg success';msg.textContent='${autoMsg_34e634a3b2}';} else {msg.className='field-msg error';msg.textContent='${autoMsg_fec4436972}';}
  });

  document.getElementById('resetBtn').addEventListener('click',async function(){
    const newPassword=document.getElementById('newPassword').value;
    const cfm=document.getElementById('confirmPassword').value;
    const token=document.getElementById('token').value;
    const errBanner=document.getElementById('errorBanner');
    if(newPassword.length<8){
      document.getElementById('pwMsg').className='field-msg error';
      document.getElementById('pwMsg').textContent='${autoMsg_685cbadcef}';
      return;
    }
    if(newPassword!==cfm){
      document.getElementById('cfmMsg').className='field-msg error';
      document.getElementById('cfmMsg').textContent='${autoMsg_fec4436972}';
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
      errBanner.textContent='${autoMsg_4e6a8b7c30} ' + (data.message||'${autoMsg_c974b0b7c2}');
      errBanner.classList.add('show');
      this.classList.remove('loading'); this.disabled=false;
    }
  });
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
