<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_87597b946e" code="superAdmin.layout.titleSuffix"/>
<spring:message var="autoMsg_5b4c69fb42" code="superAdmin.layout.brandName"/>
<spring:message var="autoMsg_b04ae2884e" code="superAdmin.layout.brandSub"/>
<spring:message var="autoMsg_49b64a862b" code="superAdmin.layout.section.admin"/>
<spring:message var="autoMsg_ad6fa49c3a" code="superAdmin.layout.menu.adminMembers"/>
<spring:message var="autoMsg_64922d2fc0" code="superAdmin.layout.menu.org"/>
<spring:message var="autoMsg_2ea61bc9e8" code="superAdmin.layout.section.permissions"/>
<spring:message var="autoMsg_f3eaa4f02f" code="superAdmin.layout.menu.permissionItems"/>
<spring:message var="autoMsg_3ecb683fe1" code="superAdmin.layout.menu.permissionGroups"/>
<spring:message var="autoMsg_1248fe7d19" code="superAdmin.layout.menu.permissionTemplates"/>
<spring:message var="autoMsg_4f4676716f" code="superAdmin.layout.section.analytics"/>
<spring:message var="autoMsg_493e7b25b8" code="superAdmin.layout.menu.salary"/>
<spring:message var="autoMsg_7896166b35" code="superAdmin.layout.menu.stats"/>
<spring:message var="autoMsg_c930052e71" code="superAdmin.layout.menu.adminPanel"/>
<spring:message var="autoMsg_41e0671e70" code="superAdmin.layout.menu.viewSite"/>
<spring:message var="autoMsg_185066f2bb" code="superAdmin.layout.role"/>
<spring:message var="autoMsg_5d9e8acb77" code="superAdmin.layout.logout"/>
<spring:message var="autoMsg_9c749007cd" code="superAdmin.layout.themeToggle"/>
<spring:message var="autoMsg_ef2e12ff2c" code="superAdmin.layout.theme.light"/>
<spring:message var="autoMsg_a2f69db9b1" code="superAdmin.layout.pathRoot"/>
<spring:message var="autoMsg_8b300ae231" code="superAdmin.layout.theme.dark" javaScriptEscape="true"/>
<spring:message var="autoMsg_050c6dc281" code="superAdmin.layout.theme.light" javaScriptEscape="true"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png">
    <title>${pageTitle} — ${autoMsg_87597b946e}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/superAdmin/superadmin.css">
</head>
<body>
<script>
(function(){
    // 구버전 키(sa_theme) → 신규 키(tt_theme) 일회성 마이그레이션
    var legacy = localStorage.getItem('sa_theme');
    if (legacy !== null) {
        if (!localStorage.getItem('tt_theme')) {
            localStorage.setItem('tt_theme', legacy === 'sa-light' ? 'light' : 'dark');
        }
        localStorage.removeItem('sa_theme');
    }
    // superAdmin 기본 테마는 다크. tt_theme === 'light' 일 때만 sa-light 적용
    var t = localStorage.getItem('tt_theme');
    if (t === 'light') document.body.classList.add('sa-light');
})();
</script>
<div class="adm-shell">
    <aside class="adm-sidebar" id="adm-sidebar">
        <a class="adm-brand" href="${pageContext.request.contextPath}/superAdmin">
            <div class="adm-brand-icon">🔑</div>
            <div>
                <div class="adm-brand-text">${autoMsg_5b4c69fb42}</div>
                <div class="adm-brand-sub">${autoMsg_b04ae2884e}</div>
            </div>
        </a>

        <nav class="adm-nav">
            <div class="adm-nav-section">${autoMsg_49b64a862b}</div>
            <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/members">
                <span class="adm-nav-icon">👤</span> ${autoMsg_ad6fa49c3a}
            </a>
            <a class="adm-nav-item ${activeMenu=='org'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/org">
                <span class="adm-nav-icon">🏢</span> ${autoMsg_64922d2fc0}
            </a>

            <div class="adm-nav-section" style="margin-top:16px;">${autoMsg_2ea61bc9e8}</div>
            <a class="adm-nav-item ${activeMenu=='permissions'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permissions">
                <span class="adm-nav-icon">🔑</span> ${autoMsg_f3eaa4f02f}
            </a>
            <a class="adm-nav-item ${activeMenu=='groups'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/groups">
                <span class="adm-nav-icon">🔐</span> ${autoMsg_3ecb683fe1}
            </a>
            <a class="adm-nav-item ${activeMenu=='permissionCodes'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permission-codes">
                <span class="adm-nav-icon">🗂️</span> ${autoMsg_1248fe7d19}
            </a>

            <div class="adm-nav-section" style="margin-top:16px;">${autoMsg_4f4676716f}</div>
            <a class="adm-nav-item ${activeMenu=='salary'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/salary">
                <span class="adm-nav-icon">💰</span> ${autoMsg_493e7b25b8}
            </a>
            <a class="adm-nav-item ${activeMenu=='stats'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/stats">
                <span class="adm-nav-icon">📊</span> ${autoMsg_7896166b35}
            </a>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item sa-nav-aux" href="${pageContext.request.contextPath}/admin">
                    <span class="adm-nav-icon">↩️</span> ${autoMsg_c930052e71}
                </a>
                <a class="adm-nav-item sa-nav-aux" href="${pageContext.request.contextPath}/" target="_blank" style="margin-top:4px;">
                    <span class="adm-nav-icon">↗️</span> ${autoMsg_41e0671e70}
                </a>
            </div>
        </nav>

        <div class="adm-sidebar-foot">
            <div class="adm-user-chip">
                <div class="adm-user-av">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                <div>
                    <div class="adm-user-name">${sessionScope.loginUser.nickname}</div>
                    <div class="adm-user-role">${autoMsg_185066f2bb}</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="${autoMsg_5d9e8acb77}">⏏</a>
            </div>
        </div>
    </aside>

    <div class="adm-main">
        <div class="adm-topbar">
            <button type="button" class="adm-nav-toggle" id="sidebar-toggle"
                    aria-label="메뉴" aria-expanded="false" aria-controls="adm-sidebar">
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
            </button>
            <div class="adm-topbar-title">${pageTitle}</div>
            <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="${autoMsg_9c749007cd}">${autoMsg_ef2e12ff2c}</button>
            <div class="adm-topbar-path">
                <span>${autoMsg_a2f69db9b1}</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
<script>
(function(){
    var btn = document.getElementById('saThemeBtn');
    var isLight = document.body.classList.contains('sa-light');
    if (btn) btn.textContent = isLight
        ? '${autoMsg_8b300ae231}'
        : '${autoMsg_050c6dc281}';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('tt_theme', 'dark');
        if (btn) btn.textContent = '${autoMsg_050c6dc281}';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('tt_theme', 'light');
        if (btn) btn.textContent = '${autoMsg_8b300ae231}';
    }
}
</script>
