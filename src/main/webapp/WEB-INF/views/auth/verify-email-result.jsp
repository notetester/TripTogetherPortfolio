<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageCSS" value="auth/auth.css"/>
<%@ include file="../common/header.jsp" %>
<html lang="ko">
<body>
<div class="auth-wrap">
  <div class="auth-card" style="text-align:center;">

    <div class="auth-logo" style="justify-content:center;"
         onclick="location.href='${pageContext.request.contextPath}/'">
      <div class="auth-logo-icon">🌐</div><span class="auth-logo-text">TripTogether</span>
    </div>

    <c:choose>
      <c:when test="${success}">
        <div style="font-size:56px;margin:16px 0 20px;">✅</div>
        <h1 class="auth-title">이메일 인증 완료!</h1>
        <p class="auth-sub">이메일 인증이 성공적으로 완료되었습니다.<br>
          이제 회원정보 수정 페이지에서 이메일 로그인을 활성화할 수 있어요.</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          회원정보 수정으로 가기
        </button>
      </c:when>
      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">❌</div>
        <h1 class="auth-title">인증에 실패했어요</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/mypage/edit'">
          다시 시도하기
        </button>
      </c:otherwise>
    </c:choose>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
