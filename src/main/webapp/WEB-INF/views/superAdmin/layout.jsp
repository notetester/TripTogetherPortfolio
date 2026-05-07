<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_layout_logout" code="superAdmin.layout.logout"/>
<spring:message var="msg_superAdmin_layout_themeToggle" code="superAdmin.layout.themeToggle"/>
<spring:message var="msg_superAdmin_layout_theme_dark_js" code="superAdmin.layout.theme.dark" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_layout_theme_light_js" code="superAdmin.layout.theme.light" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_layout_titleSuffix" code="superAdmin.layout.titleSuffix"/>
<spring:message var="msg_superAdmin_layout_brandName" code="superAdmin.layout.brandName"/>
<spring:message var="msg_superAdmin_layout_brandSub" code="superAdmin.layout.brandSub"/>
<spring:message var="msg_superAdmin_layout_section_admin" code="superAdmin.layout.section.admin"/>
<spring:message var="msg_superAdmin_layout_menu_adminMembers" code="superAdmin.layout.menu.adminMembers"/>
<spring:message var="msg_superAdmin_layout_menu_org" code="superAdmin.layout.menu.org"/>
<spring:message var="msg_superAdmin_layout_section_permissions" code="superAdmin.layout.section.permissions"/>
<spring:message var="msg_superAdmin_layout_menu_permissionItems" code="superAdmin.layout.menu.permissionItems"/>
<spring:message var="msg_superAdmin_layout_menu_permissionGroups" code="superAdmin.layout.menu.permissionGroups"/>
<spring:message var="msg_superAdmin_layout_menu_permissionTemplates" code="superAdmin.layout.menu.permissionTemplates"/>
<spring:message var="msg_superAdmin_layout_section_analytics" code="superAdmin.layout.section.analytics"/>
<spring:message var="msg_superAdmin_layout_menu_salary" code="superAdmin.layout.menu.salary"/>
<spring:message var="msg_superAdmin_layout_menu_stats" code="superAdmin.layout.menu.stats"/>
<spring:message var="msg_superAdmin_layout_menu_adminPanel" code="superAdmin.layout.menu.adminPanel"/>
<spring:message var="msg_superAdmin_layout_menu_viewSite" code="superAdmin.layout.menu.viewSite"/>
<spring:message var="msg_superAdmin_layout_role" code="superAdmin.layout.role"/>
<spring:message var="msg_superAdmin_layout_theme_light" code="superAdmin.layout.theme.light"/>
<spring:message var="msg_superAdmin_layout_pathRoot" code="superAdmin.layout.pathRoot"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png">
    <title>${pageTitle} — ${msg_superAdmin_layout_titleSuffix}</title>
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
                <div class="adm-brand-text">${msg_superAdmin_layout_brandName}</div>
                <div class="adm-brand-sub">${msg_superAdmin_layout_brandSub}</div>
            </div>
        </a>

        <nav class="adm-nav">
            <div class="adm-nav-section">${msg_superAdmin_layout_section_admin}</div>
            <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/members">
                <span class="adm-nav-icon">👤</span> ${msg_superAdmin_layout_menu_adminMembers}
            </a>
            <a class="adm-nav-item ${activeMenu=='org'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/org">
                <span class="adm-nav-icon">🏢</span> ${msg_superAdmin_layout_menu_org}
            </a>

            <div class="adm-nav-section sa-nav-section-spaced">${msg_superAdmin_layout_section_permissions}</div>
            <a class="adm-nav-item ${activeMenu=='permissions'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permissions">
                <span class="adm-nav-icon">🔑</span> ${msg_superAdmin_layout_menu_permissionItems}
            </a>
            <a class="adm-nav-item ${activeMenu=='groups'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/groups">
                <span class="adm-nav-icon">🔐</span> ${msg_superAdmin_layout_menu_permissionGroups}
            </a>
            <a class="adm-nav-item ${activeMenu=='permissionCodes'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permission-codes">
                <span class="adm-nav-icon">🗂️</span> ${msg_superAdmin_layout_menu_permissionTemplates}
            </a>

            <div class="adm-nav-section sa-nav-section-spaced">${msg_superAdmin_layout_section_analytics}</div>
            <a class="adm-nav-item ${activeMenu=='salary'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/salary">
                <span class="adm-nav-icon">💰</span> ${msg_superAdmin_layout_menu_salary}
            </a>
            <a class="adm-nav-item ${activeMenu=='stats'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/stats">
                <span class="adm-nav-icon">📊</span> ${msg_superAdmin_layout_menu_stats}
            </a>

            <div class="sa-nav-aux-wrap">
                <a class="adm-nav-item sa-nav-aux" href="${pageContext.request.contextPath}/admin">
                    <span class="adm-nav-icon">↩️</span> ${msg_superAdmin_layout_menu_adminPanel}
                </a>
                <a class="adm-nav-item sa-nav-aux sa-nav-aux-site" href="${pageContext.request.contextPath}/" target="_blank">
                    <span class="adm-nav-icon">↗️</span> ${msg_superAdmin_layout_menu_viewSite}
                </a>
            </div>
        </nav>

        <div class="adm-sidebar-foot">
            <div class="adm-user-chip">
                <div class="adm-user-av">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                <div>
                    <div class="adm-user-name">${sessionScope.loginUser.nickname}</div>
                    <div class="adm-user-role">${msg_superAdmin_layout_role}</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="${msg_superAdmin_layout_logout}">⏏</a>
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
            <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="${msg_superAdmin_layout_themeToggle}">${msg_superAdmin_layout_theme_light}</button>
            <div class="adm-topbar-path">
                <span>${msg_superAdmin_layout_pathRoot}</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
<script>
(function(){
    var btn = document.getElementById('saThemeBtn');
    var isLight = document.body.classList.contains('sa-light');
    if (btn) btn.textContent = isLight
        ? '${msg_superAdmin_layout_theme_dark_js}'
        : '${msg_superAdmin_layout_theme_light_js}';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('tt_theme', 'dark');
        if (btn) btn.textContent = '${msg_superAdmin_layout_theme_light_js}';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('tt_theme', 'light');
        if (btn) btn.textContent = '${msg_superAdmin_layout_theme_dark_js}';
    }
}
</script>
