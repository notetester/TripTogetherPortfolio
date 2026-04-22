<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png"> <%-- 파비콘 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
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
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/explore'"><spring:message code="header.nav.explore"/></button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/courses'"><spring:message code="header.nav.courses"/></button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/assistant'"><spring:message code="header.nav.assistant"/></button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/community/list'"><spring:message code="header.nav.community"/></button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/wallet'"><spring:message code="header.nav.wallet"/></button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/mypage'"><spring:message code="header.nav.mypage"/></button>
            <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userRole == 'ADMIN'}">
    <button class="nb" onclick="location.href='${pageContext.request.contextPath}/admin'"><spring:message code="header.nav.admin"/></button>
    <button class="admin-mode-btn ${isAdminMode ? 'admin' : 'user'}"
            onclick="toggleViewMode()">
        ${isAdminMode ? '🛡️ ' : '👤 '}
        <spring:message code="${isAdminMode ? 'header.mode.admin' : 'header.mode.user'}"/>
    </button>
</c:if>

        </nav>
        <div class="hr">
            <label>
                <select class="lang-sel" id="langSel">
                    <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}><spring:message code="header.lang.ko"/></option>
                    <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}><spring:message code="header.lang.en"/></option>
                    <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}><spring:message code="header.lang.ja"/></option>
                    <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}><spring:message code="header.lang.zh"/></option>
                </select>
            </label>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <span class="user-nick">${sessionScope.loginUser.nickname}</span>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/logout'"><spring:message code="header.auth.logout"/></button>
                </c:when>
                <c:otherwise>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/login'"><spring:message code="header.auth.login"/></button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userRole == 'ADMIN'}">
<script>
function toggleViewMode() {
    fetch('${pageContext.request.contextPath}/community/admin/viewmode', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        if (data.success) location.reload();
    });
}
</script>
</c:if>

<script>
(function () {
    const langSel = document.getElementById('langSel');
    if (!langSel) return;

    langSel.addEventListener('change', function () {
        const url = new URL(window.location.href);
        url.searchParams.set('lang', this.value);
        window.location.href = url.toString();
    });
})();
</script>
