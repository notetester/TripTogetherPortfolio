<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — TripTogether Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
</head>
<body>
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

            <div class="adm-nav-section" style="margin-top:8px;">회원 / 인증</div>
            <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/admin/members">
                <span class="adm-nav-icon">👥</span> 회원 관리
            </a>
            <a class="adm-nav-item ${activeMenu=='logins'?'active':''}" href="${pageContext.request.contextPath}/admin/logins">
                <span class="adm-nav-icon">🔐</span> 로그인 감사
            </a>
            <a class="adm-nav-item ${activeMenu=='security'?'active':''}" href="${pageContext.request.contextPath}/admin/security">
                <span class="adm-nav-icon">🛡️</span> 보안 이력
            </a>
            <a class="adm-nav-item ${activeMenu=='emailVerifications'?'active':''}" href="${pageContext.request.contextPath}/admin/email-verifications">
                <span class="adm-nav-icon">📧</span> 이메일 인증 요청
            </a>

            <div class="adm-nav-section" style="margin-top:8px;">운영</div>
            <a class="adm-nav-item ${activeMenu=='inquiries'?'active':''}" href="${pageContext.request.contextPath}/admin/inquiries">
                <span class="adm-nav-icon">📩</span> 문의 관리
            </a>

            <div class="adm-nav-section" style="margin-top:8px;">콘텐츠</div>
            <span class="adm-nav-item disabled">
                <span class="adm-nav-icon">📝</span> 커뮤니티 관리
                <span class="adm-nav-badge soon">회의 후</span>
            </span>
            <span class="adm-nav-item disabled">
                <span class="adm-nav-icon">📍</span> 여행지 관리
                <span class="adm-nav-badge soon">회의 후</span>
            </span>
            <span class="adm-nav-item disabled">
                <span class="adm-nav-icon">🗺️</span> 코스 관리
                <span class="adm-nav-badge soon">회의 후</span>
            </span>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item" href="${pageContext.request.contextPath}/" target="_blank" style="background:#1e2330; color:#64748b;">
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
            <div class="adm-topbar-path">
                <span>Admin</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
