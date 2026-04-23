<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png">
    <title>${pageTitle} — TripTogether SuperAdmin</title>
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
                <div class="adm-brand-text">TripTogether</div>
                <div class="adm-brand-sub">Super Admin</div>
            </div>
        </a>

        <nav class="adm-nav">
            <div class="adm-nav-section">관리자 관리</div>
            <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/members">
                <span class="adm-nav-icon">👤</span> 관리자 목록
            </a>
            <a class="adm-nav-item ${activeMenu=='org'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/org">
                <span class="adm-nav-icon">🏢</span> 조직도
            </a>

            <div class="adm-nav-section" style="margin-top:16px;">권한 관리</div>
            <a class="adm-nav-item ${activeMenu=='permissions'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permissions">
                <span class="adm-nav-icon">🔑</span> 권한 항목
            </a>
            <a class="adm-nav-item ${activeMenu=='groups'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/groups">
                <span class="adm-nav-icon">🔐</span> 권한 그룹
            </a>
            <a class="adm-nav-item ${activeMenu=='permissionCodes'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permission-codes">
                <span class="adm-nav-icon">🗂️</span> 권한 템플릿
            </a>

            <div class="adm-nav-section" style="margin-top:16px;">현황 분석</div>
            <a class="adm-nav-item ${activeMenu=='salary'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/salary">
                <span class="adm-nav-icon">💰</span> 급여/역량 현황
            </a>
            <a class="adm-nav-item ${activeMenu=='stats'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/stats">
                <span class="adm-nav-icon">📊</span> 통계 대시보드
            </a>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item sa-nav-aux" href="${pageContext.request.contextPath}/admin">
                    <span class="adm-nav-icon">↩️</span> 관리자 패널
                </a>
                <a class="adm-nav-item sa-nav-aux" href="${pageContext.request.contextPath}/" target="_blank" style="margin-top:4px;">
                    <span class="adm-nav-icon">↗️</span> 사이트 보기
                </a>
            </div>
        </nav>

        <div class="adm-sidebar-foot">
            <div class="adm-user-chip">
                <div class="adm-user-av">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                <div>
                    <div class="adm-user-name">${sessionScope.loginUser.nickname}</div>
                    <div class="adm-user-role">최고관리자</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="로그아웃">⏏</a>
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
            <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="테마 변경">☀️ 밝게</button>
            <div class="adm-topbar-path">
                <span>SuperAdmin</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
<script>
(function(){
    var btn = document.getElementById('saThemeBtn');
    var isLight = document.body.classList.contains('sa-light');
    if (btn) btn.textContent = isLight ? '🌙 어둡게' : '☀️ 밝게';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('tt_theme', 'dark');
        if (btn) btn.textContent = '☀️ 밝게';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('tt_theme', 'light');
        if (btn) btn.textContent = '🌙 어둡게';
    }
}
</script>
