<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
    <%-- 페이지 전용 CSS (include 전에 c:set var="pageCSS" 설정 필요) --%>
    <c:if test="${not empty pageCSS}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/${pageCSS}">
    </c:if>
</head>
<header>
    <div class="hi">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">
            <div class="logo-icon">🌐</div>
            <span class="logo-text">TripTogether</span>
        </div>
        <nav>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/explore'">여행지 탐색</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/courses'">여행 코스</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/assistant'">AI 도우미</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/community/list'">커뮤니티</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/mypage'">마이페이지</button>
        </nav>
        <div class="hr">
            <label>
                <select class="lang-sel">
                    <option value="ko">한국어</option>
                    <option value="en">English</option>
                    <option value="ja">日本語</option>
                    <option value="zh">中文</option>
                </select>
            </label>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span class="user-nick">${sessionScope.loginUser.nickname}</span>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/logout'">로그아웃</button>
                </c:when>
                <c:otherwise>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/login'">로그인</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>