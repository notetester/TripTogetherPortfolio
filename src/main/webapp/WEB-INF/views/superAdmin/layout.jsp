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
    var t = localStorage.getItem('sa_theme');
    if (t) document.body.classList.add(t);
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
            <a class="adm-nav-item ${activeMenu=='groups'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/groups">
                <span class="adm-nav-icon">🔐</span> 권한 그룹
            </a>
            <a class="adm-nav-item ${activeMenu=='requests'?'active':''}" href="${pageContext.request.contextPath}/superAdmin/permissions/requests">
                <span class="adm-nav-icon">📋</span> 권한 요청
                <span class="sa-req-badge" id="pendingBadge" style="display:none;"></span>
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
            <button class="adm-btn adm-btn-ghost" style="display:none;padding:6px 8px;" id="sidebar-toggle"
                    onclick="document.getElementById('adm-sidebar').classList.toggle('open')">☰</button>
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
    fetch('${pageContext.request.contextPath}/superAdmin/permissions/requests/count')
        .then(function(r){ return r.json(); })
        .then(function(d){ if(d.count>0){ var b=document.getElementById('pendingBadge'); if(b){b.textContent=d.count;b.style.display='inline';} } })
        .catch(function(){});
})();

(function(){
    var btn = document.getElementById('saThemeBtn');
    var t   = localStorage.getItem('sa_theme') || '';
    if (btn) btn.textContent = (t === 'sa-light') ? '🌙 어둡게' : '☀️ 밝게';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('sa_theme', '');
        if (btn) btn.textContent = '☀️ 밝게';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('sa_theme', 'sa-light');
        if (btn) btn.textContent = '🌙 어둡게';
    }
}
</script>
