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
      <c:when test="${not empty foundUserId}">
        <div style="font-size:56px;margin:16px 0 20px;">🎉</div>
        <h1 class="auth-title">아이디 힌트를 안내드려요</h1>
        <p class="auth-sub">보안을 위해 아이디는 일부만 마스킹하여 표시됩니다.</p>

        <div style="background:var(--blue-light);border:1px solid #bfdbfe;border-radius:12px;
                    padding:20px;margin:20px 0;font-size:22px;font-weight:700;color:var(--blue);
                    letter-spacing:.08em;">
          ${foundUserId}
        </div>

        <div style="display:flex;flex-direction:column;gap:10px;">
          <button class="btn-submit"
                  onclick="location.href='${pageContext.request.contextPath}/auth/login'">
            로그인하기
          </button>
          <button class="btn-submit"
                  style="background:var(--gray-100);color:var(--gray-700);box-shadow:none;"
                  onclick="location.href='${pageContext.request.contextPath}/auth/find-pw'">
            비밀번호 찾기
          </button>
        </div>
      </c:when>

      <c:otherwise>
        <div style="font-size:56px;margin:16px 0 20px;">😢</div>
        <h1 class="auth-title">링크가 만료되었어요</h1>
        <p class="auth-sub">${error}</p>
        <button class="btn-submit"
                onclick="location.href='${pageContext.request.contextPath}/auth/find-id'">
          다시 시도하기
        </button>
      </c:otherwise>
    </c:choose>

    <div class="auth-footer" style="margin-top:20px;">
      <a href="${pageContext.request.contextPath}/auth/login">← 로그인으로</a>
    </div>
  </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
