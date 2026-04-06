<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card">

    <div class="auth-logo" onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <c:choose>
      <c:when test="${not empty error}">
        <!-- 토큰 만료 -->
        <div style="text-align:center;">
          <div style="font-size:56px;margin:16px 0 20px;">⏰</div>
          <h1 class="auth-title">링크가 만료되었어요</h1>
          <p class="auth-sub">${error}</p>
          <button class="btn-submit"
                  onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            다시 요청하기
          </button>
        </div>
      </c:when>

      <c:otherwise>
        <h1 class="auth-title">새 비밀번호 설정 🔑</h1>
        <p class="auth-sub"><strong>${nickname}</strong>님의 새 비밀번호를 설정해주세요.</p>

        <div id="errorBanner" class="auth-error-banner"></div>

        <input type="hidden" id="token" value="${token}">

        <div class="form-group">
          <label class="form-label" for="newPassword">새 비밀번호</label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="newPassword"
                   placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="64">
            <button type="button" class="pw-toggle" id="pt1">👁</button>
          </div>
          <div class="pw-strength">
            <div class="pw-bar" id="b1"></div>
            <div class="pw-bar" id="b2"></div>
            <div class="pw-bar" id="b3"></div>
          </div>
          <div class="field-msg" id="pwMsg"></div>
        </div>

        <div class="form-group">
          <label class="form-label" for="confirmPassword">비밀번호 확인</label>
          <div class="pw-wrap">
            <input class="form-input" type="password" id="confirmPassword"
                   placeholder="비밀번호 재입력" maxlength="64">
            <button type="button" class="pw-toggle" id="pt2">👁</button>
          </div>
          <div class="field-msg" id="cfmMsg"></div>
        </div>

        <button type="button" class="btn-submit" id="resetBtn">비밀번호 재설정</button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:16px;">
      <a href="${pageContext.request.contextPath}/auth/login">← 로그인으로</a>
    </div>
  </div>
</div>
<script>
(function(){
  // 토글
  function toggle(btnId, inputId){
    document.getElementById(btnId).addEventListener('click',function(){
      const el=document.getElementById(inputId);
      const t=el.type==='text';
      el.type=t?'password':'text'; this.textContent=t?'👁':'🙈';
    });
  }
  toggle('pt1','newPassword'); toggle('pt2','confirmPassword');

  // 강도
  document.getElementById('newPassword').addEventListener('input',function(){
    const v=this.value, bars=[document.getElementById('b1'),document.getElementById('b2'),document.getElementById('b3')];
    let s=0;
    if(v.length>=8)s++;
    if(/[A-Za-z]/.test(v)&&/\d/.test(v))s++;
    if(/[^A-Za-z0-9]/.test(v))s++;
    const cls=s===1?'weak':s===2?'fair':s===3?'strong':'';
    bars.forEach((b,i)=>{ b.className='pw-bar'+(i<s&&cls?' '+cls:''); });
  });

  // 확인
  document.getElementById('confirmPassword').addEventListener('input',function(){
    const pw=document.getElementById('newPassword').value;
    const msg=document.getElementById('cfmMsg');
    if(!this.value){msg.className='field-msg';return;}
    if(pw===this.value){msg.className='field-msg success';msg.textContent='비밀번호가 일치합니다.';}
    else{msg.className='field-msg error';msg.textContent='비밀번호가 일치하지 않습니다.';}
  });

  document.getElementById('resetBtn').addEventListener('click',async function(){
    const newPassword=document.getElementById('newPassword').value;
    const cfm=document.getElementById('confirmPassword').value;
    const token=document.getElementById('token').value;
    const errBanner=document.getElementById('errorBanner');

    if(newPassword.length<8){
      document.getElementById('pwMsg').className='field-msg error';
      document.getElementById('pwMsg').textContent='비밀번호는 8자 이상이어야 합니다.'; return;
    }
    if(newPassword!==cfm){
      document.getElementById('cfmMsg').className='field-msg error';
      document.getElementById('cfmMsg').textContent='비밀번호가 일치하지 않습니다.'; return;
    }

    this.classList.add('loading'); this.disabled=true;
    const res=await fetch('${pageContext.request.contextPath}/auth/reset-pw',{
      method:'POST',
      headers:{'Content-Type':'application/x-www-form-urlencoded'},
      body:new URLSearchParams({token,newPassword})
    });
    const data=await res.json();
    if(data.success){
      location.href = data.redirect + '?resetOk=1';
    } else {
      errBanner.textContent='⚠️ '+(data.message||'오류가 발생했습니다.');
      errBanner.classList.add('show');
      this.classList.remove('loading'); this.disabled=false;
    }
  });
})();
</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
