<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png"> <%-- 파비콘 --%>
    <title>${pageTitle} — TripTogether Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
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
        <a class="adm-brand" href="${pageContext.request.contextPath}/admin">
            <div class="adm-brand-icon">🌐</div>
            <div>
                <div class="adm-brand-text">TripTogether</div>
                <div class="adm-brand-sub">Admin Panel</div>
            </div>
        </a>

        <nav class="adm-nav">
            <div class="adm-nav-section">메인</div>
            <a class="adm-nav-item ${activeMenu=='dashboard'?'active':''}" href="${pageContext.request.contextPath}/admin">
                <span class="adm-nav-icon">📊</span> 대시보드
            </a>

            <c:if test="${hasMemberAdmin or hasAuditAdmin}">
            <div class="adm-nav-section" style="margin-top:8px;">회원 / 인증</div>
            </c:if>
            <c:if test="${hasMemberAdmin}">
            <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/admin/members">
                <span class="adm-nav-icon">👥</span> 회원 관리
            </a>
            </c:if>
            <c:if test="${hasAuditAdmin}">
            <a class="adm-nav-item ${activeMenu=='logins'?'active':''}" href="${pageContext.request.contextPath}/admin/logins">
                <span class="adm-nav-icon">🔐</span> 로그인 감사
            </a>
            <a class="adm-nav-item ${activeMenu=='security'?'active':''}" href="${pageContext.request.contextPath}/admin/security">
                <span class="adm-nav-icon">🛡️</span> 보안 이력
            </a>
            <a class="adm-nav-item ${activeMenu=='emailTokens'?'active':''}" href="${pageContext.request.contextPath}/admin/email-tokens">
                <span class="adm-nav-icon">🔗</span> 이메일 액션 토큰
            </a>
            <a class="adm-nav-item ${activeMenu=='emailVerifications'?'active':''}" href="${pageContext.request.contextPath}/admin/email-verifications">
                <span class="adm-nav-icon">📧</span> 이메일 액션 요청
            </a>
            <a class="adm-nav-item ${activeMenu=='activityLogs'?'active':''}" href="${pageContext.request.contextPath}/admin/activity-logs">
                <span class="adm-nav-icon">🧭</span> 일반 활동 로그
            </a>
            </c:if>

            <c:if test="${hasInquiryAdmin or hasReportAdmin}">
            <div class="adm-nav-section" style="margin-top:8px;">운영</div>
            </c:if>
            <c:if test="${hasInquiryAdmin}">
            <a class="adm-nav-item ${activeMenu=='inquiries'?'active':''}" href="${pageContext.request.contextPath}/admin/inquiries">
                <span class="adm-nav-icon">📩</span> 문의 관리
            </a>
            </c:if>
            <c:if test="${hasReportAdmin}">
            <a class="adm-nav-item ${activeMenu=='reports'?'active':''}" href="${pageContext.request.contextPath}/admin/reports">
                <span class="adm-nav-icon">🚨</span> 신고 관리
            </a>
            </c:if>

            <c:if test="${hasCommunityAdmin or hasExploreAdmin}">
            <div class="adm-nav-section" style="margin-top:8px;">콘텐츠</div>
            </c:if>
            <c:if test="${hasCommunityAdmin}">
            <a class="adm-nav-item ${activeMenu=='community'?'active':''}" href="${pageContext.request.contextPath}/admin/community">
                <span class="adm-nav-icon">📝</span> 커뮤니티 관리
            </a>
            </c:if>
            <c:if test="${hasExploreAdmin}">
            <a class="adm-nav-item ${activeMenu=='explore'?'active':''}" href="${pageContext.request.contextPath}/admin/explore">
                <span class="adm-nav-icon">📍</span> 여행지 관리
            </a>
            </c:if>
            <span class="adm-nav-item disabled">
                <span class="adm-nav-icon">🗺️</span> 코스 관리
                <span class="adm-nav-badge soon">회의 후</span>
            </span>

            <div class="adm-nav-section" style="margin-top:8px;">시스템</div>
            <a class="adm-nav-item ${activeMenu=='superAdmin'?'active':''}" href="${pageContext.request.contextPath}/superAdmin">
                <span class="adm-nav-icon">🔑</span> 관리자 계정 관리
            </a>
            <c:if test="${hasContentModerationAdmin}">
            <a class="adm-nav-item ${activeMenu=='moderation'?'active':''}" href="${pageContext.request.contextPath}/admin/moderation">
                <span class="adm-nav-icon">🛡️</span> 콘텐츠 검열 정책
            </a>
            </c:if>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/" target="_blank">
                    <span class="adm-nav-icon">↗️</span> 사이트 보기
                </a>
            </div>
        </nav>

        <div class="adm-sidebar-foot">
            <div class="adm-user-chip">
                <div class="adm-user-av">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                <div>
                    <div class="adm-user-name">${sessionScope.loginUser.nickname}</div>
                    <div class="adm-user-role">관리자</div>
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
                <span>Admin</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
<script>
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
